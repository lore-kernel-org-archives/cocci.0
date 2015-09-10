From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 10 Sep 2015 18:24:46 +0200 (CEST)
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
In-Reply-To: <CAB3z_RqpjvcJnaEWcUi58Fp=S=W6=GUi_jb3wRrJKVZQojFmbA@mail.gmail.com>
References: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
 <alpine.DEB.2.10.1509091559330.2798@hadrien>
 <CAB3z_Rp9V9U8KcD6OgY=tuTmO3AHVT-UwwVim+yxitMAvQWWgw@mail.gmail.com>
 <alpine.DEB.2.10.1509091617370.2798@hadrien>
 <CAB3z_RoqPMH3ZEwXHk-NHWt2qbLx3vv5bWcFY7eWuw0OqDOa0A@mail.gmail.com>
 <55F046A3.4000004@users.sourceforge.net>
 <CAB3z_RqpjvcJnaEWcUi58Fp=S=W6=GUi_jb3wRrJKVZQojFmbA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1509101824030.2316@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The following patch should hopefully remove the problem of undesrably
removing the comment.  Let me know if there are further such problems.

thanks,
julia

---

diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 7240165..3879df5 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -272,9 +272,9 @@ let get_fakeInfo_and_tokens celem toks =

 (* Fake nodes that have BEFORE code or are - should be moved over any
 subsequent whitespace and newlines, but not any comments starting in column
-0, to get as close to the affected code as possible.  Similarly, fake nodes
-that have AFTER code should be moved backwards.  No fake nodes should have
-both before and after code. *)
+0 or the last newline, to get as close to the affected code as possible.
+Similarly, fake nodes that have AFTER code should be moved backwards.  No
+fake nodes should have both before and after code. *)

 let displace_fake_nodes toks =
   let is_fake = function Fake1 _ -> true | _ -> false in
@@ -286,6 +286,13 @@ let displace_fake_nodes toks =
 	(* column 0 is the leftmost column. *)
 	Ast_c.col_of_info i > 0
     | _ -> false in
+  let is_nonnl_whitespace_or_noncol0_comment = function
+    | T1(Parser_c.TCommentSpace _) -> true
+  (* patch: cocci    *)
+    | T1(Parser_c.TComment i) ->
+	(* column 0 is the leftmost column. *)
+	Ast_c.col_of_info i > 0
+    | _ -> false in
   let is_whitespace_or_comment = function
     | T1(Parser_c.TCommentSpace _)
     | T1(Parser_c.TCommentNewline _)
@@ -316,6 +323,11 @@ let displace_fake_nodes toks =
           (* move the fake node forwards *)
           let (whitespace,rest) = span is_whitespace_or_noncol0_comment aft in
           bef @ whitespace @ fake :: (loop rest)
+        | (Ast_cocci.MINUS(_,_,_,Ast_cocci.NOREPLACEMENT),_) ->
+          (* move the fake node forwards *)
+          let (whitespace,rest) =
+	    span is_nonnl_whitespace_or_noncol0_comment aft in
+          bef @ whitespace @ fake :: (loop rest)
         | (Ast_cocci.CONTEXT(_,Ast_cocci.AFTER _),_) ->
           (* move the fake node backwards *)
           let revbef = List.rev bef in
