From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 1 Jun 2018 13:13:18 +0200
Subject: [Cocci] Evolution around profiling of SmPL script execution
In-Reply-To: <595d32bf-e506-614a-f1d1-3295a0322647@users.sourceforge.net>
References: <595d32bf-e506-614a-f1d1-3295a0322647@users.sourceforge.net>
Message-ID: <9cb37b5c-bc0b-de6a-7495-95de0971aa6f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>    How should the execution of each SmPL rule be identified there?

Can the following source code adjustment help a bit besides the general possibility
to clarify additional data export formats?

diff --git a/cocci.ml b/cocci.ml
index 64503ee9..43cfc996 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -1563,7 +1563,7 @@ let printtime str = Printf.printf "%s: %f\n" str (Unix.gettimeofday ())
 
 let rec apply_cocci_rule r rules_that_have_ever_matched parse_strings es
     (ccs:file_info list ref) =
-  Common.profile_code r.rule_info.rulename (fun () ->
+  Common.profile_code ("Rule " ^ r.rule_info.rulename) (fun () ->
     show_or_not_rule_name r.ast_rule r.rule_info.ruleid;
     show_or_not_ctl_text r.ctl r.metavars r.ast_rule r.rule_info.ruleid;
 

Regards,
Markus
