From: chrubis@suse.cz (chrubis at suse.cz)
Date: Tue, 23 Sep 2014 15:26:20 +0200
Subject: [Cocci] wrong indentation
Message-ID: <20140923132620.GA32618@rei.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
I've found that spatch fails to detect correct indentation when it
replaces two functions inside of #ifdef block with one function.

bug.c:

int main(void)
{
#if ! HAVE_XYZ
        f1();
        f2();
#endif
}

bug.cocci:

@@ @@
- f1();
- f2();
+ f3();

result:

init_defs_builtins: /usr/lib64/ocaml/coccinelle/standard.h
HANDLING: d.c
diff = 
--- d.c
+++ /tmp/cocci-output-32687-903dcc-d.c
@@ -1,7 +1,6 @@
 int main(void)
 {
 #if ! HAVE_XYZ
-       f1();
-       f2();
+f3();
 #endif
 }

spatch --version
spatch version 1.0.0-rc19 with Python support and with PCRE support

-- 
Cyril Hrubis
chrubis at suse.cz
