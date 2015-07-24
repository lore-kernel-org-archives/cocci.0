From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Fri, 24 Jul 2015 20:53:03 +0200
Subject: [Cocci] [PATCH 1/2] autotools: unify the way to determine
 version information
In-Reply-To: <20150723071244.GA1536@pl-59055.rocqadm.inria.fr>
References: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
 <1437511861-2205-2-git-send-email-mcgrof@do-not-panic.com>
 <CAJLtBvOvZqYf0NP4R-Amu_sc6Cz8=J7_gFsCuKCtM1dQ4yk5tQ@mail.gmail.com>
 <20150723071244.GA1536@pl-59055.rocqadm.inria.fr>
Message-ID: <20150724185302.GO30479@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jul 23, 2015 at 09:12:44AM +0200, S?bastien Hinderer wrote:
> Hi,
> 
> Nikolay Orlyuk (2015/07/23 07:18 +0300):
> > Do we still need VERSION=$(shell ./version.sh | tr -d '\n') ? I'm pretty
> > sure that VERSION=$(shell ./version.sh) will be enough. Same for
> > configure.ac.
> > Moreover why script version.sh can't be simply?
> > 
> > #!/bin/sh
> > > tr -d '\n' < ./version
> > >
> > 
> > Other option would be to introduce subst. variable in configure.ac and use
> > it in configurable Makefile. This approach might be more widespread.
> 
> Yes, I believe this second approach would be better.

Do you mean AC_SUBST()? Using AC_SUBST() is overkill and we don't use automake.
But up to you folks.  I try to avoid using autotools at all costs so if you
would like that instead a replacement patch by you might be more suitable.

  Luis
