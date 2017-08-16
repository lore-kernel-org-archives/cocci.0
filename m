From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Aug 2017 08:26:31 +0200 (CEST)
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <26694395-e366-a049-b30d-8b27a925dc56@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <26694395-e366-a049-b30d-8b27a925dc56@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708160825590.2196@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Aug 2017, SF Markus Elfring wrote:

> > However they can only be bound to the complete sequence of statements in a block.  So
> >
> > @@
> > statement list sl;
> > @@
> > if (x) {
> >   sl
> > }
> >
> > is ok, but
> >
> > @@
> > statement list sl;
> > @@
> > if (x) {
> >   one();
> >   sl
> >   two();
> > }
> >
> > is not.
>
> How do you think about the usage of a similar SmPL specification?
>
> @display@
> statement list sl;
> @@
>  if (...)
>  {
>     header();
>     { // Extra block
> *   sl
>     }
>     footer();
>  }

It's fine,  A statement list just needs { } around it.

julia
