From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jul 2018 22:42:45 +0200 (CEST)
Subject: [Cocci] Perforce support,
 or generating list of files that would be changed?
In-Reply-To: <CAOZdJXXY-kD+6=gDD8fBgPNNFKe5g_=2GLV-zYi54k2AVD1pLQ@mail.gmail.com>
References: <CAOZdJXXmFPuZFmeaJcB4V5+biQ3DBFZTyam452BgyV9MLgnP4Q@mail.gmail.com>
 <alpine.DEB.2.20.1807262225450.6047@hadrien>
 <CAOZdJXXY-kD+6=gDD8fBgPNNFKe5g_=2GLV-zYi54k2AVD1pLQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807262241320.6047@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jul 2018, Timur Tabi wrote:

> On Thu, Jul 26, 2018 at 3:26 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> >> 1. Provide a list of files that "spatch --in-place --dir ." would edit
> >
> > I'm not sure to understand what you are asking for here.
>
> So when I run "spatch --in-place --dir .", spatch run my cocci script
> on a bunch of files, but not all of them will need to be changed.  For
> some, there won't be a match.
>
> I would like a list of files that spatch *would* change in this
> situation.  Something like "spatch --list-only", so I can do this:
>
> $ p4 edit `spatch --sp-file nvprintf.cocci --in-place --list-only --dir .`
> $ spatch --sp-file nvprintf.cocci --in-place --list-only --dir .

Coccinelle can make a list of relevant files, but there is not a guarantee
that the rule will actually match on those files.  The option is
--selected-only.

julia
