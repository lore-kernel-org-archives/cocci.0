From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Aug 2014 05:59:49 -0500 (CDT)
Subject: [Cocci] Clarification for array indexing style
In-Reply-To: <53F1DBA8.5010005@users.sourceforge.net>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725> <53F0D3CB.4000803@users.sourceforge.net>
 <1408292542.17489.11.camel@joe-AO725>
 <alpine.DEB.2.10.1408171241450.2520@hadrien> <53F1BB55.8080008@metafoo.de>
 <alpine.DEB.2.10.1408180446550.2548@hadrien> <53F1CDF3.5010105@metafoo.de>
 <alpine.DEB.2.10.1408180530130.2548@hadrien>
 <53F1DBA8.5010005@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1408180559110.2548@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 18 Aug 2014, SF Markus Elfring wrote:

> > How about then
> >
> > (
> > e1 . at e2 f + x
> > |
> > e1 ->@e2 f + x
> > )
> >
> > where e2 has pointer typw (or array type?)
> >
> > e2 on the . or -> will pick up the entire innermost enclosing expression.
> >
>
> Would such a semantic patch approach handle also longer reference chains?

Yes, I am assuming that e1 has been declared to be an arbitrary
expression.

julia
