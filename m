From: mstefani@redhat.com (Michael Stefaniuc)
Date: Tue, 14 Jun 2016 15:31:03 +0200
Subject: [Cocci] Wrong Matching Order for Alternations
Message-ID: <dd5e95c6-a5fc-8c93-3f2d-bff982184b33@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm getting the wrong patch generated when using the below alternation:

@@
typedef RECT;
RECT *r1;
RECT *r2;
expression size;
@@
(
- !memcmp
+ EqualRect
|
- memcmp
+ !EqualRect
)
            ( r1, r2,
-                     size
            )


On this code:
BOOL foo(RECT *r1, RECT *r2)
{
    return !memcmp(r1, r2, sizeof(*r1));
}

Will generate the wrong diff:
-    return !memcmp(r1, r2, sizeof(*r1));
+    return !!EqualRect(r1, r2);


--parse-cocci seems to show the correct pattern:
(
-!
  >>> EqualRect
-memcmp(r1, r2, -size)
|
-memcmp
  >>> !EqualRect
(r1, r2, -size)
)


If I remove the memcmp ==> !EqualRect alternative I get the correct
patch generated:
-    return !memcmp(r1, r2, sizeof(*r1));
+    return EqualRect(r1, r2);


I know how to workaround it but I thought I'll mention it here. I am
still on 1.0.4 but I don't remember to have seen anything in the 1.0.5
release notes that would fix it.

bye
	michael
