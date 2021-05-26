Return-Path: <SRS0=hedW=KV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F95AC2B9F7
	for <cocci@archiver.kernel.org>; Wed, 26 May 2021 10:53:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD5B613F4
	for <cocci@archiver.kernel.org>; Wed, 26 May 2021 10:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD5B613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14QArAoc006683;
	Wed, 26 May 2021 12:53:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 02C907737;
	Wed, 26 May 2021 12:53:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 838E23E3B
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 12:53:08 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1034])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14QAr5rr002846
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 12:53:06 +0200 (CEST)
Received: by mail-pj1-x1034.google.com with SMTP id
 n6-20020a17090ac686b029015d2f7aeea8so112016pjt.1
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2kMrSjqpnO773vizNjOrs4h03IR4qasA2xhVqDCWrGs=;
 b=D7mzQXC1Pw+AKF/v4dsAtAi1Iq08KGS5aSt5ITQmDUHjIuXcV0oK5nkUujVOQu+5A7
 bApgdcWk018shtU5On2+o0IH0oLY8eS7/HQ9ousatayBs2ylmuQ6A9vrojQtBYFdoL2O
 QwFnbi2mCKpZLWx9KEv2oNKmnmOT69n/mvW+ej8oR/mUUg7Teea25L0AfZyOcIcRXEme
 rSdyNilzersSe50kzbs5PgfmoMUoJE/Imf4GiFgjPM7re3lLDEK12LSVd6TDtsMcQTa4
 8RbabsrHQMewqv1GAPatxUNuA5QQGgap57p1XmgIpPuEL1ySVbRMqwTT2pSGBI4OeL3H
 yvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2kMrSjqpnO773vizNjOrs4h03IR4qasA2xhVqDCWrGs=;
 b=UE3bfZbxCAqpkXYVlQybv8KPa+69X1SQAL3Yaa17DMAyXCFZOgP486lCP3z/a9+W5A
 iF6OOuLh2UN3ohHp29XYuSHbDVslVq4/fmTs080XaQTTroxB99UTFso06Knx8XU3TS8E
 s14CoaJ/9kIuJZ16NzjSfGX/22Ov05n1xAruuTLPfS1ROG7Ckp8CNnl3vMKf34Jv0NSP
 DzMbfOmX/WW7iONzKYFMV5vKRnYaDwE3+h1w1gGMp8mfjCaGi1X1X1oHtVnPoEagsd0z
 4wmGLKI1uadQykds+5kf71KeYv2GQd6fyPsBg0lYFIHs3LB4qWnMch2kdQHO+giAYK3z
 OY+Q==
X-Gm-Message-State: AOAM533Q9eUo+nRuBLg5THOpcCKtdb8409gBdUUBwSOWQ5tKZ58Kd8zu
 AF74c8KGL1axCjh4GYWaMKH0Iy0URAieZw==
X-Google-Smtp-Source: ABdhPJxra96K2+IE2eK4N3OK9wo3Llvwk0kDNu4BNpHIIZZcr/g5C2GJ+QmtukUSmplmOELwe4bK2A==
X-Received: by 2002:a17:902:ce90:b029:f7:72be:b420 with SMTP id
 f16-20020a170902ce90b02900f772beb420mr25631408plg.67.1622026385053; 
 Wed, 26 May 2021 03:53:05 -0700 (PDT)
Received: from adolin ([49.207.210.55])
 by smtp.gmail.com with ESMTPSA id h76sm16919819pfe.161.2021.05.26.03.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 03:53:04 -0700 (PDT)
Date: Wed, 26 May 2021 16:22:37 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: julia.lawall@inria.fr
Message-ID: <9094fbf80de08736f12e8a0306a2c4885db77d50.1622024972.git.sylphrenadin@gmail.com>
References: <cover.1622024972.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1622024972.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 26 May 2021 12:53:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 26 May 2021 12:53:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 1/2] parsing_cocci: Add feature to check only
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

This patch adds an option "use-patchdiff" to allow for
applying a semantic patch to only those files in a directory
where code additions have been made.

Usage: spatch -D <mode> --sp-file <cocci script> --use-patchdiff <target
directory>

Example: spatch -D report --sp-file for_each_child.cocci --use-patchdiff drivers/gpu

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
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
index 9643df782..587071aa8 100644
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
+  "--use-patchdiff",
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
index 3759e7787..41f89ccde 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -1372,6 +1372,7 @@ module Flag :
       | Glimpse
       | CocciGrep
       | GitGrep
+      | PatchDiff
       | NoScanner
     val scanner : scanner ref
     val pyoutput : string ref
diff --git a/parsing_cocci/get_constants2.ml b/parsing_cocci/get_constants2.ml
index 0f18aa037..2a02c2b6c 100644
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
index 000000000..a117349ab
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
2.31.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
