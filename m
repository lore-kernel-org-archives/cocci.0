From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Thu, 22 Oct 2015 15:18:29 +0200
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
Message-ID: <20151022131829.GQ9528@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Oct 22, 2015 at 09:51:17AM +0200, Jan Engelhardt wrote:
> 
> On Thursday 2015-10-22 07:23, SF Markus Elfring wrote:
> >
> >> Since coccinelle.spec does not invoke autoreconf
> >
> >How does the script "https://github.com/coccinelle/coccinelle/blob/a46bef70162d17cec6b0fc6101d737989f735ee4/autogen"
> >fit to your view?
> 
> 1. Running `aclocal; autoconf` is not enough. I spot a Makefile.am
> in the source tree, so you more or less need `autoreconf -fi`
> instead in the "autogen" script.

Then autogen should have this as well, how about:

diff --git a/autogen b/autogen
index a80cb14bab1d..42d6372669b6 100755
--- a/autogen
+++ b/autogen
@@ -4,5 +4,4 @@ if [ "$1" = "--ignore_localversion" ]; then
 else
 	unset MAKE_COCCI_RELEASE
 fi
-aclocal -I setup
-autoconf -Wall
+autoreconf -f -i --warnings=all

> 2. My point was that autogen / aclocal / autoconf / etc.
> only needs to be run if there is no "configure" script present.
> Because there is a configure script in the released tarballs
> (at least there was so far), there is no need for coccinelle.spec to run
> autogen. And if autogen/aclocal/autoconf/etc. is not run, we do not need to
> BuildRequire it.

The latest tarballs do not require it but the next releases will, so configure
will not be carried, so this was more of a heads up note / pro-active patch.

  Luis
