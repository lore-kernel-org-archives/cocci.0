From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Jul 2015 08:08:09 +0200 (CEST)
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <559402D7.7020203@users.sourceforge.net>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
 <558818EE.8000900@users.sourceforge.net> <55892843.7070001@gmail.com>
 <55892D6D.5000001@users.sourceforge.net>
 <20150623172811.GU11147@wotan.suse.de> <5593A5BE.7090308@gmail.com>
 <559402D7.7020203@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507020806020.2017@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > Do any of you have an idea why coccinelle was installed in lib64?
> 
> Yes, in principle.   ;-)
> 
> How do you distinguish 64 bit systems nowadays?

What does "Yes, in principle" mean?  Did you actually change anything to 
lib64, or specify lib64 on a command line, because you considered that on 
your 64 bit system that was the better choice?

Because there are hard coded instances of lib in the various configuration 
files.  So it seems hard to understand how a hard coded occurrence of lib 
could be transformed into lib64.

julia
