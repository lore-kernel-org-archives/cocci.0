From: mstefani@redhat.com (Michael Stefaniuc)
Date: Sat, 05 Jan 2013 23:48:43 +0100
Subject: [Cocci] Parsing error for struct names starting with two
	underscore
In-Reply-To: <alpine.DEB.2.02.1301050906120.2085@localhost6.localdomain6>
References: <50E74F50.6000308@redhat.com>
 <alpine.DEB.2.02.1301050906120.2085@localhost6.localdomain6>
Message-ID: <50E8ADCB.9090407@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks Julia,

On 01/05/2013 09:07 AM, Julia Lawall wrote:
> The problem is that it was considering anything beginning with __ that
> is followed by an identifier to be an attribute.  The following patch
> does not do that when the __ thing is immediately preceded by a struct.
> Perhaps that is not the best solution, but it works in this case.
the patch works here though only for structs and not unions. Which is
good enough for Wine. One of this days I should learn OCaml so I can
modify coccinelle myself...

bye
	michael

> The line number in the patch are likely to be off.
> 
> julia
> 
> diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
> index f6ed199..13ce673 100644
> --- a/parsing_cocci/parse_cocci.ml
> +++ b/parsing_cocci/parse_cocci.ml
> @@ -828,6 +828,8 @@ let rec detect_attr l =
>    let rec loop = function
>        [] -> []
>      | [x] -> [x]
> +    | ((PC.Tstruct _,_) as t1)::x::rest ->
> +       t1::x::loop rest
>      | ((PC.TIdent(nm,clt),info) as t1)::id::rest when is_id id ->
>         if String.length nm > 2 && String.sub nm 0 2 = "__"
>         then (PC.Tattr(nm,clt),info)::(loop (id::rest))
