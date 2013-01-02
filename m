From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 2 Jan 2013 21:28:32 +0100 (CET)
Subject: [Cocci] Problem with variable declared with macro
In-Reply-To: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
References: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301022125250.2022@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Actually, I was totally off on my explanation.

It won't parse

#define MACRO1(id) \
int id

It doesn't accept incomplete statements.  I think it has a special case 
for while ... do (...).

But the reason why the use of MACRO1 doesn't get changed has nothing to do 
with that.  The problem is that it is at top level, and with just

-MACRO1
+MACRO2

the code is expected to be inside a function definition.

The following semantic patch works fine:

@@
declarer name MACRO1, MACRO2;
@@

-MACRO1
+MACRO2
  (...);

julia
