From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 21 Jun 2016 22:46:52 +0200
Subject: [Cocci] bundles/pycaml/: force pycaml preparation to be done
 serially
In-Reply-To: <20160621203838.GT25646@wotan.suse.de>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606172009220.3164@hadrien>
 <20160617184724.GW11948@wotan.suse.de> <20160617223327.GX11948@wotan.suse.de>
 <7d8c0732-59ba-a49d-4834-48f1dc0285f7@users.sourceforge.net>
 <20160620221839.GL25646@wotan.suse.de>
 <a273d1e4-143d-9850-940b-8f1ccf8c7fa6@users.sourceforge.net>
 <CAB=NE6VhQ-4c6U740w6q+yCghBQMp0ces8f3B=wnq18hQLptrw@mail.gmail.com>
 <b130cdc7-d1f0-ab61-b17b-89959e108e10@users.sourceforge.net>
 <20160621203838.GT25646@wotan.suse.de>
Message-ID: <7a457259-d8e8-45b2-89c8-b18195e5f1f7@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Patches welcomed.

Where do you want to switch parallelisation off exactly?

1. Whole make script

or

2. Treat only a specific preparation target specially.


Regards,
Markus
