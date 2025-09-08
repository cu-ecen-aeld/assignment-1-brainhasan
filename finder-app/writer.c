// finder-app/writer.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <syslog.h>


int main(int argc, char *argv[]) {
// argv[1] = writefile, argv[2] = writestr
openlog("writer", LOG_PID | LOG_CONS, LOG_USER);


if (argc != 3) {
syslog(LOG_ERR, "Invalid number of arguments: expected 2, got %d", argc - 1);
fprintf(stderr, "Usage: %s <writefile> <writestr>\n", argv[0]);
closelog();
return 1;
}


const char *writefile = argv[1];
const char *writestr = argv[2];


// Log what we're going to do
syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);


FILE *fp = fopen(writefile, "w");
if (fp == NULL) {
syslog(LOG_ERR, "Failed to open %s: %m", writefile);
perror("fopen");
closelog();
return 1;
}


size_t len = strlen(writestr);
size_t nw = fwrite(writestr, 1, len, fp);
if (nw != len) {
syslog(LOG_ERR, "Short write to %s: wrote %zu of %zu bytes", writefile, nw, len);
fclose(fp); // best effort
closelog();
return 1;
}


if (fclose(fp) != 0) {
syslog(LOG_ERR, "Failed to close %s: %m", writefile);
closelog();
return 1;
}


closelog();
return 0;
}
