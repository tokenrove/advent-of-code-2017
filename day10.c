#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static size_t reverse(uint8_t *a, uint8_t p, size_t l)
{
    uint8_t e = p+l-1;
    size_t n = l >> 1;
    while (n-- > 0) { uint8_t t = a[p]; a[p] = a[e]; a[e] = t; ++p; --e; }
    return l;
}

int main(void)
{
#ifdef PART_1
    enum { ROUNDS = 1 };
    size_t lens[] = {14,58,0,116,179,16,1,104,2,254,167,86,255,55,122,244};
    size_t n = sizeof(lens)/sizeof(*lens);
#else
    enum { ROUNDS = 64 };
    char *s = "14,58,0,116,179,16,1,104,2,254,167,86,255,55,122,244";
    //char *s = "AoC 2017";
    uint8_t extra[] = {17, 31, 73, 47, 23};
    size_t n = strlen(s)+sizeof(extra);
    uint8_t lens[n];
    for (size_t i = 0; i < strlen(s); ++i) lens[i] = s[i];
    for (size_t i = 0; i < sizeof(extra); ++i) lens[strlen(s)+i] = extra[i];
#endif

    uint8_t a[256];
    for (size_t i = 0; i < 256; ++i) a[i] = i;
    for (size_t i = 0, p = 0; i < ROUNDS*n; ++i)
        p += reverse(a, p, lens[i%n]) + i;

#ifdef PART_1
    printf("%d*%d = %d\n", a[0], a[1], a[0]*a[1]);
#else
    for (size_t i = 0; i < 256; i += 16) {
        uint8_t o = 0;
        for (size_t j = 0; j < 16; ++j) o ^= a[i+j];
        printf("%02x", o);
    }
    printf("\n");
#endif
}
