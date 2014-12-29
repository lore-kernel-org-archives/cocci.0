From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 29 Dec 2014 14:08:45 +0100
Subject: [Cocci] Support for SmPL ellipsis in logical expressions?
Message-ID: <54A1525D.3040009@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Julia,

I have tried the following semantic filter approach out.

@safety_check_with_pointer@
identifier input, member, process, work;
statement is, es;
type input_type, return_type;
@@
 return_type work(input_type * input)
 {
  ... when any
(
* if (!input)
     return ... ;
|
* if (unlikely(ZERO_OR_NULL_PTR(input)))
     return ... ;
|
* if (!input || ... process(& input->member) ... )
     return ... ;
|
* if (input && ... process(& input->member) ... )
     is
  else
     es
)
  ... when any
 }

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file show_input_parameter_validation7.cocci ~/Projekte/Linux/next-patched/fs/kernfs/dir.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
293 300
Fatal error: exception Failure("minus: parse error: \n = File \"show_input_parameter_validation7.cocci\", line 16, column 20,  charpos = 293\n    around = 'process', whole content = * if (!input || ... process(& input->member) ... )\n")


Does the Coccinelle software not like my placement of the SmPL ellipsis within a condition specification?

Regards,
Markus
