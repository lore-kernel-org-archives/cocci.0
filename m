From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 01 Oct 2014 15:21:46 +0200
Subject: [Cocci] string parameter concatenation
In-Reply-To: <alpine.DEB.2.10.1410011504340.2489@hadrien>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.10.1410011504340.2489@hadrien>
Message-ID: <542BFFEA.4020309@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> String made up of multiple concatenated strings are perhaps not so well supported.
> I don't think that automatic concatenation would be a good idea,
> because some users might not want it.

Does the semantic patch language support to find source code places where values
are constructed out of several substrings?
How much do other string layouts matter in coding styles?

Regards,
Markus
