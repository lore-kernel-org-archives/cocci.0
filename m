From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Tue, 15 Jan 2013 14:43:09 -0200
Subject: [Cocci] Two identical declarer macros handled differently
In-Reply-To: <CAACXqO_gsGeqAyNEVYUuLgciCEF6TdyMmrYWZN_kXztTw84yuA@mail.gmail.com>
References: <CAACXqO_gsGeqAyNEVYUuLgciCEF6TdyMmrYWZN_kXztTw84yuA@mail.gmail.com>
Message-ID: <CA+MoWDpHWt1aiinQv5YoGfZJOB+D1gmirB5ihKskQpvLtpfGyA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi H?kon L?vdal,

I do not know why, but the problem disappeared when I changed the "D1" name.

$ more test.c test.cocci
::::::::::::::
test.c
::::::::::::::
static void foo(void *arg)
{
}
DD1(foo, 0, 0, 0, 0);

static void bar(void *arg)
{
}
DD2(bar, 0, 0, 0, 0);

::::::::::::::
test.cocci
::::::::::::::
@r@
declarer name DD1;
declarer name DD2;
expression E1, E2, E3, E4, E5;
@@
        DD1(E1, E2, E3, E4, E5);

@script:python@
e1 << r.E1;
e2 << r.E2;
e3 << r.E3;
e4 << r.E4;
e5 << r.E5;
@@
print "MATCH: 1: %s, 2: %s, 3: %s, 4: %s, 5: %s" % (e1, e2, e3, e4, e5)

$ spatch /tmp/test.c /tmp/test.cocci
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /tmp/test.c
MATCH: 1: foo, 2: 0, 3: 0, 4: 0, 5: 0

Can you reproduce this?

[]'s

Peter

On Tue, Jan 15, 2013 at 2:14 PM, H?kon L?vdal <hlovdal@gmail.com> wrote:
> Hi list. I started writing a script to be a grep for a declarer macro and
> print its arguments. For one of the source files however, it produced
> a false positive by printing arguments for another declarer macro as
> well. Investigating this, I found the following which I think is at
> least related, if not the same issue.
>
> With the following two identical D1 and D2 macros, coccinelle fails to
> handle D1.
>
> $ more declarer_test.c declarer_test-d2.cocci
> ::::::::::::::
> declarer_test.c
> ::::::::::::::
>
> static void foo(void *arg)
> {
> }
> D1(foo, 0, 0, 0, 0);
>
> static void bar(void *arg)
> {
> }
> D2(bar, 0, 0, 0, 0);
>
> ::::::::::::::
> declarer_test-d2.cocci
> ::::::::::::::
> @r@
> declarer name D1;
> declarer name D2;
> expression E1, E2, E3, E4, E5;
> @@
>         D2(E1, E2, E3, E4, E5);
>
> @script:python@
> e1 << r.E1;
> e2 << r.E2;
> e3 << r.E3;
> e4 << r.E4;
> e5 << r.E5;
> @@
> print "MATCH: 1: %s, 2: %s, 3: %s, 4: %s, 5: %s" % (e1, e2, e3, e4, e5)
>
> $ spatch --sp-file declarer_test-d2.cocci declarer_test.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: declarer_test.c
> MATCH: 1: bar, 2: 0, 3: 0, 4: 0, 5: 0
> $ diff declarer_test-d*
> 6c6
> <       D1(E1, E2, E3, E4, E5);
> ---
>>       D2(E1, E2, E3, E4, E5);
> $ spatch --sp-file declarer_test-d1.cocci declarer_test.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: declarer_test.c
> $
>
>
> So when trying to print D2 it succeeds, but it fails for D1.
> Am I doing something wrong here?
>
> BR H?kon L?vdal
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



--
Peter
