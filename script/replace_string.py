#!/usr/bin/env python3

import os
import re
import sys

def replace_in_files(directory, search_str, replace_str, exclude_files=None, exclude_dirs=None, encoding='utf-8'):
    if exclude_files is None:
        exclude_files = []
    if exclude_dirs is None:
        exclude_dirs = []
    
    current_script = os.path.basename(__file__)
    exclude_files.append(current_script)
    
    for root, dirs, files in os.walk(directory, topdown=True):
        dirs[:] = [d for d in dirs if d not in exclude_dirs]
        
        for filename in files:
            if filename in exclude_files:
                print(f"Skipping excluded file: {os.path.join(root, filename)}")
                continue
                
            file_path = os.path.join(root, filename)
            
            try:
                with open(file_path, 'r', encoding=encoding) as file:
                    content = file.read()
                
                if search_str in content:
                    new_content = content.replace(search_str, replace_str)
                    
                    with open(file_path, 'w', encoding=encoding) as file:
                        file.write(new_content)
                    
                    print(f"Modified: {file_path}")
                    
            except (IOError, UnicodeDecodeError) as e:
                print(f"Unable to process file {file_path}: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python script.py <search_string> <replace_string>")
        sys.exit(1)
    
    current_directory = os.getcwd()
    
    SEARCH_STRING = sys.argv[1]
    REPLACE_STRING = sys.argv[2]
    
    EXCLUDED_FILES = []
    EXCLUDED_DIRS = ['.git']
    
    replace_in_files(current_directory, SEARCH_STRING, REPLACE_STRING, 
                    EXCLUDED_FILES, EXCLUDED_DIRS)
