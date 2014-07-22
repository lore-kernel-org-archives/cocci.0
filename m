From: riccardo.lucchese@gmail.com (Riccardo Lucchese)
Date: Tue, 22 Jul 2014 15:43:09 +0200
Subject: [Cocci] [bug-cocci] "badly compiled mcode" error
In-Reply-To: <alpine.DEB.2.10.1407221455390.2366@hadrien>
References: <20140721184219.GA7903@rlp>
 <alpine.DEB.2.10.1407221455390.2366@hadrien>
Message-ID: <20140722134309.GA30105@rlp>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 22, 2014 at 02:55:57PM +0200, Julia Lawall wrote:
> A patch is below.
> 
> julia

Thank you, I cannot reproduce the error with this applied.

riccardo


> diff --git a/parsing_cocci/iso_compile.ml b/parsing_cocci/iso_compile.ml
> index 5e39b9c..7921f44 100644
> --- a/parsing_cocci/iso_compile.ml
> +++ b/parsing_cocci/iso_compile.ml
> @@ -52,7 +52,7 @@ let process_info l =
>  	 let safe_add p pos =
>  	   (* don't add pos var where a pos var is already present *)
>  	   if Common.inter_set previously_used pos = [] then p::pos else pos in
> -	 let p =
> +	 let new_previously_used =
>  	   if List.for_all (List.for_all (function e -> List.length e = 1)) a
>  	   then
>  	     let p = get_p() in
> @@ -60,22 +60,23 @@ let process_info l =
>  	       (List.iter
>  		  (List.iter (function (_,pos) -> pos := safe_add p !pos)))
>  	       a;
> -	     [p]
> +	     p::previously_used
>  	   else
>  	     let all = r @ List.concat xs in
> -	     let rec find_first_available a = function
> +	     let rec find_first_available a previously_used = function
>  		 [] -> raise Not_found
>  	       | (str,pos)::xs ->
>  		   if str = a && Common.inter_set previously_used !pos = []
>  		   then pos
> -		   else find_first_available a xs in
> +		   else find_first_available a previously_used xs in
>  	     List.fold_left
>  	       (function prev ->
>  		 function (str,pos) ->
>  		   if Common.inter_set previously_used !pos = []
>  		   then
>  		     try
> -		       let entries = List.map (find_first_available str) all in
> +		       let entries =
> +			 List.map (find_first_available str prev) all in
>  		       let p = get_p() in
>  		       pos := p::!pos;
>  		       List.iter (function pos -> pos := p :: !pos) entries;
> @@ -83,8 +84,8 @@ let process_info l =
>  		     with Not_found -> prev
>  		   (* otherwise already annotated *)
>  		   else prev)
> -	       [] f in
> -	 loop (p at previously_used) xs
> +	       previously_used f in
> +	 loop new_previously_used xs
>       | _ -> failwith "bad iso" in
>     loop l
> 
