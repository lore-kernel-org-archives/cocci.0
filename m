From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 25 Jul 2015 16:35:24 +0200 (CEST)
Subject: [Cocci] expression list[n] el and ...
In-Reply-To: <CA+MoWDoK_ZD2YEKYn-2ejG+to4SgRg5obz1YKiRKqF4ZmgFNnA@mail.gmail.com>
References: <CA+MoWDoK_ZD2YEKYn-2ejG+to4SgRg5obz1YKiRKqF4ZmgFNnA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1507251634370.2061@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 25 Jul 2015, Peter Senna Tschudin wrote:

> This works fine:
> 
> @r1@
> identifier i;
> position p;
> expression list[n] el;
> @@
> i at p(el)
> 
> @script:python@
> p << r1.p;
> i << r1.i;
> n << r1.n;
> @@
> print "f," + i + "," + n + "," + p[0].file
> 
> But if I change:
> 
> i at p(el)
> 
> to
> 
> i at p(el, ...)
> 
> Then I get multiple matches for each function call: One match for each
> parameter. I don't need the ..., but it was there on my first version,
> so I'm reporting in case this is not a feature.

It's completely normal.  A priori, it doesn't know how long the list 
should be, so it reports all possibilities.

julia
