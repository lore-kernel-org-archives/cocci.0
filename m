From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 28 Aug 2014 18:28:01 +0200 (CEST)
Subject: [Cocci] patch for coccinelle's Makefile
In-Reply-To: <53FF46E5.4070804@inria.fr>
References: <53FF35F5.9040903@inria.fr>
 <alpine.DEB.2.10.1408281616110.4009@hadrien> <53FF46E5.4070804@inria.fr>
Message-ID: <alpine.DEB.2.02.1408281827240.2226@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 28 Aug 2014, Francois BERENGER wrote:

> On 08/28/2014 04:16 PM, Julia Lawall wrote:
> > On Thu, 28 Aug 2014, Francois BERENGER wrote:
> > 
> > > I think the uninstall target can be made much simpler and robust.
> > 
> > Could you explain?  I am not at all familiar with the code.
> 
> Rather than removing things one by one in [...]/share/coccinelle/*
> you can remove directly [...]/share/coccinelle .
> 
> This is more robust since some of the things in [...]/share/coccinelle/*
> are not installed by all make targets but were nonetheless listed
> by the uninstall target (which would fail with an exit 1, which is a problem
> when you package things for opam).

OK, what worries me is that what you suggest seems rather obvious, but I 
don't know why it was not originally done that way.  I will try to find 
out.

julia
