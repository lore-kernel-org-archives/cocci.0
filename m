From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 22 Oct 2015 12:32:26 +0200
Subject: [Cocci] Request 339055 commented by jengelh (submit
 devel:tools/coccinelle)
In-Reply-To: <alpine.LSU.2.20.1510220948270.20948@nerf40.vanv.qr>
References: <obs-request-339055@build.opensuse.org>
 <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
 <20151014210450.GI14464@wotan.suse.de>
 <alpine.LSU.2.20.1510142311580.17133@nerf40.vanv.qr>
 <20151014212342.GK14464@wotan.suse.de>
 <alpine.LSU.2.20.1510150045200.18488@nerf40.vanv.qr>
 <562872D8.3060004@users.sourceforge.net>
 <alpine.LSU.2.20.1510220948270.20948@nerf40.vanv.qr>
Message-ID: <5628BB3A.1060204@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> 1. Running `aclocal; autoconf` is not enough. I spot a Makefile.am
> in the source tree, so you more or less need `autoreconf -fi`
> instead in the "autogen" script.

Are you interested in achieving progress on a topic like
'Collateral evolution around "Automake"'?
https://github.com/coccinelle/coccinelle/issues/41


> 2. My point was that autogen / aclocal / autoconf / etc.
> only needs to be run if there is no "configure" script present.

That is usual.


> Because there is a configure script in the released tarballs
> (at least there was so far),

This might look convenient.


> there is no need for coccinelle.spec to run autogen.

Have you got any concerns for the dependency on such a pregenerated script
together with the discussed distribution package?

Regards,
Markus
