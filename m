From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 18 Oct 2014 08:02:00 +0200 (CEST)
Subject: [Cocci] sgen problems
In-Reply-To: <20141018055143.GA1266@katana>
References: <20141017202400.GA2576@katana>
 <alpine.DEB.2.02.1410180726100.2049@localhost6.localdomain6>
 <20141018055143.GA1266@katana>
Message-ID: <alpine.DEB.2.02.1410180800200.2049@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @fix1_context depends on match1 && !patch && (context || org || report)@
> identifier match1.__driver;
> position j0;
> @@
> 
> * 	static struct platform_driver __driver at j0 = {
> 		.driver = {
> 			.owner = THIS_MODULE,
> 		}
> 	};
> 
> @fix2_context depends on match2 && !patch && (context || org || report)@
> identifier match2.__driver;
> position j0;
> @@
> 
> * 	static struct platform_driver __driver at j0 = {
> 		.driver = {
> 			.owner = THIS_MODULE,
> 		}
> 	};

In these cases, I think it would look nicer to put the *s and the @j0's 
on .owner rather than at the start of the structure.

Unless there is some situation in which the transformation is not 
required, I think High confidence would be appropriate.

julia
