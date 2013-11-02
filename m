From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 16:02:28 +0100 (CET)
Subject: [Cocci] Matching an absence of statements before the closing
 brace of a function?
In-Reply-To: <20131102145412.GT15704@leaf>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021455070.2261@hadrien> <20131102145412.GT15704@leaf>
Message-ID: <alpine.DEB.2.02.1311021555360.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2 Nov 2013, Josh Triplett wrote:

> On Sat, Nov 02, 2013 at 03:27:35PM +0100, Julia Lawall wrote:
> > On Sat, 2 Nov 2013, Josh Triplett wrote:
> > > I wanted to write a semantic patch that matched (and removed) "return;"
> > > at the end of a void function.  I've attached the full .cocci file
> > > written for coccicheck, but the key bit looks like this:
> > >
> > > @@
> > > identifier fn;
> > > @@
> > > void fn ( ... )
> > > {
> > > ...
> > > - return;
> > > }
> > >
> > > However, that patch also produces results like this:
> > >
> > > --- a/drivers/scsi/aacraid/dpcsup.c
> > > +++ b/drivers/scsi/aacraid/dpcsup.c
> > > @@ -255,7 +255,6 @@ static void aac_aif_callback(void *conte
> > >  	    cpu_to_le32(NoMoreAifDataAvailable)) {
> > >  		aac_fib_complete(fibptr);
> > >  		aac_fib_free(fibptr);
> > > -		return;
> > >  	}
> > >
> > >  	aac_intr_normal(dev, 0, 1, 0, fibptr->hw_fib_va);
> > >
> > > I'm guessing that either coccinelle didn't pair the braces (so that the
> > > '}' matches close braces other than the one matching fn's opening brace)
> > > or coccinelle allowed extra statements before the logical end of the
> > > function despite the lack of '...'.
> >
> > The problem is that Coccinlle works on control-flow paths, and a return is
> > always at the end of a control-flow path...
>
> Not sure I fully understand what you mean.  I do understand why
> coccinelle works on control-flow paths rather than literal code, and
> that makes it much more powerful, but I'm still not sure how coccinelle
> manages to match the patch above to the code above.  Do the braces in
> the semantic patch above not pair with each other?  If not, why not?  If
> so, how does "return; }" match something between the "return;" and the
> "}"?

The return is followed by all of the nested }s to get it out of the
function.  I think that there is something special for these }s to skip
over them, so that the return always seems to be next to the final }.

> > Try the following:
> >
> > @start@
> > identifier f;
> > position p;
> > @@
> > f(...) {@p ... }
> >
> > @bad@
> > position p, s != start.p;
> > @@
> >
> > {@s <... return;@p ...> }
> >
> > @ef@
> > position p;
> > statement S;
> > @@
> >
> > (
> > while (...) return;@p
> > |
> > if (...) return;@p else S
> > )
> >
> > @@
> > position p != {bad.p,ef.p};
> > @@
> >
> > - return;@p
>
> Interesting; I didn't know about the ability to exclude specific
> positions that way.  However, that doesn't quite work, since it still
> matches code like this:

OK, good point.  I will try to find something else.

return;
S

doesn't work, because no statement follows a return.  A return is just
followed by a sequence of closing braces.

You can try this:

@@
@@

- return;
+ RETURN;

@r exists@
identifier f;
position p;
@@

f(...) {
  ...
  RETURN at p;
}

@@
position r.p;
@@

- RETURN at p;

@@
@@

- RETURN;
+ return;
