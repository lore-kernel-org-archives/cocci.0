From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 04 Mar 2013 13:20:30 +0100
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <alpine.DEB.2.02.1303041106480.1984@hadrien>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
Message-ID: <5134918E.7090304@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Maybe you could use find with the -exec argument, if it is acceptable to
> work on only one file at a time?

I do not see that this suggestion works here because I understand the tool
"ocamldoc" in the way that it wants to get all relevant parameters (including
the source file names) passed at once.


> I wouldn't know how to make it sensitive to the configuration.

My attempt with the tool "find" alone leads to unwanted results. I would like to
avoid to maintain file name list manually.
It seems that your repository contains 321 OCaml source files from which
documentation information can eventually be extracted.

Your tool "spatch" reuses also some other software components. I see it as a
configuration challenge to exclude source files from these dependencies for the
suggested documentation process.

Regards,
Markus
