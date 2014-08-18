From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Aug 2014 06:55:41 -0500 (CDT)
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <53F1E421.5000408@users.sourceforge.net>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725> <53F0D3CB.4000803@users.sourceforge.net>
 <1408292542.17489.11.camel@joe-AO725>
 <alpine.DEB.2.10.1408171241450.2520@hadrien> <53F1BB55.8080008@metafoo.de>
 <alpine.DEB.2.10.1408180439500.2548@hadrien>
 <53F1E421.5000408@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1408180654370.2548@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 18 Aug 2014, SF Markus Elfring wrote:

>
> >> I think for these kinds of problems it would be helpful to have a metavariable
> >> type that is somewhere in the middle of idexpression and expression. Something
> >> that matches an identifier or accessing a field in an identifier, or a field
> >> of a field of an identifier and so on.
> >>
> >> In the past I had cocci scripts where I ended up doing
> >>
> >> (
> >> id->fld1
> >> |
> >> id->fld1.fld2
> >> |
> >> id->fld1.fld2.fld3
> >> ...
> >> )
> >>
> >> to kind of make this work.
> > It's probably true,  But I don't know what one would call it, and I think
> > that if one had a name for it, no one would understand it...
>
> Do you dare to suggest another type name for a metavariable in the
> semantic patch language?

Now that we have the feature of an expression metavariable that matches
the innermost enclosing expression that contains a token, I don't think it
is necessary.

julia
