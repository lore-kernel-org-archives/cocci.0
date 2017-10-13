From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 13 Oct 2017 09:51:01 +0200
Subject: [Cocci] make install broken
In-Reply-To: <3ac6bcd7-b8b9-b873-562f-2781d75870af@mykolab.com>
References: <1791440820.5185535.1507765384109.JavaMail.zimbra@inria.fr>
 <85d845b3-148f-4169-c2af-ce904655e6dd@users.sourceforge.net>
 <3ac6bcd7-b8b9-b873-562f-2781d75870af@mykolab.com>
Message-ID: <4e0328da-c280-335c-886f-0e3caa36914a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Is this software development also relevant for the following error messages?
>>
>> elfring at Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/janitor/?.cocci ?.c
>> warning: Can't find macro file: /usr/local/bin/../lib/coccinelle/standard.h
>> warning: Can't find default iso file: /usr/local/bin/../lib/coccinelle/standard.iso
>> Python error: No module named coccilib.elems
> Correct. It fixes that issue.

It is nice that the current tool is working for you now as expected.

I am curious on what I need to change more so that I can report the same
for my test system.
Would you like to contribute further ideas?

Regards,
Markus
