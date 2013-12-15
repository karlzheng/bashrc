#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	FILE*  fp_in    = NULL;
	FILE*  fp_out   = NULL;
  char* file_name;
  int start;
  int len;
  int count = 0;
  char buf[512];

	if (argc < 4) {
		printf("usage: %s filename start len\n", argv[0]);
		return 0;
	}

  file_name = argv[1];
  start = atoi(argv[2]);
  len = atoi(argv[3]);

	if((fp_in = fopen(file_name, "rb")) == NULL) {
		perror("fopen");
		return 0;
	}
	
  if((fp_out = fopen("part.bin", "wb")) == NULL) {
		perror("fopen part.bin for output!");
		return 0;
	}
   
  if (fseek(fp_in, start, 0) == -1) {
		printf("fseek to file postion:%d error!", start);
		return 0;
  }

  fseek(fp_in, 0, 2); // seek to the end of file

  len = ftell(fp_in)-start>len ? len:ftell(fp_in)-start;
  fseek(fp_in, start, 0);

  while (len>0) {
      count = (len>512) ? 512:len;
      fread(buf, count, 1, fp_in);
      fwrite(buf, count, 1, fp_out);
      len -= count;
      if (feof(fp_in)) {
          break;
      }
  }
	
	fclose(fp_in);
	fclose(fp_out);

	return 0;
}

