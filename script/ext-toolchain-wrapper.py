#!/usr/bin/python

from __future__ import print_function
import os
import sys
import commands
import subprocess

def main():
    is_ld = os.path.basename(sys.argv[0]).endswith('ld')
    path = os.path.dirname(os.path.realpath(__file__))
    openwrt_base = os.path.realpath(os.path.join(path, '../../'))
    prebuild_toolchain_base = os.path.join(openwrt_base, 'prebuild/toolchain')
    bin_name = os.path.basename(sys.argv[0])
    bin_path = os.path.join(prebuild_toolchain_base, 'bin', bin_name)
    
    bin_param = []
    if not is_ld:
        bin_param.append('-Os -pipe -march=armv7-a -mtune=cortex-a9 -muclibc -msoft-float')
    
    bin_param.append('-I%s' % os.path.join(prebuild_toolchain_base, 'usr/include'))
    bin_param.append('-L%s' % os.path.join(prebuild_toolchain_base, 'usr/lib'))
    bin_param.append('-I%s' % os.path.join(prebuild_toolchain_base, 'include'))
    bin_param.append('-L%s' % os.path.join(prebuild_toolchain_base, 'lib'))
    
    staging_path = os.path.join(openwrt_base, 'staging_dir/target-arm-openwrt-linux-uclibcgnueabi')
    if os.path.exists(staging_path):
        bin_param.append('-I%s' % os.path.join(staging_path, 'usr/include'))
        bin_param.append('-L%s' % os.path.join(staging_path, 'usr/lib'))
        if not is_ld:
            bin_param.append('-Wl,-rpath-link,%s' % os.path.join(staging_path, 'usr/lib'))

    bin_param = bin_param + sys.argv[1:]
    bin_param = [bin_path] + ' '.join(bin_param).split();

    subprocess.call(bin_param)

if __name__ == '__main__':
    main()

