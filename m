From: riccardo.lucchese@gmail.com (Riccardo Lucchese)
Date: Tue, 22 Jul 2014 01:25:50 +0200
Subject: [Cocci] Exception "try to delete an expanded token: {" and C macros
Message-ID: <20140721232550.GA20402@rlp>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Running the command (semantic patch is attached)

$ spatch --sp-file macro-err.cocci --dir drivers/staging/octeon-usb/octeon-hcd.c

from the root dir of linux-next-20140721, yields the following error:

init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: drivers/staging/octeon-usb/octeon-hcd.c
Fatal error: exception Failure("drivers/staging/octeon-usb/octeon-hcd.c: 429: try to delete an expanded token: {")


The code around where the exception happens (--->) reads:

/* This macro spins on a field waiting for it to reach a value */
#define CVMX_WAIT_FOR_FIELD32(address, type, field, op, value, timeout_usec)\
--->    ({int result;                                                       \
        do {                                                                \
                uint64_t done = cvmx_get_cycle() + (uint64_t)timeout_usec * \
                        octeon_get_clock_rate() / 1000000;                  \
                type c;                                                     \
                while (1) {                                                 \
                        c.u32 = __cvmx_usb_read_csr32(usb, address);        \
                        if (c.s.field op (value)) {                         \
                                result = 0;                                 \
                                break;                                      \
                        } else if (cvmx_get_cycle() > done) {               \
                                result = -1;                                \
                                break;                                      \
                        } else                                              \
                                cvmx_wait(100);                             \
                }                                                           \
        } while (0);                                                        \
        result; })


Should I change something in my invocation to deal with this macro ?

Thanks,
riccardo

-------------- next part --------------
@@
identifier func;
expression e;
identifier x;
statement S;
@@
func(...) {
<...
* if (<+... (x = e) ...+>) S
...>
}
