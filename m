From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 12 Mar 2014 11:10:23 +0100
Subject: [Cocci] Clarification for OCaml scripts in SmPL
In-Reply-To: <alpine.DEB.2.02.1403102215010.2181@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <531DFDBC.9010801@users.sourceforge.net>
 <alpine.DEB.2.10.1403101919350.2082@hadrien>
 <531E04D9.5000605@users.sourceforge.net>
 <alpine.DEB.2.02.1403102022510.2181@localhost6.localdomain6>
 <531E2A51.5050000@users.sourceforge.net>
 <alpine.DEB.2.02.1403102215010.2181@localhost6.localdomain6>
Message-ID: <5320328F.5090507@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I imagine that in-place modification will be a more efficient approach for my
>> use case. Is a kind of list buffer available?
> 
> You can just add information to the front of the list, and then reverse it 
> at the end if that is needed.

I am trying to convert Python statements into similar OCaml functionality for
one of my semantic patch examples.

@initialize:ocaml@
@@
let result = Queue.create ()

let current_function = ref ""
let current_count = ref ""
let empty = ""
let delimiter = "|"
let quote = "\""
let quote2 = "\"\""
let mark text = String.concat empty [quote; text; quote]

let replace text =
    let length = String.length text in
    let part = Buffer.create length in
    for x = 0 to length - 1 do
        if text.[x] = '"' then
           Buffer.add_string part quote2
        else
           Buffer.add_char part text.[x]
    done;
    Buffer.contents part


(* Add a source code position to an internal list. *)
let append place =
    Queue.add (String.concat delimiter [!current_function;
                                        !current_count;
                                        mark (replace place.file);
                                        string_of_int place.line;
                                        string_of_int (place.column + 1)]) result

let store_positions fun count places =
    current_function := fun;
    current_count := string_of_int count;
    List.iter append places

@no_input@
identifier fun;
position pos;
@@
 fun at pos(void) { ... }

@input depends on no_input@
identifier fun;
parameter list [count] pl;
position pos != no_input.pos;
@@
 fun at pos(pl) { ... }

@script:ocaml collection@
fun << input.fun;
count << input.count;
places << input.pos;
@@
store_positions fun count places

@finalize:ocaml@
@@
if Queue.is_empty result then
   Printf.eprintf "No result for this analysis!\n"
else
   let output text = Printf.printf "%s\r\n" text in
   Printf.printf "%s\r\n" (String.concat delimiter ["function";
                                                    "\"parameter count\"";
                                                    "\"source file\"";
                                                    "line";
                                                    "column"]);
   Queue.iter output result



The source code from this SmPL finalisation rule works as expected in a OCaml
command line interface. Now I wonder about the following error message.

elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --sp-file
list_function_parameters3.cocci ../Probe/f-ptr-test1.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
File "list_function_parameters3.cocci", line 69, column 27,  charpos = 1914
    around = '', whole content =    Queue.iter output result
Fatal error: exception Failure("lexing: empty token")


I would appreciate your advices.

Regards,
Markus
