From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Feb 2018 17:00:21 +0100
Subject: [Cocci] Determination for the absence of an option in a function
	call
Message-ID: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am working with the following specification in some scripts for the semantic
patch language.

?
 target = action(...);
?


This source code search pattern shows that a return value from a function call
should be stored somewhere. The concrete call is restricted by a selection of
function names. Such an approach is working to some degree when restrictions
on function call parameters can be omitted.

But a safer source code analysis requires to distinguish these parameters in
more detail.

1. How should be ensured that a specific option was not passed?

2. The parameter number becomes also relevant then.
   How should functions be split based on their signature?

Regards,
Markus
