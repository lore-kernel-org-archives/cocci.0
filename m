From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 25 Nov 2013 18:38:50 +0100 (CET)
Subject: [Cocci] purely syntactic transformations
In-Reply-To: <1385395511.3195.64.camel@zamolxis.metaware.tm.fr>
References: <1385395511.3195.64.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1311251835250.2285@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Josh Triplett josh at joshtriplett.org wrote:
> > I wanted to write a semantic patch that matched (and removed) "return;"
> > at the end of a void function.  I've attached the full .cocci file
> > written for coccicheck, but the key bit looks like this:
> >
> > @@
> > identifier fn;
> > @@
> > void fn ( ... )
> > {
> > ...
> > - return;
> > }
> >
> > However, that patch also produces results like this:
> > [...]
>
> In summary, in order to take control flow features into account
> (which are irrelevant here), the patch becomes much more complex.

I think that the problem is actually related to the handling of return.
Coccinelle considers implicitly that there is a return; at the end of any
function that does not end with an explicit return.

> There are other examples of simple syntactic transformations that
> become artificially complicated, such as instrumenting the code
> with traces, in presence of some return statements.

Normally, you can get the effect you want using

{
<...
blah
...>
}

It doesn't follow the control-flow paths in that case.

> So I was wandering if it would be difficult to have a command-line
> option such as --no-control-flow to totally disable the construction
> of the control flow graph and apply the rules simply on the AST.

There are options no-gotos and no-loops that are probably good enough.  I
don't think that in the short term I want to make a competely alternative
tree structure.

julia
