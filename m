From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 Apr 2018 16:40:22 +0200 (CEST)
Subject: [Cocci] Blocks Support?
In-Reply-To: <CADZ9DPx6=rs2vBrauhsLeBbrjT6798KkgAYnRLr16eu_UsKKJA@mail.gmail.com>
References: <CADZ9DPx6=rs2vBrauhsLeBbrjT6798KkgAYnRLr16eu_UsKKJA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1804171639391.4631@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 17 Apr 2018, Mitchell Cuddie wrote:

> Has anyone looked at supporting the blocks extension in Coccinelle?
> https://clang.llvm.org/docs/BlockLanguageSpec.html
>
> There are a number of large projects like WebKit that could make use of
> Coccinelle if it could parse the code. Any thoughts?

Looking extremely quickly it looks like it could be possible.  Do you just
want the parser not to crash or to change this kind of code.  Could you
send a small typical example?

julia
