From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 23 Jun 2015 11:57:01 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <55892843.7070001@gmail.com>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
 <558818EE.8000900@users.sourceforge.net> <55892843.7070001@gmail.com>
Message-ID: <55892D6D.5000001@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> What about configure ?

There are some software development ideas in the waiting queue.


> Did you specify "--libdir=/usr/local/lib64" ?

No.


>> Do settings need improvements for the variables "LIBDIR"
>> and "SHAREDIR" (in a script template)?
> I did modify that since 1.0.1 release.

Interesting.

How do you think about to make the assignment "@prefix@/lib" configurable
a bit more in the affected script template?


> In case I missed something could you tell me the distrib you are using ?

I guess that my usage of openSUSE does not really matter here.


Would you like to correct also corresponding error display commands?

Regards,
Markus
