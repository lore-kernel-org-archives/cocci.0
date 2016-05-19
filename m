From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 20 May 2016 00:45:33 +0200
Subject: [Cocci] [RFC 0/3] coccinelle: add initial control flow
 documentation and extend tests
In-Reply-To: <alpine.DEB.2.10.1605191229140.2865@hadrien>
References: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1605191229140.2865@hadrien>
Message-ID: <20160519224533.GG11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 19, 2016 at 12:30:06PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 18 May 2016, Luis R. Rodriguez wrote:
> 
> > This adds some initial control flow documentation, I wanted to add some
> > basic control flow diagrams as well with self generated diagrams from
> > Coccinelle however I had issues figuring out what to use with dot to
> > make it fit within the margins. We can skip that, but I thought adding it
> > would also help document support and example use case for that feature
> > as well.
> >
> > The tests/remove-code-in-branch1* was more collateral effort as I
> > saw a removal of a statement from a branch that only had one statement
> > left an empty brace. I hope we can discuss here what the expected
> > outcome should be. I figured removing the empty code may be an
> > optional optimization, however it was still unclear how to resolve this
> > if that's desirable. Would it be up to Coccinelle or would that be
> > an optional isomorphism ? I noticed no current isomorphisms seem to
> > remove code like this so it was unclear what to do.
> >
> > The following rule for instnace can deal with it.
> >
> > @ remove_empty_branch @
> > expression E;
> > @@
> >
> > -if (E) {}
> 
> I don't think this is desirable as a general rule.  E might contain
> function calls that perform side effects.

Ah, yes good point.

  Luis
