#!/usr/bin/env python3

"""Simple HTTP Server With Upload.
https://gist.github.com/arulrajnet/af376482bbe95346824e419b7c9cbdd0
This module builds on http.server by implementing the standard GET
and HEAD requests in a fairly straightforward manner.
"""

__version__ = "0.1"
__all__ = ["SimpleHTTPRequestHandler"]
__author__ = "bones7456"
__home_page__ = "http://li2z.cn/"

import os
import posixpath
import http.server
import urllib.parse
import shutil
import mimetypes
import re
import socket
from io import BytesIO
import html


class SimpleHTTPRequestHandler(http.server.BaseHTTPRequestHandler):
    server_version = "SimpleHTTPWithUpload/" + __version__

    def do_GET(self):
        f = self.send_head()
        if f:
            try:
                self.copyfile(f, self.wfile)
            finally:
                f.close()

    def do_HEAD(self):
        f = self.send_head()
        if f:
            f.close()

    def do_POST(self):
        r, info = self.deal_post_data()
        print(r, info, "by: ", self.client_address)
        f = BytesIO()
        f.write(b'<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">')
        f.write(b"<html>\n<title>Upload Result Page</title>\n")
        f.write(b"<body>\n<h2>Upload Result Page</h2>\n")
        f.write(b"<hr>\n")
        if r:
            f.write(b"<strong>Success:</strong>")
        else:
            f.write(b"<strong>Failed:</strong>")
        f.write(info.encode('utf-8'))
        referer = self.headers.get('referer', '')
        f.write(b"<br><a href=\"%s\">back</a>" % referer.encode('utf-8') if referer else b"")
        f.write(b"<hr><small>Powered By: bones7456, check new version at ")
        f.write(b"<a href=\"http://li2z.cn/?s=SimpleHTTPServerWithUpload\">")
        f.write(b"here</a>.</small></body>\n</html>\n")
        length = f.tell()
        f.seek(0)
        self.send_response(200)
        self.send_header("Content-type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(length))
        self.end_headers()
        if f:
            try:
                self.copyfile(f, self.wfile)
            finally:
                f.close()

    def deal_post_data(self):
        content_type = self.headers.get('Content-Type', '')
        if not content_type.startswith('multipart/form-data'):
            return (False, "Content-Type is not multipart/form-data")

        boundary = None
        for part in content_type.split(';'):
            part = part.strip()
            if part.startswith('boundary='):
                boundary = part.split('=', 1)[1].strip('"')
                break
        if not boundary:
            return (False, "Can't find boundary in Content-Type")
        boundary = boundary.encode('utf-8')

        remainbytes = int(self.headers['Content-Length'])

        line = self.rfile.readline()
        remainbytes -= len(line)
        if boundary not in line:
            return (False, "Content does NOT begin with boundary")

        line = self.rfile.readline()
        remainbytes -= len(line)
        fn_match = re.findall(rb'Content-Disposition.*name="file"; filename="(.*)"', line)
        if not fn_match:
            return (False, "Can't find out file name")
        fn = fn_match[0].decode('utf-8', errors='replace')
        path = self.translate_path(self.path)
        fn = os.path.join(path, fn)

        while remainbytes > 0:
            line = self.rfile.readline()
            remainbytes -= len(line)
            if line.strip() == b'':
                break

        try:
            with open(fn, 'wb') as out:
                preline = self.rfile.readline()
                remainbytes -= len(preline)
                while remainbytes > 0:
                    line = self.rfile.readline()
                    remainbytes -= len(line)
                    if boundary in line:
                        preline = preline.rstrip(b'\r\n')
                        out.write(preline)
                        return (True, f"File '{fn}' uploaded successfully!")
                    else:
                        out.write(preline)
                        preline = line
            return (False, "Unexpected end of data")
        except OSError as e:
            return (False, f"Can't create file for writing: {str(e)} (do you have permission?)")

    def send_head(self):
        path = self.translate_path(self.path)
        f = None
        if os.path.isdir(path):
            if not self.path.endswith('/'):
                self.send_response(301)
                self.send_header("Location", self.path + "/")
                self.end_headers()
                return None
            for index in ("index.html", "index.htm"):
                index_path = os.path.join(path, index)
                if os.path.exists(index_path):
                    path = index_path
                    break
            else:
                return self.list_directory(path)
        ctype = self.guess_type(path)
        try:
            f = open(path, 'rb')
        except OSError as e:
            self.send_error(404, f"File not found: {str(e)}")
            return None
        try:
            self.send_response(200)
            self.send_header("Content-type", ctype)
            fs = os.fstat(f.fileno())
            self.send_header("Content-Length", str(fs.st_size))
            self.send_header("Last-Modified", self.date_time_string(fs.st_mtime))
            self.end_headers()
            return f
        except:
            f.close()
            raise

    def list_directory(self, path):
        try:
            file_list = os.listdir(path)
        except OSError as e:
            self.send_error(403, f"No permission to list directory: {str(e)}")
            return None
        file_list.sort(key=lambda a: a.lower())
        f = BytesIO()
        displaypath = html.escape(urllib.parse.unquote(self.path))
        f.write(b'<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">')
        f.write(f"<html>\n<title>Directory listing for {displaypath}</title>\n".encode('utf-8'))
        f.write(f"<body>\n<h2>Directory listing for {displaypath}</h2>\n".encode('utf-8'))
        f.write(b"<hr>\n")
        f.write(b"<form enctype=\"multipart/form-data\" method=\"post\">")
        f.write(b"<input name=\"file\" type=\"file\"/>")
        f.write(b"<input type=\"submit\" value=\"Upload\"/></form>\n")
        f.write(b"<hr>\n<ul>\n")
        for name in file_list:
            fullname = os.path.join(path, name)
            displayname = linkname = name
            if os.path.isdir(fullname):
                displayname += "/"
                linkname += "/"
            if os.path.islink(fullname):
                displayname += "@"
            encoded_link = urllib.parse.quote(linkname).encode('utf-8')
            escaped_name = html.escape(displayname).encode('utf-8')
            f.write(b'<li><a href="%s">%s</a>\n' % (encoded_link, escaped_name))
        f.write(b"</ul>\n<hr>\n</body>\n</html>\n")
        length = f.tell()
        f.seek(0)
        self.send_response(200)
        self.send_header("Content-type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(length))
        self.end_headers()
        return f

    def translate_path(self, path):
        path = path.split('?', 1)[0]
        path = path.split('#', 1)[0]
        path = posixpath.normpath(urllib.parse.unquote(path))
        words = path.split('/')
        words = filter(None, words)
        path = os.getcwd()
        for word in words:
            if word in (os.curdir, os.pardir):
                continue
            path = os.path.join(path, word)
        return path

    def copyfile(self, source, outputfile):
        shutil.copyfileobj(source, outputfile)

    def guess_type(self, path):
        base, ext = posixpath.splitext(path)
        if ext in self.extensions_map:
            return self.extensions_map[ext]
        ext = ext.lower()
        if ext in self.extensions_map:
            return self.extensions_map[ext]
        return self.extensions_map['']

    if not mimetypes.inited:
        mimetypes.init()
    extensions_map = mimetypes.types_map.copy()
    extensions_map.update({
        '': 'application/octet-stream',
        '.py': 'text/plain',
        '.c': 'text/plain',
        '.h': 'text/plain',
    })


def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('8.8.8.8', 80))
        lan_ip = [s.getsockname()[0]]
        s.close()
        return lan_ip + ['127.0.0.1']
    except Exception as e:
        print(e)
        return ['127.0.0.1', 'localhost']


def test(HandlerClass=SimpleHTTPRequestHandler, ServerClass=http.server.HTTPServer, port=8000):
    local_ips = get_local_ip()
    print("=" * 50)
    print("Simple HTTP Server With Upload Started Successfully!")
    print(f"Server Port: {port}")
    print("Local Accessible Addresses:")
    for ip in local_ips:
        print(f"  http://{ip}:{port}")
    print(f"Local Quick Access: http://localhost:{port} or http://127.0.0.1:{port}")
    print("=" * 50)
    print("Press Ctrl+C to stop the server...\n")

    server_address = ('', port)
    httpd = ServerClass(server_address, HandlerClass)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
        httpd.server_close()


if __name__ == '__main__':
    test(port=8000)
