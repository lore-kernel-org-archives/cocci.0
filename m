From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Aug 2014 15:00:23 +0200 (CEST)
Subject: [Cocci] unreadable files
In-Reply-To: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
References: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1408051500090.2333@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A better patch is below.

julia

diff --git a/cocci.ml b/cocci.ml
index e67f5ba..5fc6ed0 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -516,7 +516,13 @@ let worth_trying2 cfiles (tokens,_,query,_) =
   res

 let worth_trying a b  =
-  Common.profile_code "worth_trying" (fun () -> worth_trying2 a b)
+  Common.profile_code "worth_trying" (fun () ->
+    try worth_trying2 a b
+    with Flag.UnreadableFile file ->
+      begin
+	pr2 ("Skipping unreadable file: " ^ file);
+	false
+      end)

 let check_macro_in_sp_and_adjust = function
     None -> ()
@@ -1134,14 +1140,23 @@ let fixpath s =

 let rec prepare_h seen env (hpath : string) choose_includes parse_strings
     : file_info list =
-  if not (Common.lfile_exists hpath)
-  then
-    begin
-      pr2_once ("TYPE: header " ^ hpath ^ " not found");
-      []
-    end
-  else
-    begin
+  let h_cs =
+    if not (Common.lfile_exists hpath)
+    then
+      begin
+	pr2_once ("TYPE: header " ^ hpath ^ " not found");
+        None
+      end
+    else
+      try Some (cprogram_of_file_cached parse_strings hpath)
+      with Flag.UnreadableFile file ->
+	begin
+	  pr2_once ("TYPE: header " ^ hpath ^ " not readable");
+	  None
+	end in
+  match h_cs with
+    None -> []
+  | Some h_cs ->
       let h_cs = cprogram_of_file_cached parse_strings hpath in
       let local_includes =
 	if choose_includes =*= Flag_cocci.I_REALLY_ALL_INCLUDES
@@ -1171,11 +1186,20 @@ let rec prepare_h seen env (hpath : string) choose_includes parse_strings
 	fpath = hpath;
 	fkind = Header;
       }]
-    end

 let prepare_c files choose_includes parse_strings : file_info list =
-  let cprograms = List.map (cprogram_of_file_cached parse_strings) files in
-  let includes = includes_to_parse (zip files cprograms) choose_includes in
+  let files_and_cprograms =
+    List.rev
+      (List.fold_left
+	 (function prev ->
+	   function file ->
+	     try (file,cprogram_of_file_cached parse_strings file) :: prev
+	     with Flag.UnreadableFile file ->
+	       pr2_once ("C file " ^ file ^ " not readable");
+	       prev)
+	 [] files) in
+  let (files,cprograms) = List.split files_and_cprograms in
+  let includes = includes_to_parse files_and_cprograms choose_includes in
   let seen = ref includes in

   (* todo?: may not be good to first have all the headers and then all the c *)
diff --git a/globals/flag.ml b/globals/flag.ml
index e77c599..d04ea86 100644
--- a/globals/flag.ml
+++ b/globals/flag.ml
@@ -44,3 +44,5 @@ let ibm = ref false

 (* was in main *)
 let include_headers = ref false
+
+exception UnreadableFile of string
diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
index aabd57c..972579b 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -888,7 +888,8 @@ let with_program2_unit f program2 =
 let parse_print_error_heuristic2 saved_typedefs saved_macros parse_strings
     file =

-  let filelines = Common.cat_array file in
+  let filelines =
+    try Common.cat_array file with _ -> raise (Flag.UnreadableFile file) in
   let stat = Parsing_stat.default_stat file in

   (* -------------------------------------------------- *)
diff --git a/parsing_cocci/cocci_grep.ml b/parsing_cocci/cocci_grep.ml
index 1b9e087..2e0ef00 100644
--- a/parsing_cocci/cocci_grep.ml
+++ b/parsing_cocci/cocci_grep.ml
@@ -6,7 +6,7 @@ let interpret_clause re l =
   with Not_found -> false

 let interpret (big_regexp,regexps) file =
-  let i = open_in file in
+  let i = try open_in file with _ -> raise (Flag.UnreadableFile file) in
   let simple = match regexps with [_] -> true | _ -> false in
   let rec loop big_regexp simple regexps =
     let l = input_line i in
