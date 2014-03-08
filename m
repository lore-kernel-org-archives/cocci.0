From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 08 Mar 2014 13:30:10 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <530DD06F.4090703@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
Message-ID: <531B0D52.5070008@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> A source code search with the following pattern found 893 functions which check
> their single parameter.

I am also interested to generate statistics for the declaration of function
parameters and their use.
Is it possible to analyse the function parameter list by interfaces from the
semantic patch language? Can any useful numbers be extracted at this place?

Regards,
Markus
