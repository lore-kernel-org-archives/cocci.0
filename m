From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 29 Oct 2014 09:29:59 +0100
Subject: [Cocci] Parsing errors in several headers
In-Reply-To: <544FED2B.2030305@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
Message-ID: <5450A587.1080709@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I wanted to add a #define just above a function prototype or the
> function itself.
[...]
> @rule1@
> identifier func;
> @@
> 
> -#define        func    BAR(func)

I find this SmPL approach strange according to your description.
- Would you really like to delete the definition for a preprocessor symbol here?
- Should this semantic patch express the change to move the position of such a
statement to other source code places?

Regards,
Markus
