From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 13 May 2014 20:08:40 -0700
Subject: [Cocci] coccinelle 1.0.0-rc21 build failure (RHEL 6)
In-Reply-To: <alpine.DEB.2.10.1405141034060.2913@hadrien>
References: <20140514015330.GG28907@ld-irv-0074>
 <alpine.DEB.2.10.1405141005140.2913@hadrien>
 <20140514022141.GH28907@ld-irv-0074>
 <alpine.DEB.2.10.1405141034060.2913@hadrien>
Message-ID: <20140514030840.GI28907@ld-irv-0074>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 14, 2014 at 10:36:05AM +0800, Julia Lawall wrote:
> OK, sorry about that.  It seems that your ocaml is old enough that it does
> not support dynaically loaded libraries, and I didn't try compiling with
> that option...
> 
> Here is another patch.
> 
> julia
> 
> commit 6589767e27043caeab982ecb4bc444227d946af7
> Author: Julia Lawall <Julia.Lawall@lip6.fr>
> Date:   Wed May 14 10:33:45 2014 +0800
> 
>     update constructors for new types
> 
> diff --git a/ocaml/no_prepare_ocamlcocci.ml b/ocaml/no_prepare_ocamlcocci.ml
> index 772528b..f5c52d9 100644
> --- a/ocaml/no_prepare_ocamlcocci.ml
> +++ b/ocaml/no_prepare_ocamlcocci.ml
> @@ -9,9 +9,9 @@ let prepare coccifile code =
>  	function
>  	    Ast_cocci.ScriptRule (name,"ocaml",deps,mv,script_vars,code) ->
>  	      code :: prev
> -	  | Ast_cocci.InitialScriptRule (name,"ocaml",deps,code) ->
> +	  | Ast_cocci.InitialScriptRule (name,"ocaml",deps,mvs,code) ->
>  	      code :: prev
> -	  | Ast_cocci.FinalScriptRule (name,"ocaml",deps,code) ->
> +	  | Ast_cocci.FinalScriptRule (name,"ocaml",deps,mvs,code) ->
>  	      code :: prev
>  	  | _ -> prev)
>        [] code in

That seems to work for me. Thanks!

Brian
