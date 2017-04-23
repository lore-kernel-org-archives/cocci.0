From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Apr 2017 18:03:06 +0200 (CEST)
Subject: [Cocci] Q: question on disjunction of sub-expression patterns
In-Reply-To: <20170423150816.GA24670@redhat.com>
References: <20170422160202.GA23532@redhat.com>
 <alpine.DEB.2.20.1704221844060.2351@hadrien>
 <20170423150816.GA24670@redhat.com>
Message-ID: <alpine.DEB.2.20.1704231802520.2894@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 23 Apr 2017, Oleg Nesterov wrote:

> On 04/22, Julia Lawall wrote:
> >
> > On Sat, 22 Apr 2017, Oleg Nesterov wrote:
> >
> > > It looks as if only one pattern from disjunction can match in the same statement.
> > > IOW, (PAT1 | PAT2) actually means (PAT1* | PAT2*), not (PAT1 | PAT2)*. Say,
> > >
> > The idea with a disjunction is that if the first rule matches, then that
> > one wins.  Actually, ( A | B ) is encoded as A v (not A & B).
>
> OK, thanks a lot Julia!
>
> Does this mean that I have to write 2 separate rules if I want to track the member
> dereferences? One for "->" and another for ".", because I can't use the "operator"
> metadecl in this case.

This would be safer in any case.

julia
