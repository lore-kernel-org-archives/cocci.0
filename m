From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 24 Aug 2014 15:00:30 +0200
Subject: [Cocci] Clarification for dependencies in SmPL rules
In-Reply-To: <alpine.DEB.2.10.1408240751210.2460@hadrien>
References: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
 <53F9DD5D.50807@users.sourceforge.net>
 <alpine.DEB.2.10.1408240751210.2460@hadrien>
Message-ID: <53F9E1EE.10002@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Maybe it would be more efficient.  But conceptually it is redundant.

Thanks for your feedback.

I would find it a bit clearer or safer to use a SmPL variable like "r.i" only if
a corresponding dependency was specified on the rule beginning.

Regards,
Markus
