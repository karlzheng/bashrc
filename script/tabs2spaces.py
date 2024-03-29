#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
url = https://github.com/jabaa/ConvertTabsSpaces.git
Converts tabs into spaces
'''

import argparse
import os.path
import sys

__version__ = '0.0.1'

def parse_arguments():
	parser = argparse.ArgumentParser(description='Replace tabs with spaces')
	parser.add_argument('files', metavar='FILE', help='files', nargs='+')
	parser.add_argument("-t", dest='tabwidth', help="set tabwidth", type=int, default=4)
	args = parser.parse_args()

	return args.files, args.tabwidth

def convert_line(line, tabwidth):
	pos = line.find('\t')
	while pos != -1:
		line = line.replace('\t', ' ' * (tabwidth - (pos % tabwidth)), 1)
		pos = line.find('\t', pos)
	return line

def main():
	files, tabwidth = parse_arguments()

	for current_file_path in files:
		if os.path.isdir(current_file_path):
			print('Path is a directory: ' + current_file_path, file=sys.stderr)
			continue

		if not os.path.isfile(current_file_path):
			print('File not found: ' + current_file_path, file=sys.stderr)
			continue

		converted = ''
		with open(current_file_path, 'r') as current_file:
			for line in current_file:
				converted += convert_line(line, tabwidth)
		#print(converted)
		with open(current_file_path, 'w') as file:
			file.write(converted)

if __name__ == "__main__":
	main()
