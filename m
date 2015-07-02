From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Thu, 02 Jul 2015 11:06:20 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <alpine.DEB.2.02.1507021011230.2017@localhost6.localdomain6>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
 <558818EE.8000900@users.sourceforge.net> <55892843.7070001@gmail.com>
 <55892D6D.5000001@users.sourceforge.net>
 <20150623172811.GU11147@wotan.suse.de> <5593A5BE.7090308@gmail.com>
 <559402D7.7020203@users.sourceforge.net>
 <alpine.DEB.2.02.1507020806020.2017@localhost6.localdomain6>
 <5594E6EE.90202@users.sourceforge.net>
 <alpine.DEB.2.02.1507020934160.2017@localhost6.localdomain6>
 <5594F0E0.8090408@users.sourceforge.net>
 <alpine.DEB.2.02.1507021011230.2017@localhost6.localdomain6>
Message-ID: <5594FF0C.7070206@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I am very sorry, I must have made a mistake before I have successfully 
reproduced the bug
I am working on fixing it now.

On 02/07/2015 10:11, Julia Lawall wrote:
> On Thu, 2 Jul 2015, SF Markus Elfring wrote:
>
>>> But changing it at this point will not help to find the source
>>> of your problem.
>> Do we talk about the same meaning for the directory name "lib"?
> The issue is the sequence of letters /lib and /lib64, not what they mean.
>
> julia
