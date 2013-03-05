From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 05 Mar 2013 11:22:05 +0100
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <alpine.DEB.2.02.1303051104310.1954@hadrien>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
 <alpine.DEB.2.02.1303041338350.1984@hadrien>
 <5135B8DB.30307@users.sourceforge.net>
 <alpine.DEB.2.02.1303051028450.1954@hadrien>
 <5135C125.6070707@users.sourceforge.net>
 <alpine.DEB.2.02.1303051104310.1954@hadrien>
Message-ID: <5135C74D.8000602@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> To the best of my understanding, our files are in separate directories
> from the files for external libraries.

Your top directory contains also a few source files which might be interesting
here. I assume that the file "myocamlbuild.ml" belongs to the configuration
option "--enable-ocamlbuild" for example.
Are there any more conditions to consider?



> But if you need everything to get any documentation, then I guess you would need
> the external libraries as well.

I guess that I will need a technique to determine include paths for the
referenced modules consistently.


> I'm not sure why ocamldoc can't just use the -I paths to find the things
> it needs.  That is you should be able to give just one file, and it should
> be able to find the information for any dependencies.

Do you expect that more "intelligence" or "convenience" should be provided by
this tool?

I imagine that the desired (include) parameters need to be constructed by
adjustments for the configuration script.

Regards,
Markus
