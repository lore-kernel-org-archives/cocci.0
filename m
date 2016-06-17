From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 17 Jun 2016 17:18:37 +0200
Subject: [Cocci] [PATCH v2 4/8] scripts: add glimpse.sh for indexing the
 kernel
In-Reply-To: <alpine.DEB.2.10.1606171129200.3164@hadrien>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
 <1466116292-21843-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606171129200.3164@hadrien>
Message-ID: <477f1f1d-f60f-79b9-1f0f-f9cb030c240a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm not sure that this is worth it.  It adds a dependency on a tool
> that seems not to be well maintained.

Would any developers like to achieve further software improvements by
additional means?
How are the chances for corresponding progress from an approach like in
a repository by Luis?
https://github.com/mcgrof/glimpse


> In terms of Coccinelle, I'm not sure that it gives a big benefit.

Under which circumstances will the indexing efforts pay off?


> Attached is a graph showing the file selection time for Coccinelle for a
> selection of fairly complex semantic patches.

Would you like to share more information about test cases for this report?
Which scripts measured the shown data points?

Regards,
Markus
