From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 14 Mar 2014 15:25:41 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <531C2B51.1040700@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <531B771D.3020900@users.sourceforge.net>
 <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
 <531C1FAD.6030009@users.sourceforge.net>
 <alpine.DEB.2.02.1403090906180.2030@localhost6.localdomain6>
 <531C2B51.1040700@users.sourceforge.net>
Message-ID: <53231165.7050707@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> 2. Comparison for the incidence of unnamed function parameters to all of them

I am trying out a bit more preparation with OCaml script development for this
report variant.


@initialize:ocaml@
@@
module My_map = Map.Make(Int64)

let m = ref My_map.empty

let counting dir =
    let d = Unix.opendir dir in
    try while true do
        let name = Unix.readdir d in
        let length = Int64.of_int (String.length name) in

        if My_map.mem length (! m) then
           ignore (m := My_map.add length (Int64.add (My_map.find length (! m))
Int64.one) (! m))
        else
           ignore (m := My_map.add length Int64.one (! m))
        done
    with End_of_file -> Unix.closedir d

@find@
identifier fu;
@@
*fu(...)
 { ... }

@script:ocaml collection@
area << virtual.folder;
@@
if area = "" then
   counting "/"
else
   counting area

@finalize:ocaml@
@@
if My_map.is_empty (! m) then
   prerr_endline "No result for this analysis!"
else
   let delimiter = '|' in
   let output key count = Printf.printf "%Li%c%Li\r\n" key delimiter count in
   Printf.printf "length%cincidence\r\n" delimiter;
   My_map.iter output (! m)


elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --sp-file
list_file_name_lengths1.cocci ../Probe/f-ptr-test1.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
Using native version of ocamlc/ocamlopt/ocamldep
ocamlopt.opt -shared -o /tmp/list_file_name_lengths1f3bae5.cmxs -g -I
/usr/lib64/ocaml  -I /usr/local/share/coccinelle/ocaml
/tmp/list_file_name_lengths1f3bae5.ml
Compilation OK!
Loading ML code of the SP...
HANDLING: ../Probe/f-ptr-test1.c
...
No result for this analysis!


How do you think about such a semantic patch approach?

Regards,
Markus
