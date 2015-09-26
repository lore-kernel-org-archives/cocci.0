From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 Sep 2015 18:01:15 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <alpine.DEB.2.10.1509261754350.2864@hadrien>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net> <56051D2B.5040802@samsung.com>
 <56064D0B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <56066866.1060602@users.sourceforge.net>
 <alpine.DEB.2.10.1509261144270.2737@hadrien>
 <56066AD4.9060306@users.sourceforge.net>
 <alpine.DEB.2.10.1509261154500.2737@hadrien>
 <560684F3.9090700@users.sourceforge.net>
 <alpine.DEB.2.10.1509261554100.2717@hadrien>
 <5606B837.7030608@users.sourceforge.net>
 <alpine.DEB.2.10.1509261728140.2864@hadrien>
 <5606BEBC.4010305@users.sourceforge.net>
 <alpine.DEB.2.10.1509261754350.2864@hadrien>
Message-ID: <5606C14B.2080400@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Are there any risks to include too many functions?
> 
> Maybe if there are conflicting definitions of the function with different
> return types.  This is probably not a big deal in practice.

Are there any more concerns around the handling of conditional source code
analysis for Linux subsystems?

Regards,
Markus
