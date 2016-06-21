From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 21 Jun 2016 18:22:57 +0200
Subject: [Cocci] bundles/pycaml/: force pycaml preparation to be done
	serially
In-Reply-To: <20160620221839.GL25646@wotan.suse.de>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606172009220.3164@hadrien>
 <20160617184724.GW11948@wotan.suse.de> <20160617223327.GX11948@wotan.suse.de>
 <7d8c0732-59ba-a49d-4834-48f1dc0285f7@users.sourceforge.net>
 <20160620221839.GL25646@wotan.suse.de>
Message-ID: <a273d1e4-143d-9850-940b-8f1ccf8c7fa6@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> ?, the only consistent fix seems to be to use
> .NOTPARALLEL on all bundles.

How do you think about a bit more fine-tuning for this setting?

Would you really like to switch parallelisation off for the affected make scripts completely?

Regards,
Markus
