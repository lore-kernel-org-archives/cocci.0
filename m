From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 30 Oct 2015 16:43:23 +0100 (CET)
Subject: [Cocci] Release 1.0.3: Clarification around SmPL conjunctions
In-Reply-To: <56338C69.3030401@users.sourceforge.net>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <5631F344.9080804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301405330.2364@hadrien>
 <56337A59.8030804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301535230.2364@hadrien>
 <563383DF.9000509@users.sourceforge.net>
 <alpine.DEB.2.10.1510301606020.2364@hadrien>
 <56338C69.3030401@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1510301643040.2364@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 30 Oct 2015, SF Markus Elfring wrote:

> > When you have ..., the thing after the ... has to come after (in the
> > control-flow graph) the thing before the ...  So this would only match
> > code that has a call to f followed by a call to g followed by a call to f
> > followed by a call to g.  In particular, if the C code has no loops, then
> > it must contain two calls to g.
>
> I would find such a situation also occasionally interesting for specific
> function implementations.
>
>
> > If you look a demos/conjunction.c, both of the C functions contain only
> > one call to g, so neither would match your pattern.
>
> I find it strange that the function name "main" is repeated without
> conditional compilation statements in this source code example.

The code is not intended to be run.

julia
