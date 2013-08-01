From: rminnich@gmail.com (ron minnich)
Date: Thu, 1 Aug 2013 08:22:41 -0700
Subject: [Cocci]  changing type to struct
Message-ID: <CAP6exYKuBk5LsNQLornHMCxXb0eAxY4HYC4Q1c3Pvj2zBVa=HA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Sorry for this obvious question, but I am restarting on coccinnelle
and could use a jumpstart.

I have types named
Chan

and would like to change them to this:
struct chan

Here is my first failing pass.

@@
identifier d;
@@
-Chan
+struct chan
d

fails badly ...

er, hints, I've been out of this game for a while.

ron
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
