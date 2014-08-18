From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Aug 2014 04:40:55 -0500 (CDT)
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <53F1BB55.8080008@metafoo.de>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725> <53F0D3CB.4000803@users.sourceforge.net>
 <1408292542.17489.11.camel@joe-AO725>
 <alpine.DEB.2.10.1408171241450.2520@hadrien> <53F1BB55.8080008@metafoo.de>
Message-ID: <alpine.DEB.2.10.1408180439500.2548@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 18 Aug 2014, Lars-Peter Clausen wrote:

> On 08/17/2014 07:42 PM, Julia Lawall wrote:
> >
> >
> > On Sun, 17 Aug 2014, Joe Perches wrote:
> >
> > > On Sun, 2014-08-17 at 18:09 +0200, SF Markus Elfring wrote:
> > > > > I would prefer to be able to convert
> > > > > 	*(skb->data + frame_size / 2 + 10)
> > > > > not to
> > > > > 	(skb->data + frame_size / 2)[10]
> > > > > but to
> > > > > 	skb->data[frame_size / 2 + 10]
> > > > >
> > > > > but I don't know how.
> > > >
> > > > How do you think about a bit more fine-tuning for the desired semantic
> > > > patch?
> > >
> > > Not sure I understand what you are requesting.
> > >
> > > > Can it be that the pattern "*(foo + e)" is too generic for any source
> > > > code place?
> > >
> > > I don't think so as any type or combination of
> > > arithmetic operations would then need to be specified
> > > by the spatch input script.
> > >
> > > > Would you like to try out the specification of a few more elements
> > > > instead of a single expression here?
> > >
> > > Not really.
> > >
> > > I think a precedence specification capability like first
> > > pointer match followed by longest arithmetic match would
> > > perhaps be a better generic facility.
> >
> > Isn't the problem already solved? If not, I will look into it.
>
> I think for these kinds of problems it would be helpful to have a metavariable
> type that is somewhere in the middle of idexpression and expression. Something
> that matches an identifier or accessing a field in an identifier, or a field
> of a field of an identifier and so on.
>
> In the past I had cocci scripts where I ended up doing
>
> (
> id->fld1
> |
> id->fld1.fld2
> |
> id->fld1.fld2.fld3
> ...
> )
>
> to kind of make this work.

It's probably true,  But I don't know what one would call it, and I think
that if one had a name for it, no one would understand it...

julia
