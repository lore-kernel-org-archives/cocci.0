From: jengelh@inai.de (Jan Engelhardt)
Date: Thu, 22 Oct 2015 13:04:54 +0200 (CEST)
Subject: [Cocci] Request 339055 commented by jengelh (submit
 devel:tools/coccinelle)
In-Reply-To: <5628BB3A.1060204@users.sourceforge.net>
References: <obs-request-339055@build.opensuse.org>
 <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
 <20151014210450.GI14464@wotan.suse.de>
 <alpine.LSU.2.20.1510142311580.17133@nerf40.vanv.qr>
 <20151014212342.GK14464@wotan.suse.de>
 <alpine.LSU.2.20.1510150045200.18488@nerf40.vanv.qr>
 <562872D8.3060004@users.sourceforge.net>
 <alpine.LSU.2.20.1510220948270.20948@nerf40.vanv.qr>
 <5628BB3A.1060204@users.sourceforge.net>
Message-ID: <alpine.LSU.2.20.1510221256380.5067@nerf40.vanv.qr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


On Thursday 2015-10-22 12:32, SF Markus Elfring wrote:

>> 1. Running `aclocal; autoconf` is not enough. I spot a Makefile.am
>> in the source tree, so you more or less need `autoreconf -fi`
>> instead in the "autogen" script.
>
>Are you interested in achieving progress on a topic like
>'Collateral evolution around "Automake"'?
>https://github.com/coccinelle/coccinelle/issues/41

Sort of.

>> there is no need for coccinelle.spec to run autogen.
>
>Have you got any concerns for the dependency on such a pregenerated script
>together with the discussed distribution package?

If a tarball ships configure, good for us. If it does not, well, then that
means it will take a few seconds more to build and extra dependencies to be
installed. For a build system, all of that is a no-brainer, but for "users", it
can get annoying when they have to install, for example, half of the
gnome-devel stack just to satisfy an m4 macro in case they have to rerun the
configure generator.
