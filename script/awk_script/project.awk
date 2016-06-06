#!/usr/bin/awk -f 
{
	havedata = 1
	if (match($0, "^project")) {
		f1 = $2
		do {
			havedata = getline
			if (havedata && !match($0, "^project")) {
				printf("%s%s\r\n", f1,$2)
			} else
			f1 = $2
		} while(havedata)
	}
}
