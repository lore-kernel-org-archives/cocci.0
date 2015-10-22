From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 22 Oct 2015 07:23:36 +0200
Subject: [Cocci] Request 339055 commented by jengelh (submit
 devel:tools/coccinelle)
In-Reply-To: <alpine.LSU.2.20.1510150045200.18488@nerf40.vanv.qr>
References: <obs-request-339055@build.opensuse.org>
 <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
 <20151014210450.GI14464@wotan.suse.de>
 <alpine.LSU.2.20.1510142311580.17133@nerf40.vanv.qr>
 <20151014212342.GK14464@wotan.suse.de>
 <alpine.LSU.2.20.1510150045200.18488@nerf40.vanv.qr>
Message-ID: <562872D8.3060004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Since coccinelle.spec does not invoke autoreconf

How does the script "https://github.com/coccinelle/coccinelle/blob/a46bef70162d17cec6b0fc6101d737989f735ee4/autogen"
fit to your view?


> or any of the developer-side regenration tools,

Do you see any more software evolution there?


> we do not need autoconf/automake/libtool in the .spec at all.

Can it occasionally help to make more software dependencies explicit
also in the package specification?

Regards,
Markus
