From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Sep 2015 19:54:21 +0200 (CEST)
Subject: [Cocci] Finding all uses of a flag define
In-Reply-To: <20150929175135.GA32346@thinkpad.swarthmore.edu>
References: <20150929173810.GA10442@thinkpad.swarthmore.edu>
 <alpine.DEB.2.10.1509291942410.2615@hadrien>
 <20150929175135.GA32346@thinkpad.swarthmore.edu>
Message-ID: <alpine.DEB.2.10.1509291954060.2615@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 29 Sep 2015, Michael McConville wrote:

> Julia Lawall wrote:
> > On Tue, 29 Sep 2015, Michael McConville wrote:
> > > This is probably a simple question. I'm trying to find all uses of
> > > the preproc define M_WAITOK used in the second argument of malloc()
> > > or mallocarray(). It may be or'd with other flags in any order.
> >
> > malloc(e1, M_WAITOK | ...)
>
> Right, thanks. I was trying to get too fancy by using a disjunction.
> I'll just make separate rules for malloc and mallocarray.

Disjunction should be ok too.

julia
