if __name__ == '__main__':  
    import socket  
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
    sock.bind(('0.0.0.0', 8001))  
    sock.listen(5)  
    while True:  
        connection,address = sock.accept()  
        print(address)
        try:  
            connection.settimeout(5)  
            buf = connection.recv(1024)  
            if buf == '1':  
                connection.send('welcome to server!')  
            else:  
                connection.send('please go out!')  
        except socket.timeout:  
            print 'time out'  
        connection.close() 
