From: chrubis@suse.cz (Cyril Hrubis)
Date: Wed, 3 Dec 2014 09:33:52 +0100
Subject: [Cocci] string parameter concatenation
In-Reply-To: <alpine.DEB.2.10.1410170752240.2654@hadrien>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.02.1410021858360.2062@localhost6.localdomain6>
 <20141006102500.GC8551@rei.suse.cz>
 <alpine.DEB.2.10.1410170752240.2654@hadrien>
Message-ID: <20141203083352.GA9214@rei.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
> diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
> index 3c54c33..77c23bb 100644
> --- a/parsing_c/unparse_c.ml
> +++ b/parsing_c/unparse_c.ml
> @@ -1288,14 +1288,12 @@ let add_newlines toks tabbing_unit =
>      | _ -> (count,List.tl stack,space_cell,seen_cocci) in
>    let update_by_stack s count stack sp space_cell seen_cocci =
>      let count = simple_string_length s (count + 1 (*space*)) in
> -    let newinfo =
> -      match stack with
> -      | [(x,tustack)] ->
> -          (match check_for_newline count x tustack space_cell with
> -          | Some count -> (stack,Some (x,sp), seen_cocci)
> -          | None -> (stack,Some (count,sp),seen_cocci))
> -      | _ -> (stack,space_cell,seen_cocci) in
> -    (newinfo,count) in
> +    match stack with
> +    | [(x,tustack)] ->
> +        (match check_for_newline count x tustack space_cell with
> +        | Some count -> ((stack,Some (x,sp), seen_cocci),count)
> +        | None -> ((stack,Some (count,sp),seen_cocci),count))
> +    | _ -> ((stack,space_cell,seen_cocci),count) in
>    let rec loop ((stack,space_cell,seen_cocci) as info) count seeneq =
>      function
>      | [] -> []

Sorry, I've lost context on this one. Over what patches should I apply
this patch? I've tried both 1.0.0-rc22 and 1.0.0-rc22 + patches you send
previously and neither of them worked :(.

It would have been easier if coccinelle had official git repository you
could have pushed the patch there and easily point me to it...

-- 
Cyril Hrubis
chrubis at suse.cz
