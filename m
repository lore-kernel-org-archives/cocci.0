From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Tue, 26 May 2015 17:34:50 +0200
Subject: [Cocci] iteration.cocci
Message-ID: <CABBGRWtGqhJG4ZUfquga8SY4ASOcAuQP-Oug-gobhS9LMspx9A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

hello,
 Can you tell me please what is the function of this part in the
file coccinelle/demos/iteration.cocci

virtual after_start @initialize:ocaml@@@ let tbl = Hashtbl.create(100) let
add_if_not_present from f file =try let _ = Hashtbl.find tbl (f,file) in ()with
Not_found -> Hashtbl.add tbl (f,file) file; let it = new iteration() in
(match file with Some fl -> it#set_files [fl] | None -> ());
it#add_virtual_rule After_start; it#add_virtual_identifier Err_ptr_function
f; it#register()
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150526/8de78b86/attachment.html>
