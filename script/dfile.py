#!/usr/bin/env python
# -*- coding: utf-8 -*-
import commands
import os

output_dir = "out/A3930/"
output_file = "/Users/karlzheng/tmp/tmp_work_file/1.c"
c_file = ""

# https://blog.csdn.net/qq_52684161/article/details/109822481
class Neg_STR:
	def __init__(self, arg):
		self.x = arg

	def __sub__(self, other):
		c = self.x.replace(other.x, "")
		return c

def get_cwd():
	cwd = "/"
	status, cwd = commands.getstatusoutput('pwd')
	return cwd

def get_fa_file():
	status, fn = commands.getstatusoutput("bash -l -c 'fa'")
	if status == 0:
		return fn
	else:
		return None

def get_base_file(fn):
	return fn

def get_dot_d_file():
	global c_file
	fn = get_fa_file()
	#print(fn)
	cwd = get_cwd()
	#print(cwd)
	c_file = Neg_STR(get_fa_file()) - Neg_STR(cwd + '/')
	fp, fn = os.path.split(c_file)
	#print(fn)
	fn, ext = os.path.splitext(fn)
	#print(fn)
	d_file = output_dir + fp + "/" + '.' + fn + ".o.d"
	print(d_file)
	return d_file

def get_gcc_command(d_file):
	cmd = "grep arm-none-eabi-g " + d_file
	cmd += "| sed 's/cmd_.*arm-none-eabi-g/arm-none-eabi-g/'| sed 's/-c -o .*//'"
	print(cmd)
	status, rs = commands.getstatusoutput(cmd)
	rs += ' -c '
	rs += ' -E -fdirectives-only '
	rs += ' -o ' + output_file
	rs += " ../../" + c_file
	print(rs)
	return rs

def backup_d_file(d_file):
	os.system("cp " + d_file + ' ' + d_file + '.bak')

def run_gcc_command(cmd):
	os.system("cd " + output_dir + ';' + cmd)

def restore_d_file(d_file):
	os.system("/bin/mv " + d_file + '.bak' + ' ' + d_file)

def run_ksformat():
	cmd = 'bash -l -c "'
	cmd += 'yes|ksformat.sh '
	cmd += output_file
	cmd += '"'
	print(cmd)
	os.system(cmd)

def delete_pound_key_line():
	#cmd = r"sed -i -e '/# [0-9]\+ \".*\"$/d' "
	cmd = r"sed -i -e '/^# [0-9]\+ \".*\".*$/d' "
	cmd += output_file
	print(cmd)
	os.system(cmd)

if __name__ == "__main__":
	d_file = get_dot_d_file()
	gcc_command = get_gcc_command(d_file)
	backup_d_file(d_file)
	run_gcc_command(gcc_command)
	restore_d_file(d_file)
	delete_pound_key_line()
	run_ksformat()
