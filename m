From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jul 2018 19:14:37 +0200 (CEST)
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <8c83d9bf-bf11-567a-62f8-0ab713c6a310@users.sourceforge.net>
References: <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
 <8c83d9bf-bf11-567a-62f8-0ab713c6a310@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1807271914180.12787@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 27 Jul 2018, SF Markus Elfring wrote:

> > @script:python s@
> > c << r.c;
> > c2;
> > @@
> > if c.startswith('"NVRM: '):
> >     coccinelle.c2 = '"' + c[7:];
> > else:
> >    coccinelle.c2 = c;
>
> I suggest to reconsider the action if no modification should be performed finally.
> How do you think about to use the statement ?cocci.include_match(False)?
> in the else branch instead?

This is also a reasonable strategy.

julia
