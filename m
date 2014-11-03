From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 03 Nov 2014 18:40:48 +0100
Subject: [Cocci] s390/net: Deletion of unnecessary checks before two
 function calls
In-Reply-To: <20141103171625.GU6890@mwanda>
References: <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <5453C98C.90105@users.sourceforge.net>
 <20141103095059.GL6879@mwanda> <5457A560.2020304@users.sourceforge.net>
 <20141103162528.GT6890@mwanda> <5457B268.3020202@users.sourceforge.net>
 <20141103171625.GU6890@mwanda>
Message-ID: <5457BE20.5020205@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you can benchmark the code and the new code is faster then, yes, this
> patch is good and we will apply it.

I guess that I do not have enough resources myself to measure different run time
effects in a S390 environment.


> If you have no benchmarks then do not send the patch.

Are other software developers and testers eventually interested to try a few
pointer check adjustments out a bit more?

Regards,
Markus
