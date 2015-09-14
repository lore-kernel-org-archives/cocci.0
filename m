From: mq+coccinelle@ucw.cz (Jan Moskyto Matejka)
Date: Mon, 14 Sep 2015 10:29:05 +0200
Subject: [Cocci] Find expressions of given type
Message-ID: <20150914082905.GA11348@kaficko.joja.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm trying to match all expressions of a given type. I want to check
whether all accesses to any part of some struct are locked.

In the hypothetical case (which doesn't happen), every access to that
struct would create a local variable of the wanted type and I could then
match it with something like this:

@@
identifier	   i;
@@

...
my_specific_type  *var;
...
var->i
...

Unfortunately, this structure may be also referenced from another
structure, like this:

struct A { int foo; int bar; };
struct B { int foo; struct A *bar };

struct B *b;
...
b->bar->foo;

I would like to write something like:

@@
expression struct A* E;
@@

...
+E
...

and match every occurence of not only variables of the given type, but
also an expression.

I was first trying to find some hint in the doc, found 
expression struct *E;
which is almost what I want but still too broad.

Does there exist some way to
A) achieve the behaviour I want by config
or
B) implement it?

If A, could you please give me a hint?
If B, I wanted to implement it but got totally lost in the code. Could
you please give me a pointer, where to begin? I'd like to contribute the
result then.

Best regards and thanks
MQ
