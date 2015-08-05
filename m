From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 5 Aug 2015 23:10:34 +0200
Subject: [Cocci] autotools: add localversion information
In-Reply-To: <55BB1DBB.4030606@users.sourceforge.net>
References: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
 <1438034612-10595-3-git-send-email-mcgrof@do-not-panic.com>
 <55BB1DBB.4030606@users.sourceforge.net>
Message-ID: <20150805211034.GG30479@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jul 31, 2015 at 09:03:23AM +0200, SF Markus Elfring wrote:
> > When working from source, the average user and developer will run just
> > ./autogen, this will peg the local version into the version string.
> 
> How do you think about to collaborate with a command like "autoreconf --install"?
> http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/autoreconf-Invocation.html

Huh? I'll do the least work possible to muck with autoconf crap.

> Do the available build scripts need any more clean-up and improvements?
> https://github.com/coccinelle/coccinelle/blob/e7dd46783d6addd7efad735144d85ed8fde841ce/configure.ac#L11

That's such a general and braod question. The answer is: like with
any system, tons, so take your pick and work on it if you wish.

  Luis
