From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 29 Oct 2014 09:45:20 +0100
Subject: [Cocci] Addition of preprocessor statements with SmPL
In-Reply-To: <5450A6EB.6050803@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450A587.1080709@users.sourceforge.net> <5450A6EB.6050803@dumbbell.fr>
Message-ID: <5450A920.4020503@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I wanted to be able to re-run spatch on an already patched content.
> The use case is to add new function prototypes manually and run spatch
> to handle the associated #define automatically.

Thanks for a bit more explanation.

I imagine that you might need to specify more source code as adjustment context
for a statement deletion to achieve a safer semantic patch.

Regards,
Markus
