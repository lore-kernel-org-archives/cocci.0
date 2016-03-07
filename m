From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 8 Mar 2016 07:29:08 +0900 (JST)
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DDFEA7.1080407@users.sourceforge.net>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <alpine.DEB.2.10.1603080655550.2647@hadrien>
 <56DDFEA7.1080407@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1603080728340.2647@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 7 Mar 2016, SF Markus Elfring wrote:

> >> The software library "http://cristal.inria.fr/~fpottier/menhir/"
> >> is involved to some degree.
> >
> > None whatsoever, actually.
>
> An option like "--enable-menhirLib" is provided under the configuration category
> "Optional Features", isn't it?

This is for the parsing of the semantic patch.  Not the parsing of the C
code.

> > A parser is implemented using ocamlyacc, combined with some hauristics
> > that reorganize the input tokens a little bit.  The approach is described in the following paper:
> >
> > Yoann Padioleau:
> > Parsing C/C++ Code without Pre-processing. CC 2009: 109-125
>
> How much did the software design and corresponding implementation evolve further
> since the description of this approach?

Not at all.

julia
