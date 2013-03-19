From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 19 Mar 2013 18:18:26 +0100 (CET)
Subject: [Cocci] Have coccinelle follow typedef ?
In-Reply-To: <1363709777.30419.20.camel@tiger2>
References: <1363709777.30419.20.camel@tiger2>
Message-ID: <alpine.DEB.2.02.1303191817500.1999@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 19 Mar 2013, Eric Leblond wrote:

> Hello,
>
> I've got the following construction in a code:
>  typedef struct Packet_ {
> 	struct Flow_ * flow;
>  } Packet;
> and in an other include file:
>  typedef struct Flow_ {
> 	...
>  } Flow;
>
> My problem here is that if p is a Packet then p->flow is a Flow at least
> from a developer point of view. But coccinelle is not detecting the
> match "Flow f" do not match on a "p->flow".
>
> I've thought about adding a new isomorphism to solve this but I don't
> like the idea...
>
> How could I fix this issue ?

--all-includes?

I thik the type inferencer should be aware of typedefs, if it sees the
definition.

julia
