From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 14 Apr 2014 18:26:07 +0200
Subject: [Cocci] Coccinelle 1.0.0-rc21: Clarification for
	"coccilib.elems"?
In-Reply-To: <alpine.DEB.2.10.1404141622020.2591@hadrien>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
 <alpine.DEB.2.10.1404141525370.2572@hadrien>
 <534BE66B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1404141622020.2591@hadrien>
Message-ID: <534C0C1F.8000808@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Nothing is planned for the handling of regular expressions.

I have built the current release on my openSUSE system.

I have tried out the following command again.

elfring at Sonne:~/Projekte/Coccinelle/janitor> date && ../1.0.0-rc21/spatch.opt
--sp-file list_functions_with_unnecessary_checks1.cocci --dir
/usr/src/linux-stable > list_functions_with_unnecessary_checks1-rc21.txt 2>
list_functions_with_unnecessary_checks1-rc21-errors.txt && date
Mo 14. Apr 18:18:16 CEST 2014


Unfortunately, I stumble on an error message in the shown log file.

init_defs_builtins: /usr/local/share/coccinelle/standard.h
ImportError: No module named coccilib.elems
while importing module coccilib.elems:
Failure in rule starting on line 1
Fatal error: exception Yes_pycocci.Pycocciexception


Why does it not work as expected?

Regards,
Markus
