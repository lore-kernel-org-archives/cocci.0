From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 14 Oct 2016 09:01:53 +0200
Subject: [Cocci] Replacing calls of general functions by more specific ones
	with SmPL
Message-ID: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I came during my software development activities along a few Linux source files
where I got an advice by the script "checkpatch.pl" like the following.

WARNING: Prefer seq_puts to seq_printf

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?id=29fbff8698fc0ac1a1d74584b258e0bf18b469f9#n5610


Joe Perches pointed out that the function "seq_putc" would be more appropriate
at a specific source code place.
https://patchwork.kernel.org/patch/9364455/
https://lkml.kernel.org/r/<1475771699.1914.10.camel@perches.com>


Now I am curious on how good the semantic patch language is applicable
for advanced source code transformations in similar use cases.
With which metavariables and corresponding programming interfaces can strings that
are passed to such functions be checked in more detail by the Coccinelle software?

Regards,
Markus
