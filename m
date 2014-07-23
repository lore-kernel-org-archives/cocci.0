From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Jul 2014 22:58:34 +0200 (CEST)
Subject: [Cocci] patch for string matching problem
Message-ID: <alpine.DEB.2.02.1407232257500.2014@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

diff --git a/parsing_c/parse_string_c.ml b/parsing_c/parse_string_c.ml
index da6c91a..aa54c74 100644
--- a/parsing_c/parse_string_c.ml
+++ b/parsing_c/parse_string_c.ml
@@ -82,7 +82,7 @@ let parse_middle middle info offset =
       let (first,offset) =
         if fst = ""
         then ([],offset)
-        else ([(string_to_frag fst info 0)],offset + String.length fst) in
+        else ([(string_to_frag fst info offset)],offset + String.length fst) in
       let (rest,_) =
         List.fold_left
           (function (prev,offset) ->
@@ -96,8 +96,10 @@ let parse_middle middle info offset =
               let first = [mkfmt c1 offset;pct] in
               if rest = ""
               then (first at prev,after_offset)
-              else ((string_to_frag rest info offset)::first at prev,
-		    after_offset))
+              else
+		let rest_offset = offset + String.length c1 in
+		((string_to_frag rest info rest_offset)::first at prev,
+		 after_offset))
           (first,offset) rest in
       rest
 
@@ -110,7 +112,7 @@ let parse_string (str,isW) info =
       begin
 	let first = update_info "\"" 0 info Before (make_quote str isW) in
 	let last =
-	  update_info "\"" (String.length str - 1) info After
+	  update_info "\"" (String.length str+1) info After
 	    (make_quote str isW) in
 	let middle = parse_middle str info 1 in
 	List.rev (last :: middle @ [first])
