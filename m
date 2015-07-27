From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 27 Jul 2015 17:18:56 +0200
Subject: [Cocci] Finding non-zero returning functions with SmPL
Message-ID: <55B64BE0.7050303@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried the following small SmPL script out


@non_zero_returning_functions@
identifier work;
type return_type;
@@
*return_type work(...)
 {
  <+...
  return ... when != 0
             when != NULL
         ;
  ...+>
 }


on this bit of source code.


#include <API-test1.h>

int my_status(void)
{
  return 1;
}

int main(void)
{
  return my_status();
}


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_non-zero_returning_functions1.cocci ../Probe/API-test1.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
116 120
Fatal error: exception Failure("minus: parse error: \n = File \"show_non-zero_returning_functions1.cocci\", line 8, column 13,  charpos = 116\n    around = 'when', whole content =   return ... when != 0;\n")


Do I use the SmPL construct "when" in an inappropriate way here?

Regards,
Markus
