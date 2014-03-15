From: suyogburadkar@gmail.com (Shreeram B)
Date: Sat, 15 Mar 2014 20:38:26 +0530
Subject: [Cocci] Cocci Digest, Vol 19, Issue 14
In-Reply-To: <mailman.1.1394881201.27491.cocci@systeme.lip6.fr>
References: <mailman.1.1394881201.27491.cocci@systeme.lip6.fr>
Message-ID: <CAFEZ=9rxUC6ODqhKEHrrGAmKC75PXUjzVoEGYerhHk9oMgwX+g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Sir ... i solved the problem with installing libraries ... your
application works outstanding

On 3/15/14, cocci-request at systeme.lip6.fr <cocci-request@systeme.lip6.fr> wrote:
> Send Cocci mailing list submissions to
> 	cocci at systeme.lip6.fr
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://systeme.lip6.fr/mailman/listinfo/cocci
> or, via email, send a message with subject or body 'help' to
> 	cocci-request at systeme.lip6.fr
>
> You can reach the person managing the list at
> 	cocci-owner at systeme.lip6.fr
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Cocci digest..."
>
>
> Today's Topics:
>
>    1. Re:  Determination of the number for named function
>       parameters (SF Markus Elfring)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 14 Mar 2014 15:25:41 +0100
> From: SF Markus Elfring <elfring@users.sourceforge.net>
> To: cocci at systeme.lip6.fr
> Subject: Re: [Cocci] Determination of the number for named function
> 	parameters
> Message-ID: <53231165.7050707@users.sourceforge.net>
> Content-Type: text/plain; charset=ISO-8859-1
>
>> 2. Comparison for the incidence of unnamed function parameters to all of
>> them
>
> I am trying out a bit more preparation with OCaml script development for
> this
> report variant.
>
>
> @initialize:ocaml@
> @@
> module My_map = Map.Make(Int64)
>
> let m = ref My_map.empty
>
> let counting dir =
>     let d = Unix.opendir dir in
>     try while true do
>         let name = Unix.readdir d in
>         let length = Int64.of_int (String.length name) in
>
>         if My_map.mem length (! m) then
>            ignore (m := My_map.add length (Int64.add (My_map.find length (!
> m))
> Int64.one) (! m))
>         else
>            ignore (m := My_map.add length Int64.one (! m))
>         done
>     with End_of_file -> Unix.closedir d
>
> @find@
> identifier fu;
> @@
> *fu(...)
>  { ... }
>
> @script:ocaml collection@
> area << virtual.folder;
> @@
> if area = "" then
>    counting "/"
> else
>    counting area
>
> @finalize:ocaml@
> @@
> if My_map.is_empty (! m) then
>    prerr_endline "No result for this analysis!"
> else
>    let delimiter = '|' in
>    let output key count = Printf.printf "%Li%c%Li\r\n" key delimiter count
> in
>    Printf.printf "length%cincidence\r\n" delimiter;
>    My_map.iter output (! m)
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --sp-file
> list_file_name_lengths1.cocci ../Probe/f-ptr-test1.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> Using native version of ocamlc/ocamlopt/ocamldep
> ocamlopt.opt -shared -o /tmp/list_file_name_lengths1f3bae5.cmxs -g -I
> /usr/lib64/ocaml  -I /usr/local/share/coccinelle/ocaml
> /tmp/list_file_name_lengths1f3bae5.ml
> Compilation OK!
> Loading ML code of the SP...
> HANDLING: ../Probe/f-ptr-test1.c
> ...
> No result for this analysis!
>
>
> How do you think about such a semantic patch approach?
>
> Regards,
> Markus
>
>
> ------------------------------
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
>
> End of Cocci Digest, Vol 19, Issue 14
> *************************************
>
