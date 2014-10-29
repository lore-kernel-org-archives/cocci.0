From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 29 Oct 2014 11:02:38 +0100 (CET)
Subject: [Cocci] Addition of preprocessor statements with SmPL
In-Reply-To: <5450B739.8050109@users.sourceforge.net>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450B739.8050109@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1410291102110.2459@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 29 Oct 2014, SF Markus Elfring wrote:

> > However, I fail to assemble those two patches in a single concise one.
>
> How do you think about the following approach?
>
> @Add_before_declaration@
> identifier func;
> type t;
> @@
> (
>  #define func BAR(func)
>  t func(...);
> |
> +#define func BAR(func)
>  t func(...);
> )
>
> @Add_before_implementation@
> identifier func;
> type t;
> @@
> (
>  #define func BAR(func)
>  t func(...)
>  { ... }
> |
> +#define func BAR(func)
>  t func(...)
>  { ... }
> )

This doesn't work.  There is no kind of disjunction that includes a
function definition in a branch.

julia

>
>
> Do you need to express a detailed adjustment precondition for a safer semantic
> patch?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
