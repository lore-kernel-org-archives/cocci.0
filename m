From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 Sep 2015 17:22:31 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <alpine.DEB.2.10.1509261554100.2717@hadrien>
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
Message-ID: <5606B837.7030608@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It doesn't matter, as long as the type is available.

I suggest to make the circumstances better known when this will be the case.


>> How do you think about reuse another data type enumeration there?
> 
> No idea what you mean by this.

A SmPL variable can also be connected with a data type list which is
discussed here.


>> How would you like to manage names for functions which are not defined
>> in the current source file?
> 
> Why does it matter in this case?

* Will a command-line parameter like "--include-headers-for-types"
  be needed here?

* Would it make sense to work with function name lists in SmPL constraints?


Will any fine-tuning be needed for the execution speed of the evolving
source code analysis?

Regards,
Markus
