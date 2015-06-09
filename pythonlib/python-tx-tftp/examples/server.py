'''
@author: shylent
'''
import sys
import random
import os

def main():
    from tftp.backend import FilesystemSynchronousBackend
    from tftp.protocol import TFTP
    from twisted.internet import reactor
    from twisted.python import log
    random.seed()
    log.startLogging(sys.stdout)
    #reactor.listenUDP(1069, TFTP(FilesystemSynchronousBackend('output')))
    cwd = os.getcwd()
    reactor.listenUDP(69, TFTP(FilesystemSynchronousBackend(cwd)))
    reactor.run()

if __name__ == '__main__':
    dirname = os.path.dirname(sys.argv[0]) + "/.."
    #sys.path.append("/home/karlzheng/bashrc/pythonlib/python-tx-tftp/")
    sys.path.append(dirname)
    print(dirname)
    main()
