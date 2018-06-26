From: michelemartone@users.sourceforge.net (Michele Martone)
Date: Tue, 26 Jun 2018 17:27:55 +0200
Subject: [Cocci] coccinelle computes patch very slowly
In-Reply-To: <alpine.DEB.2.20.1806261257580.3957@hadrien>
References: <20180625154402.GC7044@localhost>
 <alpine.DEB.2.20.1806261257580.3957@hadrien>
Message-ID: <20180626152755.GH14796@localhost>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20180626 at 13:03, Julia Lawall wrote:
> On Mon, 25 Jun 2018, Michele Martone wrote:
> > Dear Coccinelle Team,
> >
> > While patching source files of a few thousand lines long, I
> > noticed prohibitively long patch compute times (seemed hanged).
> >
> > This effectively prevented spatch from being usable.
> >
> > I attach a minimalistic program and patch replicating the problem.
> >
> > It seems like presence of uninitialized variables  and/or
> > a loops body might slow down spatch computation extremely.
> >
> > I will be grateful of any support!

Hi Julia,

> Loops can cause the matching process to become very expensive.

With your suggeston below (thanks!) I was able to go around
the problem (see comments) !

However, I hope that this behaviour is unintended.

I mean: to practical means, loop presence, or a growing amount of
uninitialized variables leading to supra-linear patch compute 
times is a game-stopper: it can IMHO severely scare users...
I hope it is some algorithmic limitation that can be overcome..

> I was about to propose various solutionsto get around the loop problem,
> but I think you don't care.
I do care --- I am open to further techniques --- they might very likel
y come in handy soon ;-).
So you may send them, please.

> You just want to know the type of I.  Hence:
> 
> @@
> type T;
> idexpression T I;
> identifier f;
> @@
> 
> I =
> + (T)
>   f(...)

Now the POC code gets patched in a fraction of a second.
And a 1.2KLOC source with 17 occurrences of 'f' in just <1s.
So my practical problem here is solved: thanks!

I have an extra question.
I observed that applying:
 spatch --sp-file <patch above> <120 files totalling 140 KLOC>
seems to take >4 minutes time and consuming > 5.5 GB of memory;
I reran on each file separately, concatenating the patches.
Then it finishes in ~40s, computing the same exact patch.

Given such a simple patch, was this expected to be so ?

Cheers,
Michele
