From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 13 May 2014 19:21:41 -0700
Subject: [Cocci] coccinelle 1.0.0-rc21 build failure (RHEL 6)
In-Reply-To: <alpine.DEB.2.10.1405141005140.2913@hadrien>
References: <20140514015330.GG28907@ld-irv-0074>
 <alpine.DEB.2.10.1405141005140.2913@hadrien>
Message-ID: <20140514022141.GH28907@ld-irv-0074>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 14, 2014 at 10:05:51AM +0800, Julia Lawall wrote:
> Please try this patch.
> 
> julia
> 
> diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
> index 0e31412..482cc13 100644
> --- a/engine/cocci_vs_c.ml
> +++ b/engine/cocci_vs_c.ml
> @@ -653,8 +653,6 @@ module type PARAM =
>        (A.meta_name A.mcode, (string Ast_c.wrap, Ast_c.il) either list) matcher
>      val distrf_pragmainfo :
>        (A.meta_name A.mcode, Ast_c.pragmainfo) matcher
> -    val distrf_ident_list :
> -      (A.meta_name A.mcode, (Ast_c.name, Ast_c.il) either list) matcher
> 
>      val distrf_enum_fields :
>        (A.meta_name A.mcode, (B.oneEnumType, B.il) either list) matcher

A little better, but no dice:

make[5]: Entering directory `/exp00/norris/build/coccinelle-1.0.0-rc21/ocaml'
/usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../parsing_cocci -I ../parsing_c -I ../engine -c exposed_modules.ml
/usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../parsing_cocci -I ../parsing_c -I ../engine -c coccilib.ml
/usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../parsing_cocci -I ../parsing_c -I ../engine -c ocamlcocci_aux.mli
/usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../parsing_cocci -I ../parsing_c -I ../engine -c ocamlcocci_aux.ml
/usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I ../globals -I ../parsing_cocci -I ../parsing_c -I ../engine -c no_prepare_ocamlcocci.ml
File "no_prepare_ocamlcocci.ml", line 12, characters 5-57:
Error: The constructor Ast_cocci.InitialScriptRule expects 5 argument(s),
       but is applied here to 4 argument(s)
make[5]: *** [no_prepare_ocamlcocci.cmo] Error 2
make[5]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21/ocaml'
make[4]: *** [ocaml.all] Error 2
make[4]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
make[3]: *** [subdirs.all] Error 1
make[3]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
make[2]: *** [byte] Error 2
make[2]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
make[1]: *** [all-dev] Error 2
make[1]: Leaving directory `/exp00/norris/build/coccinelle-1.0.0-rc21'
make: *** [all] Error 2
