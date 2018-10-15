From: timur@kernel.org (Timur Tabi)
Date: Mon, 15 Oct 2018 13:35:35 -0500
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <alpine.DEB.2.20.1810151853140.10109@hadrien>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810132318330.15695@hadrien>
 <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
 <alpine.DEB.2.20.1810151839210.10109@hadrien>
 <CAOZdJXWgMZCaiE0y9PL3fc6NLdLNGLFUvN2v+EAE2tffXHe9_w@mail.gmail.com>
 <alpine.DEB.2.20.1810151853140.10109@hadrien>
Message-ID: <CAOZdJXXg+su+OXjb15wnpwk1WNZY-MyVAE8oZxwRud2pgGOQyw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Oct 15, 2018 at 11:55 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> Do you have parmap installed on your machine?  Try
>
> ocamlfind query parmap

$  ocamlfind query parmap
/usr/lib/ocaml/parmap

> Then try which ocaml and see if they have the same prefix.  For example,
> I have:
>
> hadrien: ocamlfind query parmap
> /home/jll/.opam/4.06.1/lib/parmap
> hadrien: which ocaml
> /home/jll/.opam/4.06.1/bin/ocaml

$ which ocaml
/usr/bin/ocaml
$ ocaml --version
The OCaml toplevel, version 4.05.0

I have a stock Ubuntu 18.04 installation.
