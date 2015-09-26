From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 Sep 2015 17:50:20 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <alpine.DEB.2.10.1509261728140.2864@hadrien>
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
Message-ID: <5606BEBC.4010305@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> * Will a command-line parameter like "--include-headers-for-types"
>>   be needed here?
> 
> This argument is never needed.  It is only an optimization.  It means that
> he header files are only considered when collecting type information, but
> not whn doing transformation.  But this argument has no effect on the set
> of types tha are available.

I would consider the reuse of the parameter "--recursive-includes" then
so that the most function signatures will be available.
This has got some consequences on the execution speed and configuration
for the source code analysis.

Are there any risks to include too many functions?

Regards,
Markus
