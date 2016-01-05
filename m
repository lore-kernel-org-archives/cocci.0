From: geyslan@gmail.com (Geyslan G. Bem)
Date: Tue, 5 Jan 2016 13:48:41 -0300
Subject: [Cocci] [PATCH v6] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <CAGG-pUQai30T7B2FAkOHzLLuxh-ej2GhwQgs4BNX=vMe8-gVzw@mail.gmail.com>
References: <alpine.DEB.2.02.1512301502100.2048@localhost6.localdomain6>
 <1451893531-15817-1-git-send-email-a.hajda@samsung.com>
 <CAGG-pUSfBLeyktSP=u-rzjH+Q1LUcdKnh4H9ssTguL5WnKRkZw@mail.gmail.com>
 <alpine.DEB.2.10.1601051401150.2521@hadrien>
 <CAGG-pUQai30T7B2FAkOHzLLuxh-ej2GhwQgs4BNX=vMe8-gVzw@mail.gmail.com>
Message-ID: <CAGG-pUT7mGvd+0KPXDkCv6Px9bFxpQPsJBcMQXZfC5vYCn_Org@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2016-01-05 11:10 GMT-03:00 Geyslan G. Bem <geyslan@gmail.com>:
> 2016-01-05 10:02 GMT-03:00 Julia Lawall <julia.lawall@lip6.fr>:
>>> *** Error in `/usr/lib/coccinelle/spatch': corrupted double-linked
>>> list (not small): 0x0000000001c523d0 ***
>>> ======= Backtrace: =========
>>
>> Wow...  I've never seen an error from OCaml like that.
>>
>> What version of ocaml and Coccinelle are you using?
> $ ocaml -version
> The OCaml toplevel, version 4.02.3
>
> $ spatch --version
> spatch version 1.0.4 with Python support and with PCRE support
Please let me know anything about this issue. I would like to help.

>
>>
>> julia
>>
>>> /usr/lib/libc.so.6(+0x72055)[0x7fb3ec683055]
>>> /usr/lib/libc.so.6(+0x779a6)[0x7fb3ec6889a6]
>>> /usr/lib/libc.so.6(+0x7a2d3)[0x7fb3ec68b2d3]
>>> /usr/lib/libc.so.6(__libc_malloc+0x54)[0x7fb3ec68c3d4]
>>> /usr/lib/coccinelle/spatch(caml_stat_alloc+0x9)[0x42dd14]
>>> /usr/lib/coccinelle/spatch(caml_open_descriptor_in+0x12)[0x432fe2]
>>> /usr/lib/coccinelle/spatch(caml_ml_open_descriptor_in+0xc)[0x43368f]
>>> /usr/lib/coccinelle/spatch(caml_interprete+0x14ba)[0x43e9e1]
>>> /usr/lib/coccinelle/spatch(caml_main+0x371)[0x42b327]
>>> /usr/lib/coccinelle/spatch(main+0xc)[0x43d513]
>>> /usr/lib/libc.so.6(__libc_start_main+0xf0)[0x7fb3ec631610]
>>> /usr/lib/coccinelle/spatch(_start+0x29)[0x417609]
>>> ======= Memory map: ========
>>> 00400000-00452000 r-xp 00000000 08:03 1318169
>>>   /usr/lib/coccinelle/spatch
>>> 00651000-00656000 rw-p 00051000 08:03 1318169
>>>   /usr/lib/coccinelle/spatch
>>> 00656000-00664000 rw-p 00000000 00:00 0
>>> 019ea000-0c642000 rw-p 00000000 00:00 0                                  [heap]
>>> 7fb3e4000000-7fb3e4021000 rw-p 00000000 00:00 0
>>> 7fb3e4021000-7fb3e8000000 ---p 00000000 00:00 0
>>> 7fb3ea931000-7fb3eab32000 rw-p 00000000 00:00 0
>>> 7fb3eae36000-7fb3eaef6000 rw-p 00000000 00:00 0
>>> 7fb3eaef6000-7fb3eaef8000 r-xp 00000000 08:03 2365929
>>>   /usr/lib/python3.5/lib-dynload/_heapq.cpython-35m-x86_64-linux-gnu.so
>>> 7fb3eaef8000-7fb3eb0f7000 ---p 00002000 08:03 2365929
>>>   /usr/lib/python3.5/lib-dynload/_heapq.cpython-35m-x86_64-linux-gnu.so
>>> 7fb3eb0f7000-7fb3eb0f8000 r--p 00001000 08:03 2365929
>>>   /usr/lib/python3.5/lib-dynload/_heapq.cpython-35m-x86_64-linux-gnu.so
>>> 7fb3eb0f8000-7fb3eb0fa000 rw-p 00002000 08:03 2365929
>>>   /usr/lib/python3.5/lib-dynload/_heapq.cpython-35m-x86_64-linux-gnu.so
>>> 7fb3eb0fa000-7fb3eb13a000 rw-p 00000000 00:00 0
>>> 7fb3eb787000-7fb3ebb31000 r--p 00000000 08:03 2119451
>>>   /usr/lib/locale/locale-archive
>>> 7fb3ebb31000-7fb3ebe4a000 rw-p 00000000 00:00 0
>>> 7fb3ebfbe000-7fb3ebfd4000 r-xp 00000000 08:03 2100676
>>>   /usr/lib/libgcc_s.so.1
>>> 7fb3ebfd4000-7fb3ec1d3000 ---p 00016000 08:03 2100676
>>>   /usr/lib/libgcc_s.so.1
>>> 7fb3ec1d3000-7fb3ec1d4000 rw-p 00015000 08:03 2100676
>>>   /usr/lib/libgcc_s.so.1
>>> 7fb3ec20c000-7fb3ec40e000 rw-p 00000000 00:00 0
>>> 7fb3ec40e000-7fb3ec410000 r-xp 00000000 08:03 2100408
>>>   /usr/lib/libutil-2.22.so
>>> 7fb3ec410000-7fb3ec60f000 ---p 00002000 08:03 2100408
>>>   /usr/lib/libutil-2.22.so
>>> 7fb3ec60f000-7fb3ec610000 r--p 00001000 08:03 2100408
>>>   /usr/lib/libutil-2.22.so
>>> 7fb3ec610000-7fb3ec611000 rw-p 00002000 08:03 2100408
>>>   /usr/lib/libutil-2.22.so
>>> 7fb3ec611000-7fb3ec7ac000 r-xp 00000000 08:03 2100354
>>>   /usr/lib/libc-2.22.so
>>> 7fb3ec7ac000-7fb3ec9ab000 ---p 0019b000 08:03 2100354
>>>   /usr/lib/libc-2.22.so
>>> 7fb3ec9ab000-7fb3ec9af000 r--p 0019a000 08:03 2100354
>>>   /usr/lib/libc-2.22.so
>>> 7fb3ec9af000-7fb3ec9b1000 rw-p 0019e000 08:03 2100354
>>>   /usr/lib/libc-2.22.so
>>> 7fb3ec9b1000-7fb3ec9b5000 rw-p 00000000 00:00 0
>>> 7fb3ec9b5000-7fb3ec9cd000 r-xp 00000000 08:03 2100335
>>>   /usr/lib/libpthread-2.22.so
>>> 7fb3ec9cd000-7fb3ecbcc000 ---p 00018000 08:03 2100335
>>>   /usr/lib/libpthread-2.22.so
>>> 7fb3ecbcc000-7fb3ecbcd000 r--p 00017000 08:03 2100335
>>>   /usr/lib/libpthread-2.22.so
>>> 7fb3ecbcd000-7fb3ecbce000 rw-p 00018000 08:03 2100335
>>>   /usr/lib/libpthread-2.22.so
>>> 7fb3ecbce000-7fb3ecbd2000 rw-p 00000000 00:00 0
>>> 7fb3ecbd2000-7fb3ecc39000 r-xp 00000000 08:03 2100758
>>>   /usr/lib/libncursesw.so.6.0
>>> 7fb3ecc39000-7fb3ece39000 ---p 00067000 08:03 2100758
>>>   /usr/lib/libncursesw.so.6.0
>>> 7fb3ece39000-7fb3ece3d000 r--p 00067000 08:03 2100758
>>>   /usr/lib/libncursesw.so.6.0
>>> 7fb3ece3d000-7fb3ece3f000 rw-p 0006b000 08:03 2100758
>>>   /usr/lib/libncursesw.so.6.0
>>> 7fb3ece3f000-7fb3ece42000 r-xp 00000000 08:03 2100403
>>>   /usr/lib/libdl-2.22.so
>>> 7fb3ece42000-7fb3ed041000 ---p 00003000 08:03 2100403
>>>   /usr/lib/libdl-2.22.so
>>> 7fb3ed041000-7fb3ed042000 r--p 00002000 08:03 2100403
>>>   /usr/lib/libdl-2.22.so
>>> 7fb3ed042000-7fb3ed043000 rw-p 00003000 08:03 2100403
>>>   /usr/lib/libdl-2.22.so
>>> 7fb3ed043000-7fb3ed140000 r-xp 00000000 08:03 2100404
>>>   /usr/lib/libm-2.22.so
>>> 7fb3ed140000-7fb3ed33f000 ---p 000fd000 08:03 2100404
>>>   /usr/lib/libm-2.22.so
>>> 7fb3ed33f000-7fb3ed340000 r--p 000fc000 08:03 2100404
>>>   /usr/lib/libm-2.22.so
>>> 7fb3ed340000-7fb3ed341000 rw-p 000fd000 08:03 2100404
>>>   /usr/lib/libm-2.22.so
>>> 7fb3ed341000-7fb3ed578000 r-xp 00000000 08:03 2128110
>>>   /usr/lib/libpython3.5m.so.1.0
>>> 7fb3ed578000-7fb3ed778000 ---p 00237000 08:03 2128110
>>>   /usr/lib/libpython3.5m.so.1.0
>>> 7fb3ed778000-7fb3ed77a000 r--p 00237000 08:03 2128110
>>>   /usr/lib/libpython3.5m.so.1.0
>>> 7fb3ed77a000-7fb3ed7df000 rw-p 00239000 08:03 2128110
>>>   /usr/lib/libpython3.5m.so.1.0
>>> 7fb3ed7df000-7fb3ed80f000 rw-p 00000000 00:00 0
>>> 7fb3ed80f000-7fb3ed87e000 r-xp 00000000 08:03 2108758
>>>   /usr/lib/libpcre.so.1.2.6
>>> 7fb3ed87e000-7fb3eda7d000 ---p 0006f000 08:03 2108758
>>>   /usr/lib/libpcre.so.1.2.6
>>> 7fb3eda7d000-7fb3eda7e000 r--p 0006e000 08:03 2108758
>>>   /usr/lib/libpcre.so.1.2.6
>>> 7fb3eda7e000-7fb3eda7f000 rw-p 0006f000 08:03 2108758
>>>   /usr/lib/libpcre.so.1.2.6
>>> 7fb3eda7f000-7fb3edaa1000 r-xp 00000000 08:03 2100353
>>>   /usr/lib/ld-2.22.so
>>> 7fb3edaa2000-7fb3edc68000 rw-p 00000000 00:00 0
>>> 7fb3edc9f000-7fb3edca0000 rw-p 00000000 00:00 0
>>> 7fb3edca0000-7fb3edca1000 r--p 00021000 08:03 2100353
>>>   /usr/lib/ld-2.22.so
>>> 7fb3edca1000-7fb3edca2000 rw-p 00022000 08:03 2100353
>>>   /usr/lib/ld-2.22.so
>>> 7fb3edca2000-7fb3edca3000 rw-p 00000000 00:00 0
>>> 7ffdc8750000-7ffdc8773000 rw-p 00000000 00:00 0                          [stack]
>>> 7ffdc8796000-7ffdc8798000 r--p 00000000 00:00 0                          [vvar]
>>> 7ffdc8798000-7ffdc879a000 r-xp 00000000 00:00 0                          [vdso]
>>> ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
>>>   [vsyscall]
>>> ./scripts/coccicheck: line 97: 18682 Segmentation fault      (core
>>> dumped) /usr/bin/spatch -D report --very-quiet --no-show-diff
>>> --cocci-file /home/geyslan/Projects/linuxtest/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>>> --all-includes --dir . -I ./arch/x86/include -I
>>> arch/x86/include/generated/uapi -I arch/x86/include/generated -I
>>> include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi
>>> -I ./include/uapi -I include/generated/uapi --include
>>> ./include/linux/kconfig.h --max 8 --index 0
>>> ./scripts/coccicheck: line 97: 18684 Segmentation fault      (core
>>> dumped) /usr/bin/spatch -D report --very-quiet --no-show-diff
>>> --cocci-file /home/geyslan/Projects/linuxtest/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>>> --all-includes --dir . -I ./arch/x86/include -I
>>> arch/x86/include/generated/uapi -I arch/x86/include/generated -I
>>> include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi
>>> -I ./include/uapi -I include/generated/uapi --include
>>> ./include/linux/kconfig.h --max 8 --index 2
>>> ./scripts/coccicheck: line 97: 18685 Aborted                 (core
>>> dumped) /usr/bin/spatch -D report --very-quiet --no-show-diff
>>> --cocci-file /home/geyslan/Projects/linuxtest/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>>> --all-includes --dir . -I ./arch/x86/include -I
>>> arch/x86/include/generated/uapi -I arch/x86/include/generated -I
>>> include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi
>>> -I ./include/uapi -I include/generated/uapi --include
>>> ./include/linux/kconfig.h --max 8 --index 3
>>> ./scripts/coccicheck: line 97: 18686 Segmentation fault      (core
>>> dumped) /usr/bin/spatch -D report --very-quiet --no-show-diff
>>> --cocci-file /home/geyslan/Projects/linuxtest/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>>> --all-includes --dir . -I ./arch/x86/include -I
>>> arch/x86/include/generated/uapi -I arch/x86/include/generated -I
>>> include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi
>>> -I ./include/uapi -I include/generated/uapi --include
>>> ./include/linux/kconfig.h --max 8 --index 4
>>> ./scripts/coccicheck: line 97: 18689 Segmentation fault      (core
>>> dumped) /usr/bin/spatch -D report --very-quiet --no-show-diff
>>> --cocci-file /home/geyslan/Projects/linuxtest/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
>>> --all-includes --dir . -I ./arch/x86/include -I
>>> arch/x86/include/generated/uapi -I arch/x86/include/generated -I
>>> include -I ./arch/x86/include/uapi -I arch/x86/include/generated/uapi
>>> -I ./include/uapi -I include/generated/uapi --include
>>> ./include/linux/kconfig.h --max 8 --index 7
>>> ./drivers/cpufreq/cpufreq-dt.c:87:20-28: WARNING: Unsigned expression
>>> compared with zero: volt_old > 0
>>> ./drivers/cpufreq/scpi-cpufreq.c:36:5-11: WARNING: Unsigned expression
>>> compared with zero: domain < 0
>>> ./drivers/hsi/controllers/omap_ssi.c:327:5-12: WARNING: Unsigned
>>> expression compared with zero: ssi -> id < 0
>>> ./drivers/clk/clk-vt8500.c:462:16-20: WARNING: Unsigned expression
>>> compared with zero: div1 >= 0
>>> ./drivers/clk/clk-vt8500.c:506:16-20: WARNING: Unsigned expression
>>> compared with zero: div1 >= 0
>>> ./drivers/clk/clk-vt8500.c:395:17-21: WARNING: Unsigned expression
>>> compared with zero: div2 >= 0
>>> ./drivers/clk/clk-vt8500.c:463:17-21: WARNING: Unsigned expression
>>> compared with zero: div2 >= 0
>>> ./drivers/clk/clk-vt8500.c:507:17-21: WARNING: Unsigned expression
>>> compared with zero: div2 >= 0
>>> ^CMakefile:1488: recipe for target 'coccicheck' failed
>>> make: *** [coccicheck] Error 1
>>>
>>>
>>> --
>>> Regards,
>>>
>>> Geyslan G. Bem
>>> hackingbits.com
>>>
>
>
>
> --
> Regards,
>
> Geyslan G. Bem
> hackingbits.com



-- 
Regards,

Geyslan G. Bem
hackingbits.com
