From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 23 Jul 2016 12:46:01 +0200 (CEST)
Subject: [Cocci] [PATCH RFC] coccinelle: tests: if and else branch
 should probably not be identical
In-Reply-To: <20160722190839.GA15538@osadl.at>
References: <1469178343-29192-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1607221855500.4131@hadrien>
 <20160722190839.GA15538@osadl.at>
Message-ID: <alpine.DEB.2.10.1607231242420.3304@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 22 Jul 2016, Nicholas Mc Guire wrote:

> On Fri, Jul 22, 2016 at 06:56:47PM +0200, Julia Lawall wrote:
> > > +virtual context
> > > +virtual org
> > > +virtual report
> > > +
> > > + at cond@
> > > +statement S1;
> > > +position p;
> > > +@@
> > > +
> > > +<+...
> > > +* if at p (...) S1 else S1
> > > +...+>
> >
> > You don't need the <+... ...+>.  Just put the if by itself.
> >
>
> will drop that then - though those would be needed for the cases that
> do this recursively. Will fix it and resend.

Sorry, I don't get your point about recursiveness at all.  Even if you
have bizarrely

if (e1)
  if (e2) S else S
else
  if (e2) S else S

the version without <+... ...+> will still work, finding three matches.

The <+... ...+> starts the matching process at the beginning of the
function and ends it at the end of the function, instead of just working
on each if one by one.  Thus <+... ...+> should be much less efficient.
Also with <+... ...+> if you put a position variable on eg the if, you
will get a single position array with all the matches, whereas without it
you get one position array per if.  The latter is probably easier to
manage.

julia
