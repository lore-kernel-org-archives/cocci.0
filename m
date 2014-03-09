From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 09 Mar 2014 14:51:58 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <alpine.DEB.2.10.1403091439160.2101@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <531C6E71.8020807@users.sourceforge.net>
 <alpine.DEB.2.10.1403091439160.2101@hadrien>
Message-ID: <531C71FE.5010503@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Without knowing what you mean by "data analysis" it is impossible to tell.

I mean the existence check for a parameter like "format" or extraction of a
position for the function signature.


> It is clear that there is some problem with ... matching a parameter-typed metavariable.

Thanks that you agree to this detail. Would you like to test the handling of
variadic macros and functions also in other situations?


> This could be considered reasonable, because ... is not a (single) parameter.

Is there any special mapping of the "ellipsis" at this place in the semantic
patch language needed?

Regards,
Markus
