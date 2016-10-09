import socket
import sys
import urlparse

def sock_http_req():
    url = "http://m5.file.xiami.com/21/2021/829432541/1774191999_16565455_l.mp3?auth_key=b7fb248d5f73c36f4b5a9c49c1279aa2-1443484800-0-null"
    host_name = urlparse.urlparse(url).hostname
    #server = "m5.file.xiami.com"
    host_ip = socket.gethostbyname(host_name)
    #request = http.getRequestForURL(url)
    request = """GET /21/2021/829432541/1774191999_16565455_l.mp3?auth_key=b7fb248d5f73c36f4b5a9c49c1279aa2-1443484800-0-null HTTP/1.1\r\nHost: m5.file.xiami.com\r\n\r\n"""
    print(host_ip)
    print(request)
    #return
    server_address = (host_ip, 80)
    sock = socket.socket(
        socket.AF_INET, socket.SOCK_STREAM, socket.IPPROTO_TCP
    )
    socket.setdefaulttimeout(10)
    print >>sys.stderr, 'connecting to {0} port {1}'.format(*server_address)
    sock.connect(server_address)
    response = ''
    done = False
    bufsize = 1024
    data=''
    try:
        print >>sys.stderr, 'sending "{0}"'.format(request)
        sock.sendall(request)
        data = sock.recv(1024)
        CLP = data.find('Content-Length:', 0, len(data))
        end = data.find('\r\n', CLP,len(data))
        contentlen = long(data[CLP + 16 : end])
        print contentlen
        data_start = data.find("\r\n\r\n", 0, len(data))
        data = data[data_start + 4:]
        recv_len = len(data)
        while (1):
            data += sock.recv(1024)
            recv_len = len(data)
            if(recv_len >= contentlen):
                break
        sock.close()
    except Exception:
        print(Exception)
    finally:
        print >>sys.stderr, 'closing socket'
        sock.close()

    print(len(data))
    file = open("tmp.mp3", 'wb')
    file.write(data)
    file.close()
    return data 

if __name__ == '__main__':
    sock_http_req()
