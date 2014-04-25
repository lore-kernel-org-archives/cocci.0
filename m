From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 25 Apr 2014 23:31:33 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv=nPEuQ0U22Lk0Pa8U=qwfLODKPGKgAoY8SKdW4L8srGoA@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <535A7186.1020301@users.sourceforge.net>
 <CABxcv=nPEuQ0U22Lk0Pa8U=qwfLODKPGKgAoY8SKdW4L8srGoA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1404252330580.2176@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 25 Apr 2014, Javier Martinez Canillas wrote:

> Hello Markus,
> 
> On Fri, Apr 25, 2014 at 4:30 PM, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
> >> I was wondering if the change I'm doing manually could be automated by
> >> using cocinelle but I've no experience neither writing semantic
> >> patches nor the SmPL language grammar.
> >
> > I would like to point out a general consideration.
> >
> > Semantic patches can be developed for some use cases. I find that
> > corresponding efforts are only useful if such a generalised patch can be
> > applied to a source code base several times.
> > I doubt that you want to try it out for a single source code adjustment.
> > It might be that a need will appear to perform a transformation once
> > more a bit later, doesn't it?
> >
> 
> Thanks a lot for your feedback.
> 
> I understand the the primary use for cocinelle could be to have
> generalized patches that can detect common semantic errors to have a
> flexible and extensible static analysis.

Making this kind of frequent change is a perfectly reasonable, indeed 
intended, use of Coccinelle.

julia


> In this case I'm interested in a different use case though. I'm doing
> a kernel wide change on a core API used by a lot of drivers (~250) so
> is a lot of work to do this manually and I can miss a driver when
> grepping the code. And even if I manage to do all the manual changes
> (I've already changed a bunch of them), I don't have cross-compiler to
> at least build test the drivers for every single architecture to find
> out if I made a silly programming mistake.
> 
> So I think that it is much safer to express the change as a semantic
> patch even if the change is going to be made only once, in order to
> avoid introducing any build regressions.
> 
> Best regards,
> Javier
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
