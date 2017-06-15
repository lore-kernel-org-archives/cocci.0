From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 15 Jun 2017 13:43:52 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706142255480.3610@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
Message-ID: <9d0d2319-1f9b-8e1a-fdd9-1a764e71ce9c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you have changed things, then perhaps you have caused the problem?

This is also another possibility in principle.

It seems that I wonder again why some source files should be compiled without
interface description files there.


An other script variant showed the following result.


elfring at Sonne:~/Projekte/Coccinelle/20160205/globals> LANG=C make iteration.cmx V=1
My test command:
/usr/bin/ocamlopt.opt -unsafe -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ -c flag.ml
File "flag.ml", line 24, characters 17-36:
Error: Unbound module Commands
make: *** [Makefile:62: flag.cmx] Error 2


Can it be that the corresponding dependency specifications were incomplete anyhow
in this make script for the direct use at such a place?

Would you like to help any more to get these dependencies more consistent?

Regards,
Markus
