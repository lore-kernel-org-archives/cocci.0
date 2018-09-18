From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 18 Sep 2018 11:20:33 +0200
Subject: [Cocci] moving const instead of not matching?
Message-ID: <1537262433.2957.18.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I was trying to do something like this:

@@
typedef u8;
expression D, T, S2;
@@
(
 memcpy(
-(u8 *)(D)
+D
 ,
-(u8 *)(T)
+T
 , S2)
|
 memcpy(
-(u8 *)(D)
+D
 ,
-(T)
+T
 , S2)
|
 memcpy(
-(D)
+D
 ,
-(u8 *)(T)
+T
 , S2)
)


but then I ran across a place that had a const, and the result was
rather unexpected:

$ spatch --sp-file /tmp/test3.spatch /tmp/test.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: /tmp/test.c
diff = 
--- /tmp/test.c
+++ /tmp/cocci-output-8879-8411db-test.c
@@ -1,4 +1,4 @@
 int main()
 {
-	memcpy(dst, (const u8 *)src, sz);
+	memcpy(dst, src const, sz);
 }


Why is the const being moved there, rather than not matching?

spatch version 1.0.6.

johannes
