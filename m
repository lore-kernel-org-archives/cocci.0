From: mcgrof@kenrel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 00:18:39 +0200
Subject: [Cocci] [PATCH] bundles/pycaml/: force pycaml preparation to be
 done serially
In-Reply-To: <7d8c0732-59ba-a49d-4834-48f1dc0285f7@users.sourceforge.net>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606172009220.3164@hadrien>
 <20160617184724.GW11948@wotan.suse.de>
 <20160617223327.GX11948@wotan.suse.de>
 <7d8c0732-59ba-a49d-4834-48f1dc0285f7@users.sourceforge.net>
Message-ID: <20160620221839.GL25646@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jun 18, 2016 at 09:12:16AM +0200, SF Markus Elfring wrote:
> > +.ONESHELL:

This ended causing some loop on some system, the only consistent
fix seems to be to use .NOTPARALLEL on all bundles.

  Luis
