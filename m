From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 9 Sep 2015 19:57:43 +0100
Subject: [Cocci] Spatch fail on v1.0.2
Message-ID: <CAB3z_Rqaiz1f9TLbpwjU0kZ2yJKKAK-CBdkD8oOQAcLWyA0FRw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Having now updated using OPAM from earlier, my spatch no longer executes.

Has there been a change, whereby I need to adapt my patch? Or was
there a fault in the OPAM installation? or does this patch simply not
run on v.1.0.2?

Spatch available at: https://gist.github.com/kbingham/96477177dd20a72b1c2f

Run it on a linux kernel tree:

with spatch v.1.0.2 I get the following:

kbingham at CookieMonster:/opt/projects/linaro/hikey/kernel$ spatch
--linux-spacing --sp-file patches/i2c-dt.cocci . --in-place
init_defs_builtins: /home/kbingham/.opam/system/lib/coccinelle/standard.h
1115 1116
Fatal error: exception Failure("plus: parse error:
 = File "patches/i2c-dt.cocci", line 66, column 1,  charpos = 1115
    around = ')', whole content =       )
")
kbingham at CookieMonster:/opt/projects/linaro/hikey/kernel$ spatch --version
spatch version 1.0.2 with Python support and with PCRE support


However, re-installing v.1.0.0 executes fine:

kbingham at CookieMonster:/opt/projects/linaro/hikey/kernel$ spatch --version
spatch version 1.0.0-rc22 with Python support and with PCRE support

init_defs_builtins: /usr/share/coccinelle/standard.h
(ONCE) Expected tokens i2c_device_id
Skipping:./firmware/ihex2fw.c
Skipping:./arch/ia64/lib/checksum.c
... <continues>


--
Any thoughts?

Kieran
