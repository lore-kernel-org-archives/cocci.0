From: rminnich@gmail.com (ron minnich)
Date: Thu, 1 Aug 2013 08:56:15 -0700
Subject: [Cocci]  OK, this time I *promise* I'm stuck
Message-ID: <CAP6exYJwt0HpKsACRGRY0PBd-Ez7PE=NZyDsKGabRSUxpHk=Xw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've got lots of these:
void f(int i, Chan *x)

or similar

to
void f(int i, struct chan *x)

I've got lots of spatches that selectively delete function calls with
certain types, but not that change a parameter.

I've tried stuff like this:

@@
function f;
identifier d;
@@
f(...,
-Chan *d,
+struct chan *d,
 ...);

and several variants but ... no luck.

thanks

ron
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
