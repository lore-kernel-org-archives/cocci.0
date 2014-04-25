From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 25 Apr 2014 18:24:20 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <535A7186.1020301@users.sourceforge.net>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <535A7186.1020301@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404251823510.3323@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 25 Apr 2014, SF Markus Elfring wrote:

> > I was wondering if the change I'm doing manually could be automated by
> > using cocinelle but I've no experience neither writing semantic
> > patches nor the SmPL language grammar.
>
> I would like to point out a general consideration.
>
> Semantic patches can be developed for some use cases. I find that
> corresponding efforts are only useful if such a generalised patch can be
> applied to a source code base several times.
> I doubt that you want to try it out for a single source code adjustment.
> It might be that a need will appear to perform a transformation once
> more a bit later, doesn't it?

I believe that he has hundreds of use cases.  The attached patch
illustrated a number of them.

julia
