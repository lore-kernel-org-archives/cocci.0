From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 02 Jul 2015 09:23:26 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <alpine.DEB.2.02.1507020806020.2017@localhost6.localdomain6>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
 <558818EE.8000900@users.sourceforge.net> <55892843.7070001@gmail.com>
 <55892D6D.5000001@users.sourceforge.net>
 <20150623172811.GU11147@wotan.suse.de> <5593A5BE.7090308@gmail.com>
 <559402D7.7020203@users.sourceforge.net>
 <alpine.DEB.2.02.1507020806020.2017@localhost6.localdomain6>
Message-ID: <5594E6EE.90202@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> What does "Yes, in principle" mean?

My knowledge might be still incomplete for this issue.


> Did you actually change anything to lib64, or specify lib64 on a command line,

No.


> because you considered that on your 64 bit system that was the better choice?

I find such technical detail still ordinary.


> Because there are hard coded instances of lib in the various configuration files.

Would it make sense to change this?


> So it seems hard to understand how a hard coded occurrence of lib 
> could be transformed into lib64.

How do you think about to add any dedicated configuration options?
Are additional variables needed?

Does this specific name "lib" refer to the well-known directory
where shared libraries should usually be stored?

Regards,
Markus
