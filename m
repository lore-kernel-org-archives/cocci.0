From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 13 Jul 2015 14:01:40 +0200
Subject: [Cocci] Error predicate determination with SmPL?
In-Reply-To: <alpine.DEB.2.10.1507130743580.2561@hadrien>
References: <55A36680.1020707@users.sourceforge.net>
 <55A39908.6060600@users.sourceforge.net>
 <alpine.DEB.2.10.1507130657040.2561@hadrien>
 <55A39DA6.3030109@users.sourceforge.net>
 <alpine.DEB.2.10.1507130743580.2561@hadrien>
Message-ID: <55A3A8A4.9030101@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Does the metavariable type "expression" match also to the empty string?
> 
> No.

Thanks for your clarification.

I hope then that the shown specification of the SmPL variable will be
sufficient for a while to search for function implementations with
a non-void return type.


>> How are the chances that more documentation will become available
>> for safe processing of corresponding abstract syntax graph instances?
> 
> About the same as the chance that a user who wants the documentation will
> write it.  I have no plans to do so.  In general, if you know enough OCaml
> to use the abstract syntax tree, you also know enough OCaml to figure out
> what it is from the source code.  Everything is defined in
> parsing_c/ast_c.ml.

I would find it nice if a data structure representation will evolve
which is more independent from specific programming languages.

Regards,
Markus
