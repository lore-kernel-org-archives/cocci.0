From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 8 Mar 2016 06:57:48 +0900 (JST)
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DDCAD3.2080309@users.sourceforge.net>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1603080655550.2647@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 7 Mar 2016, SF Markus Elfring wrote:

> > I am interested in exploring how Coccinelle is parsing C programs,
>
> The software library "http://cristal.inria.fr/~fpottier/menhir/"
> is involved to some degree.

None whatsoever, actually.  A parser is implemented using ocamlyacc,
combined with some hauristics that reorganize the input tokens a little
bit.  The approach is described in the following paper:

Yoann Padioleau:
Parsing C/C++ Code without Pre-processing. CC 2009: 109-125

julia

>
>
> > in order to detect the bugs indicated by SmPL patches.
>
> Would you like to develop your own source code search patterns?
>
>
> > This is the reason why I was trying to examine the source
> > and perform the compilation myself.
>
> Will it be a bit easier to ask about relevant implementation details here?
>
>
> > However, I am facing issues executing spatch.
>
> Which ones?
>
>
> > The installation probably didn't work.
>
> How did you get this impression?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
