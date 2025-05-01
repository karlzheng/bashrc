#!/usr/bin/env python
# coding: utf-8

import os
import shutil
import subprocess
import sys
import pyzipper
from datetime import datetime


def get_last_git_hash(directory):
    try:
        result = subprocess.run(
            ["git", "-C", directory, "rev-parse", "HEAD"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        if result.returncode == 0:
            return result.stdout.strip()[:8]
        else:
            print(f"Error getting Git hash: {result.stderr}")
            return None
    except Exception as e:
        print(f"An error occurred: {e}")
        return None


def copy_directory(source_dir, target_dir):
    try:
        if os.path.exists(target_dir):
            print(f"Target directory exists, removing: {target_dir}")
            shutil.rmtree(target_dir)
        shutil.copytree(source_dir, target_dir)
        print(f"Directory copied to: {target_dir}")
        return True
    except Exception as e:
        print(f"Error copying directory: {e}")
        return False


def remove_git_directory(target_dir):
    git_dir = os.path.join(target_dir, ".git")
    if os.path.exists(git_dir):
        try:
            shutil.rmtree(git_dir)
            print(f"Removed .git directory: {target_dir}")
        except Exception as e:
            print(f"Error removing .git directory: {e}")


def run_commands_in_directory(target_dir):
    original_dir = os.getcwd()
    try:
        os.chdir(target_dir)
        commands = ["yes|genalltags.sh clean", ". env.sh", "./clean.sh"]
        for command in commands:
            print(f"Executing command: {command}")
            if command.startswith(". "):
                subprocess.run(["bash", "-c", command], check=True)
            else:
                subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Command execution error: {e}")
    finally:
        os.chdir(original_dir)


def zip_directory_with_password(target_dir, zip_file_path, password):
    try:
        if os.path.exists(zip_file_path):
            print(f"ZIP file exists, removing: {zip_file_path}")
            os.remove(zip_file_path)

        if password == "nopass":
            import zipfile
            with zipfile.ZipFile(zip_file_path, 'w') as zipf:
                base_path = os.path.dirname(target_dir)
                for root, _, files in os.walk(target_dir):
                    for file in files:
                        full_path = os.path.join(root, file)
                        rel_path = os.path.relpath(full_path, base_path)
                        zipf.write(full_path, rel_path)
            print(f"Created unencrypted ZIP file: {zip_file_path}")
        else:
            with pyzipper.AESZipFile(
                zip_file_path, "w", encryption=pyzipper.WZ_AES
            ) as zipf:
                zipf.setpassword(password.encode("utf-8"))

                base_path = os.path.dirname(target_dir)
                for root, _, files in os.walk(target_dir):
                    for file in files:
                        full_path = os.path.join(root, file)
                        rel_path = os.path.relpath(full_path, base_path)
                        zipf.write(full_path, rel_path)

            print(f"Created encrypted ZIP file: {zip_file_path}")
        return True
    except Exception as e:
        print(f"Error creating ZIP: {e}")
        if os.path.exists(zip_file_path):
            os.remove(zip_file_path)
        return False


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <source_directory> [zip_password]")
        sys.exit(1)

    source_directory = os.path.abspath(sys.argv[1])

    zip_password = "ams"
    if len(sys.argv) >= 3:
        zip_password = sys.argv[2]

    last_git_hash = get_last_git_hash(source_directory)
    if not last_git_hash:
        print("Cannot get Git hash, using timestamp instead")
        last_git_hash = datetime.now().strftime("%Y%m%d_%H%M%S")

    current_date = datetime.now().strftime("%m%d")
    target_directory = f"{source_directory}_{last_git_hash}"
    zip_file_path = f"{source_directory}_{current_date}_{last_git_hash}.zip"

    if copy_directory(source_directory, target_directory):
        remove_git_directory(target_directory)
        run_commands_in_directory(target_directory)
        if zip_directory_with_password(target_directory, zip_file_path, zip_password):
            shutil.rmtree(target_directory)
            print(f"Cleaned temp directory: {target_directory}")
            print("Operation completed successfully!")
    
