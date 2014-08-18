From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Aug 2014 04:39:20 -0500 (CDT)
Subject: [Cocci] Conversion of some pointer arithmetic to array indexing
 style
In-Reply-To: <53F1B486.5080704@users.sourceforge.net>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725>
 <alpine.DEB.2.10.1408172154050.2392@hadrien>
 <53F1B486.5080704@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1408180438010.2548@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 18 Aug 2014, SF Markus Elfring wrote:

> > @@
> > expression e,x;
> > identifier f;
> > @@
> >
> > + e->f[
> > - *(
> >    <+...
> > (
> > -  (e->f + x)
> > +  x
> > |
> > +  x
> > -  (x + e->f)
> > )
> >    ...+>
> > -  )
> > +  ]
>
> Does the issue "isomorphism" matter in the shown addition?

I don'tknw if there is one for the commutativity of addition.  If there is
then the disjunction is not needed.

"matter" implies that something could go wrong.  Nothing could go wrong,
whether the rule is redundnt or not.

julia
