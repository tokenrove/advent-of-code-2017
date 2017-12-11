#include <assert.h>
#include <err.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    FILE *fp = fopen("day5.in", "r");
    if (!fp) err(1, "fopen");
    size_t avail = 4096, actual = 0, line_n = 0;
    int jumps[avail];
    char *line = NULL;
    while (!feof(fp)) {
        ssize_t n = getline(&line, &line_n, fp);
        if (n <= 0) break;
        jumps[actual++] = strtol(line, NULL, 10); // XXX lack of error checking
        assert(actual < avail);
    }
    int j[actual];
    memcpy(j, jumps, sizeof(j));
    size_t n = 0;
    for (size_t i = 0; i < actual; ++n) i += j[i]++;
    printf("part 1: %zu\n", n);
    n = 0;
    memcpy(j, jumps, sizeof(j));
    for (size_t i = 0; i < actual; ++n) i += j[i] < 3 ? j[i]++ : j[i]--;
    printf("part 2: %zu\n", n);
}
