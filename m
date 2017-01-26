From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 26 Jan 2017 13:28:11 +0100
Subject: [Cocci] modifying initializers with spatch?
Message-ID: <1485433691.14760.1.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I've been playing with C99 initializers a bit, what I'm trying to do is
replace them with explicit memset()/assignments.

This works as expected:

@@
identifier x;
type t;
@@
?t x =
-{0};
+{};


This actually removes the braces, but not only if they're empty, and it
leaves the inner content there without braces, which won't even compile
afterwards:

@@
identifier x;
type t;
@@
?t x
- ={}
?;

e.g.:

-	const u8 q[] = { 1, (const u8) '*', 0 };
+	const u8 q[] 1, (const u8) '*', 0;


I've also not managed to add any memset(&x, 0, sizeof(x)); in the same
patch, especially since it should go after all other declarations.

Do you think this is possible at all?

johannes
