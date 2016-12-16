From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Dec 2016 20:21:35 +0100 (CET)
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <20161216191011.cgxsa7mymssrjtsx@fbsd-laptop>
References: <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
 <alpine.DEB.2.10.1612161453460.6500@hadrien>
 <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
 <alpine.DEB.2.10.1612161531110.6500@hadrien>
 <20161216144645.h3tl5m3f5333zif2@fbsd-laptop>
 <alpine.DEB.2.10.1612161549220.6500@hadrien>
 <20161216170814.netw7heh2bdyvmm5@fbsd-laptop>
 <alpine.DEB.2.10.1612161929450.3239@hadrien>
 <20161216183705.madw4mpsfqmkvmky@fbsd-laptop>
 <alpine.DEB.2.10.1612162004510.3178@hadrien>
 <20161216191011.cgxsa7mymssrjtsx@fbsd-laptop>
Message-ID: <alpine.DEB.2.10.1612162018470.3178@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The problem for the vset function is that a pattern like

A
...

requires that there be no A along all paths leaving from the matched A.
Your code matching the first pattern is in a loop, so obviously there is
at least one path that reaches A again.  So the rule doesn't match.  If
you want to consider the region until A optionally occurs again, then you
can write:

A
...
?A

The ? makes it optional.

julia
