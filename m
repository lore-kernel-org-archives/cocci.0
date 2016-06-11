From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 11 Jun 2016 07:45:28 +0200
Subject: [Cocci] [PATCH 2/4] coccicheck: enable paramap support
In-Reply-To: <1465591332-31113-3-git-send-email-mcgrof@kernel.org>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-3-git-send-email-mcgrof@kernel.org>
Message-ID: <5ec86b43-5fc8-b4b7-11a3-f1cef751270d@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Also enable the load balancing to be dynamic, so that
> if a thread finishes early we keep feeding it.

Is this functionality influenced by the parameter "chunksize"?

Regards,
Markus
