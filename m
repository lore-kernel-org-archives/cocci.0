From: rminnich@gmail.com (ron minnich)
Date: Wed, 7 Aug 2013 08:21:24 -0700
Subject: [Cocci]  disjunction and parens
Message-ID: <CAP6exY+yyWBN5LPF7fT5KHuGe8VM4z0R5ywJ08Pq2rwOO3Hxaw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've never been sure what to do about this error:

[rminnich at localhost akaros]$ spatch --sp-file !$ kern/src/chan.c
spatch --sp-file scripts/spatch/waserror.cocci kern/src/chan.c
init_defs_builtins: /usr/share/coccinelle/standard.h
Fatal error: exception Failure("normal parenthesis in line 5 matched
to disjunction parenthesis on line 7 column 0

Spatch is:

@@
type T;
identifier f;
@@
T F(...,
+struct errbuf *errbuf
){...}

What did I do wrong here?
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
