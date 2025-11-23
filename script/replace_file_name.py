#!/usr/bin/env python3
import os
import argparse

def rename_files_and_dirs(root_dir, old_str="tcs3555", new_str="tsl2543", dry_run=False):
    if not os.path.isdir(root_dir):
        print(f"Error: Directory {root_dir} does not exist")
        return
    
    renamed_files_count = 0
    renamed_dirs_count = 0
    error_count = 0
    
    dirs_to_rename = []
    
    for dirpath, dirnames, filenames in os.walk(root_dir, topdown=True):
        for filename in filenames:
            if old_str in filename:
                old_path = os.path.join(dirpath, filename)
                new_filename = filename.replace(old_str, new_str)
                new_path = os.path.join(dirpath, new_filename)
                
                if old_path == new_path:
                    continue
                
                try:
                    if not dry_run:
                        os.rename(old_path, new_path)
                    print(f"{'[Dry Run]' if dry_run else 'Renamed file'}: {old_path} -> {new_path}")
                    renamed_files_count += 1
                except Exception as e:
                    print(f"Failed to rename file {old_path}: {str(e)}")
                    error_count += 1
        
        for dirname in dirnames:
            if old_str in dirname:
                old_dir_path = os.path.join(dirpath, dirname)
                new_dirname = dirname.replace(old_str, new_str)
                new_dir_path = os.path.join(dirpath, new_dirname)
                dirs_to_rename.append((old_dir_path, new_dir_path))
    
    for old_dir_path, new_dir_path in reversed(dirs_to_rename):
        if old_dir_path == new_dir_path:
            continue
        
        try:
            if not dry_run:
                os.rename(old_dir_path, new_dir_path)
            print(f"{'[Dry Run]' if dry_run else 'Renamed directory'}: {old_dir_path} -> {new_dir_path}")
            renamed_dirs_count += 1
        except Exception as e:
            print(f"Failed to rename directory {old_dir_path}: {str(e)}")
            error_count += 1
    
    print("\n" + "="*50)
    print(f"Processing complete!")
    print(f"Successfully renamed files: {renamed_files_count}")
    print(f"Successfully renamed directories: {renamed_dirs_count}")
    print(f"Total errors: {error_count}")

def main():
    parser = argparse.ArgumentParser(description='Recursively rename files and directories with specified string')
    parser.add_argument('--dir', '-d', default=os.getcwd(), help='Root directory to process (default: current directory)')
    parser.add_argument('--old', '-o', default="tcs3555", help='String to be replaced (default: tcs3555)')
    parser.add_argument('--new', '-n', default="tsl2543", help='Replacement string (default: tsl2543)')
    parser.add_argument('--dry-run', '-dr', action='store_true', help='Preview operations without actual renaming')
    
    args = parser.parse_args()
    
    rename_files_and_dirs(args.dir, args.old, args.new, args.dry_run)

if __name__ == "__main__":
    main()
