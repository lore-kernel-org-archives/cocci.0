From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 27 Mar 2014 19:59:38 +0100
Subject: [Cocci] How to exclude volatile data accesses in expressions
	with SmPL?
In-Reply-To: <alpine.DEB.2.10.1403271942390.2088@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53342A9C.9070406@users.sourceforge.net>
 <alpine.DEB.2.10.1403271907390.2088@hadrien>
 <5334705A.9050303@users.sourceforge.net>
 <alpine.DEB.2.10.1403271942390.2088@hadrien>
Message-ID: <5334751A.2020309@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Coccinelle makes an effort to infer types.  YOu may need to use eg
> --recursive-includes and --relax-include-path to get the most possible
> type information.

It is nice when a simple filter pattern works in principle. A filter
pattern which needs the knowledge about all data type details to
consider relevant constraints will need more time for the data analysis.
I hope that the corresponding execution speed can also be improved.

Regards,
Markus
