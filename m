From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 23 Dec 2014 08:40:48 +0100
Subject: [Cocci] Dynamic construction of SmPL constraints
Message-ID: <54991C80.6000508@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I try to extract data and filter on properties from various
function implementations.
Now I would like to clarify consequences from the name resolution
process of the C programming language a bit more for safer
development of semantic patches.

Implementations from separate directories can provide different properties.
It can occasionally happen that functions from different folders
have got the same name.

I see that there are some development challenges when I would like
to construct SmPL constraints in the way that they will take the directory
hierarchy for a source file into account.
How can this functionality be achieved?

Regards,
Markus
