Return-Path: <SRS0=jpx+=MF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC46C07E95
	for <cocci@archiver.kernel.org>; Tue, 13 Jul 2021 09:29:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D55960FF2
	for <cocci@archiver.kernel.org>; Tue, 13 Jul 2021 09:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55960FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16D9TUr4001402;
	Tue, 13 Jul 2021 11:29:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C0A4D776E;
	Tue, 13 Jul 2021 11:29:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DF1443F5A
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 11:29:29 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:62d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16D9TRYv013055
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 11:29:28 +0200 (CEST)
Received: by mail-pl1-x62d.google.com with SMTP id j3so8869995plx.7
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=n+dumODucywcvn1HWhWrJ81YTZaduGjGDRcXTgOhs8k=;
 b=EJgVuIB8Hh1ZRJ+huwgyMAqDgdpAcYkw4GKMti/ssJWah7p9O2SDiVQZzve2baoh4P
 axYEOPmWcOpdYps0X1UD4LnSgmMIX5d9UFE7C7vihg2PwIeQUsvoLfJkphTzj/x8MlOY
 8QBk3w71wU8GqOkHn7OODRO9S93x4jc2/PAwNPIMY0yuKq31HJ9TxFrVaEPWr45B/+A7
 Aqi61lACe75LwL87SGcIXHkhgIt0XF4lJv1FVuwQWa9jl8I0Uz+WSxstz2nEZi0CBaDB
 xjG4MwKGqs3CrYBB3bPr3q0myszrTYY+nN6NcU5HWZ9n/cVCjARMibTSAed80e9sljmp
 5Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n+dumODucywcvn1HWhWrJ81YTZaduGjGDRcXTgOhs8k=;
 b=dg/XvBkuaYXdjhCwUEuo1l0X27Zy+XWjBrQi8l9NM7MaAF91qZJwoI4wpZr9rkL+vQ
 FfKAlAgL6+ob3aIOHhHKKAVpzqLft4mWgW7vFQ2a8pRRzpim+yncQzRATszstcooHGZ8
 XboXBnVgzEr1+GMtBQfQSi8NwB6vF8EdFTA45lv1uQ1jicMDBt7f9mnkT0Ygj4UzOmAe
 7Ow3DuZ726X+uAwPrHSIee3qQ8w6gRNDEelpJXPjFRTyeR3aZu6VNugKY5l1JcN2Alij
 XIYkPzXqRJEeudkOSKChyYIcOfcjnPVsr4t4et5o9+OOmVssU1drp0/UQy1ENHwUG0zP
 STjw==
X-Gm-Message-State: AOAM5334uts6MeckiID+gNPw5lqCqpFu4Y/ITxaaG0V1Vh17FhPu1Wdj
 ejk/LL8+NhuDaXhLHdwPg9eFsRCD6rk=
X-Google-Smtp-Source: ABdhPJz2XV7dIPjHGwLsVG/q+lqjJV2irXcFeR+0wAsQ55vMDuRf6rPAqjRm70ZuKCNNkMPi9JPZbw==
X-Received: by 2002:a17:90b:1482:: with SMTP id
 js2mr18454420pjb.85.1626168566458; 
 Tue, 13 Jul 2021 02:29:26 -0700 (PDT)
Received: from adolin ([49.207.196.203])
 by smtp.gmail.com with ESMTPSA id g18sm18671953pfi.199.2021.07.13.02.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 02:29:26 -0700 (PDT)
Date: Tue, 13 Jul 2021 14:58:27 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: julia.lawall@inria.fr
Message-ID: <6ce417caf6542df07ebc428f602cbbadc5d0342c.1626167690.git.sylphrenadin@gmail.com>
References: <cover.1626167690.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1626167690.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Jul 2021 11:29:30 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 13 Jul 2021 11:29:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH V2 1/2] parsing_cocci: Add feature to check only
 modified files
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This patch adds an option "use-patch-diff" to allow for
applying a semantic patch to only those files in a directory
where code additions have been made.

Usage: spatch -D <mode> --sp-file <cocci script> --use-patch-diff <target
directory>

