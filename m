From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 09 Mar 2014 14:36:49 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <alpine.DEB.2.10.1403091404230.2101@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <531B771D.3020900@users.sourceforge.net>
 <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
 <531C1FAD.6030009@users.sourceforge.net>
 <alpine.DEB.2.02.1403090906180.2030@localhost6.localdomain6>
 <531C63B8.6090403@users.sourceforge.net>
 <alpine.DEB.2.10.1403091404230.2101@hadrien>
Message-ID: <531C6E71.8020807@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I have no idea.  I would have sort of expected that it would return a
> length of 2, but I guess it is reasonable, and even desirable, that it
> does not.  What answer would you like?

I would expect that it will be treated by the SmPL pattern as a function with a
single named parameter at least. I am unsure how the "ellipsis" should be
counted and matched in the signature eventually.

Does this small source file indicate that there might be further difficulties
for data analysis of variadic functions?

Regards,
Markus
