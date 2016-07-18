From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Jul 2016 07:11:40 +0200 (CEST)
Subject: [Cocci] Coccinelle vs Firefox
In-Reply-To: <46E0A0AB-6D78-485E-8CEA-2F7639BF12AC@mac.com>
References: <009C7972-C7EB-4B7F-ABC5-A1C0C1CA5797@mac.com>
 <alpine.DEB.2.10.1607170737330.3253@hadrien>
 <46E0A0AB-6D78-485E-8CEA-2F7639BF12AC@mac.com>
Message-ID: <alpine.DEB.2.10.1607180700380.3156@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 Jul 2016, Perry Wagle wrote:

> If you took coccinelle and somehow retargeted it to ocaml, which I believe
> it?s implemented in, could you then turn around and use that version to
> automate excising/abstracting the AST out, and maybe automating the addition
> of a new/different AST? ?In principle, I mean. ?In practice, I can think of
> a few possible problems, but bootstrapping it might help.

I guess.  I would imagine that reimplementing the whole thing in a more
generic way would be easier.  But neither is a priority for us.

> This is the sort of transformation I?m looking to do, and, in any case, I
> want to do things to ocaml itself (and hence coq).

This person:

Th?ophane Hufschmitt <theophane.hufschmitt@polytechnique.org>

worked on something like Coccinelle for OCaml. It was just a summer
project, but he may have come up with something usable.

> PS. ?John Viega convinced me in 2001 (personal conversation) that trying to
> write your own C++ grammar was a PITA, and mostly futile to get perfect.

The nice part of Coccinele is that we have no need for the grammar to be
perfect.  Our goal is to convert the source code to an AST, not to be sure
that the source code is correctly formed.

> ?Since then, I?ve had the stance that using the compiler itself to do the
> parse was the way to go, but found that GCC was purposely designed not to
> allow you to do this. ?The then new LLVM seemed the way to go, and now its
> finally matured. ?What?s your take on using the compiler?s AST?

If you use someone else's AST, then you have to live with the information
that they thought was useful.  Coccinelle needs information about the
whitespace and commas around each token so that it is able to perform
transformation, ie rebuild the code exactly as it was outside of the
transformed parts.  Coccinelle also has the goal of parsing individual
source code files without expanding macros, to limit the code size, to
avoid the need to interpret make files, and so that the user can express
transformations in terms of the code that he sees, ie macro uses.  I don't
know if LLVM would support that.

>?I did see a
> paper recently fly by about using approximation methods instead of full
> parsing with a compiler, but I can?t find it in my notes right now. ?Anyone
> recognize what I?m talking about?

The concept of island grammars comes to mind:

https://en.wikipedia.org/wiki/Island_grammar

There was also recently a paper from the group of Dawson Engler about
doing program analysis for lots of languages using approximate parsing.
I'm not sure if either is connected to a compiler though.

Fraser Brown, Andres N?tzli, Dawson R. Engler:
How to Build Static Checking Systems Using Orders of Magnitude Less Code.
ASPLOS 2016: 143-157

julia
