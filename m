From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 28 Sep 2014 15:44:59 +0200
Subject: [Cocci] Transformations for implementations of functions
 without explicit return type
In-Reply-To: <alpine.DEB.2.10.1409281154140.2481@hadrien>
References: <54279D0D.2050809@users.sourceforge.net>
 <alpine.DEB.2.10.1409281154140.2481@hadrien>
Message-ID: <542810DB.6050304@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


>> Does the current software "Coccinelle" support to transform implementations of
>> functions where a return type was not explicitly specified for it in a source file?
> I think so, but perhaps not in the released version.

Would you like to try out if a function like "my_free" could be adjusted
after the reuse of your recent (unpublished) updates?
https://github.com/gvelez17/glimpse/blob/9557d48221aeaa64a43477c82ff6c66c94324081/index/io.c#L662

Regards,
Markus