Example: spatch -D report --sp-file for_each_child.cocci --use-patch-diff drivers/gpu

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V2:
- Change "use-patchdiff" to "use-patch-diff" (Julia)
---
 Makefile                        |   2 +-
 enter.ml                        |  17 +++--
 globals/flag.ml                 |   2 +-
 globals/flag.mli                |   2 +-
 ocaml/coccilib.mli              |   1 +
 parsing_cocci/get_constants2.ml |   1 +
 parsing_cocci/patch_diff.ml     | 118 ++++++++++++++++++++++++++++++++
 parsing_cocci/patch_diff.mli    |   9 +++
 8 files changed, 143 insertions(+), 9 deletions(-)
 create mode 100755 parsing_cocci/patch_diff.ml
 create mode 100644 parsing_cocci/patch_diff.mli

diff --git a/Makefile b/Makefile
index f8d3424c0..455e92395 100644
--- a/Makefile
+++ b/Makefile
@@ -44,7 +44,7 @@ SOURCES_parsing_cocci := \
 	parse_printf.ml parse_aux.ml cleanup_rules.ml disjdistr.ml \
 	parser_cocci_menhir.mly lexer_cocci.mll \
 	lexer_cli.mll lexer_script.mll \
-	cocci_grep.ml dpll.ml get_constants2.ml id_utils.ml git_grep.ml \
+	cocci_grep.ml dpll.ml get_constants2.ml id_utils.ml git_grep.ml patch_diff.ml \
 	adjacency.ml commas_on_lists.ml re_constraints.ml parse_cocci.ml \
 	command_line.ml cocci_args.ml
 SOURCES_parsing_c := \
diff --git a/enter.ml b/enter.ml
index 77e1540fd..1219c027d 100644
--- a/enter.ml
+++ b/enter.ml
@@ -18,9 +18,7 @@ module Inc = Includes
  * globals/config.ml, mainly a standard.h and standard.iso file *)
 
 let cocci_file = ref ""
-
 let opt_c_files = ref []
-
 let output_file = ref "" (* resulting code *)
 let tmp_dir = ref "" (* temporary files for parallelism *)
 let aux_file_suffix =
