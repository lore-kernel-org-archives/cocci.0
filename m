From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Jun 2017 12:50:25 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706160829130.3459@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
 <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
 <alpine.DEB.2.20.1706152233080.3015@hadrien>
 <75d88a53-ace7-3bea-a3b2-bbc100091e78@users.sourceforge.net>
 <alpine.DEB.2.20.1706160802420.3013@hadrien>
 <8acbcd33-5eb7-08d3-c841-734d0359f87b@users.sourceforge.net>
 <alpine.DEB.2.20.1706160829130.3459@hadrien>
Message-ID: <083937c4-2fa9-d76b-a1dd-f1d5314a69be@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> OK, I don't undertand what command you are doing to get the problem,

Did we achieve a better common understanding in the meantime?


> so I can't reproduce it, so I can't determine whether it is a real issue.

* Are you really keen to achieve this also in your own test environments?

* How much does my build difficulty fit into your development attention
  and software change capacity?


> The OCaml makefile specifies an order in which the files should be
> compiled in the project.  If you are sidestepping that ordering, then you
> are not doing things in the intended manner.

I am just curious to fix the dependency checking (without unexpected
side effects) for build prerequisites somehow in the involved software components.

Regards,
Markus
