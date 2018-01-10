From: rob@hoelz.ro (Rob Hoelz)
Date: Wed, 10 Jan 2018 13:34:40 -0600
Subject: [Cocci] Patching const char * constants
In-Reply-To: <alpine.DEB.2.20.1801100933580.3252@hadrien>
References: <20180109202248.7a1e4e1c@eridanus>
 <alpine.DEB.2.20.1801100933580.3252@hadrien>
Message-ID: <20180110133440.32998166@eridanus>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 10 Jan 2018 09:40:19 +0100 (CET)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Tue, 9 Jan 2018, Rob Hoelz wrote:
> 
> > Hi Coccinelle community,
> >
> > I just discovered Coccinelle a few days ago, and already my mind is
> > reeling with the possibilities. I'm doing some work porting the
> > Claws Mail mail client to GTK3, and I think Coccinelle would be a
> > great tool to use to accomplish this task.
> >
> > One of the thing I'm trying to use Coccinelle to do is to detect
> > and patch string concatenation via string literal juxtaposition;
> > for example:
> >
> > > ...
> > >  GTK_STOCK_NO, "+" GTK_STOCK_YES, NULL);
> >
> > I would like to write a spatch that does something like the
> > following:
> >
> > > @@
> > > constant char *stock_constant =~ "^GTK_STOCK";
> > > @@
> > >
> > > -"+" stock_constant
> > > +stock_constant
> >
> > For starters, Coccinelle doesn't seem to recognize string
> > juxtaposition (spatch gives me an error when I try this); secondly,
> > I can't seem to get "constant char *p" to match *any* string
> > literals.  For example, take this simple test program:
> >
> > > int
> > > main(void)
> > > {
> > >    const char *p = "bar";
> > >    return 0;
> > > }
> >
> > If I just use "constant p", it'll match the 0 literal in the return
> > statement.  I can use "constant int p" to make only that 0 match,
> > but I'd like to match the "bar" string literal, and "constant char
> > *p" doesn't seem to work.  Is there some way I can get Coccinelle
> > to match only string literals to a metavariable?
> 
> It's constant char[] c.  A string is an array.

/me facepalms

Of course!  What a silly mistake on my part =/  Thanks for clarifying for me!

> 
> >
> > Another quick question: is there a way to tell Coccinelle to dump
> > its AST so I can see which type an expression has been assigned?
> > Having such a tool might help me get more familiar with the tool!
> 
> No there is nothing like this.  There is a BNF in the documentation
> (http://coccinelle.lip6.fr/docs/index.html).
> People don't find it very user-friendly, but for example here:
> 
> http://coccinelle.lip6.fr/docs/main_grammar010.html
> 
> you can see that there are possibilities like:
> 
> exp metaidAssignOp exp
> exp metaidBinOp exp
> metaidExp
> metaidConst
> 
> Unfortunately, none of those names actually correspond to the way in
> which one declares those metavariables, which are assignment operator
> x, binary operator x, expression, and constant, respectively.
> 
> It may be helpful to look at the examples in http://coccinellery.org/
> 
> For the concatenated strings, unfortunately the patern matching
> language doesn't support that.  The only thing you can do is match
> the full string, and then do some magic with python to get out the
> parts you want.  I'm not sure that this is the best first project.
> 
> julia
> 

Thanks for the quick answer, Julia!  I'll try to undertake something a little
simpler to start.

-Rob
