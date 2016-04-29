From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 29 Apr 2016 21:00:54 +0200 (CEST)
Subject: [Cocci] Odd behaviour for ... and sub-expressions
In-Reply-To: <57239B93.9020600@redhat.com>
References: <57239B93.9020600@redhat.com>
Message-ID: <alpine.DEB.2.02.1604292100370.2060@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 29 Apr 2016, Michael Stefaniuc wrote:

> Hello,
> 
> I'm observing an odd behaviour difference when using an ellipses
> following a plain expression or a sub-expression in <+... ...+>
> 
> Following coccinelle rule does not behave as expected:
> 
> // Sanity check to not use a RECT field in the SetRect.
> @@
> expression rect;
> identifier fld;
> @@
>   SetRect(&rect, ...,
> -                     <+... rect.fld ...+>
> +                     BADBADBAD
>                                 ,...)
> 
> It does not matches cases where the bad subexpression is the last
> argument of the function call. E.g. for
> 
> void foo(void)
> {
>     RECT r;
>     SetRect(&r, 0, 0, r.left, 0);
>     SetRect(&r, 0, 0, 0, r.top);
>     SetRect(&r, 0, 0, r.left + 1, 0);
>     SetRect(&r, 0, 0, 0, r.top + 1);
> }
> 
> it modifies just the 1st and 3rd SetRect() call while it should match
> all 4 cases.
> 
> If I just use rect.fld without the <+... ...+> the rule will match
> correctly both the 1st and 2nd SetRect() call aka it matches at the end
> of the argument list too.
> 
> Is this a bug? I'm running coccinelle 1.0.4.

Surely a bug.  Thanks for the report.

julia

> 
> thanks
> bye
>      michael
> 
> P.S.: As a workaround I have created a separate rule for the last
> argument and that works.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
