From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 28 Oct 2012 05:14:19 -0700 (PDT)
Subject: [Cocci] semantic patches for C preprocessing constructs?
In-Reply-To: <508CF786.7050503@users.sourceforge.net>
References: <CAP6exYJCAAPUyc4K8dYfLG23Aekb1nEC=O4Cv-R2AL4TEEtABw@mail.gmail.com>
 <alpine.DEB.2.02.1210251318530.1955@hadrien>
 <508A6C2C.5030608@users.sourceforge.net>
 <alpine.DEB.2.02.1210260646230.1977@hadrien>
 <508CF786.7050503@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1210280511160.1952@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 28 Oct 2012, SF Markus Elfring wrote:

> > If someoen wants to, I guess that would be useful, but it would require
> > quite substantial changes, and thus a good understanding of both
> > ocaml and the existing code.
>
> Are there any chances to reduce the dependency on the syntax of a specific
> programming language like "OCaml"?

Huh?  Coccinelle is written in Ocaml.  Matching C preprocessing code
requires pervasive changes to its implementation.  Thus it requires
knowing the language in which the code is implemented.

> How do you think about to talk a bit more about general data structures,
> modules, classes and corresponding interfaces?

I think it is completely irrelevant to the project.

julia
