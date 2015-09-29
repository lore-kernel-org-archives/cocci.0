From: mmcconville@mykolab.com (Michael McConville)
Date: Tue, 29 Sep 2015 13:51:36 -0400
Subject: [Cocci] Finding all uses of a flag define
In-Reply-To: <alpine.DEB.2.10.1509291942410.2615@hadrien>
References: <20150929173810.GA10442@thinkpad.swarthmore.edu>
 <alpine.DEB.2.10.1509291942410.2615@hadrien>
Message-ID: <20150929175135.GA32346@thinkpad.swarthmore.edu>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall wrote:
> On Tue, 29 Sep 2015, Michael McConville wrote:
> > This is probably a simple question. I'm trying to find all uses of
> > the preproc define M_WAITOK used in the second argument of malloc()
> > or mallocarray(). It may be or'd with other flags in any order.
> 
> malloc(e1, M_WAITOK | ...)

Right, thanks. I was trying to get too fancy by using a disjunction.
I'll just make separate rules for malloc and mallocarray.
