From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 12 Jul 2017 07:48:45 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170711221701.2zgryrwx4wyhxhnk@eos.mistotebe.net>
References: <20170710162835.xnkjn7btb3cwplsy@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101925350.1978@hadrien>
 <WM!5b84796296144341d624902eddc2fab8cb72294094f53296fafa12642d6a73a74f5216fe1a48aa1018fdaf2162eca726!@mailstronghold-2.zmailcloud.com>
 <20170711130640.heuc3m4mca7vxy52@eos.mistotebe.net>
 <alpine.DEB.2.20.1707111508220.2316@hadrien>
 <WM!c47e11010083686c9aadfde329eb4f31090053d095a60ac9df8bbc8224796e493af84b1948709a4b0a11aa0da4f34967!@mailstronghold-2.zmailcloud.com>
 <20170711142544.dodc2awelxffs6oi@eos.mistotebe.net>
 <alpine.DEB.2.20.1707112123000.2316@hadrien>
 <WM!722e339a1005fef2c134dd9ac0ae6a397244b31d97d213bd70f018388df0843856b835981db31cfffbbceb8ea4d36bdf!@mailstronghold-2.zmailcloud.com>
 <20170711220554.otb33muo5v7o2gcz@eos.mistotebe.net>
 <20170711221701.2zgryrwx4wyhxhnk@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707120747310.2123@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Oh, somehow the end of the format string gets mangled, presumably in the
> Python code, which doesn't expect this at all, so I guess this would be
> the reason the last part of the patch never applies. Sorry.

Yes, it seems to be the inlining of the snprintf string for %s that
doesn't work when the snprintf string ends with a constant.

julia
