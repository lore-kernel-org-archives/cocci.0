From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 21 Sep 2015 15:02:44 +0200
Subject: [Cocci] [PATCH v3] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <1442831864-25759-1-git-send-email-a.hajda@samsung.com>
References: <alpine.DEB.2.02.1509180734350.2064@localhost6.localdomain6>
 <1442831864-25759-1-git-send-email-a.hajda@samsung.com>
Message-ID: <55FFFFF4.4000007@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> v3: added bool type

I would appreciate a bit more feedback for my concerns around your
evolving approach.
* Reuse of "long int"?
* Splitting of the suggested SmPL rule so that each source code check
will be connected with appropriate warning messages.

Will any more fine-tuning be useful?

Regards,
Markus
