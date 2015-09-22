From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 22 Sep 2015 17:27:48 +0200
Subject: [Cocci] [PATCH v3] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <56000777.6060208@samsung.com>
References: <alpine.DEB.2.02.1509180734350.2064@localhost6.localdomain6>
 <1442831864-25759-1-git-send-email-a.hajda@samsung.com>
 <55FFFFF4.4000007@users.sourceforge.net> <56000777.6060208@samsung.com>
Message-ID: <56017374.3080402@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you mean adding int to 'unsigned long [long]' types, it does not work.
> For some reason it works only without adding int after long.

Do you get any error message for this SmPL approach?
With which source files do you try the extended SmPL script out?

Regards,
Markus
