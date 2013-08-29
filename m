From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Thu, 29 Aug 2013 11:06:28 +0200
Subject: [Cocci] question about --allow-inconsistent-paths
In-Reply-To: <alpine.DEB.2.02.1308281850460.2279@hadrien>
References: <1377707947.3192.51.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1308281850460.2279@hadrien>
Message-ID: <1377767188.3212.16.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2013-08-28 at 18:52 +0200, Julia Lawall wrote:
> On Wed, 28 Aug 2013, Nic Volanschi (R&D) wrote:
> > The rule I'm trying is:
> >
> > --- trace.c
> > @@ statement s; @@
> >  switch(...) {
> >  case ...:
> > +mwtrace();/*case*/
> >   s
> >   ... }
> > +mwtrace();/*endsw*/
> >
> > @@ statement s; @@
> >  switch(...) {
> >  default:
> > +mwtrace();/*def*/
> >   s
> >   ... }
> >
[...]
> > To avoid the problem, I used the option --allow-inconsistent-paths,
> and
> > this works for both cases, with the results I'm expecting. So this is
> > ok.
> >
> > However, as the manual says that this option is "unsafe", my question
> > is: do I risk anything on this kind of local syntactic transformations?
> > I mean, when all the rules have to be applied independently of the
> > control flow graph?
> 
> I haven't looked at the example in detail, but the control-flow graph for
> switches is known not to be as nice as one would want.  The problem is
> with the need to support fall through from one branch to the next.
> Probably the best thing is to look at the code and check that it is OK, if
> that is not too much of a burden...
> 
> julia

I guess that no matter the examples, I was just looking for a
qualitative confirmation about the fact that if all the rules are local
syntactic transformations, and one doesn't care about control flow, the
--allow-inconsistent-path option should not harm, a priori, could it?
I mean, in the above rules, the various "..." just stand for subtrees in
the AST, not for paths in the CFG.

Nic.
