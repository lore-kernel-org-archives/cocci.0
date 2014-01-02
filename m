From: eugen@debian.org (Eugeniy Meshcheryakov)
Date: Thu, 2 Jan 2014 21:36:45 +0100
Subject: [Cocci] [PATCH] Support for systems without [gs]etitimer API
Message-ID: <20140102203645.GA26767@localhost.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

After enabling the testsuite execution when building Debian packages I
noticed that the testsuite fails on Debian/Hurd. Every testcase was
failing with Unix_error exception, because while Hurd has getitimer
function, it just returns ENOSYS error there.

The attached patch detects whether the system has working getitimer
function, and if not, makes coccinelle use alarm() API instead.

With this patch coccinelle builds fine on all Debian architectures with
386 successful test cases (expected: 377).

Regards,
Eugeniy Meshcheryakov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: detect-itimer.diff
Type: text/x-diff
Size: 369 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140102/a1b7f518/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140102/a1b7f518/attachment.asc>
