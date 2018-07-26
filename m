From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 15:38:02 -0500
Subject: [Cocci] Perforce support,
 or generating list of files that would be changed?
In-Reply-To: <alpine.DEB.2.20.1807262225450.6047@hadrien>
References: <CAOZdJXXmFPuZFmeaJcB4V5+biQ3DBFZTyam452BgyV9MLgnP4Q@mail.gmail.com>
 <alpine.DEB.2.20.1807262225450.6047@hadrien>
Message-ID: <CAOZdJXXY-kD+6=gDD8fBgPNNFKe5g_=2GLV-zYi54k2AVD1pLQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jul 26, 2018 at 3:26 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>> 1. Provide a list of files that "spatch --in-place --dir ." would edit
>
> I'm not sure to understand what you are asking for here.

So when I run "spatch --in-place --dir .", spatch run my cocci script
on a bunch of files, but not all of them will need to be changed.  For
some, there won't be a match.

I would like a list of files that spatch *would* change in this
situation.  Something like "spatch --list-only", so I can do this:

$ p4 edit `spatch --sp-file nvprintf.cocci --in-place --list-only --dir .`
$ spatch --sp-file nvprintf.cocci --in-place --list-only --dir .
