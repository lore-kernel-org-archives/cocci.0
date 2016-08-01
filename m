From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 1 Aug 2016 14:03:25 +0200 (CEST)
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <0dbd2dd6-4c68-1f7c-1500-9e5d40047813@users.sourceforge.net>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <alpine.DEB.2.10.1608011336590.3188@hadrien>
 <0dbd2dd6-4c68-1f7c-1500-9e5d40047813@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608011359210.3188@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 1 Aug 2016, SF Markus Elfring wrote:

> >> 1. Would it make sense to merge such SmPL rules into one
> >>    so that code duplication could be reduced a bit
> >>    in such a script?
> >
> > I think it would suffer in readability.
>
> How do you think about the following SmPL script example?
>
> @vz_combined
>  depends on patch && !context && !org && !report@
> type T;
> T* pointer;
> +statement S;
> expression express;
> @@
>  pointer =
> -          vmalloc
> +          vzalloc
>            (...);
>  if (!d)
>     S
> -memset(d, 0, sizeof(
> (
> -T
> |
> -*(express)
> )
> -));

OK, I thought you meant to make a big disjunctions for all of the before
and after functions.  This is a little better because it is bounded in
size.  But I don't understand why you have introduced the variable
express.  Normally one wants the cleared space to be the allocated size,
which is normally the size of *pointer.

The performance issue is that disjunctions on expressions, eg (A | B), are
implemented as (A | (!A & B)), ie with a negation of all the previous
options &d with each option.  So it is better to avoid very large
disjunctions on expressions.

julia


>
>
> > Perhaps in performance as well.
>
> I admit that I am unsure about the run-time characteristics
> for my suggestion.
>
> Regards,
> Markus
>
