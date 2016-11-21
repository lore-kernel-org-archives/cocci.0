From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 21 Nov 2016 15:40:29 -0800
Subject: [Cocci] semantic patch to replace 'ASSERT'
Message-ID: <20161121234029.wper5znya2zjm2xd@xsjsorenbubuntu.xilinx.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am working with a code base that defines a custom macro 'ASSERT' that
compared to the usual c 'assert' interprets the condition the other way
around. Hence, I wanted to "fix" this and get the definition of ASSERT
in line with assert.h and came up with:

/* Invert condition in ASSERT */
@ rule1 @
expression E;
@@
 	ASSERT (
-	E
+	!(E)
	, ...)

But that didn't seem to work, though, some experiments with slight
variations do. Eventually, I ended up 'git grepping' the coccinelle
sources and found some code that seems to introduce special handling for
some macros/identifiers. I changed coccinelle like this:
diff --git a/standard.h b/standard.h
index 612cd54bc9d6..c9190222d3bf 100644
--- a/standard.h
+++ b/standard.h
@@ -635,7 +635,6 @@ do {                                                                        \
 
 
 
-#define ASSERT(x) MACROSTATEMENT
 #define IRDA_ASSERT(x) MACROSTATEMENT
 
 #define CHECK_NULL(x) MACROSTATEMENT

and my patch started to work. I have no idea what other side effects that
change might have, but overall, I kind of find the behavior that breaks
on certain identifiers rather wrong.

	S?ren
