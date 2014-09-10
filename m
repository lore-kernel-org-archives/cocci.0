From: rv@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Wed, 10 Sep 2014 17:49:45 +0200
Subject: [Cocci] Problem with "already tagged token"
Message-ID: <87fvfztqzq.fsf@rasmusvillemoes.dk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm trying to write a semantic patch to convert consecutive seq_puts()
calls into a single one, with the string literals concatenated. My
attempt below works fine when there are exactly two seq_puts() calls,
but fails when there are more. If I use coccicheck on a directory,
coccinelle seems to silently skip files containing three-or-more
(e.g. kernel/trace/trace.c), but gives me the "already tagged token"
error when I use it on the specific file.

Ideally, I'd of course like coccinelle to apply the spatch iteratively
until only a single call remains. I think I understand why I get the
error, but I'd like to know if there's some obvious fix I've overlooked.



@concat1 depends on patch@
expression s;
constant c1, c2;
position p1, p2;
@@
  seq_puts at p1(s, c1);
  seq_puts at p2(s, c2);

@script:python concat2@
c1 << concat1.c1;
c2 << concat1.c2;
c3;
@@

// The indentation probably needs to be fixed manually
coccinelle.c3 = c1 + "\n\t" + c2

@concat3 depends on patch@
identifier concat2.c3;
expression concat1.s;
constant concat1.c1, concat1.c2;
position concat1.p1, concat1.p2;
@@
- seq_puts at p1(s, c1);
- seq_puts@p2(s, c2);
+ seq_puts(s, c3);



Thanks,
Rasmus
