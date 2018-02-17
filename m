From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Feb 2018 14:34:49 +0100
Subject: [Cocci] Avoiding code duplication for SmPL constraints
Message-ID: <06b4669e-7419-e4f8-1761-4e58eef44fbd@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Constraints can be specified for metavariables of the semantic patch language.
I noticed that they can trigger software maintenance challenges
when bigger specifications are repeated in some SmPL rules.
Now I am looking again for further possibilities to avoid corresponding
code duplication.

* Scripted constraints might be a design option.
  Unfortunately, I find the documentation for this functionality still incomplete.

* I imagine that it would nice if constraints could be set by programming script
  rules at a single place.

Regards,
Markus
