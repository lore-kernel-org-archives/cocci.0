From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Jun 2016 18:06:32 +0200
Subject: [Cocci] scripts/coccinelle: require coccinelle >= 1.0.4 on
 device_node_continue.cocci
In-Reply-To: <alpine.DEB.2.10.1606151753190.2887@hadrien>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606151042080.2887@hadrien>
 <20160615154918.GN11948@wotan.suse.de>
 <alpine.DEB.2.10.1606151753190.2887@hadrien>
Message-ID: <ff2d8d68-20fb-1572-50e7-94a39107c442@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The above ocaml code just produces eg 1.0.5 or 1.0.5-dirty.  I could drop
> the -dirty at the coccilib level, if that seems desirable.

Are there risks that any more fine-grained checks will be needed for
special functionality?

Regards,
Markus
