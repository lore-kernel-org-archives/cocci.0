From: chrubis@suse.cz (Cyril Hrubis)
Date: Wed, 1 Oct 2014 15:02:15 +0200
Subject: [Cocci] string parameter concatenation
Message-ID: <20141001130215.GB4701@rei.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
I've found a small nit in the handling of strings that spans over
multiple lines:

nit.c:
int main(void)
{
        f("This is a string that continues to the next line"
          " just string continuation");
}

nit.cocci:
@@
expression list L;
@@
- f(L);
+ g(L);


spatch nit.cocci nit.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: nit.c
diff = 
--- nit.c
+++ /tmp/cocci-output-8374-71ffd9-nit.c
@@ -1,5 +1,4 @@
 int main(void)
 {
-       f("This is a string that continues to the next line"
-         " just string continuation");
+       g("This is a string that continues to the next line"" just string continuation");
 }

While this produces perfectly correct C code it would be nicer if the
strings were merged into one single C string. Othewise this still breaks
what LKML coding style says about being able to grep user-visible
strings in the source code.

-- 
Cyril Hrubis
chrubis at suse.cz
