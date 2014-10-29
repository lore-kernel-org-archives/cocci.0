From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 29 Oct 2014 13:05:18 +0100
Subject: [Cocci] Parsing errors in several headers
In-Reply-To: <alpine.DEB.2.10.1410291123540.26234@hadrien>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450A587.1080709@users.sourceforge.net> <5450A6EB.6050803@dumbbell.fr>
 <alpine.DEB.2.10.1410291123540.26234@hadrien>
Message-ID: <5450D7FE.304@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @@
> identifier func;
> position p != s.p;
> @@
> 
> +#define        func    BAR(func)
> func(...) { ... }

Will the shown position check really work when the variable p is not referenced
in the patch specification block?

Regards,
Markus
