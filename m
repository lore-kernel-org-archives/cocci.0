From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 28 Nov 2014 23:33:44 +0100
Subject: [Cocci] Finding function implementations that call only a single
	function.
Message-ID: <5478F848.1080808@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I would like to try another specific source code analysis out.
My approach contains the following semantic patch rule.

@non_void_single_function_call@
identifier caller, input, result, work;
type data_type,
     input_type,
     return_type !~ "void";
position pos;
@@
 return_type caller at pos(input_type input)
 {
(
  return work(input);
|
  data_type result = work(input);
  return result;
)
 }


But I wonder about the following error message.

elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file list_functions_with_single_function_call1.cocci -dir /usr/src/linux-stable/drivers/gpu/drm/ast
init_defs_builtins: /usr/local/share/coccinelle/standard.h
1612 1614
Fatal error: exception Failure("meta: parse error: 
 = File "list_functions_with_single_function_call1.cocci", line 77, column 17,  charpos = 1612
    around = '!~', whole content =      return_type !~ "void";
")


Regards,
Markus
