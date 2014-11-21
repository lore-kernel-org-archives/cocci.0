From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Nov 2014 07:07:26 +0100 (CET)
Subject: [Cocci] Ignore Code in Macro Def
In-Reply-To: <1416521057.28778.25.camel@QNXWS8653-PC>
References: <1416521057.28778.25.camel@QNXWS8653-PC>
Message-ID: <alpine.DEB.2.02.1411210706260.2030@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 20 Nov 2014, Mitchell Cuddie wrote:

> I am working on a patch that manipulates null pointer usage. However the
> second rule matches code inside macros which causes issues. Is there a
> way to have rule 2 skip macros or rule 1 match against them and thereby
> deactivate rule 2?

Could you send an example of a macro where you don't want a match?

thanks,
julia

> 
> Cheers
> 
> Mitchell
> 
> @p_null disable is_null, isnt_null1, is_zero, isnt_zero@
> expression *E;
> type T;
> position p;
> T *f;
> @@
> (
>     \(E\|f(...)\) == @p NULL
> |
>     \(E\|f(...)\) != @p NULL
> |
>     E =@p NULL
> )
> 
> @np_null depends on !p_null && !ptr_zero disable is_null, isnt_null1,
> is_zero, isnt_zero@
> position p;
> T g;
> expression F;
> @@
> (
>     \(F\|g(...)\)  == @p
> -   NULL
> +   0   
> |
>     \(F\|g(...)\)  != @p
> -   NULL
> +   0
> |
>     F  = @p
> -   NULL
> +   0
> )
> 
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
