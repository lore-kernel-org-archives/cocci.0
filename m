From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 24 Feb 2014 17:34:49 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.10.1402241710370.2074@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
Message-ID: <530B74A9.8050400@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm not sure what is the point of the if (input) is else es pattern.

Now it seems that I added it because of too few considerations for isomorphisms.


> I would think you only want to find cases where the function does nothing
> until it tests input and aborts the function is the value is 0.  So you
> only want the return case.  Before it, you would want
> 
> ... when != S
> 
> where S is a statement typed metavariable.  That way the ... will only
> match declarations.

We have got different expectations about the amount of source code before the
statement "return". A bit more fine-tuning with the SmPL construct "when" might
be needed to achieve further constraints.

Regards,
Markus
