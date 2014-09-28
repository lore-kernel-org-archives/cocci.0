From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 28 Sep 2014 16:28:34 +0200
Subject: [Cocci] Transformations for implementations of functions
 without explicit return type
In-Reply-To: <alpine.DEB.2.10.1409281603340.2394@hadrien>
References: <54279D0D.2050809@users.sourceforge.net>
 <alpine.DEB.2.10.1409281154140.2481@hadrien>
 <542810DB.6050304@users.sourceforge.net>
 <alpine.DEB.2.10.1409281603340.2394@hadrien>
Message-ID: <54281B12.6030309@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The lack of a return type is not supported for K&R functions.

That is a pity.

Now it seems that a function like "my_free" could only be adjusted after
a patch will be applied from my bug report.
https://github.com/gvelez17/glimpse/issues/6

How do you think about the possibility to transform more such
implementation details from a Kernighan/Ritchie coding style to a
current C standard approach?

Regards,
Markus
