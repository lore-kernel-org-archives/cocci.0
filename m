From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 21 Jun 2016 19:54:42 +0200
Subject: [Cocci] bundles/pycaml/: force pycaml preparation to be done
 serially
In-Reply-To: <CAB=NE6VhQ-4c6U740w6q+yCghBQMp0ces8f3B=wnq18hQLptrw@mail.gmail.com>
References: <1466186657-25309-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606172009220.3164@hadrien>
 <20160617184724.GW11948@wotan.suse.de> <20160617223327.GX11948@wotan.suse.de>
 <7d8c0732-59ba-a49d-4834-48f1dc0285f7@users.sourceforge.net>
 <20160620221839.GL25646@wotan.suse.de>
 <a273d1e4-143d-9850-940b-8f1ccf8c7fa6@users.sourceforge.net>
 <CAB=NE6VhQ-4c6U740w6q+yCghBQMp0ces8f3B=wnq18hQLptrw@mail.gmail.com>
Message-ID: <b130cdc7-d1f0-ab61-b17b-89959e108e10@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Building should work, period.

I would appreciate this also.


> The disabling of parallel building here is just for the prepare target.

I have got the understanding from the make documentation
that the discussed setting does not work in the way
you seem to expect here.
I suggest therefore to consider additional possibilities.

Regards,
Markus
