From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 11 Apr 2014 15:46:21 -0700
Subject: [Cocci] [RFC] fix compilation error on
	ocaml/no_prepare_ocamlcocci.ml
Message-ID: <20140411224621.GA23218@garbanzo.do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Using debian testing with the latest version of ocaml I ran into a
compilation error with the gforge version of Coccinelle. This fixes it
and lets me use coccinelle but its unclear if its correct.

diff --git a/ocaml/no_prepare_ocamlcocci.ml b/ocaml/no_prepare_ocamlcocci.ml
index 772528b..5d94b3c 100644
--- a/ocaml/no_prepare_ocamlcocci.ml
+++ b/ocaml/no_prepare_ocamlcocci.ml
@@ -9,9 +9,9 @@ let prepare coccifile code =
 	function
 	    Ast_cocci.ScriptRule (name,"ocaml",deps,mv,script_vars,code) ->
 	      code :: prev
-	  | Ast_cocci.InitialScriptRule (name,"ocaml",deps,code) ->
+	  | Ast_cocci.InitialScriptRule (name,"ocaml",deps,mv,code) ->
 	      code :: prev
-	  | Ast_cocci.FinalScriptRule (name,"ocaml",deps,code) ->
+	  | Ast_cocci.FinalScriptRule (name,"ocaml",deps,mv,code) ->
 	      code :: prev
 	  | _ -> prev)
       [] code in
