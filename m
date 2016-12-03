From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 11:01:53 +0100
Subject: [Cocci] Excluding specific assignment combinations with SmPL
Message-ID: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am experimenting with another source code search pattern. This approach
pointed a place like the following out for further considerations.

?
	ice->akm = kcalloc(?);
	ak = ice->akm;
?


My evolving SmPL script used also two separate metavariables with the
type ?expression? so that the value and target should be distinguished
for assignment statements. Now I would like to exclude cases where the target
is directly used again for the value specification as in the small example above.

How should be checked with the means of the semantic patch language that
the same expression is not used in subsequent lines?

Regards,
Markus
