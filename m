From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Jan 2016 11:30:15 +0100
Subject: [Cocci] script code on metavariables
In-Reply-To: <alpine.DEB.2.10.1601181112390.2520@hadrien>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
 <569CBA51.2040303@users.sourceforge.net>
 <alpine.DEB.2.10.1601181112390.2520@hadrien>
Message-ID: <569CBEB7.1030509@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> The expression should return true or false, ie true if the proposed value
>>> of p is acceptable as a match, and false if it is not.
>>
>> Do you describe the introduction of generic predicate functions here?
> 
> I don't understand the question.

I try another wording ?


> In any case, the script doesn't define functions, due to the very limited syntax.

Do you exclude function definitions there so far?

Does the described SmPL extension correspond to predicate functionality?


> The normal case woudl be to define some functions in the initialize rule
> of the semantic patch, and just call them here.

I like such source code organisation in principle for some use cases.
Will this aspect need further considerations because of the evolving
parallelisation support?
https://github.com/coccinelle/coccinelle/issues/50

Regards,
Markus
