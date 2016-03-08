From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 8 Mar 2016 19:55:16 +0900 (JST)
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DE94FD.3030707@users.sourceforge.net>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <alpine.DEB.2.10.1603080655550.2647@hadrien>
 <56DDFEA7.1080407@users.sourceforge.net>
 <alpine.DEB.2.10.1603080728340.2647@hadrien>
 <56DE94FD.3030707@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1603081953040.2693@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 8 Mar 2016, SF Markus Elfring wrote:

> >> An option like "--enable-menhirLib" is provided under the configuration category
> >> "Optional Features", isn't it?
> >
> > This is for the parsing of the semantic patch.
>
> Does this information mean that the software library "Menhir" is not so optional at the moment?

Menhirlib is needed from the Coccinelle sources if you do not already have
menhir installed on your machine.  Thus there are two options.

> >>> Yoann Padioleau:
> >>> Parsing C/C++ Code without Pre-processing. CC 2009: 109-125
> >>
> >> How much did the software design and corresponding implementation evolve further
> >> since the description of this approach?
> >
> > Not at all.
>
> I have got an other impression through the years.
>
> Your software supports source code transformations also without
> including header files and other pre-processing stuff.
>
> Example:
> The option "--include-headers-for-types" was added by the release "Coccinelle 1.0.0-rc22".

It's true, but that has nothing to do with the parsing algorithm.  It has
to do with what files are selected for parsing.  I don't think there has
been any substantial change in the actual parsing algorithm.

julia
