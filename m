From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 25 Feb 2014 22:44:45 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
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
Message-ID: <530D0ECD.5000004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Remember that ... matches the shortest path between what is before and 
> what is after.  So if there is another if test on the same data in the 
> function, that will cause a failure.  If yo udon't care to have this 
> constraint, you can put when any on a ...

Which SmPL "when variant" would you recommend here?

Regards,
Markus
