From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 18 Oct 2014 07:26:53 +0200 (CEST)
Subject: [Cocci] sgen problems
In-Reply-To: <20141017202400.GA2576@katana>
References: <20141017202400.GA2576@katana>
Message-ID: <alpine.DEB.2.02.1410180726100.2049@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 17 Oct 2014, Wolfram Sang wrote:

> Hi,
> 
> so I was trying to convert my spatch from the platform-owner series to a
> Kernel-cocci with sgen. However, that didn't work and produced a corrupt
> cocci file (at least the name of the matching rules has been eaten). I
> used a self-compiled sgen from the Debian rc22. I attach the cocci and
> config file for easier reproducing. Does the sgen author read the list?
> Probably it would be easy to fix the broken file, but it seems more
> sustainable to me to fix the tool :)

Two patches are attached.  Apply p1 and then p2.

-------------- next part --------------
commit 99fba8e0afe74f8f9cc9ecea14efb096469b0b9a
Author: Chi Pham <fempsci@gmail.com>
Date:   Sat Oct 18 01:09:36 2014 +0100

    sgen: Fixed a file transformation bug.
    
    Bug reported by Wolfram Sang regarding faulty rule headers during
    file transformation.
    
    (also in this commit: a tiny eta reduction just because)

diff --git a/tools/sgen/source/context_rule.ml b/tools/sgen/source/context_rule.ml
index 7efff59..37c309e 100644
--- a/tools/sgen/source/context_rule.ml
+++ b/tools/sgen/source/context_rule.ml
@@ -53,7 +53,7 @@ let generate ~new_name ~disj_map ~rule ~context_mode = match rule with
         ("MEGA ERROR: Congratulations! You managed to write a Coccinelle " ^
          "rule that sgen was unable to add a position to! The rule is \"" ^
          nme ^ "\".") in
-      let pos_mv = List.map (fun a -> M.make_metavar ~typ:"position " a) pos in
+      let pos_mv = List.map (M.make_metavar ~typ:"position ") pos in
       let pos_inh = M.inherit_rule cnm pos_mv in
 
       (* check if any extra generated disj rule *)
diff --git a/tools/sgen/source/file_transform.ml b/tools/sgen/source/file_transform.ml
index a54eec7..26aef9f 100644
--- a/tools/sgen/source/file_transform.ml
+++ b/tools/sgen/source/file_transform.ml
@@ -65,7 +65,7 @@ let match_part rulename =
   regex_match ("^@"^spcmnt_re^(escape rulename)^"\\("^spp_re^".*\\)?$")
 let match_end = regex_match ".*@"
 let match_nameless_rule = regex_match "\\(^\\(@@\\)\\|^@.*@$\\)"
-let match_rule_start = regex_match "^@"
+let match_rule_start = regex_match ("^@"^spcmnt_re^"$")
 let match_rule_end = regex_match (spcmnt_re^"@@")
 let match_non_empty = regex_match (spcmnt_re^"[^ \t]")
 
-------------- next part --------------
commit 5c16e565dc2fc98769e4f7f458812a0ead08334a
Author: Chi Pham <fempsci@gmail.com>
Date:   Sat Oct 18 01:20:30 2014 +0100

    sgen: more defensive programming in file transform.
    
    An extension of the bugfix in 99fba8e0afe74f8f9cc9ecea14efb096469b0b9a
    that covers more cases of user antics.

diff --git a/tools/sgen/source/file_transform.ml b/tools/sgen/source/file_transform.ml
index 26aef9f..83466d6 100644
--- a/tools/sgen/source/file_transform.ml
+++ b/tools/sgen/source/file_transform.ml
@@ -65,7 +65,8 @@ let match_part rulename =
   regex_match ("^@"^spcmnt_re^(escape rulename)^"\\("^spp_re^".*\\)?$")
 let match_end = regex_match ".*@"
 let match_nameless_rule = regex_match "\\(^\\(@@\\)\\|^@.*@$\\)"
-let match_rule_start = regex_match ("^@"^spcmnt_re^"$")
+let match_rule_start = regex_match ("^@")
+let match_rule_start_arob = regex_match ("^@"^spcmnt_re^"$")
 let match_rule_end = regex_match (spcmnt_re^"@@")
 let match_non_empty = regex_match (spcmnt_re^"[^ \t]")
 
@@ -110,7 +111,7 @@ let traverse name outch inch =
       (line, inch)
     else if match_part name line then
       find_match nothing match_end inch
-    else if match_rule_start line && not(match_rule_end line) then
+    else if match_rule_start_arob line then
       let (line,inch) = find_match nothing match_non_empty inch in
       if regex_match (sp_re^name) line then
         find_match nothing match_end inch
