From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 21 Feb 2014 22:52:34 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
Message-ID: <5307CAA2.8060406@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried the following short semantic patch out on a source file directory
for Linux 3.13.1.

@Remove_unnecessary_pointer_checks@
expression x;
@@
-if (x)
    kfree(x);


Some update candidates were found. I imagine that this search pattern can be
extended a bit more.
How do think about the applicability of corresponding changes for current kernel
source code?
What will be a good way to discuss such fixes on other mailing lists eventually?

Regards,
Markus
