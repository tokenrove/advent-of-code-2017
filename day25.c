#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>

enum { N_STEPS = 12586542UL };

static uint64_t tape[(2*N_STEPS+63) / 64] = {0}, pos = N_STEPS;

inline static void set_bit(void) { tape[pos>>6] |= 1UL<<(pos&63); }
inline static void clear_bit(void) { tape[pos>>6] &= ~(1UL<<(pos&63)); }
inline static bool read_bit(void) { return tape[pos>>6] & (1UL<<(pos&63)); }

int main(void)
{
    enum {A,B,C,D,E,F} state = A;
    size_t min_pos = pos, max_pos = pos;

    for (size_t step = 0; step < N_STEPS; ++step) {
        bool b = read_bit();
        switch (state) {
        case A:
            if (b) { clear_bit(); --pos; } else { set_bit(); ++pos; }
            state = B;
            break;

        case B:
            if (b) { set_bit(); --pos; } else { clear_bit(); ++pos; state = C; }
            break;

        case C:
            if (b) { clear_bit(); --pos; state = A; } else { set_bit(); ++pos; state = D; }
            break;

        case D:
            set_bit(); --pos; state = b ? F : E;
            break;

        case E:
            if (b) { clear_bit(); state = D; } else { set_bit(); state = A; }
            --pos;
            break;

        case F:
            set_bit(); if (b) { --pos; state = E; } else { ++pos; state = A; }
            break;
        }
        if (pos < min_pos) min_pos = pos;
        if (pos > max_pos) max_pos = pos;
    }

    size_t sum = 0;
    for (size_t i = min_pos>>6UL; i <= max_pos>>6UL; ++i) {
        sum += __builtin_popcountl(tape[i]);
    }
    printf("%zu\n", sum);
}
