From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 02 Apr 2013 17:17:23 +0200
Subject: [Cocci] Analysis for Linux source files
In-Reply-To: <alpine.DEB.2.02.1304021446260.1939@hadrien>
References: <515AAF16.7000706@users.sourceforge.net>
 <alpine.DEB.2.02.1304021344310.1939@hadrien>
 <515ACBBD.3050309@users.sourceforge.net>
 <alpine.DEB.2.02.1304021446260.1939@hadrien>
Message-ID: <515AF683.5000701@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> When I try, it complains because the parameter fun of store_positions does
> not have an ident field.  Do you not see that problem?

I'm sorry that I did not interpret the error message 'EXN:Failure("empty list,
max_min_ii_by_pos")' as an open issue from my Python function "store_positions".
I try to reuse the implementation that was already mentioned in a previous
discussion.
http://lists.diku.dk/pipermail/cocci/2011-December/002373.html

It works again if I delete the attribute access ".ident"

elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through> spatch -sp_file
list_pass-through_functions2.cocci pt1.c
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: pt1.c
function|"data type"|parameter|"contained in"|"source file"|line|column
my_copy|"char *"|destination||"pt1.c"|1|1
my_append|"char *"|prefix||"pt1.c"|8|1



Was the Pycaml interface changed anyhow in the meantime?
Is the corresponding Coccinelle API still described by a Wiki document?


elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through>
XY=/usr/src/linux-stable/ && spatch -sp_file list_pass-through_functions2.cocci \
-I ${XY}include \
-I ${XY}usr/include \
-I ${XY}arch/ia64/include \
-I ${XY}arch/ia64/include/uapi \
-I ${XY}arch/x86/include \
-I ${XY}arch/x86/include/generated \
-I /usr/include \
-I /usr/include/c++/4.7/tr1 \
-recursive_includes \
${XY}init/calibrate.c
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: /usr/src/linux-stable/init/calibrate.c
(ONCE) TYPE: header ia64intrin.h not found
(ONCE) TYPE: header stl/_prolog.h not found
(ONCE) TYPE: header gnu/stubs-x32.h not found
Fatal error: exception Failure("empty list, max_min_ii_by_pos")


Regards,
Markus
