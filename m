From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Aug 2015 14:10:28 +0200 (CEST)
Subject: [Cocci] Finding designated initialisers with SmPL
In-Reply-To: <55C5EF03.7080201@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <alpine.DEB.2.10.1507201335030.2475@hadrien>
 <55ACF739.4020802@users.sourceforge.net>
 <alpine.DEB.2.10.1507201828130.2475@hadrien>
 <55AD58A7.6030507@users.sourceforge.net>
 <alpine.DEB.2.02.1507202238110.2082@localhost6.localdomain6>
 <55ADDD03.6020401@users.sourceforge.net>
 <55C5B85A.8060508@users.sourceforge.net>
 <alpine.DEB.2.02.1508081338080.2027@localhost6.localdomain6>
 <55C5EF03.7080201@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1508081407370.2027@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Do I stumble on another open issue if I would dare to reuse the SmPL
> construct "<+... ...+>" for such an use case again?

If there were an open issue that I knew of, I would have probably fixed it.

<+... ...+> is useful when you to match a larger top-level piece of code, and
want to see if some subterm appears in it, one or more times.  But if your
pattern matches the whole top-level piece of code itself, then there is no
point to use <+... ...+>.  Either your pattern is there or it is not.  If
itis there, it will be matched with just the pattern itself.  There is no
need for <+... ...+>, because you are not looking for a subterm of
anything.

julia
