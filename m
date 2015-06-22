From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Mon, 22 Jun 2015 15:41:01 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <55852F40.4000502@users.sourceforge.net>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net>
Message-ID: <5588106D.7020305@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On 20/06/2015 11:15, SF Markus Elfring wrote:
>> How should such a surprise be fixed?
> I can circumvent the open issue by a symbolic link for a while.
>
> Sonne:~ # ln -s /usr/local/lib64/coccinelle /usr/local/lib/coccinelle
>
>
> elfring at Sonne:~> spatch -version
> spatch version 1.0.1 with Python support and with PCRE support
I am trying to understand the build system in further details and
I would appreciate it if you could send me the commands you called when
you installed coccinelle, so that I can try to reproduce the bug.


Regards,
Quentin
