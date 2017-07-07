import sys
import telnetlib
import os

def main():
    os.system('taskkill -im jlink.exe')
    os.system(r'start "" "c:\Program Files (x86)\SEGGER\JLink_V510i\JLink.exe" -device nrf51822 -if swd -speed 4000 -autoconnect 1')

    rtt = telnetlib.Telnet('localhost', 19021)

    while(True):
        data = rtt.read_until('\n')
        print(data), # one may do further processing here

    return 0

if __name__ == '__main__':
    sys.exit(main())
