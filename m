From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 28 Jun 2014 20:32:45 +0200 (CEST)
Subject: [Cocci] [PATCH V3] scripts/coccinelle/free: Delete NULL test
 before freeing functions?
In-Reply-To: <53AE8613.8080600@users.sourceforge.net>
References: <1403945247-21549-1-git-send-email-fabf@skynet.be>
 <53AE8613.8080600@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1406282030260.2538@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 28 Jun 2014, SF Markus Elfring wrote:

>
> > V3:
> >    -Update print_main message.
>
> Does the discussion topic need also an adjustment?
>
> How do you think about my previous update suggestion "Deletion of
> unnecessary checks before specific function calls"?
> https://systeme.lip6.fr/pipermail/cocci/2014-March/000675.html
> https://lkml.org/lkml/2014/3/5/344

I would prefer to accept Fabian's semantic patch for the moment, as it
considers a more restricted, well thought out, set of functions,

julia
