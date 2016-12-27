From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 27 Dec 2016 19:21:56 +0100 (CET)
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <20160426222442.GA8104@www.outflux.net>
References: <20160426222442.GA8104@www.outflux.net>
Message-ID: <alpine.DEB.2.20.1612271916250.2001@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I totally dropped the ball on this.  Many thanks to Vaishali for
resurrecting it.

Some changes are suggested below.

On Tue, 26 Apr 2016, Kees Cook wrote:

> This is usually a sign of a resized request. This adds a check for
> potential races or confusions. The check isn't 100% accurate, so it
> needs some manual review.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/coccinelle/tests/reusercopy.cocci | 36 +++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 scripts/coccinelle/tests/reusercopy.cocci
>
> diff --git a/scripts/coccinelle/tests/reusercopy.cocci b/scripts/coccinelle/tests/reusercopy.cocci
> new file mode 100644
> index 000000000000..53645de8ae95
> --- /dev/null
> +++ b/scripts/coccinelle/tests/reusercopy.cocci
> @@ -0,0 +1,36 @@
> +/// Recopying from the same user buffer frequently indicates a pattern of
> +/// Reading a size header, allocating, and then re-reading an entire
> +/// structure. If the structure's size is not re-validated, this can lead
> +/// to structure or data size confusions.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2016 Kees Cook, Google. License: GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Comments:
> +// Options: -no_includes -include_headers

The options could be: --no-include --include-headers

Actually, Coccinelle supports both, but it only officially supports the
-- versions.

> +
> +virtual report
> +virtual org

Add, the following for the *s:

virtual context

Then add the following rule:

@ok@
position p;
expression src,dest;
@@

copy_from_user at p(&dest, src, sizeof(dest))

> +
> + at cfu_twice@
> +position p;

Change this to:

position p != ok.p;

> +identifier src;
> +expression dest1, dest2, size1, size2, offset;
> +@@
> +
> +*copy_from_user(dest1, src, size1)
> + ... when != src = offset
> +     when != src += offset

Add the following lines:

     when != if (size2 > e1 || ...) { ... return ...; }
     when != if (size2 > e1 || ...) { ... size2 = e2 ... }

These changes drop cases where the last argument to copy_from_usr is the
size of the first argument, which seems safe enough, and where there is a
test on the size value that can either update it or abort the function.
These changes only eliminate false positives, as far as I could tell.

If it would be more convenient, I could just send the complete revised
patch, or whatever seems convenient.

thanks,
julia

> +*copy_from_user at p(dest2, src, size2)
> +
> + at script:python depends on org@
> +p << cfu_twice.p;
> +@@
> +
> +cocci.print_main("potentially dangerous second copy_from_user()",p)
> +
> + at script:python depends on report@
> +p << cfu_twice.p;
> +@@
> +
> +coccilib.report.print_report(p[0],"potentially dangerous second copy_from_user()")
> --
> 2.6.3
>
>
> --
> Kees Cook
> Chrome OS & Brillo Security
>
