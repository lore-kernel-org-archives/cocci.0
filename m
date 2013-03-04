From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 04 Mar 2013 12:35:36 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
Message-ID: <51348708.1000005@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm not completely sure what you are proposing.

Have you got any idea why I get a result like the following?

elfring at Sonne:~/Projekte/Coccinelle/Bau> ocamlfind query camlp4 && ocamlfind
query menhirLib
/usr/lib64/ocaml/camlp4
ocamlfind: Package `menhirLib' not found


Are there any configuration challenges to consider with the use of a locally
installed variant in comparison to the version for this library which you also
bundle with your software?

Regards,
Markus
