From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 03 Nov 2014 22:30:37 +0100
Subject: [Cocci] Are defensive checks treated differently in specific
	areas?
In-Reply-To: <5457B5C7.7020406@knosof.co.uk>
References: <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <5453C98C.90105@users.sourceforge.net>
 <20141103095059.GL6879@mwanda> <5457A560.2020304@users.sourceforge.net>
 <20141103162528.GT6890@mwanda> <5457B5C7.7020406@knosof.co.uk>
Message-ID: <5457F3FD.9090306@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> The truth is I think that all these patches are bad and they make the
>> code harder to read.
> 
> I disagree, I think the code requires less effort to read without the
> if test.
> 
> A developer reading the code will wonder why kfree does not handle the
> case when its argument is NULL.  This takes effort.

Does it make a difference for you where such safety checks should be
finally placed in the source code?

Do you consider different assumptions for function implementations from
an operating system in comparison to user applications?

How much will corresponding expectations need adjustments with the
software evolution?

Regards,
Markus
