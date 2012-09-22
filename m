From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Sep 2012 19:08:51 +0200 (CEST)
Subject: [Cocci] Unwanted space added at end of line
In-Reply-To: <1348302555.11590.8.camel@ice-age.regit.org>
References: <1348302555.11590.8.camel@ice-age.regit.org>
Message-ID: <alpine.DEB.2.02.1209221907450.1899@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A proposed patch that fixes this and some other trailing whitespace 
problems is attached.  I still need to check that it does not break 
anything, so let me know if there are any new problems.

julia

On Sat, 22 Sep 2012, Eric Leblond wrote:

> Hello,
>
> I've just wrote a really simple SMPL (attached to the mail). It makes a
> modification on the code which is the following:
>
> - if (x == NULL) S1
> + if (unlikely(x == NULL)) S1
>
> The result is semantically correct but there is spaces at end of line as
> shown in the example below:
>
> @@ -173,8 +173,8 @@ DefragContextNew(void)
>     DefragContext *dc;
>
>     dc = SCCalloc(1, sizeof(*dc));
> -    if (dc == NULL)
> -        return NULL;<- no space
> +    if (unlikely(dc == NULL))
> +        return NULL;   <- 4 space here
>
> I've tried to look at coccinelle code but I'm unable to find a way to a
> solution.
>
> Am I missing an option ?
>
> BR,
> --
> Eric Leblond
>
>
-------------- next part --------------
diff --git a/coccinelle/unparse_c.ml b/coccinelle/unparse_c.ml
index e0938e4..1d8f0b7 100644
--- a/coccinelle/unparse_c.ml
+++ b/coccinelle/unparse_c.ml
@@ -333,7 +333,7 @@ let comment2t2 = function
       C2(info.Common.str)
   | (Token_c.TCommentCpp x,(info : Token_c.info)) ->
       C2("\n"^info.Common.str^"\n")
-  | x -> failwith (Printf.sprintf "unexpected comment %s" (Common.dump x))
+  | x -> failwith (Printf.sprintf "unexpected comment %s" (Dumper.dump x))
 
 let expand_mcode toks =
   let toks_out = ref [] in
@@ -396,7 +396,7 @@ let expand_mcode toks =
       |	Ast_c.FakeTok (s,_) ->
 	  push2 (C2 s) toks_out
       |	_ ->
-	  Printf.fprintf stderr "line: %s\n" (Common.dump info);
+	  Printf.fprintf stderr "line: %s\n" (Dumper.dump info);
 	  failwith "not an abstract line");
       (!(info.Ast_c.comments_tag)).Ast_c.mafter +>
       List.iter (fun x -> Common.push2 (comment2t2 x) toks_out) in
@@ -872,11 +872,12 @@ let paren_then_brace toks =
 	else x :: search_paren xs
     | x::xs -> x :: search_paren xs
   and search_plus xs =
-    let (spaces, rest) = Common.span is_whitespace xs in
+    let (spaces, rest) = Common.span is_space xs in
+    let (nls, rest) = Common.span is_newline rest in
     match rest with
       (* move the brace up to the previous line *)
       ((Cocci2("{",_,_,_,_)) as x) :: (((Cocci2 _) :: _) as rest) ->
-	(C2 " ") :: x :: spaces @ rest
+	spaces @ x :: nls @ rest
     | _ -> xs in
   search_paren toks
 
@@ -1163,13 +1164,15 @@ let rec adjust_indentation xs =
 	    _current_tabbing := tu::(!_current_tabbing);
 	     (* can't be C2, for later phases *)
 	     Cocci2 (tu,-1,-1,-1,None)::aux started xs)
-    | Unindent_cocci2(permanent)::xs ->
+    | Unindent_cocci2(permanent)::((Cocci2("\n",_,_,_,_)) as x)::xs ->
+	(* seems only relevant if there is a following cocci newline *)
 	(match !_current_tabbing with
 	  [] -> aux started xs
 	| _::new_tabbing ->
             let s = String.concat "" new_tabbing in
 	    _current_tabbing := new_tabbing;
-	    Cocci2 (s,-1,-1,-1,None)::aux started xs)
+	    x::Cocci2 (s,-1,-1,-1,None)::aux started xs)
+    | Unindent_cocci2(permanent)::xs -> aux started xs
     (* border between existing code and cocci code *)
     | ((T2 (tok,_,_)) as x)::((Cocci2("\n",_,_,_,_)) as y)::xs
       when str_of_token2 x =$= "{" ->
