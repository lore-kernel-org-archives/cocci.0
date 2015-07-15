From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Jul 2015 11:00:37 +0200
Subject: [Cocci] Finding unstored return values with SmPL
Message-ID: <55A62135.90206@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I can find some function calls with the help of the semantic patch
language easily.
But I see further software development challenges in the following use cases.

1. The return value was not used for the initialisation of a variable.

2. The return value was not assigned to another variable.


Do I need to fiddle with SmPL position variables to determine if an assignment
is not performed together with a call within a function implementation?

I would appreciate your advices for such a source code analysis.

Regards,
Markus
