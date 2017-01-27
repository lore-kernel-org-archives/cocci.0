From: johannes@sipsolutions.net (Johannes Berg)
Date: Sat, 28 Jan 2017 00:10:06 +0100
Subject: [Cocci] position confusion?
Message-ID: <1485558606.14579.15.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This is nonsense, but I don't see why it shouldn't parse:

@a@
type T;
identifier x;
position p;
@@
T x at p = { };

@b@
type T;
identifier x;
position p;
@@
T x at p = { };

@@
position p != a.p;
position q != b.p;
type T;
identifier x;
@@
*T x at q = {};

->
148 149
Fatal error: exception Failure("meta: parse error: \n = File \"/tmp/test.spatch\", line 17, column 16,??charpos = 148\n????around = 'p', whole content = position q != b.p;\n")


if I replace 'p' by 'q' in @b@, it works fine?

johannes
