From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 1 Dec 2017 19:57:19 +0100 (CET)
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <1512151378.25588.20.camel@sipsolutions.net>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
 <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
 (sfid-20171201_185732_488308_017133DA)
 <1512151378.25588.20.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1712011954500.2825@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 1 Dec 2017, Johannes Berg wrote:

> On Fri, 2017-12-01 at 09:57 -0800, Remington Furman wrote:
> >
> > Ok, I've rebuilt with 1.0.4, and it applied genl-const.cocci just
> > fine.  But, later on my CPU was held at 100% for 29 minutes:
>
> Yeah, known issue. Give it more time - that particular patch is
> *really* slow. Yes, more than 29 minutes, on my system as well.
>
> What I can recommend is that you remove things from copy-list that you
> don't care about, e.g. bluetooth drivers if you don't need them,
> certain wifi drivers you don't need, etc. (before running gentree.py)

You can also set a timeout, for example --timeout 120 (120 seconds).  It
will report on the files that timed out and you can check on them
manually.  Some other useful options are:

--profile: see how long it spends in each rule or various parts of the
OCaml code

--show-trying: see what function it is working on

--debug see what rule and with what inputs it is working on

It may work better to put --debug before the others.

julia

>
> johannes
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
