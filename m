From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 5 May 2018 07:20:04 +0200 (CEST)
Subject: [Cocci] Multiple match versus single header result in conflicts
In-Reply-To: <20180504193010.GA25201@redhat.com>
References: <20180504193010.GA25201@redhat.com>
Message-ID: <alpine.DEB.2.20.1805050718570.2528@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 4 May 2018, Jerome Glisse wrote:

> Following semantics does not update function prototype in header file:
>
> @S@
> identifier I1, I2;
> @@
> struct myop I1 = { ..., .add = I2 , ... };
>
> @U depends on S@
> identifier S.I2;
> identifier A1, A2;
> type T1, T2;
> @@
> int I2(T1 A1,
> +int c,
> T2 A2) { ... }
>
> run with spatch --in-place --sp-file test.spatch --dir . --all-includes
> (tested various includes/headers combinations) on 3 files f1.h f1.c
> f2.c (if f1.c and f2.c are merge together then thing works).
>
> f1.h: ----------------------------------------------------------------
> struct myop {
>     int (*add)(int, int);
> };
>
> int myadd(int, int);
> ----------------------------------------------------------------------
>
> f1.c: ----------------------------------------------------------------
> #include "f1.h"
>
> int myadd(int a, int b)
> {
>     return a + b;
> }
>
> struct myop myop = {
>     .add = myadd,
> };
> ----------------------------------------------------------------------
>
> f2.c: ----------------------------------------------------------------
> #include "f1.h"
>
> int myadd2(int a, int b)
> {
>     return a + b;
> }
>
> struct myop myop2 = {
>     .add = myadd2,
> };
> ----------------------------------------------------------------------
>
> If f1.c and f2.c are just one file than the header files is properly
> updated. The error message is:
>
> different modification result for ./f1.h
>
> I am not sure if there is a way to make the semantic patch work against
> such scenario. So is this expected ? Is my semantic patch wrong ? Or
> is it a bug in coccinelle ?

I believe that Coccinelle just doesn't make the effort to realize that the
modifications are the same.  Probably things will be fine if you don't use
--in-place.

julia
