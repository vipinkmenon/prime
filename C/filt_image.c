#include <stdio.h>
#include <stdlib.h>

int main( int argc, char *argv[] )  
{
	FILE *file;
        FILE *file1;
	char *buffer;
        char *data;
	unsigned long fileLen;

	//Open file
	file = fopen(argv[1], "rb");
        file1 = fopen(argv[2], "wb");
	if (!file)
	{
		fprintf(stderr, "Unable to open file %s", argv[1]);
		return;
	}
	
	//Get file length
	fseek(file, 0, SEEK_END);
	fileLen=ftell(file);
	fseek(file, 0, SEEK_SET);

	//Allocate memory
	buffer=(char *)malloc(fileLen+1);
	data=(char *)malloc(512*512);
	if (!buffer)
	{
		fprintf(stderr, "Memory error!");
                fclose(file);
		return;
	}

	//Read file contents into buffer
	fread(buffer, fileLen, 1, file);
	fclose(file);

        fwrite(buffer, 1048, 1, file1);
	fwrite(data, 512*512, 1, file1);
	//Do what ever with buffer

	free(buffer);
	free(data);
        fclose(file1);
   return 0;
}
