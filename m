From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 30 Oct 2015 16:09:26 +0100 (CET)
Subject: [Cocci] Release 1.0.3: Clarification around SmPL conjunctions
In-Reply-To: <563383DF.9000509@users.sourceforge.net>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <5631F344.9080804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301405330.2364@hadrien>
 <56337A59.8030804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301535230.2364@hadrien>
 <563383DF.9000509@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1510301606020.2364@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 30 Oct 2015, SF Markus Elfring wrote:

> > You would have to give an example.
>
> Should an approach like the following which is derived from
> the script "demos/conjunction.cocci" also work?
>
>
> @@
> identifier f;
> @@
> -f
> +m
>   (...,3,...);
>  ...
>  g(...,3,...);
>  ...
>  f(...,
> -  8
> +  80
>    ,...);
>  ...
>  g(...,8,...);

When you have ..., the thing after the ... has to come after (in the
control-flow graph) the thing before the ...  So this would only match
code that has a call to f followed by a call to g followed by a call to f
followed by a call to g.  In particular, if the C code has no loops, then
it must contain two calls to g.  If you look a demos/conjunction.c, both
of the C functions contain only one call to g, so neither would match your
pattern.

demos/conjunction.cocci will only match code that contains a call to f
that has 3 as one of its arguments and that has 8 as another.  The 8 may
appear before or after the 3.

julia
