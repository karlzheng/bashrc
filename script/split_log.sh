#!/bin/bash

filename=""
split_count=10

while getopts "f:n:" opt; do
	case $opt in
		f) filename="$OPTARG" ;;
		n) split_count="$OPTARG" ;;
		\?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
		:) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
	esac
done

if [ -z "$filename" ]; then
	echo "Usage: $0 -f <filename> [-n <split_count>]"
	exit 1
fi

if [ ! -f "$filename" ]; then
	echo "Error: File '$filename' does not exist!"
	exit 1
fi

if ! [[ "$split_count" =~ ^[0-9]+$ ]] || [ "$split_count" -le 0 ]; then
	echo "Error: Split count must be a positive integer!"
	exit 1
fi

file_name="${filename%.*}"
file_ext="${filename##*.}"

if [ "$file_name" = "$file_ext" ]; then
	file_ext=""
	prefix="$file_name"
else
	prefix="$file_name"
	suffix=".$file_ext"
fi

total_lines=$(wc -l < "$filename")
lines_per_file=$(((total_lines + split_count - 1) / split_count))

suffix_len=2
if [ -z "$file_ext" ]; then
	split -l "$lines_per_file" -d -a "$suffix_len" "$filename" "${prefix}_"
else
	split -l "$lines_per_file" -d -a "$suffix_len" "$filename" "${prefix}_"
	for part in "${prefix}_"*; do
		if [ -f "$part" ]; then
			num="${part##*_}"
			mv "$part" "${prefix}_${num}${suffix}"
		fi
	done
fi

echo "Split completed! Split into $split_count parts, each file has max $lines_per_file lines. Generated files:"
ls -1 "${prefix}_"*"${suffix:-}" 2>/dev/null

