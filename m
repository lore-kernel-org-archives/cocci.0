From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 Oct 2015 07:20:10 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: misc: remove "complex return code"
 warnings
In-Reply-To: <1443652647-23097-1-git-send-email-johan@kernel.org>
References: <1443652647-23097-1-git-send-email-johan@kernel.org>
Message-ID: <alpine.DEB.2.02.1510010716280.2233@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 30 Sep 2015, Johan Hovold wrote:

> This effectively reverts 932058a5d5f9 ("coccinelle: misc: semantic patch
> to delete overly complex return code processing").
> 
> There can be both symmetry and readability reasons for not wanting to do
> the final function call as part of the return statement and to maintain
> a clear separation of success and error paths.
> 
> Since this is in no way mandated by the coding standard, let's just
> remove this semantic patch to avoid having "clean up" patches being
> posted over and over in response to these Coccinelle warnings.

What do you mean by "posted"?  Are you referring to 0-day build testing 
or individual usage of make coccicheck?  Maybe it would make sense to 
remove the semantic patch from 0-day build testing but leave it in the 
kernel, perhaps removing the < 0 case because that one in practice doesn't 
seem to turn up much that is useful?

Perhaps it could also be improved to detect a previous != 0 case and then 
not return a warning.  On some functions, this change can make some nice 
simplifications.

julia

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  scripts/coccinelle/misc/simple_return.cocci | 180 ----------------------------
>  1 file changed, 180 deletions(-)
>  delete mode 100644 scripts/coccinelle/misc/simple_return.cocci
> 
> diff --git a/scripts/coccinelle/misc/simple_return.cocci b/scripts/coccinelle/misc/simple_return.cocci
> deleted file mode 100644
> index e8b6313b116f..000000000000
> --- a/scripts/coccinelle/misc/simple_return.cocci
> +++ /dev/null
> @@ -1,180 +0,0 @@
> -/// Simplify a trivial if-return sequence.  Possibly combine with a
> -/// preceding function call.
> -///
> -// Confidence: High
> -// Copyright: (C) 2014 Julia Lawall, INRIA/LIP6.  GPLv2.
> -// Copyright: (C) 2014 Gilles Muller, INRIA/LiP6.  GPLv2.
> -// URL: http://coccinelle.lip6.fr/
> -// Comments:
> -// Options: --no-includes --include-headers
> -
> -virtual patch
> -virtual context
> -virtual org
> -virtual report
> -
> - at r depends on patch@
> -local idexpression e;
> -identifier i,f,fn;
> -@@
> -
> -fn(...) { <...
> -- e at i =
> -+ return
> -    f(...);
> --if (i != 0) return i;
> --return 0;
> -...> }
> -
> - at depends on patch@
> -identifier r.i;
> -type t;
> -@@
> -
> --t i;
> - ... when != i
> -
> - at depends on patch@
> -expression e;
> -@@
> -
> --if (e != 0)
> -   return e;
> --return 0;
> -
> -// -----------------------------------------------------------------------
> -
> - at s1 depends on context || org || report@
> -local idexpression e;
> -identifier i,f,fn;
> -position p,p1,p2;
> -@@
> -
> -fn(...) { <...
> -* e at i@p = f(...);
> -  if (\(i at p1 != 0\|i at p2 < 0\))
> -     return i;
> -  return 0;
> -...> }
> -
> - at s2 depends on context || org || report forall@
> -identifier s1.i;
> -type t;
> -position q,s1.p;
> -expression e,f;
> -@@
> -
> -* t i at q;
> -  ... when != i
> -  e at p = f(...);
> -
> - at s3 depends on context || org || report@
> -expression e;
> -position p1!=s1.p1;
> -position p2!=s1.p2;
> -@@
> -
> -*if (\(e at p1 != 0\|e at p2 < 0\))
> -   return e;
> - return 0;
> -
> -// -----------------------------------------------------------------------
> -
> - at script:python depends on org@
> -p << s1.p;
> -p1 << s1.p1;
> -q << s2.q;
> -@@
> -
> -cocci.print_main("decl",q)
> -cocci.print_secs("use",p)
> -cocci.include_match(False)
> -
> - at script:python depends on org@
> -p << s1.p;
> -p2 << s1.p2;
> -q << s2.q;
> -@@
> -
> -cocci.print_main("decl",q)
> -cocci.print_secs("use with questionable test",p)
> -cocci.include_match(False)
> -
> - at script:python depends on org@
> -p << s1.p;
> -p1 << s1.p1;
> -@@
> -
> -cocci.print_main("use",p)
> -
> - at script:python depends on org@
> -p << s1.p;
> -p2 << s1.p2;
> -@@
> -
> -cocci.print_main("use with questionable test",p)
> -
> - at script:python depends on org@
> -p << s3.p1;
> -@@
> -
> -cocci.print_main("test",p)
> -
> - at script:python depends on org@
> -p << s3.p2;
> -@@
> -
> -cocci.print_main("questionable test",p)
> -
> -// -----------------------------------------------------------------------
> -
> - at script:python depends on report@
> -p << s1.p;
> -p1 << s1.p1;
> -q << s2.q;
> -@@
> -
> -msg = "WARNING: end returns can be simpified and declaration on line %s can be dropped" % (q[0].line)
> -coccilib.report.print_report(p[0],msg)
> -cocci.include_match(False)
> -
> - at script:python depends on report@
> -p << s1.p;
> -p1 << s1.p1;
> -q << s2.q
> -;
> -@@
> -
> -msg = "WARNING: end returns may be simpified if negative or 0 value and declaration on line %s can be dropped" % (q[0].line)
> -coccilib.report.print_report(p[0],msg)
> -cocci.include_match(False)
> -
> - at script:python depends on report@
> -p << s1.p;
> -p1 << s1.p1;
> -@@
> -
> -msg = "WARNING: end returns can be simpified"
> -coccilib.report.print_report(p[0],msg)
> -
> - at script:python depends on report@
> -p << s1.p;
> -p2 << s1.p2;
> -@@
> -
> -msg = "WARNING: end returns can be simpified if negative or 0 value"
> -coccilib.report.print_report(p[0],msg)
> -
> - at script:python depends on report@
> -p << s3.p1;
> -@@
> -
> -msg = "WARNING: end returns can be simpified"
> -coccilib.report.print_report(p[0],msg)
> -
> - at script:python depends on report@
> -p << s3.p2;
> -@@
> -
> -msg = "WARNING: end returns can be simpified if tested value is negative or 0"
> -coccilib.report.print_report(p[0],msg)
> -- 
> 2.4.9
> 
> 
