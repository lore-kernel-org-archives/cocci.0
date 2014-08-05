From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Aug 2014 13:59:38 +0200 (CEST)
Subject: [Cocci] unreadable files
In-Reply-To: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
References: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1408051359090.2333@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Could you try the following patch?

julia

diff --git a/commons/common.ml b/commons/common.ml
index 9914c44..a8ee414 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -3505,6 +3505,19 @@ let (with_open_infile: filename -> ((in_channel) -> 'a) -> 'a) = fun file f ->
     res)
     (fun e -> close_in chan)

+let (safe_with_open_infile: 'a -> filename -> ((in_channel) -> 'a) -> 'a) =
+  fun default file f ->
+  let chan = try Some (open_in file) with _ -> None in
+  match chan with
+    Some chan ->
+      unwind_protect (fun () ->
+	let res = f chan in
+	close_in chan;
+	res)
+	(fun e -> close_in chan)
+  | None ->
+      pr2 ("Failed to open "^file);
+      default

 let (with_open_outfile_append: filename -> (((string -> unit) * out_channel) -> 'a) -> 'a) =
  fun file f ->
diff --git a/commons/common.mli b/commons/common.mli
index f20d66f..2cef883 100644
--- a/commons/common.mli
+++ b/commons/common.mli
@@ -1128,6 +1128,8 @@ val with_open_outfile :
   filename -> ((string -> unit) * out_channel -> 'a) -> 'a
 val with_open_infile :
   filename -> (in_channel -> 'a) -> 'a
+val safe_with_open_infile :
+  'a -> filename -> (in_channel -> 'a) -> 'a
 val with_open_outfile_append :
   filename -> ((string -> unit) * out_channel -> 'a) -> 'a

diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
index aabd57c..e322f3a 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -242,7 +242,7 @@ let print_commentized xs =
 let tokens2 file =
  let table     = Common.full_charpos_to_pos_large file in

- Common.with_open_infile file (fun chan ->
+ Common.safe_with_open_infile [] file (fun chan ->
   let lexbuf = Lexing.from_channel chan in
   try
     let rec tokens_aux acc =
