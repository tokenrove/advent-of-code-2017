#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

int main(void)
{
    uint64_t a = 873, b = 583;
    //uint64_t a = 65, b = 8921;
    uint64_t a_factor = 16807, b_factor = 48271;
    uint64_t a_save, b_save;
    bool have_a = false, have_b = false;
    a_save = b_save = 0;
    size_t count = 0;
    //for (size_t i = 0; i < 40000000; ++i) {
    for (size_t i = 0; i < 5000000;) {
        if (!have_a) a = (a*a_factor) % 2147483647;
        if (!have_b) b = (b*b_factor) % 2147483647;
        if (0 == (a % 4)) {
            a_save = a;
            have_a = true;
        }
        if (0 == (b % 8)) {
            b_save = b;
            have_b = true;
        }
        if (have_a && have_b) {
            if ((a_save&0xffff) == (b_save&0xffff))
                ++count;
            have_a = have_b = false;
            ++i;
        }
    }
    printf("%zu\n", count);
}
