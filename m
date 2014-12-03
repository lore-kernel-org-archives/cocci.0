From: francois.berenger@inria.fr (Francois Berenger)
Date: Wed, 03 Dec 2014 16:50:49 +0100
Subject: [Cocci] while compiling coccci 1.0.0-rc22
In-Reply-To: <547F3005.2060402@inria.fr>
References: <20141202085950.GA13434@mwanda>
 <547F0297.6030202@users.sourceforge.net> <20141203124511.GR5048@mwanda>
 <alpine.DEB.2.10.1412031352120.2373@hadrien> <547F3005.2060402@inria.fr>
Message-ID: <547F3159.1050605@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There is exactly the same problem with 1.0.0-rc21.
So the coccinelle opam package just got broken recently.

The only change I could see is that the package pcre-ocaml
was renamed to pcre.

I will dig a little ...

On 12/03/2014 04:45 PM, Francois Berenger wrote:
> Hi,
>
> Anyone got this?
>
> /home/berenger/.opam/4.01.0/bin/ocamlopt.opt -unsafe -I
> /home/berenger/.opam/4.01.0/lib/menhirLib -I
> /home/berenger/.opam/4.01.0/lib/ocaml -I
> /home/berenger/.opam/4.01.0/lib/pcre -I
> /home/berenger/src/coccinelle-1.0.0-rc22/bundles/pycaml/ -I commons -I
> commons/ocamlextra -I ctl -I engine -I extra -I globals -I ocaml -I
> parsing_c -I parsing_cocci -I popl09 -I python    -cclib -lpycaml_stubs
> -cclib -lpython2.7 -ccopt -lpcre -cclib -lpcre_stubs -o spatch.opt
> str.cmxa unix.cmxa bigarray.cmxa nums.cmxa
> /home/berenger/.opam/4.01.0/lib/ocaml/dynlink.cmxa
> /home/berenger/src/coccinelle-1.0.0-rc22/bundles/pycaml//pycaml.cmxa
> /home/berenger/.opam/4.01.0/lib/pcre/pcre.cmxa commons/commons.cmxa
> globals/globals.cmxa ctl/ctl.cmxa parsing_cocci/cocci_parser.cmxa
> parsing_c/parsing_c.cmxa engine/cocciengine.cmxa popl09/popl.cmxa
> extra/extra.cmxa python/coccipython.cmxa ocaml/cocciocaml.cmxa
> flag_cocci.cmx cocci.cmx testing.cmx test.cmx main.cmx
> File "_none_", line 1:
> Error: No implementations provided for the following modules:
>           Bytes referenced from
> /home/berenger/.opam/4.01.0/lib/pcre/pcre.cmxa(Pcre)
>
> Regards,
> F.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci

-- 
Regards,
Francois.
