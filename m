From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Sat, 25 Jul 2015 15:00:52 +0200
Subject: [Cocci] expression list[n] el and ...
Message-ID: <CA+MoWDoK_ZD2YEKYn-2ejG+to4SgRg5obz1YKiRKqF4ZmgFNnA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This works fine:

@r1@
identifier i;
position p;
expression list[n] el;
@@
i at p(el)

@script:python@
p << r1.p;
i << r1.i;
n << r1.n;
@@
print "f," + i + "," + n + "," + p[0].file

But if I change:

i at p(el)

to

i@p(el, ...)

Then I get multiple matches for each function call: One match for each
parameter. I don't need the ..., but it was there on my first version,
so I'm reporting in case this is not a feature.
