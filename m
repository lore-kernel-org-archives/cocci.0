From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Dec 2016 20:05:35 +0100 (CET)
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <20161216183705.madw4mpsfqmkvmky@fbsd-laptop>
References: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
 <alpine.DEB.2.10.1612161242300.3566@hadrien>
 <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
 <alpine.DEB.2.10.1612161453460.6500@hadrien>
 <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
 <alpine.DEB.2.10.1612161531110.6500@hadrien>
 <20161216144645.h3tl5m3f5333zif2@fbsd-laptop>
 <alpine.DEB.2.10.1612161549220.6500@hadrien>
 <20161216170814.netw7heh2bdyvmm5@fbsd-laptop>
 <alpine.DEB.2.10.1612161929450.3239@hadrien>
 <20161216183705.madw4mpsfqmkvmky@fbsd-laptop>
Message-ID: <alpine.DEB.2.10.1612162004510.3178@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 16 Dec 2016, Thomas Adam wrote:

> On Fri, Dec 16, 2016 at 07:30:46PM +0100, Julia Lawall wrote:
> > The file I got had only pkg_vset, with some comments and includes
> > beforehand.  Perhaps you sent the wrong one.
>
> Sorry, I meant pkg_vset() -- there's too many moving parts!  I'm sending the
> entire .c file so that you might better place it in context with the debug
> file I attached in my previous email.  Needless to say, despite my
> chopping/changing this file, it's still not working.

For me they are all transformed.  What is your version of spatch?  What is
your command line?  What is your semantic patch (you sent it before, but I
no longer have it)?

julia
