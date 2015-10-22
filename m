From: jengelh@inai.de (Jan Engelhardt)
Date: Thu, 22 Oct 2015 09:51:17 +0200 (CEST)
Subject: [Cocci] Request 339055 commented by jengelh (submit
 devel:tools/coccinelle)
In-Reply-To: <562872D8.3060004@users.sourceforge.net>
References: <obs-request-339055@build.opensuse.org>
 <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
 <20151014210450.GI14464@wotan.suse.de>
 <alpine.LSU.2.20.1510142311580.17133@nerf40.vanv.qr>
 <20151014212342.GK14464@wotan.suse.de>
 <alpine.LSU.2.20.1510150045200.18488@nerf40.vanv.qr>
 <562872D8.3060004@users.sourceforge.net>
Message-ID: <alpine.LSU.2.20.1510220948270.20948@nerf40.vanv.qr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


On Thursday 2015-10-22 07:23, SF Markus Elfring wrote:
>
>> Since coccinelle.spec does not invoke autoreconf
>
>How does the script "https://github.com/coccinelle/coccinelle/blob/a46bef70162d17cec6b0fc6101d737989f735ee4/autogen"
>fit to your view?

1. Running `aclocal; autoconf` is not enough. I spot a Makefile.am
in the source tree, so you more or less need `autoreconf -fi`
instead in the "autogen" script.

2. My point was that autogen / aclocal / autoconf / etc.
only needs to be run if there is no "configure" script present.
Because there is a configure script in the released tarballs
(at least there was so far), there is no need for coccinelle.spec to run
autogen. And if autogen/aclocal/autoconf/etc. is not run, we do not need to
BuildRequire it.
