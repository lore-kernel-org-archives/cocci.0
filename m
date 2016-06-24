From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 24 Jun 2016 08:18:33 +0200 (CEST)
Subject: [Cocci] Matching stack addresses passed to a function?
In-Reply-To: <CALCETrVprCY9uRtm4EAtx9DYupJWg_exJRrpZWj=6Ja7rmFLhw@mail.gmail.com>
References: <CALCETrVprCY9uRtm4EAtx9DYupJWg_exJRrpZWj=6Ja7rmFLhw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1606240818000.2008@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 23 Jun 2016, Andy Lutomirski wrote:

> Hi all-
> 
> I'm trying to see if I've found all sg_init_one misuses.  Is there a
> way to write a rule that will match obvious code paths that pass a
> stack address into sg_init_one?  Basically, I want to match:
> 
> int foo;
> sg_init_one(..., &foo, ...);
> 
> and:
> 
> int foo[10];
> sg_init_one(..., foo, ...);
> 
> but not:
> 
> void whatever(void *ptr, ...)
> {
>   sg_init_one(..., ptr, ...);
> }
> 
> Is there some way to write a metavariable that refers to a value on
> the stack?  Or can I somehow cleanly match an actual declaration
> followed by a use of the declared variable?

local idexpression x; is a local variable or function parameter
global idexpression x; is something else.

julia



> 
> Thanks,
> Andy
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
