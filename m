From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 1 Oct 2014 20:28:45 +0200
Subject: [Cocci] string parameter concatenation
In-Reply-To: <alpine.DEB.2.10.1410011504340.2489@hadrien>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.10.1410011504340.2489@hadrien>
Message-ID: <20141001182845.GL14081@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 01, 2014 at 03:08:54PM +0200, Julia Lawall wrote:
> On Wed, 1 Oct 2014, Cyril Hrubis wrote:
> 
> > Hi!
> > I've found a small nit in the handling of strings that spans over
> > multiple lines:
> >
> > nit.c:
> > int main(void)
> > {
> >         f("This is a string that continues to the next line"
> >           " just string continuation");
> > }
> >
> > nit.cocci:
> > @@
> > expression list L;
> > @@
> > - f(L);
> > + g(L);
> >
> >
> > spatch nit.cocci nit.c
> > init_defs_builtins: /usr/local/share/coccinelle/standard.h
> > HANDLING: nit.c
> > diff =
> > --- nit.c
> > +++ /tmp/cocci-output-8374-71ffd9-nit.c
> > @@ -1,5 +1,4 @@
> >  int main(void)
> >  {
> > -       f("This is a string that continues to the next line"
> > -         " just string continuation");
> > +       g("This is a string that continues to the next line"" just string continuation");
> >  }
> >
> > While this produces perfectly correct C code it would be nicer if the
> > strings were merged into one single C string. Othewise this still breaks
> > what LKML coding style says about being able to grep user-visible
> > strings in the source code.
> 
> I can try to see what to do about it.  String made up of multiple
> concatenated strings are perhaps not so well supported.  I don't think
> that automatic concatenation would be a good idea, because some users
> might not want it.

If at any point in time you find some odd things C may do which might be
real hard to gramatically handle within Coccinelle it may be worthwhile
for us to consider on the kernel as something to consider to avoid as
coding practice. This obviously cannot apply to all odd-ball C hacks
possible I certainly would not rule it out given the gains.

  Luis
