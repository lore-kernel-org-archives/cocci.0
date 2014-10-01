From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Oct 2014 00:03:51 +0200 (CEST)
Subject: [Cocci] minor issue: pretty printing for modified functions as
 arguments
In-Reply-To: <CAB=NE6UJpVSiAW-wOzGxW7UmB5PyTt-DpuFKj08BTn7wjPqSSQ@mail.gmail.com>
References: <20141001184054.GM14081@wotan.suse.de>
 <542C5AAD.5080001@users.sourceforge.net>
 <CAB=NE6UJpVSiAW-wOzGxW7UmB5PyTt-DpuFKj08BTn7wjPqSSQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1410020000390.2058@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 1 Oct 2014, Luis R. Rodriguez wrote:

> On Wed, Oct 1, 2014 at 12:49 PM, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
> >> Is there perhaps a coccinelle bugzilla to help keep track
> >> of minor issues like these?
> >
> > Do you find the available issue tracker useful?
> > https://github.com/coccinelle/coccinelle/issues/
> 
> That's a possibility, but given that currently code is developed on
> gforge and then pushed out to github as a full release there may be
> other approaches desired. I'll wait for Julia's feedback on the
> desired approach forward.

I would rather fix the bug and be done with it.  It could be reasonable to 
store a report on github, but in practice, I never look at it.

rc22 is going to be replaced shortly, because it has a big problem with 
the parsing of mixtures of strings and explicit constants.  Any other bug 
reports would be most welcome.

julia
