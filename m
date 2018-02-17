From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Feb 2018 15:54:16 +0100
Subject: [Cocci] Clarification for scripted SmPL constraints
In-Reply-To: <alpine.DEB.2.20.1802171531330.2205@hadrien>
References: <06b4669e-7419-e4f8-1761-4e58eef44fbd@users.sourceforge.net>
 <alpine.DEB.2.20.1802171437580.2205@hadrien>
 <388d5af8-d3e4-ee18-7481-3675e2b52024@users.sourceforge.net>
 <alpine.DEB.2.20.1802171510070.2205@hadrien>
 <9d550db4-cad4-f625-32da-173078fdde54@users.sourceforge.net>
 <alpine.DEB.2.20.1802171531330.2205@hadrien>
Message-ID: <0fcc795e-4d45-d92e-b2c2-149a8485dfd5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Which parameters should be passed to the selected function?
> 
> You can always pass the declared metavariable.

I have got special imaginations for convenient parameter passing
in such an use case.


> You can put a comma-separated list of inherited metavariables

Do you suggest that a dependency on metavariable inheritance is required?


> (r.a, r.b, ...) between the parentheses, and then use a, b, etc in the script code.

I would appreciate if the needed data would be directly available for
the predicate function (without repeating variable names).


> If there are no disjunctions in the rule and if the declared metavariable
> is no seprated by ... from a metavariable previously declared in the same rule,
> then the latter variable can be included in the () as well, with no rule
> name, and then used in the script code.

I find this condition hard to understand at the moment.

Regards,
Markus
