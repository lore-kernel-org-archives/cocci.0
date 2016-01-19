From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 19 Jan 2016 21:24:40 +0100
Subject: [Cocci] Request 339055 commented by jengelh (submit
 devel:tools/coccinelle)
In-Reply-To: <20151210151748.GD2253@pl-59055.rocqadm.inria.fr>
References: <obs-request-339055@build.opensuse.org>
 <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
 <20151014210450.GI14464@wotan.suse.de>
 <alpine.LSU.2.20.1510142311580.17133@nerf40.vanv.qr>
 <20151014212342.GK14464@wotan.suse.de>
 <alpine.LSU.2.20.1510150045200.18488@nerf40.vanv.qr>
 <562872D8.3060004@users.sourceforge.net>
 <alpine.LSU.2.20.1510220948270.20948@nerf40.vanv.qr>
 <20151022131829.GQ9528@wotan.suse.de>
 <20151210151748.GD2253@pl-59055.rocqadm.inria.fr>
Message-ID: <20160119202440.GA11277@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Dec 10, 2015 at 04:17:48PM +0100, S?bastien Hinderer wrote:
> Hi,
> 
> Sorry for the delayed response.
> 
> Luis R. Rodriguez (2015/10/22 15:18 +0200):
> > On Thu, Oct 22, 2015 at 09:51:17AM +0200, Jan Engelhardt wrote:
> > > 
> > > On Thursday 2015-10-22 07:23, SF Markus Elfring wrote:
> > > >
> > > >> Since coccinelle.spec does not invoke autoreconf
> > > >
> > > >How does the script "https://github.com/coccinelle/coccinelle/blob/a46bef70162d17cec6b0fc6101d737989f735ee4/autogen"
> > > >fit to your view?
> > > 
> > > 1. Running `aclocal; autoconf` is not enough. I spot a Makefile.am
> > > in the source tree, so you more or less need `autoreconf -fi`
> > > instead in the "autogen" script.
> 
> Well, the Makefile.am is indeed present but not actually used so are you
> really sure the change you suggest is required?
> 
> Is there any specific problem you are trying to solve with the current
> code?

Note: this was addressed to Markus.

> > > 2. My point was that autogen / aclocal / autoconf / etc.
> > > only needs to be run if there is no "configure" script present.
> > > Because there is a configure script in the released tarballs
> > > (at least there was so far), there is no need for coccinelle.spec to run
> > > autogen. And if autogen/aclocal/autoconf/etc. is not run, we do not need to
> > > BuildRequire it.
> > 
> > The latest tarballs do not require it but the next releases will, so configure
> > will not be carried, so this was more of a heads up note / pro-active
> > patch.
> 
> Well, so far my idea was to not provide configure in a public coccinelle
> repository but to provide it in tarballs, following an approach which I
> believe is common to many open-source projects, i.e. not
> version-controlling any generated file but still distribute them in tarballs.

Sounds good.

  Luis
