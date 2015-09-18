From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Sep 2015 07:35:34 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <55F8204D.3080606@samsung.com>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net> <55F8204D.3080606@samsung.com>
Message-ID: <alpine.DEB.2.02.1509180734350.2064@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

 >> +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;

How about adding bool?  I don't currently find any problems with it, but
perhaps some could arise.

julia


> >> +@@
> >> +
> >> +(
> >> +*v at p < 0
> >> +|
> >> +*v at p >= 0
> >> +)
> > How do you think about to use the following SmPL wording instead?
> >
> >  v at p
> > (
> > *< 0
> > |
> > *<= 0
> > )
> >
> > Regards,
> > Markus
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
