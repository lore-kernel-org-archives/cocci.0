From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Tue, 23 Jun 2015 11:34:59 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <558818EE.8000900@users.sourceforge.net>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
 <558818EE.8000900@users.sourceforge.net>
Message-ID: <55892843.7070001@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On 22/06/2015 16:17, SF Markus Elfring wrote:
>> I am trying to understand the build system in further details
> The build scripts contain some update candidates for a while.
>
>
>> and I would appreciate it if you could send me the commands
>> you called when you installed coccinelle,
> The corresponding command is just the ordinary "make install".
What about configure ? Did you specify "--libdir=/usr/local/lib64" ?
>
>> so that I can try to reproduce the bug.
> Do you work also with a subdirectory "lib64" occasionally?
>
> Do settings need improvements for the variables "LIBDIR"
> and "SHAREDIR" (in a script template)?
I did modify that since 1.0.1 release.
In case I missed something could you tell me the distrib you are using ?
