From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Jun 2016 15:39:03 +0200 (CEST)
Subject: [Cocci] Wrong Matching Order for Alternations
In-Reply-To: <dd5e95c6-a5fc-8c93-3f2d-bff982184b33@redhat.com>
References: <dd5e95c6-a5fc-8c93-3f2d-bff982184b33@redhat.com>
Message-ID: <alpine.DEB.2.10.1606141536420.2950@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Jun 2016, Michael Stefaniuc wrote:

> Hello,
>
> I'm getting the wrong patch generated when using the below alternation:
>
> @@
> typedef RECT;
> RECT *r1;
> RECT *r2;
> expression size;
> @@
> (
> - !memcmp
> + EqualRect
> |
> - memcmp
> + !EqualRect
> )
>             ( r1, r2,
> -                     size
>             )
>
>
> On this code:
> BOOL foo(RECT *r1, RECT *r2)
> {
>     return !memcmp(r1, r2, sizeof(*r1));
> }
>
> Will generate the wrong diff:
> -    return !memcmp(r1, r2, sizeof(*r1));
> +    return !!EqualRect(r1, r2);

It's a parsing issue.  Coccinelle is actually parsing each term that you
put in the disjunction as an expression.  So your pattern is effectively

(!memcmp) (...)

The C code is parsed as:

! (memcmp(...))

So they don't match.  If you want to use a disjunction, you would have to
put the argument list in each branch of the disjunction as well.

julia

>
>
> --parse-cocci seems to show the correct pattern:
> (
> -!
>   >>> EqualRect
> -memcmp(r1, r2, -size)
> |
> -memcmp
>   >>> !EqualRect
> (r1, r2, -size)
> )
>
>
> If I remove the memcmp ==> !EqualRect alternative I get the correct
> patch generated:
> -    return !memcmp(r1, r2, sizeof(*r1));
> +    return EqualRect(r1, r2);
>
>
> I know how to workaround it but I thought I'll mention it here. I am
> still on 1.0.4 but I don't remember to have seen anything in the 1.0.5
> release notes that would fix it.
>
> bye
> 	michael
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
