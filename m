From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Apr 2017 17:12:18 +0200 (CEST)
Subject: [Cocci] new to cocci, help needed
In-Reply-To: <fef9bec0-99a6-0a40-871a-01eb7972cc61@mykolab.com>
References: <ba1249bd-36ab-a819-34b8-186d84a4ec49@schleiser.de>
 <alpine.DEB.2.20.1704211109020.3038@hadrien>
 <e59dc5e9-df34-27e8-da04-c5590c00edef@schleiser.de>
 <alpine.DEB.2.20.1704211526390.3038@hadrien>
 <f489d08f-793d-6df2-791e-570c33bf25a6@schleiser.de>
 <fef9bec0-99a6-0a40-871a-01eb7972cc61@mykolab.com>
Message-ID: <alpine.DEB.2.20.1704211711560.3038@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> >>>> expression *E1;
> >>>
> >>> That brings me one step further, but now I have "*&", e.g.,
> >>>
> >>> - f(a,b,&E,whatever)
> >>> + f(a,b,&E,sizeof(*&E))
> >>
> >> I think you would want sizeof(E)?
> I normally use a second rule to clean that one up
> @@
> expression E;
> @@
> - *&
>     E

This is a good option too.

julia
