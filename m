From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Oct 2018 18:55:39 +0200 (CEST)
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXWgMZCaiE0y9PL3fc6NLdLNGLFUvN2v+EAE2tffXHe9_w@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810132318330.15695@hadrien>
 <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
 <alpine.DEB.2.20.1810151839210.10109@hadrien>
 <CAOZdJXWgMZCaiE0y9PL3fc6NLdLNGLFUvN2v+EAE2tffXHe9_w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1810151853140.10109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Oct 2018, Timur Tabi wrote:

> On Mon, Oct 15, 2018 at 11:40 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > Neither is relevant.  Try make distclean, ./autogen, ./configure
>
> That didn't help.  I'm already working with a clean clone of the git repo.

Do you have parmap installed on your machine?  Try

ocamlfind query parmap

Then try which ocaml and see if they have the same prefix.  For example,
I have:

hadrien: ocamlfind query parmap
/home/jll/.opam/4.06.1/lib/parmap
hadrien: which ocaml
/home/jll/.opam/4.06.1/bin/ocaml

julia
