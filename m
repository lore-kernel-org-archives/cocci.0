From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Sep 2015 19:43:18 +0200 (CEST)
Subject: [Cocci] Finding all uses of a flag define
In-Reply-To: <20150929173810.GA10442@thinkpad.swarthmore.edu>
References: <20150929173810.GA10442@thinkpad.swarthmore.edu>
Message-ID: <alpine.DEB.2.10.1509291942410.2615@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 29 Sep 2015, Michael McConville wrote:

> This is probably a simple question. I'm trying to find all uses of the
> preproc define M_WAITOK used in the second argument of malloc() or
> mallocarray(). It may be or'd with other flags in any order.

malloc(e1, M_WAITOK | ...)

julia

>
> A relevant example would be enough.
>
> Thanks,
> Michael
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
