From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 10 Sep 2013 17:40:59 +0200 (CEST)
Subject: [Cocci] if (expr) expr   ->  if (expr) { expr }
In-Reply-To: <03D1BAB9E4B46E48B4A70C02ADE4DE439909E677@DKAAR-EXDB02.BEUMER.com>
References: <623657CD9C4EC04888E24CFF07E08211A209D3F8@DKAAR-EXDB02.BEUMER.com>
 <alpine.DEB.2.02.1309101521170.3644@hadrien>
 <03D1BAB9E4B46E48B4A70C02ADE4DE439909E677@DKAAR-EXDB02.BEUMER.com>
Message-ID: <alpine.DEB.2.02.1309101736510.2738@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 10 Sep 2013, Wegge, Anders wrote:

> Hi Julia,
>
> We have an example from the wild:
>
> void ichain (SleepMess *m)
> {
>     register SleepChain         *p ;
>     register int                n ;
>
>     /* default is a new element                                         */
>     n = chain_end ;
>
>     /* try to find it and overwrite an old one                          */
>     p = sleepc ;
>     for (n = 0; n < chain_end; n++, p++)
>         if (p->sleepmess.id == m->id)
>             break ;
>
> ...
>
>     if (dflag (DF_clock)) {
>         testlog ("%s(%d): New element %d, acode=0x%02x, rcode=0x%02x",
>                  __FILE__, __LINE__, chain_end, sleepc[n].sleepmess.head.acode,
>                  sleepc[n].sleepmess.head.rcode) ;
>     }
> }
>
> The for and if in the code above is contrary to our in-house coding spec, so what we're looking for is a way to transform it into
>
>     for (n = 0; n < chain_end; n++, p++) {
>         if (p->sleepmess.id == m->id) {
>             break ;
>       }
>     }
>
>  Without touching the testlog line further down in the example.
>
> PS. I'm working with Andreas, which is why I'm making a followup.

A quick answer:

@r@
statement S;
@@

(
if (...) { ... }
|
if (...)
+{
 S
+}
)

This would work better with the patch I posted recently in response one of
Nic's queries.

julia




> -----Original Message-----
> From: cocci-bounces at systeme.lip6.fr [mailto:cocci-bounces at systeme.lip6.fr] On Behalf Of Julia Lawall
> Sent: 10. september 2013 15:22
> To: Aaen, Andreas.Bach
> Cc: 'cocci at systeme.lip6.fr'
> Subject: Re: [Cocci] if (expr) expr -> if (expr) { expr }
>
> On Tue, 10 Sep 2013, Aaen, Andreas.Bach wrote:
>
> >
> > Hi,
> >
> > ?
> >
> > How can you make Coccinelle assist you in inserting braces around
> > expressions after if statements?
> >
> > Semantically the two expressions are identical, but the variant
> > without braces often lead to bugs when the code is extended.
>
> Could you send a concrete example?
>
> thanks,
> julia
>
