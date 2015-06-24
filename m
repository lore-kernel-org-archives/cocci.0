From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 24 Jun 2015 09:36:05 +0200 (CEST)
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506231430140.2554@hadrien>
 <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
Message-ID: <alpine.DEB.2.10.1506240934280.2553@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

For #ifdef, are the terms in the two branches proper expressions normally
(like in your example)?  Perhaps we could do something for that.  Or are
there things like

#ifdef XXX
3 +
#else
4 -
#endif
5

julia
