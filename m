From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Sep 2015 16:53:40 +0200
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <alpine.DEB.2.10.1509151642200.2537@hadrien>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net> <55F8204D.3080606@samsung.com>
 <55F82D02.5010004@users.sourceforge.net>
 <alpine.DEB.2.10.1509151642200.2537@hadrien>
Message-ID: <55F830F4.5010003@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> --recursive-includes is already a parameter.

I am unsure if its effect on source code analysis speed will matter here.


> size_t is also unsigned.

Will such a specification work also without an explicit SmPL typedef?

Regards,
Markus