@@ -283,7 +281,6 @@ let print_version () =
 let short_options = [
   "--sp-file",  Arg.Set_string cocci_file,
   " <file> the semantic patch file";
-
   "--opt-c",
   Arg.String (fun filename ->
     if Sys.file_exists filename
@@ -370,6 +367,9 @@ let short_options = [
   "--use-coccigrep",
   Arg.Unit (function _ -> Flag.scanner := Flag.CocciGrep),
   "    find relevant files using cocci grep";
+  "--use-patch-diff",
+  Arg.Unit (function _ -> Flag.scanner := Flag.PatchDiff),
+  "    process files in the diff for a directory";
   "--patch",
     Arg.String (function s -> Flag.patch := Some (Cocci.normalize_path s)),
   ("    <dir> path name with respect to which a patch should be created\n"^
@@ -940,13 +940,18 @@ let idutils_filter (_,_,_,query) dir =
       Some
 	(files +>
 	 List.filter
-	   (fun file -> List.mem (Common.filesuffix file) suffixes))
+     (fun file -> List.mem (Common.filesuffix file) suffixes))
+
+let patchdiff_filter _ dir =
+  let struc = Patch_diff.getpatchdiff dir in
+  Some (List.map (function x -> x.Patch_diff.file_name) struc)
 
 let scanner_to_interpreter = function
     Flag.Glimpse -> glimpse_filter
   | Flag.IdUtils -> idutils_filter
   | Flag.CocciGrep -> coccigrep_filter
   | Flag.GitGrep -> gitgrep_filter
+  | Flag.PatchDiff -> patchdiff_filter
   | _ -> failwith "impossible"
 
 (*****************************************************************************)
@@ -1079,7 +1084,7 @@ let rec main_action xs =
 		     " or multiple files")
               | _, false, _, _, _ -> [List.map (fun x -> (x,None)) (x::xs)]
 	      |	_, true, "",
-		  (Flag.Glimpse|Flag.IdUtils|Flag.CocciGrep|Flag.GitGrep),
+		  (Flag.Glimpse|Flag.IdUtils|Flag.CocciGrep|Flag.GitGrep|Flag.PatchDiff),
 		  [] ->
 		    let interpreter = scanner_to_interpreter !Flag.scanner in
 		    let files =
@@ -1088,7 +1093,7 @@ let rec main_action xs =
 		      | Some files -> files in
                     files +> List.map (fun x -> [(x,None)])
               | _, true, s,
-		  (Flag.Glimpse|Flag.IdUtils|Flag.CocciGrep|Flag.GitGrep), _
+		  (Flag.Glimpse|Flag.IdUtils|Flag.CocciGrep|Flag.GitGrep|Flag.PatchDiff), _
 		when s <> "" ->
                   failwith "--use-xxx filters do not work with --kbuild"
                   (* normal *)
diff --git a/globals/flag.ml b/globals/flag.ml
index e1d01cb4c..dffe6cd80 100644
--- a/globals/flag.ml
+++ b/globals/flag.ml
@@ -16,7 +16,7 @@ let track_iso_usage = ref false
 
 let worth_trying_opt = ref true
 
-type scanner = IdUtils | Glimpse | CocciGrep | GitGrep | NoScanner
+type scanner = IdUtils | Glimpse | CocciGrep | GitGrep | PatchDiff | NoScanner
 let scanner = ref NoScanner
 
 let pyoutput = ref "coccilib.output.Console"
diff --git a/globals/flag.mli b/globals/flag.mli
index dadc7b6fc..0e8a3b063 100644
--- a/globals/flag.mli
+++ b/globals/flag.mli
@@ -4,7 +4,7 @@ val show_transinfo : bool ref
 val show_trying : bool ref
 val track_iso_usage : bool ref
 val worth_trying_opt : bool ref
-type scanner = IdUtils | Glimpse | CocciGrep | GitGrep | NoScanner
+type scanner = IdUtils | Glimpse | CocciGrep | GitGrep | PatchDiff | NoScanner
 val scanner : scanner ref
 val pyoutput : string ref
 val ocamlc : string ref
diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index c0f844ea5..1f1714cb5 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -1377,6 +1377,7 @@ module Flag :
       | Glimpse
       | CocciGrep
       | GitGrep
+      | PatchDiff
       | NoScanner
     val scanner : scanner ref
     val pyoutput : string ref
diff --git a/parsing_cocci/get_constants2.ml b/parsing_cocci/get_constants2.ml
index bc99aa231..a0daeb902 100644
--- a/parsing_cocci/get_constants2.ml
+++ b/parsing_cocci/get_constants2.ml
@@ -866,5 +866,6 @@ let get_constants rules neg_pos_vars virt =
     | Flag.IdUtils ->
 	(grep,None,coccigrep,interpret_idutils res)
     | Flag.CocciGrep | Flag.GitGrep -> (grep,None,coccigrep,None)
+    | Flag.PatchDiff -> (None, None, None, None)
     end
   else (None,None,None,None)
diff --git a/parsing_cocci/patch_diff.ml b/parsing_cocci/patch_diff.ml
new file mode 100755
index 000000000..52a04db68
--- /dev/null
+++ b/parsing_cocci/patch_diff.ml
@@ -0,0 +1,118 @@
+open Printf
+open Str
+
+(*Read file contents*)
+let read_whole_file filename =
+  let ch = open_in filename in
+  let s = really_input_string ch (in_channel_length ch) in
+  close_in ch;
+  s
+
+(*Breakdown split_result_list type to primtive type*)
+let rec decompose_list (l: Str.split_result list)  =
+  match l with
+  | [] -> []
+  | Text hd :: tl ->  decompose_list tl
+  | Delim hd :: tl -> hd ::  decompose_list tl
+;;
+
+(*Fetch output for bash commands*)
+let read_bash_help command =
+  let ic = Unix.open_process_in command in
+  let all_input = ref [] in
+  try
+    while true do
+      all_input := input_line ic :: !all_input
+    done;
+    !all_input
+  with
+    End_of_file -> close_in ic;
+    List.rev !all_input;;
+
+let get_root fpath =
+  let current_dir = List.hd (read_bash_help "pwd") in
+  let command_get_root = "cd " ^ fpath ^ " && git rev-parse --show-toplevel" in
+  let root = List.hd (read_bash_help command_get_root) in
+  let command_return = "cd " ^ current_dir in
+  let ic = Unix.open_process_in command_return in
+  close_in ic;
+  root
+
+  let extract_numbers line =
+  let sep = String.split_on_char ',' line in
+  match sep with
+  | [l] -> (int_of_string l, int_of_string l)
+  | [f ; e] -> (int_of_string f, int_of_string e)
+  | _ -> failwith "no line numbers found, sorry"
+;;
+
+let fetch_file_name line =
+  let pat_filename = Str.regexp "\\(+++ b\\)/\\(.+\\)\\.[a-z]+" in
+  let s = Str.full_split pat_filename line in
+  decompose_list s
+;;
+
+let fetch_line_number line  =
+  let pat_line_num = Str.regexp "\\(\\+\\([0-9]+,[0-9]+\\)\\)" in
+  let s = Str.full_split pat_line_num line in
+  let fa = List.hd (decompose_list s) in
+  let (b, e) = extract_numbers fa in
+  (b, (b + e)) (*start of diff, end of diff *)
+;;
+
+type diff_info =
+{
+    file_name: string;
+    line_no: (int * int) list;
+}
+
+type patch_info = No_info | File_info of string list | Line_info of (int * int)
+
+(*check line and extract file name or file number*)
+let extract_info line =
+  if Str.string_match (Str.regexp_string "+++") line 0 then
+    File_info (fetch_file_name line)
+  else if Str.string_match (Str.regexp_string "@@ ") line 0 then
+    Line_info (fetch_line_number line)
+  else
+    No_info
+
+let rec reorg_helper new_list = function
+[] -> (List.rev new_list, [])
+| No_info :: tl -> reorg_helper new_list tl
+| File_info file_list :: tl -> (List.rev new_list, File_info file_list :: tl)
+| Line_info line_list :: tl ->  reorg_helper (line_list :: new_list) tl
+;;
+
+let rec reorg fpath toproot = function
+[] -> []
+| No_info :: tl -> reorg fpath toproot tl
+| File_info [file] :: tl ->
+  let lines, rest = reorg_helper [] tl in
+  {
+    file_name = Str.replace_first (Str.regexp "+++ b") toproot file;
+    line_no = lines;
+  } :: reorg fpath toproot rest
+| File_info file_list :: tl ->
+    let lines, rest = reorg_helper [] tl in
+    reorg fpath toproot rest
+| Line_info line_list :: tl ->  failwith "bad case"
+
+let rec mlines lines =
+  match lines with
+  | [] -> []
+  | hd :: tl -> extract_info hd :: mlines tl
+
+let final_info dir =
+  let git_root = get_root dir in
+  let git_read_command = "cd " ^ git_root ^ " && git diff " ^ dir ^ " | egrep '^+++|^@'" in
+  let list_diff = reorg dir git_root (mlines (read_bash_help git_read_command)) in
+  list_diff;;
+
+let rec print_tuple_list l =
+  match l with
+  | [] -> ()
+  | (a,b) :: tl -> printf "\n%d, %d" a b; print_tuple_list tl
+
+let getpatchdiff dir = final_info dir
+
diff --git a/parsing_cocci/patch_diff.mli b/parsing_cocci/patch_diff.mli
new file mode 100644
index 000000000..b059509ef
--- /dev/null
+++ b/parsing_cocci/patch_diff.mli
@@ -0,0 +1,9 @@
+
+
+type diff_info =
+{
+    file_name: string;
+    line_no: (int * int) list;
+}
+
+val getpatchdiff : string -> diff_info list
-- 
2.32.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
