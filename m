From: mcuddie@qnx.com (Mitchell Cuddie)
Date: Tue, 12 Aug 2014 21:00:56 +0000
Subject: [Cocci] Metavariable Binding Order?
Message-ID: <1407877250.10287.28.camel@QNXWS8653-PC>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

Using coccinelle to match the argument type and edit printf format
strings. I observe the arguments to printf being matched in reverse
order(ok,i guess) but if I insert the processed identifiers into the
format string they go in out of order. Is there a binding order i am
missing? 


/*Output*/

Matched %c for argument of type () 3/0
 val=%c"

(26, 53)
Matched %d for argument of type (int) 2/1
 errno=%d

(26, 49)
Matched %d for argument of type (int) 1/2
"rc=%d

diff:
-       printf("rc=%d errno=%d val=%c", rc, errno, val);
+       printf("rc=%d val=%c" errno=%d, rc, errno, val);

/*patch*/

@base@
position pos, p;
expression fmt, a, b;
expression list[n] E;
expression list[m] F;
expression x;
@@
printf(fmt at pos, E, x at p, F)

@type_match@
position base.p;
type t;
t e;
@@
e at p

@script:python type_dict@
t << type_match.t;
p << base.p;
@@
/*Python Code*/

@script:python fix@
fmt << base.fmt; pos << base.pos; n << base.n; m << base.m;  p <<
base.p;
fix_fmt;
@@
/*Python Code*/

@fmt_replace@
position base.pos;
expression base.fmt;
identifier fix.fix_fmt;
@@
- fmt@pos
++ fix_fmt
