From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Wed, 01 Jul 2015 10:33:02 +0200
Subject: [Cocci] release: 1.0.1: Checking installation dependencies
In-Reply-To: <20150623172811.GU11147@wotan.suse.de>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
 <55845D5F.6010408@users.sourceforge.net>
 <55852F40.4000502@users.sourceforge.net> <5588106D.7020305@gmail.com>
 <558818EE.8000900@users.sourceforge.net> <55892843.7070001@gmail.com>
 <55892D6D.5000001@users.sourceforge.net>
 <20150623172811.GU11147@wotan.suse.de>
Message-ID: <5593A5BE.7090308@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On 23/06/2015 19:28, Luis R. Rodriguez wrote:
> On Tue, Jun 23, 2015 at 11:57:01AM +0200, SF Markus Elfring wrote:
>>> What about configure ?
>>> In case I missed something could you tell me the distrib you are using ?
>> I guess that my usage of openSUSE does not really matter here.
>>
> I ran into the same issue FWIW, and also using OpenSUSE. I used the same fix
> if I remember correctly.
What I don't understand is why coccinelle was installed in /usr/local/lib64.
The pattern lib64 is not used at all in my version of coccinelle's 
source code
and when I installed coccinelle on openSUSE it did end up in lib rather 
than lib64.

Do any of you have an idea why coccinelle was installed in lib64?
Could you send me the result of
grep -n lib64
for coccinelle's directory after executing "./configure"?

Regards,
Quentin
