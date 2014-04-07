From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 07 Apr 2014 17:07:50 +0200
Subject: [Cocci] How to exclude volatile data accesses in expressions
	with SmPL?
In-Reply-To: <alpine.DEB.2.10.1403271942390.2088@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53342A9C.9070406@users.sourceforge.net>
 <alpine.DEB.2.10.1403271907390.2088@hadrien>
 <5334705A.9050303@users.sourceforge.net>
 <alpine.DEB.2.10.1403271942390.2088@hadrien>
Message-ID: <5342BF46.8030405@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Coccinelle makes an effort to infer types.  YOu may need to use eg
> --recursive-includes and --relax-include-path to get the most possible
> type information.

How do you think about to make it possible to check attributes for expressions
in SmPL constraints?

Regards,
Markus
