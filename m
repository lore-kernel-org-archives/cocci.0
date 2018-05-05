From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 5 May 2018 20:16:09 +0200 (CEST)
Subject: [Cocci] Blocks Support?
In-Reply-To: <alpine.DEB.2.20.1804171639391.4631@hadrien>
References: <CADZ9DPx6=rs2vBrauhsLeBbrjT6798KkgAYnRLr16eu_UsKKJA@mail.gmail.com>
 <alpine.DEB.2.20.1804171639391.4631@hadrien>
Message-ID: <alpine.DEB.2.20.1805052015060.2553@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 17 Apr 2018, Julia Lawall wrote:

>
>
> On Tue, 17 Apr 2018, Mitchell Cuddie wrote:
>
> > Has anyone looked at supporting the blocks extension in Coccinelle?
> > https://clang.llvm.org/docs/BlockLanguageSpec.html
> >
> > There are a number of large projects like WebKit that could make use of
> > Coccinelle if it could parse the code. Any thoughts?
>
> Looking extremely quickly it looks like it could be possible.  Do you just
> want the parser not to crash or to change this kind of code.  Could you
> send a small typical example?

Currently, Coccinelle doesn't support nested function definitions.

Are these blocks used heavily in the code you are interested in?  If
Coccinelle can't parse one function, it will just move on to the next one.

julia
