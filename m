From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 10 Jun 2018 10:22:08 +0200
Subject: [Cocci] Addition of a data type property with SmPL
Message-ID: <a207d700-456d-d502-b855-66fd50a528ee@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I would like to try another source code transformation out with the help of
the semantic patch language.

@addition@
identifier var;
type T;
@@
 T
+const
 * var;


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci add_const3.cocci
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
plus: parse error: 
  File "add_const3.cocci", line 6, column 1, charpos = 42
  around = 'const',
  whole content = +const


* How do you think about this test result?

* Can the addition of such a data type property be generally avoided
  if it would be present already?

https://github.com/coccinelle/coccinelle/issues/49

Regards,
Markus
