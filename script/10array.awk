BEGIN { 
    FS = ","
}

{
	for(i = 1; i <= NF; ++i) {
	    gsub(/[[:blank:]]/, "", $i)
	    if (length($i)) {
	    #if (length($i) && (($i) !~ "[[:space:]]")) {
		printf $i", "
		if (++a % 10 == 0) 
			print ""
	    }
	}
}

END {
	print ""
}

