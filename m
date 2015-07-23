From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Thu, 23 Jul 2015 09:12:44 +0200
Subject: [Cocci] [PATCH 1/2] autotools: unify the way to determine
 version information
In-Reply-To: <CAJLtBvOvZqYf0NP4R-Amu_sc6Cz8=J7_gFsCuKCtM1dQ4yk5tQ@mail.gmail.com>
References: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
 <1437511861-2205-2-git-send-email-mcgrof@do-not-panic.com>
 <CAJLtBvOvZqYf0NP4R-Amu_sc6Cz8=J7_gFsCuKCtM1dQ4yk5tQ@mail.gmail.com>
Message-ID: <20150723071244.GA1536@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Nikolay Orlyuk (2015/07/23 07:18 +0300):
> Do we still need VERSION=$(shell ./version.sh | tr -d '\n') ? I'm pretty
> sure that VERSION=$(shell ./version.sh) will be enough. Same for
> configure.ac.
> Moreover why script version.sh can't be simply?
> 
> #!/bin/sh
> > tr -d '\n' < ./version
> >
> 
> Other option would be to introduce subst. variable in configure.ac and use
> it in configurable Makefile. This approach might be more widespread.

Yes, I believe this second approach would be better.

S?bastien.
