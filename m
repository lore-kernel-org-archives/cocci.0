From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 13 Jul 2015 13:14:46 +0200
Subject: [Cocci] Error predicate determination with SmPL?
In-Reply-To: <alpine.DEB.2.10.1507130657040.2561@hadrien>
References: <55A36680.1020707@users.sourceforge.net>
 <55A39908.6060600@users.sourceforge.net>
 <alpine.DEB.2.10.1507130657040.2561@hadrien>
Message-ID: <55A39DA6.3030109@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> 1. Do I need to specify a SmPL constraint like "non-void"
>>    for such a script?
> 
> It seems pointless.  If the code is returning something and the return
> type is void, then the problem is elsewhere.

A C compiler will usually will react with an error display
for this special case.
How should a static source code analysis tool deal with it?

Does the metavariable type "expression" match also to the empty string?


>> 2. The expression which is used for a specific return statement
>>    can be assigned to a SmPL metavariable in an other script variant.
>>    I would appreciate if I could process the extracted data
>>    in a more structured way somehow.
> 
> I have no idea what you want to do.  You can get the AST if you write
> a script using OCaml:
> 
> (stringrep,astrep) << r.express;

I guess that I am going to store elements into another SQL database.

How are the chances that more documentation will become available
for safe processing of corresponding abstract syntax graph instances?

Regards,
Markus
