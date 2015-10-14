From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 14 Oct 2015 23:23:42 +0200
Subject: [Cocci] Request 339055 commented by jengelh (submit
 devel:tools/coccinelle)
In-Reply-To: <alpine.LSU.2.20.1510142311580.17133@nerf40.vanv.qr>
References: <obs-request-339055@build.opensuse.org>
 <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
 <20151014210450.GI14464@wotan.suse.de>
 <alpine.LSU.2.20.1510142311580.17133@nerf40.vanv.qr>
Message-ID: <20151014212342.GK14464@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 14, 2015 at 11:12:48PM +0200, Jan Engelhardt wrote:
> On Wednesday 2015-10-14 23:04, Luis R. Rodriguez wrote:
> 
> >On Wed, Oct 14, 2015 at 11:00:32PM +0200, Jan Engelhardt wrote:
> >> Visit https://build.opensuse.org/request/show/339055
> >> 
> >> Jan Engelhardt wrote in request 339055:
> >> 
> >> Why is this even needed? Are changes planned to the implicitly-installed packages in prjconf?
> >
> >Not sure what you mean. The coccinelel build as of today uses the
> >concept of bundles and that requires tar to unpack things.
> 
> tar is in the list of packages installed by default on OBS, just like 
> gcc. And we don't have BuildRequires: gcc everywhere for that reason.

Great, thanks. How about the others?

  Luis
