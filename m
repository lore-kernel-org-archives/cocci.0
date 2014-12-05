From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 05 Dec 2014 15:20:50 +0100
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <alpine.DEB.2.02.1412032334330.2303@localhost6.localdomain6>
References: <5478F848.1080808@users.sourceforge.net>
 <alpine.DEB.2.02.1412032218310.2303@localhost6.localdomain6>
 <547F8C2B.5090601@users.sourceforge.net>
 <alpine.DEB.2.02.1412032334330.2303@localhost6.localdomain6>
Message-ID: <5481BF42.9040503@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How should function calls with a non-void return type be found currently?
> 
> Perhaps you can say
> 
> type t != void;

I have tried your suggestion out.


elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file list_functions_with_single_function_call3.cocci /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
1847 1849
Fatal error: exception Failure("meta: parse error: 
 = File "list_functions_with_single_function_call3.cocci", line 82, column 17,  charpos = 1847
    around = '!=', whole content =      return_type != void;
")


But I do not like the shown error message again.


> If not, then match the void functions, save their position, and then match 
> the functions that are not in the same position.

I would appreciate if I do not need to fiddle more with SmPL position variables.

Regards,
Markus
