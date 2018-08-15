From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Aug 2018 10:55:52 +0200
Subject: [Cocci] Adjustment for const qualification
In-Reply-To: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
References: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
Message-ID: <b417bf64-7970-8482-0246-ab00129b4657@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0027-genl-const/genl-const.cocci

How do you think about to try the following SmPL script variant out?

@replacement@
@@
-const
+__genl_const
 struct
(
 genl_multicast_group
|genl_ops
)


Regards,
Markus
