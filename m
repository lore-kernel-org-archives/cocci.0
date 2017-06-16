From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jun 2017 09:45:57 +0200
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <alpine.DEB.2.20.1706160907590.3049@hadrien>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
 <alpine.DEB.2.20.1706142255480.3610@hadrien>
 <47632935-6b4f-aeec-2ced-11f5d2f8609b@users.sourceforge.net>
 <alpine.DEB.2.20.1706152233080.3015@hadrien>
 <75d88a53-ace7-3bea-a3b2-bbc100091e78@users.sourceforge.net>
 <alpine.DEB.2.20.1706160802420.3013@hadrien>
 <8acbcd33-5eb7-08d3-c841-734d0359f87b@users.sourceforge.net>
 <alpine.DEB.2.20.1706160829130.3459@hadrien>
 <0e92a764-c68e-c279-4d33-228690b47172@users.sourceforge.net>
 <alpine.DEB.2.20.1706160907590.3049@hadrien>
Message-ID: <1a14a623-cb5d-b8ab-4635-2dbe2082318c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I showed how I could stumble on open issues.
> 
> No you didn't.

I try then once more to help you to interpret the mentioned
error message examples.


The command ?ocamldep *.mli *.ml > .depend? was performed for
relevant subdirectories.
Unfortunately, this approach seems to be insufficient for the desired
safe integration of dependency information so far.


> I don't know what are the arguments to the ocaml compiler.

If you think in terms of the build system, you would know that this tool
needs input files.
Unfortunately, the current build scripts did not trigger the generation
of the desired prerequisites for the command examples at the end.


> What file are you trying to compile?

The attempted data processing steps can not succeed when required
files were not built before.
If these dependencies will be fixed, then we can worry if an error message
like ?Unbound module Ast_c? can occur because of other reasons.

Regards,
Markus
