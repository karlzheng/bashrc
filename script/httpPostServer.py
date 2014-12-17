#!/usr/bin/env python
#utf8
#===============================================================================
#
#          FILE:  httpPostServer.py
# 
#         USAGE:  ./httpPostServer.py
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Meizu
#       CREATED: date: 2014/12/16 Tue 10:51:26 PM
#      REVISION:  ---
#===============================================================================

from BaseHTTPServer import BaseHTTPRequestHandler
import cgi

class PostHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Parse the form data posted
        form = cgi.FieldStorage(
                fp=self.rfile,
                headers=self.headers,
                environ={'REQUEST_METHOD':'POST',
                    'CONTENT_TYPE':self.headers['Content-Type'],
                    })

                # Begin the response
        self.send_response(200)
        self.end_headers()
        self.wfile.write('Client: %s\n' % str(self.client_address))
        self.wfile.write('Path: %s\n' % self.path)
        self.wfile.write('Form data:\n')

        # Echo back information about what was posted in the form
        for field in form.keys():
            field_item = form[field]
            print(field)
            if field_item.filename:
                # The field contains an uploaded file
                file_data = field_item.file.read()
                file_len = len(file_data)
                fd = open(field_item.filename, "wb")
                fd.write(file_data)
                del file_data
                self.wfile.write('\tUploaded %s (%d bytes)\n' % (field, file_len))
            else:
                # Regular form value
                self.wfile.write('\t%s=%s\n' % (field, form[field].value))
        return

def argsHandle():
    import optparse
    optParser = optparse.OptionParser(usage="python postServer.py -p port [-V]", version = "0.1")
    optParser.add_option("-p", action = "store", dest="port", type="int", default=8080, help="http port")
    optParser.add_option("-V", action = "store_true", dest="verbose", help="print verbose message")
    optParser.add_option("-v", action = "store", dest="version", help="version info")
    options, args = optParser.parse_args()
    if options.version:
        optParser.print_version()
        sys.exit(0)
    return options, args

if __name__ == '__main__':
    opt, args = argsHandle()
    from BaseHTTPServer import HTTPServer
    print ("%s run http server on port: %d" %(__file__, opt.port))
    #server = HTTPServer(('localhost', 8080), PostHandler)
    server = HTTPServer(('0.0.0.0', opt.port), PostHandler)
    #print 'Starting server, use <Ctrl-C> to stop'
    server.serve_forever()
