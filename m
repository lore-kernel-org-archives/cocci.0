From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 13 Jan 2018 18:38:32 +0100
Subject: [Cocci] Coccinelle: kzalloc-simple: Rename kzalloc-simple to
 zalloc-simple
In-Reply-To: <1515859050-31764-1-git-send-email-himanshujha199640@gmail.com>
References: <1515859050-31764-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <1ce7a532-ecf6-6dcd-1944-c9fc9dab709e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Rename kzalloc-simple to zalloc-simple since now the rule is not
> specific to kzalloc function only, but also to many other zero memory
> allocating functions specified in the rule.

1. Please add the tag ?Suggested-by? to the commit description.

   See also:
   Rename the SmPL script ?kzalloc-?.cocci??
   https://systeme.lip6.fr/pipermail/cocci/2018-January/004803.html
   https://lkml.kernel.org/r/<alpine.DEB.2.20.1801021541070.24055@hadrien>

2. Please try this update suggestion once more by using the command ?git mv?.

Regards,
Markus
