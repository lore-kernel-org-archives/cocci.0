From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Tue, 15 Jan 2013 17:14:54 +0100
Subject: [Cocci] Two identical declarer macros handled differently
Message-ID: <CAACXqO_gsGeqAyNEVYUuLgciCEF6TdyMmrYWZN_kXztTw84yuA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi list. I started writing a script to be a grep for a declarer macro and
print its arguments. For one of the source files however, it produced
a false positive by printing arguments for another declarer macro as
well. Investigating this, I found the following which I think is at
least related, if not the same issue.

With the following two identical D1 and D2 macros, coccinelle fails to
handle D1.

$?more declarer_test.c declarer_test-d2.cocci
::::::::::::::
declarer_test.c
::::::::::::::

static void foo(void *arg)
{
}
D1(foo, 0, 0, 0, 0);

static void bar(void *arg)
{
}
D2(bar, 0, 0, 0, 0);

::::::::::::::
declarer_test-d2.cocci
::::::::::::::
@r@
declarer name D1;
declarer name D2;
expression E1, E2, E3, E4, E5;
@@
        D2(E1, E2, E3, E4, E5);

@script:python@
e1 << r.E1;
e2 << r.E2;
e3 << r.E3;
e4 << r.E4;
e5 << r.E5;
@@
print "MATCH: 1: %s, 2: %s, 3: %s, 4: %s, 5: %s" % (e1, e2, e3, e4, e5)

$?spatch --sp-file declarer_test-d2.cocci declarer_test.c
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: declarer_test.c
MATCH: 1: bar, 2: 0, 3: 0, 4: 0, 5: 0
$?diff declarer_test-d*
6c6
<       D1(E1, E2, E3, E4, E5);
---
>       D2(E1, E2, E3, E4, E5);
$?spatch --sp-file declarer_test-d1.cocci declarer_test.c
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: declarer_test.c
$


So when trying to print D2 it succeeds, but it fails for D1.
Am I doing something wrong here?

BR H?kon L?vdal
