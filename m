From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 15 Dec 2016 07:40:54 +0100
Subject: [Cocci] non-static data structure selection by SmPL
In-Reply-To: <alpine.DEB.2.10.1612142235170.4147@hadrien>
References: <a0aae8e0-28f3-d841-8750-3b56333bf07a@users.sourceforge.net>
 <alpine.DEB.2.10.1612142235170.4147@hadrien>
Message-ID: <666a6647-cc34-2862-2896-f78a9e116066@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I have no idea what you are talking about.

I got the impression that recent extensions for the Coccinelle software could
increase the chances to update the support for special constraints a bit more.


> What is wrong with the rule that is shown?

This SmPL specification is still working for a while.

I became curious once more if there are further possibilities to select in
a single SmPL rule if a storage-class specifier like ?static? was not (!) specified.
How do you think about to reduce the dependency on position variables (or internal
database tables) for such source code checking?

Regards,
Markus
