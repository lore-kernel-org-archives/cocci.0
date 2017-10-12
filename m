From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Thu, 12 Oct 2017 21:23:19 +0200
Subject: [Cocci] make install broken
In-Reply-To: <85d845b3-148f-4169-c2af-ce904655e6dd@users.sourceforge.net>
References: <1791440820.5185535.1507765384109.JavaMail.zimbra@inria.fr>
 <85d845b3-148f-4169-c2af-ce904655e6dd@users.sourceforge.net>
Message-ID: <3ac6bcd7-b8b9-b873-562f-2781d75870af@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/12/2017 05:47 PM, SF Markus Elfring wrote:
>> Yes, but spatch should have resolved the symlink. Anyway, I changed
>> the code to use realpath, which should be more reliable (the code
>> before only resolved symlinks on the executable file, without
>> considering parent directories).
>>
>> Sorry for the wrong commit!
> 
> Is this software development also relevant for the following error messages?
> 
> elfring at Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/janitor/?.cocci ?.c
> warning: Can't find macro file: /usr/local/bin/../lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/bin/../lib/coccinelle/standard.iso
> Python error: No module named coccilib.elems
Correct. It fixes that issue.

bye
	michael
