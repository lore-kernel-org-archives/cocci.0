From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Aug 2014 12:42:12 -0500 (CDT)
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <1408292542.17489.11.camel@joe-AO725>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725> <53F0D3CB.4000803@users.sourceforge.net>
 <1408292542.17489.11.camel@joe-AO725>
Message-ID: <alpine.DEB.2.10.1408171241450.2520@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 Aug 2014, Joe Perches wrote:

> On Sun, 2014-08-17 at 18:09 +0200, SF Markus Elfring wrote:
> > > I would prefer to be able to convert
> > > 	*(skb->data + frame_size / 2 + 10)
> > > not to
> > > 	(skb->data + frame_size / 2)[10]
> > > but to
> > > 	skb->data[frame_size / 2 + 10]
> > >
> > > but I don't know how.
> >
> > How do you think about a bit more fine-tuning for the desired semantic
> > patch?
>
> Not sure I understand what you are requesting.
>
> > Can it be that the pattern "*(foo + e)" is too generic for any source
> > code place?
>
> I don't think so as any type or combination of
> arithmetic operations would then need to be specified
> by the spatch input script.
>
> > Would you like to try out the specification of a few more elements
> > instead of a single expression here?
>
> Not really.
>
> I think a precedence specification capability like first
> pointer match followed by longest arithmetic match would
> perhaps be a better generic facility.

Isn't the problem already solved? If not, I will look into it.

julia
