From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 18 Jan 2015 20:29:34 +0100 (CET)
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
Message-ID: <alpine.DEB.2.10.1501182028570.3422@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 18 Jan 2015, Eliseo Mart?nez wrote:

> No luck. ./configure seems to run fine but make this error:
>
> /opt/local/bin/ocamlc.opt -g  -I /Users/eliseo/projects/os/coccinelle/bundles/menhirLib/ -I /opt/local/lib/ocaml -I /opt/local/lib/ocaml/site-lib/pcre -I commons -I commons/ocamlextra -I ctl -I engine -I extra -I globals -I ocaml -I parsing_c -I parsing_cocci -I popl09 -I python -c main.ml
> /opt/local/bin/ocamlc.opt -g  -I /Users/eliseo/projects/os/coccinelle/bundles/menhirLib/ -I /opt/local/lib/ocaml -I /opt/local/lib/ocaml/site-lib/pcre -I commons -I commons/ocamlextra -I ctl -I engine -I extra -I globals -I ocaml -I parsing_c -I parsing_cocci -I popl09 -I python -custom -g     -ccopt -L/opt/local/lib -ccopt -lpcre -dllib -lpcre_stubs -cclib -lpcre_stubs -o spatch str.cma unix.cma bigarray.cma nums.cma /opt/local/lib/ocaml/dynlink.cma /opt/local/lib/ocaml/site-lib/pcre/pcre.cma commons/commons.cma globals/globals.cma ctl/ctl.cma parsing_cocci/cocci_parser.cma parsing_c/parsing_c.cma engine/cocciengine.cma popl09/popl.cma extra/extra.cma python/coccipython.cma ocaml/cocciocaml.cma flag_cocci.cmo cocci.cmo testing.cmo test.cmo main.cmo
> File "_none_", line 1:
> Error: Files commons/commons.cma(Common)
>        and /opt/local/lib/ocaml/stdlib.cma(Bytes)
>        make inconsistent assumptions over interface Bytes
> make[3]: *** [spatch] Error 2
> make[2]: *** [byte] Error 2
> make[1]: *** [all-dev] Error 2
> make: *** [all] Error 2
>
> Anyone has seen that before?

The use of Bytes is new with this version.  I will ask someone to look
into it.  Just in case, could you try make clean before make?

thanks,
julia

>
> Thanks,
> Eliseo.
>
> > On 17 Jan 2015, at 23:09, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> > On Sat, 17 Jan 2015, Eliseo Mart?nez wrote:
> >
> >> Hi,
> >>
> >> Up to now, I?ve been using coccinelle in an Ubuntu virtual machine, running in my OSX Yosemite machine.
> >> Now I?d like to try installing it on OSX itself.
> >> As I don?t see anything about this on the website, I wanted to ask first.
> >> Has anybody managed to successfully install coccinelle on OSX?
> >
> > Yes, I think it should be OK.  The only detail may be with PCRE (ocaml
> > library for regular expressions).  Some people reported that configure
> > correctly detected that they did not have pcre installed, but when it came
> > tie to link Coccinelle, pcre was expected.  So they had to install pcre.
> >
> > julia
>
>
