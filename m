From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 11 Jul 2016 20:20:28 +0200
Subject: [Cocci] Checking updates for documentation generation
Message-ID: <fe9afb20-ffdc-4fee-2d4d-cc97d79b0c94@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have noticed the commit "Removed docs from default make targets".
https://github.com/coccinelle/coccinelle/commit/2b3a75bb5a0b6f0ab0f6e089db56d9140b1642c7

I have tried the following command out then.


elfring at Sonne:~/Projekte/Coccinelle/20160205> make docs
?
/usr/bin/ocamldoc -I ../commons -I ../commons/ocamlextra -I ../globals -I ../parsing_cocci -I ../parsing_c -I ../engine -hide Pervasives -hide Exposed_modules \
	    -man -man-mini -d ../docs/man ../parsing_c/ast_c.ml coccilib.ml
Warning: Module or module type Exposed_modules not found
?
Finished building manuals


* How do you think about to avoid the shown message?

* Do I need to complete the software installation on my system?

Regards,
Markus
