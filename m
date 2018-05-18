From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 May 2018 19:12:18 +0200 (CEST)
Subject: [Cocci] convert if (x) stmt to if (x) {stmt}
In-Reply-To: <cea31c3d-fde8-e866-a03c-de868148ed12@users.sourceforge.net>
References: <alpine.DEB.2.20.1805162139340.3296@hadrien>
 <f9593244-a490-295b-537d-5dcc5e1017d5@users.sourceforge.net>
 <alpine.DEB.2.20.1805170919390.4571@hadrien>
 <b44ad180-3d38-ba5e-80ab-bc932263dba7@users.sourceforge.net>
 <alpine.DEB.2.20.1805172248210.2273@hadrien>
 <0c08d40c-4047-db00-9b4a-4d6a7799afe0@users.sourceforge.net>
 <alpine.DEB.2.20.1805181759490.3339@hadrien>
 <2240107d-5e70-6489-f48a-5f6675c55c64@users.sourceforge.net>
 <alpine.DEB.2.20.1805181842590.3339@hadrien>
 <cea31c3d-fde8-e866-a03c-de868148ed12@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805181911180.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 May 2018, SF Markus Elfring wrote:

> >> I understood one suggestion in the way for a SmPL specification
> >> like the following.
> >>
> >> if (...)
> >> +{
> >>  S;
> >> +e;
> >> +}
> >
> > The rule has no goal of adding some unknown e;.
>
> How does this feedback fit to your wording ?In each rule that contains S1,
> you first could replace the S1 by e; ???

I didn't mean to write a semantic patch to remove S1 and add e;.  I meant
to put e; instead of S1 in the rule, producing the rule below.

julia

>
>
> > if (...)
> > + {
> >   e;
> > + }
> >   else S
> >
> > I don't see why one should consider whether e; should have been written in
> > a different way in making this transformation.
>
> It seems that you present another variant for a SmPL script.
>
> I assume that there are further constraints to consider for the discussed
> change pattern.
>
> Regards,
> Markus
>
