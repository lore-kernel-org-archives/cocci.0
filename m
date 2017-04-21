From: kaspar@schleiser.de (Kaspar Schleiser)
Date: Fri, 21 Apr 2017 11:05:00 +0200
Subject: [Cocci] new to cocci, help needed
Message-ID: <ba1249bd-36ab-a819-34b8-186d84a4ec49@schleiser.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello all,

I'm just beginning to write my own semantic patches, and I'm having a
little trouble getting the hang of it.

Currently I'm trying to unify all calls to a function named "f" taking a
pointer to a variable and the variable's size as arguments, which I want
to deduce using sizeof:

f(..., &var, sizeof(var))


My initial approach looks similar to this:

@@
expression E1, E2;
@@

f(...,*E1,
- E2,
+ sizeof(E1))

... but this doesn't find e.g., "f(a, b, &test, whatever);".

What am I doing wrong?

Thanks in advance,
Kaspar
