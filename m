From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Sep 2012 11:24:55 +0200 (CEST)
Subject: [Cocci] Unwanted space added at end of line
In-Reply-To: <1348352839.1867.8.camel@ice-age.regit.org>
References: <1348302555.11590.8.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1209221907450.1899@localhost6.localdomain6>
 <1348352839.1867.8.camel@ice-age.regit.org>
Message-ID: <alpine.DEB.2.02.1209231124210.1911@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A patch against rc15 is attached.

julia

On Sun, 23 Sep 2012, Eric Leblond wrote:

> Hello,
>
> Thanks a lot Julia for your fast and efficient answer !
>
> Le samedi 22 septembre 2012 ? 19:08 +0200, Julia Lawall a ?crit :
>> A proposed patch that fixes this and some other trailing whitespace
>> problems is attached.  I still need to check that it does not break
>> anything, so let me know if there are any new problems.
>
> First of all, it fixes the whitespace issue described in my previous
> mail.
>
> I've runned all my cocci test with this patch applied and no problem
> appears.
>
> I've only one issue left regarding formatting but this is dependant of
> my indentation style and can not be considered as a real problem. The
> issue is that the transformation modifies my indentation like shows in
> the following example:
>
> -    if (new_pe == NULL) {
> -        return NULL;
> -    }
> +    if (unlikely(new_pe == NULL))
> +        {
> +            return NULL;
> +        }
>
> I obtain a code which is not with the good coding style and need to be
> reindented. Is there a way to specify to coccinelle we want to use a
> specific model of indentation ?
>
> BR,
>>
>> julia
>>
>> On Sat, 22 Sep 2012, Eric Leblond wrote:
>>
>>> Hello,
>>>
>>> I've just wrote a really simple SMPL (attached to the mail). It makes a
>>> modification on the code which is the following:
>>>
>>> - if (x == NULL) S1
>>> + if (unlikely(x == NULL)) S1
>>>
>>> The result is semantically correct but there is spaces at end of line as
>>> shown in the example below:
>>>
>>> @@ -173,8 +173,8 @@ DefragContextNew(void)
>>>     DefragContext *dc;
>>>
>>>     dc = SCCalloc(1, sizeof(*dc));
>>> -    if (dc == NULL)
>>> -        return NULL;<- no space
>>> +    if (unlikely(dc == NULL))
>>> +        return NULL;   <- 4 space here
>>>
>>> I've tried to look at coccinelle code but I'm unable to find a way to a
>>> solution.
>>>
>>> Am I missing an option ?
>>>
>>> BR,
>>> --
>>> Eric Leblond
>>>
>>>
>
>
-------------- next part --------------
diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index a3f9730..3ed2b0b 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -69,6 +69,12 @@ let print_option_prespace fn = function
   | Some x -> pr_space(); fn x in
 let print_between = Common.print_between in
 
+let rec param_print_between between fn = function
+  | [] -> ()
+  | [x] -> fn x
+  | x::xs -> fn x; between x; param_print_between between fn xs in
+
+
 let outdent _ = () (* should go to leftmost col, does nothing now *) in
 
 let pretty_print_c =
@@ -201,20 +207,24 @@ in
 
 (* --------------------------------------------------------------------- *)
 
-let handle_metavar name fn =
+let lookup_metavar name =
   let ((_,b) as s,info,mc,pos) = name in
   let line = info.Ast.line in
   let lcol = info.Ast.column in
-  match Common.optionise (fun () -> List.assoc s env) with
+  let rcol = if lcol = unknown then unknown else lcol + (String.length b) in
+  let res = Common.optionise (fun () -> List.assoc s env) in
+  (res,b,line,lcol,rcol) in
+
+let handle_metavar name fn =
+  let (res,name_string,line,lcol,rcol) = lookup_metavar name in
+  match res with
     None ->
-      let name_string (_,s) = s in
       if generating
-      then
-	mcode (function _ -> print_string (name_string s)) name
+      then mcode (function _ -> print_string name_string) name
       else
 	failwith
 	  (Printf.sprintf "SP line %d: Not found a value in env for: %s"
-	     line (name_string s))
+	     line name_string)
   | Some e  ->
       pr_barrier line lcol;
       (if generating
@@ -222,16 +232,14 @@ let handle_metavar name fn =
 	(* call mcode to preserve the -+ annotation *)
 	mcode (fun _ _ _ -> fn e) name
       else fn e);
-      let rcol =
-	if lcol = unknown then unknown else lcol + (String.length b) in
       pr_barrier line rcol
 in
 (* --------------------------------------------------------------------- *)
 let dots between fn d =
   match Ast.unwrap d with
-    Ast.DOTS(l) -> print_between between fn l
-  | Ast.CIRCLES(l) -> print_between between fn l
-  | Ast.STARS(l) -> print_between between fn l
+    Ast.DOTS(l) -> param_print_between between fn l
+  | Ast.CIRCLES(l) -> param_print_between between fn l
+  | Ast.STARS(l) -> param_print_between between fn l
 in
 
 let nest_dots starter ender fn f d =
