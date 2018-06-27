From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 28 Jun 2018 00:52:26 +0200 (CEST)
Subject: [Cocci] coccinelle computes patch very slowly
In-Reply-To: <20180627222327.GC7556@localhost>
References: <20180625154402.GC7044@localhost>
 <alpine.DEB.2.20.1806261257580.3957@hadrien>
 <20180626152755.GH14796@localhost>
 <alpine.DEB.2.20.1806261730130.3733@hadrien>
 <20180627222327.GC7556@localhost>
Message-ID: <alpine.DEB.2.20.1806280051030.3097@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 28 Jun 2018, Michele Martone wrote:

> On 20180626 at 17:40, Julia Lawall wrote:
> > On Tue, 26 Jun 2018, Michele Martone wrote:
> > > On 20180626 at 13:03, Julia Lawall wrote:
> > > > On Mon, 25 Jun 2018, Michele Martone wrote:
> > > > > Dear Coccinelle Team,
> > > > >
> > > > > While patching source files of a few thousand lines long, I
> > > > > noticed prohibitively long patch compute times (seemed hanged).
> > > > >
> > > > > This effectively prevented spatch from being usable.
> > > > >
> > > > > I attach a minimalistic program and patch replicating the problem.
> > > > >
> > > > > It seems like presence of uninitialized variables  and/or
> > > > > a loops body might slow down spatch computation extremely.
> > > > >
> > > > > I will be grateful of any support!
> > >
> > > Hi Julia,
> > >
> > > > Loops can cause the matching process to become very expensive.
> > >
> > > With your suggeston below (thanks!) I was able to go around
> > > the problem (see comments) !
> > >
> > > However, I hope that this behaviour is unintended.
> > >
> > > I mean: to practical means, loop presence, or a growing amount of
> > > uninitialized variables leading to supra-linear patch compute
> > > times is a game-stopper: it can IMHO severely scare users...
> > > I hope it is some algorithmic limitation that can be overcome..
> >
> > It is an algorithmic limitation, but I don't think it can be overcome in
> > general.  Coccinelle follows control-flow paths.  When A ... B matches a
> > case where there is a loop between A and B, then there is an infinite loop
> > that blocks going from A to B.  The solution is to use what is called weak
> > until (Coccinelle matching is based on computational tree logic).  This
> > inlvoves negating everything and somehow reaching the fixed point in terms
> > of the code outside the loop, rather than the code inside the loop.  This
> > easily explodes.  A solution could be --no-loops, since you don't care
> > about situations that start at the end of a loop and jump around to the
> > top in your case.  You can also use a timeout, to get an overall result
> > quickly at the risk of missing some results.  You can also reduce the
> > problem by having one rule that matches a declaration, and another rule
> > that makes the transformation for each declared variable individually;
> > currently paths for different variables are interfering with each other
> > and further inflating the cost.  You can also check whether there exists a
> > path from the declaration to a variable use, by putting exists in the
> > header, to be able to ignore variables that are simply never used.
> Hmmm I see, these are the innards... thanks!
> But ..  for what C is concerned, the presence of a loop construct
> between a variable declaration and its use after the loop shall not
> be of any problem wrt type and visibility of that variable identifier.
> So in principle in the future one might think to follow this logic ---
> at least for C --- if desired --- no ?

Coccinelle is not going to have a special case for this.  You are free to
use the --no-loops option.

julia

>
> > > > I was about to propose various solutionsto get around the loop problem,
> > > > but I think you don't care.
> > > I do care --- I am open to further techniques --- they might very likel
> > > y come in handy soon ;-).
> > > So you may send them, please.
> > >
> > > > You just want to know the type of I.  Hence:
> > > >
> > > > @@
> > > > type T;
> > > > idexpression T I;
> > > > identifier f;
> > > > @@
> > > >
> > > > I =
> > > > + (T)
> > > >   f(...)
> > >
> > > Now the POC code gets patched in a fraction of a second.
> > > And a 1.2KLOC source with 17 occurrences of 'f' in just <1s.
> > > So my practical problem here is solved: thanks!
> > >
> > > I have an extra question.
> > > I observed that applying:
> > >  spatch --sp-file <patch above> <120 files totalling 140 KLOC>
> > > seems to take >4 minutes time and consuming > 5.5 GB of memory;
> > > I reran on each file separately, concatenating the patches.
> > > Then it finishes in ~40s, computing the same exact patch.
> > >
> > > Given such a simple patch, was this expected to be so ?
> >
> > When you put many files on the command line, it works on the all at once,
> > in order to be able to take into account references from oneto the other.
> > Since there are 120 of them, that will be a lot of live memory which will
> > stress the OCaml garbage collector.  When you run on the files
> > individually the garbage collector is happy - the OCaml GC works well when
> > it only has to collect the minor heap.
> Ok, I see..
>
> > Normally, when you have many files to work on, you give the name of the
> > enclosing directory and Coccinelle works on all of them.  Then it works
> > one file at a time.  If that is not suitable for your use case, then you
> > can make a file with the names of the files you are interested in,
> > separated by blank lines, ad git the argument --file-groups filename.
> > Then it will only work on the listed files, again one at a time.
> Sounds like a very useful option!
>
> I did not find it in `man spatch'.
> That is a pity.
>
> I have two suggestions for `man spatch':
>
>  1.
>   SYNOPSIS
>   spatch --sp-file <SP> <files> [-o <outfile> ] [--iso-file <iso> ] [ options ]
>   +spatch --help
>   +spatch --longhelp
>
>   (otherwise --longhelp is buried in the man page and difficult to see1)
>
>   2. Keep the `man spatch' page in sync with the actual options.
>      I'm sure for OCaml wizards like you this shall be pretty easy to do
>      automatically ;-)
>
> Thanks,
> Michele
>
