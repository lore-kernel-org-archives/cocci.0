From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 04 Mar 2013 13:57:16 +0100
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <alpine.DEB.2.02.1303041338350.1984@hadrien>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
 <alpine.DEB.2.02.1303041338350.1984@hadrien>
Message-ID: <51349A2C.609@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> On the other hand, I'm not sure what the purpose of all of this is.

I hope to achieve a better understanding for your software by the presentation
style from the tool "ocamldoc". (It supports also to generate Graphviz files.)


> If it is only to be able to write ocaml code that processes the C abstract
> syntax tree, then it should be enough to consider the files in the
> parser_c directory.  These are however the ones where there is a risk of a
> missing mli file.

I guess that it is still a configuration challenge to set some variables in a
way so that all dependencies like needed modules can be resolved for the
documentation.

Regards,
Markus
