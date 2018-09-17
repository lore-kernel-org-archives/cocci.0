From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Mon, 17 Sep 2018 23:55:25 +0200
Subject: [Cocci] 0079-netdev-destructor.cocci very slow
Message-ID: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The 0079-netdev-destructor.cocci spatch in backports is very slow for
me. For bigger files I get a warning that it takes over to 15 seconds to
apply it to just one file, for the complete backports tree it takes over
an hour to apply.

This is the patch:
https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0079-netdev-destructor.cocci

When I remove the <-- --> in the first rule, it is applied in some
seconds on the complete tree, so an speed improvement of about 100
times, but it is not working correctly any more. ;-)

Is this normal or how can I improve the spatch to be faster? I am using
coccinelle 1.0.7 build with default configure arguments against the
libraries from Debian stable.

If this is normal I should probably try to reduce the number of files it
tries to apply this against in gentree.py before spatch gets started.

Hauke

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180917/1cbf5f50/attachment.asc>
