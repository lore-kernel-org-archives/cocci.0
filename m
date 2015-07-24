From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Fri, 24 Jul 2015 19:12:28 +0200
Subject: [Cocci] [PATCH 1/2] autotools: unify the way to determine
 version information
In-Reply-To: <CAJLtBvOvZqYf0NP4R-Amu_sc6Cz8=J7_gFsCuKCtM1dQ4yk5tQ@mail.gmail.com>
References: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
 <1437511861-2205-2-git-send-email-mcgrof@do-not-panic.com>
 <CAJLtBvOvZqYf0NP4R-Amu_sc6Cz8=J7_gFsCuKCtM1dQ4yk5tQ@mail.gmail.com>
Message-ID: <20150724171228.GM30479@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jul 23, 2015 at 07:18:34AM +0300, Nikolay Orlyuk wrote: > Do we still need VERSION=$(shell ./version.sh | tr -d '\n') ? I'm pretty
> sure that VERSION=$(shell ./version.sh) will be enough. Same for
> configure.ac.
> Moreover why script version.sh can't be simply?
> 
> #!/bin/sh
> > tr -d '\n' < ./version
> >

These are identical:

VERSION=`cat ./version | tr -d '\n'`
VERSION=`tr -d '\n' < ./version`

I'll give you calling cat can be avoided so lets go with that.
Either way we want to stash it into a variable so we can later
expand on it with something not in the version file which is
instead taken from the script we are adding.

> Other option would be to introduce subst. variable in configure.ac and use
> it in configurable Makefile. This approach might be more widespread.

We don't use automake, I think its best to keep it that way. I'll
just remove the double tr -d calls on both configure.ac and the top
level Makefile.

  Luis
