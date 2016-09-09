From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 9 Sep 2016 08:54:26 +0200
Subject: [Cocci] Marking data structures as "const" (like
 da905x_regulator_info blocks)?
In-Reply-To: <185611d7a5573a1edc5fe126f77d5543@newmail.lip6.fr>
References: <bc2a69f70af39247994fd2b26e36d1b254576247.1473389324.git.joe@perches.com>
 <1473389785.13672.25.camel@perches.com>
 <4732dc91a1990c04217370e5ecced704@newmail.lip6.fr>
 <1473395888.13672.29.camel@perches.com>
 <185611d7a5573a1edc5fe126f77d5543@newmail.lip6.fr>
Message-ID: <ada8f5f7-1519-c8d7-f756-8be195f9104e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> It's not an easy problem but it could be worthwhile when all
>> structure members are never modified after initialization.
> 
> If the structure type is file-local,

This scope limitation sounds promising. Some source code analysis
seems to be easier when you can be sure that all the information
you need for a specific task is contained in a single file.


> it could indeed be possible to do something.

I imagine that a general software development challenge remains
for further considerations and corresponding technology research.
How will the available software tools become better
in data flow analysis?

Regards,
Makrus
