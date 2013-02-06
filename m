From: mstefani@redhat.com (Michael Stefaniuc)
Date: Wed, 06 Feb 2013 10:41:44 +0100
Subject: [Cocci] C parse error: multiplication with pointer dereference
Message-ID: <51122558.3090509@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello!

I get this parse error for the attached test case:
spatch --parse-c foo.c 2>&1 | grep BAD
BAD:!!!!!     return i * *j;

gcc -Wall -Werror has no issues with it.


thanks
bye
	michael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: foo.c
Type: text/x-csrc
Size: 70 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130206/e922a328/attachment.bin>