@@ -593,18 +601,25 @@ and ty_space ty =
 and ft_space ty =
   match Ast.unwrap ty with
     Ast.Type(_,cv,ty) ->
-      (match Ast.unwrap ty with
-	Ast.Pointer(_,_) -> ()
-      | Ast.MetaType(name,_,_) ->
-	  (match List.assoc (Ast.unwrap_mcode name) env with
-            Ast_c.MetaTypeVal (tq,ty) ->
-	      (match Ast_c.unwrap ty with
-		Ast_c.Pointer(_,_) -> ()
-	      |	_ -> pr_space())
-	  | _ -> pr_space())
-      | _ -> pr_space())
+      let isptr =
+	match Ast.unwrap ty with
+	  Ast.Pointer(_,_) -> true
+	| Ast.MetaType(name,_,_) ->
+	    let (res,name_string,line,lcol,rcol) = lookup_metavar name in
+	    (match res with
+	      None ->
+		failwith
+		  (Printf.sprintf "variable %s not known on SP line %d\n"
+		     name_string line)
+	    | Some (Ast_c.MetaTypeVal (tq,ty)) ->
+		(match Ast_c.unwrap ty with
+		  Ast_c.Pointer(_,_) ->  true
+		| _ -> false)
+	    | _ -> false)
+	| _ -> false in
+      if isptr then () else pr_space()
   | _ -> pr_space()
-
+	
 and declaration d =
   match Ast.unwrap d with
     Ast.MetaDecl(name,_,_) ->
@@ -642,11 +657,11 @@ and declaration d =
       mcode print_string sem
   | Ast.MacroDecl(name,lp,args,rp,sem) ->
       ident name; mcode print_string_box lp;
-      dots (function _ -> ()) expression args;
+      dots (function _ -> ()) arg_expression args;
       close_box(); mcode print_string rp; mcode print_string sem
   | Ast.MacroDeclInit(name,lp,args,rp,eq,ini,sem) ->
       ident name; mcode print_string_box lp;
-      dots (function _ -> ()) expression args;
+      dots (function _ -> ()) arg_expression args;
       close_box(); mcode print_string rp;
       pr_space(); mcode print_string eq;
       pr_space(); initialiser true ini; mcode print_string sem
@@ -826,7 +841,7 @@ and rule_elem arity re =
   | Ast.IteratorHeader(nm,lp,args,rp) ->
       pr_arity arity;
       ident nm; pr_space(); mcode print_string_box lp;
-      dots (function _ -> ()) expression args; close_box();
+      dots (function _ -> ()) arg_expression args; close_box();
       mcode print_string rp
 
   | Ast.SwitchHeader(switch,lp,exp,rp) ->
@@ -914,11 +929,32 @@ and print_fninfo = function
   | Ast.FAttr(attr) -> mcode print_string attr; pr_space() in
 
 let indent_if_needed s f =
-  match Ast.unwrap s with
-    Ast.Seq(lbrace,body,rbrace) -> pr_space(); f()
-  | _ ->
+  let isseq =
+    match Ast.unwrap s with
+      Ast.Seq(lbrace,body,rbrace) -> true
+    | Ast.Atomic s ->
+	(match Ast.unwrap s with
+	| Ast.MetaStmt(name,_,_,_) ->
+	    let (res,name_string,line,lcol,rcol) = lookup_metavar name in
+	    (match res with
+	      None ->
+		failwith
+		  (Printf.sprintf "variable %s not known on SP line %d\n"
+		     name_string line)
+	    | Some (Ast_c.MetaStmtVal stm) ->
+		(match Ast_c.unwrap stm with
+		  Ast_c.Compound _ -> true
+		| _ -> false)
+	    | _ -> failwith "bad metavariable value")
+	| _ -> false)
+    | _ -> false in
+  if isseq
+  then begin pr_space(); f() end
+  else
+    begin
       (*no newline at the end - someone else will do that*)
-      start_block(); f(); unindent true in
+      start_block(); f(); unindent true
+    end in
 
 let rec statement arity s =
   match Ast.unwrap s with
@@ -1107,7 +1143,12 @@ let rec pp_any = function
 
   (* this is not '...', but a list of expr/statement/params, and
      normally there should be no '...' inside them *)
-  | Ast.ExprDotsTag(x) -> dots (function _ -> ()) expression x; false
+  | Ast.ExprDotsTag(x) ->
+      let check_comma cm =
+	match Ast.unwrap cm with
+	  Ast.EComma(cm) -> pr_space()
+	| _ -> () in
+      dots check_comma expression x; false
   | Ast.ParamDotsTag(x) -> parameter_list x; false
   | Ast.StmtDotsTag(x) -> dots force_newline (statement "") x; false
   | Ast.DeclDotsTag(x) -> dots force_newline declaration x; false
