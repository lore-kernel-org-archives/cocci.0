From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 02 Apr 2013 12:12:38 +0200
Subject: [Cocci] Analysis for Linux source files
Message-ID: <515AAF16.7000706@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I try out a bit of static source code analysis again by the following command.

elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through>
XY=/usr/src/linux-stable/ && spatch -sp_file list_pass-through_functions.cocci \
-dir $XY \
-I ${XY}include \
-I ${XY}usr/include \
-I ${XY}arch/ia64/include \
-I ${XY}arch/ia64/include/uapi \
-I ${XY}arch/x86/include \
-I ${XY}arch/x86/include/generated \
-I /usr/include \
-I /usr/include/c++/4.7/tr1 \
-recursive_includes \
>list_pass-through_functions-linux.txt \
2>list_pass-through_functions-linux-errors.txt


I notice results like the following in my log file.

...
HANDLING: /usr/src/linux-stable/init/noinitramfs.c
EXN:Failure("empty list, max_min_ii_by_pos")
Note: processing took    85.2s: /usr/src/linux-stable/init/noinitramfs.c
HANDLING: /usr/src/linux-stable/init/do_mounts_md.c
EXN:Failure("empty list, max_min_ii_by_pos")
Note: processing took   109.5s: /usr/src/linux-stable/init/do_mounts_md.c
...


Can the shown error message be avoided?
What does it really mean?

openSUSE package: coccinelle 1.0.0-27.6
spatch version 1.0.0-rc14 with Python support and with Str regexp support

Regards,
Markus
