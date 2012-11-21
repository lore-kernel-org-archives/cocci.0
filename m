From: maxclausen@gmail.com (Christian Clausen)
Date: Wed, 21 Nov 2012 11:51:25 +0100
Subject: [Cocci] C++ namespace in cocci files
In-Reply-To: <50AA6091.8010702@gmail.com>
References: <50AA6091.8010702@gmail.com>
Message-ID: <50ACB22D.3030201@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Here is the same update, as I posted a couple of days ago, but in form 
of a patch.
This update adds support for c++ namespace syntax in cocci files.

On 19-11-2012 17:38, Christian Clausen wrote:
> Hi,
>
> Here is an update -- to the file parsing_cocci/lexer_cocci.mll -- 
> which adds support for c++ namespace syntax in cocci files.
>

-------------- next part --------------
diff --git a/parsing_cocci/lexer_cocci.mll b/parsing_cocci/lexer_cocci.mll
index 8a254e7..ec91a89 100755
--- a/parsing_cocci/lexer_cocci.mll
+++ b/parsing_cocci/lexer_cocci.mll
@@ -827,6 +827,57 @@ rule token = parse
   | letter (letter | digit)*
       { start_line true; id_tokens lexbuf }
 
+  | (letter | '$') (letter | digit | '$') *
+      { start_line true; id_tokens lexbuf }
+
+  | (letter | '$') (letter | digit | '$') *
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>') ?
+    ("::~" (letter | '$') (letter | digit | '$') *
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>') ?) +
+
+      { 
+	start_line true; 
+	if not !Flag.c_plus_plus
+	then Common.pr2_once "< and > not allowed in C identifiers, try -c++ option";
+	id_tokens lexbuf 
+      }
+  | ((letter | '$') (letter | digit | '$') * )
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>')
+
+      { 
+	start_line true; 
+	if not !Flag.c_plus_plus
+	then Common.pr2_once "< and > not allowed in C identifiers, try -c++ option";
+	id_tokens lexbuf 
+      }
+
+  | (((letter | '$') (letter | digit | '$') * ))
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>') ?
+    "::" (((letter | '$') (letter | digit | '$') * ))
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>') ?
+    ("::" ((letter | '$') (letter | digit | '$') * )
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>') ?) *
+
+      { 
+	start_line true; 
+	if not !Flag.c_plus_plus
+	then Common.pr2_once "~ and :: not allowed in C identifiers, try -c++ option";
+	id_tokens lexbuf 
+      }
+
+   | "::" ((letter | '$') (letter | digit | '$') * )
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>') ?
+    ("::" ((letter | '$') (letter | digit | '$') * )
+      ('<' (letter | '$' | '~') (letter | digit | '$' | '~') * '>') ?) *
+      { 
+	start_line true; 
+	if not !Flag.c_plus_plus
+	then Common.pr2_once "~ and :: not allowed in C identifiers, try -c++ option";
+	id_tokens lexbuf 
+      }
+       (* christia: end *)
+
+
   | "'" { start_line true;
 	  TChar(char lexbuf,get_current_line_type lexbuf) }
   | '"' { start_line true;
