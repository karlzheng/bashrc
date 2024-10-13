#! /usr/bin/env python

# pytags
#
# Create a tags file for Python programs, usable with vi.
# Tagged are:
# - functions (even inside other defs or classes)
# - classes
# - filenames
# Warns about files it cannot open.
# No warnings about duplicate tags.

import sys, re, os

tags = []  # Modified global variable!


def main():
    # Automatically find all Python files in the current directory and its subdirectories
    py_files = find_python_files(".")
    for filename in py_files:
        treat_file(filename)
    if tags:
        with open("pytags", "w") as fp:
            tags.sort()
            for s in tags:
                fp.write(s)


# Regex to match function and class definitions
expr = "^[ \t]*(def|class)[ \t]+([a-zA-Z0-9_]+)[ \t]*[:\(]"
matcher = re.compile(expr)


def find_python_files(directory):
    """Recursively find all Python files in the given directory and subdirectories"""
    py_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".py"):
                py_files.append(os.path.join(root, file))
    return py_files


def treat_file(filename):
    try:
        with open(filename, "r") as fp:
            base = os.path.basename(filename)
            if base.endswith(".py"):
                base = base[:-3]
            s = base + "\t" + filename + "\t" + "1\n"
            tags.append(s)

            for line in fp:
                m = matcher.match(line)
                if m:
                    content = m.group(0)
                    name = m.group(2)
                    s = name + "\t" + filename + "\t/^" + content + "/\n"
                    tags.append(s)
    except Exception as e:
        sys.stderr.write(f"Cannot open {filename}: {e}\n")


if __name__ == "__main__":
    main()
