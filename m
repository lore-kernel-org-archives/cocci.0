From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 23 May 2017 11:01:45 +0200
Subject: [Cocci] Easier search for assignment targets with SmPL
In-Reply-To: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
References: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
Message-ID: <01dd4e26-0864-df8e-4b43-e054c0e61400@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>  var = action(...);

This specification looks also simple for the semantic patch language
at first glance.
I tried to express that a specific value is assigned to something.
But this ?something? could be a different item depending on the position
in the source code.

1. Variable
2. Expression
3. Element for a designated initialiser

I would appreciate if I do not need to repeat specifications for these cases
in SmPL code. How do you think about the possibility to support the desired
source code search by an additional metavariable type there?
Can it become safer and more convenient to handle assignments here?

Regards,
Markus
