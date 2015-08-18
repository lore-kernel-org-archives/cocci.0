From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 18 Aug 2015 13:34:32 +0200
Subject: [Cocci] Checking data structure modification with SmPL
Message-ID: <55D31848.1060900@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried another small SmPL script out.

@show_modification_before_memory_release@
expression value;
identifier element, var;
@@
 <+...
*var->element = value;
 ...+>
 free(var);


This approach is working to some degree.
Now I would like to support more possibilities for the determination
of affected members from the shown variable.


@show_modification_before_memory_release@
expression element, value;
identifier var;
@@
 <+...
*var->element = value;
 ...+>
 free(var);


elfring at Sonne:~/Projekte/Miller/lokal> spatch.opt -sp-file ~/Projekte/Coccinelle/janitor/show_modification_before_memory_release1.cocci c/containers/hss.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
101 108
Fatal error: exception Failure("minus: parse error: \n = File \"/home/elfring/Projekte/Coccinelle/janitor/show_modification_before_memory_release1.cocci\", line 6, column 6,  charpos = 101\n    around = 'element', whole content = *var->element = value;\n")


How can this source code analysis be improved?

Regards,
Markus
