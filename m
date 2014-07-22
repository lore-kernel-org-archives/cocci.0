From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Jul 2014 14:55:57 +0200 (CEST)
Subject: [Cocci] [bug-cocci] "badly compiled mcode" error
In-Reply-To: <20140721184219.GA7903@rlp>
References: <20140721184219.GA7903@rlp>
Message-ID: <alpine.DEB.2.10.1407221455390.2366@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A patch is below.

julia

diff --git a/parsing_cocci/iso_compile.ml b/parsing_cocci/iso_compile.ml
index 5e39b9c..7921f44 100644
--- a/parsing_cocci/iso_compile.ml
+++ b/parsing_cocci/iso_compile.ml
@@ -52,7 +52,7 @@ let process_info l =
 	 let safe_add p pos =
 	   (* don't add pos var where a pos var is already present *)
 	   if Common.inter_set previously_used pos = [] then p::pos else pos in
-	 let p =
+	 let new_previously_used =
 	   if List.for_all (List.for_all (function e -> List.length e = 1)) a
 	   then
 	     let p = get_p() in
@@ -60,22 +60,23 @@ let process_info l =
 	       (List.iter
 		  (List.iter (function (_,pos) -> pos := safe_add p !pos)))
 	       a;
-	     [p]
+	     p::previously_used
 	   else
 	     let all = r @ List.concat xs in
-	     let rec find_first_available a = function
+	     let rec find_first_available a previously_used = function
 		 [] -> raise Not_found
 	       | (str,pos)::xs ->
 		   if str = a && Common.inter_set previously_used !pos = []
 		   then pos
-		   else find_first_available a xs in
+		   else find_first_available a previously_used xs in
 	     List.fold_left
 	       (function prev ->
 		 function (str,pos) ->
 		   if Common.inter_set previously_used !pos = []
 		   then
 		     try
-		       let entries = List.map (find_first_available str) all in
+		       let entries =
+			 List.map (find_first_available str prev) all in
 		       let p = get_p() in
 		       pos := p::!pos;
 		       List.iter (function pos -> pos := p :: !pos) entries;
@@ -83,8 +84,8 @@ let process_info l =
 		     with Not_found -> prev
 		   (* otherwise already annotated *)
 		   else prev)
-	       [] f in
-	 loop (p at previously_used) xs
+	       previously_used f in
+	 loop new_previously_used xs
      | _ -> failwith "bad iso" in
    loop l
