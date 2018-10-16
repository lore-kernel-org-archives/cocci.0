From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 16 Oct 2018 17:12:04 +0200 (CEST)
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <20181016151052.GA26422@himanshu-Vostro-3559>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810132318330.15695@hadrien>
 <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
 <20181016151052.GA26422@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.20.1810161711210.3512@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 16 Oct 2018, Himanshu Jha wrote:

> On Mon, Oct 15, 2018 at 11:37:00AM -0500, Timur Tabi wrote:
> > On Sat, Oct 13, 2018 at 4:19 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > > This problem has been fixed.  Actually, it thought that "    of multiline " was the new amount to indent...
> >
> > When I try to build this on Ubuntu 18, I get the following error:
> >
> > OCAMLOPT  parsing_c/includes.ml
> > File "parsing_c/includes.ml", line 159, characters 9-22:
> > Error: Unbound module Parmap
> > Makefile:424: recipe for target 'parsing_c/includes.cmx' failed
> > make: *** [parsing_c/includes.cmx] Error 2
> > rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d
> > parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml
> > parsing_cocci/lexer_cocci.ml
> >
> > I installed all the packages listed in install.txt.
> >
> > I tried "./configure --disable-pcre-syntax" and "./configure
> > --disable-ocaml", but neither helped.
>
> FYI coccinelle works fine on Ubuntu 18.04.1 when built through
> source code.
>
> There might be problem for the specific config you're targeting.
> But I'm curious as to how disabling pcre-syntax helps ?
>
> I do understand the purpose of disabling ocaml scripting.

No, disabling OCaml scripting doesn't help either. Parmap is for
parallelism, whether one has OCaml scripting or not.

julia

>
> himanshu at himanshu-Vostro-3559:~$ spatch --version
> spatch version 1.0.7-00498-g41ec93a2 compiled with OCaml version 4.05.0
> Flags passed to the configure script: --with-bash-completion=/etc/bash_completion.d/
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
>
> Thanks
> --
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology
>
