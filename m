From: luciano.coelho@intel.com (Luciano Coelho)
Date: Tue, 14 Aug 2018 16:32:14 +0300
Subject: [Cocci] New release after 1.0.7?
In-Reply-To: <alpine.DEB.2.20.1808141515280.3371@hadrien>
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
Message-ID: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

Thanks for the quick response!

On Tue, 2018-08-14 at 15:19 +0200, Julia Lawall wrote:
> 
> On Tue, 14 Aug 2018, Luciano Coelho wrote:
> 
> > Hi,
> > 
> > Is there a plan for a new release after 1.0.7? 1.0.7 was not tagged
> > and
> > no tarballs were released, so I'm not sure what is the status of
> > it.
> > Additionally, I've had problems compiling it, and bisected it to
> > this
> > commit:
> > 
> > commit 7ab8f01b63d7cdec988e5f05065f3c18fdab7319 (refs/bisect/bad)
> > Author:     Thierry Martinez <thierry.martinez@inria.fr>
> > AuthorDate: Wed Jun 20 15:46:18 2018 +0200
> > Commit:     Thierry Martinez <thierry.martinez@inria.fr>
> > CommitDate: Wed Jun 20 15:46:18 2018 +0200
> > 
> >     Allow bytecode compilation for pyml/generate
> > 
> >     This change generalizes a patch submitted by
> >       Christopher Zimmermann <chrisz@openbsd.org>
> >     for allowing pyml/generate to be compiled by ocamlc if ocamlopt
> >     is not available.
> > 
> >     The rules are adapted from pyml-current/Makefile.
> > 
> > Nevertheless, the compilation problem I had seems to be fixed in
> > the
> > latest master (commit 97695d059cd5).
> > 
> > We (in the Linux backports project) have made a change to support
> > the
> > new attributes style[1], which was supposed to work with 1.0.6, but
> > that seems to be broken too.
> > 
> > We don't want to revert to using the pre-1.0.6 versions, so we are
> > waiting for new release to choose for our project.  So, my question
> > again, can we expect a new stable release any time soon?
> 
> Sorry, I'm not sure where 1.0.7 came from.

This is the version bump in the git repo:

commit c1522bde1ffff0ba8b977fd1e9bd259635ef6a3a
Author:     Thierry Martinez <thierry.martinez@inria.fr>
AuthorDate: Wed Jul 4 16:06:35 2018 +0200
Commit:     Thierry Martinez <thierry.martinez@inria.fr>
CommitDate: Wed Jul 4 16:57:00 2018 +0200

    Release 1.0.7



>   I think that the compilation
> issues should not be resolved, although if someone still sees
> problems
> with the github version please report them.  I'm surprised that the
> attributes have degraded, since I don't recall a change with respect
> to
> that recently.  Could you send a .c and .cocci file that shows the
> problem?

I'm not sure it's a regression, but I just couldn't get the attributes
to work with 1.0.6 either with and without Johannes' changes to upgrade
it to the 1.0.6 syntax.

This is the cocci that doesn't work (which is supposed to work with
1.0.6):

https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0027-genl-const/genl-const.cocci

And, IIRC, this is the file that it's supposed to alter:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/wireless/nl80211.c

> I would indeed like to make a release now that the compiations issues
> are
> resolved and things seem more stable.

Sounds good! :)

--
Cheers,
Luca.
