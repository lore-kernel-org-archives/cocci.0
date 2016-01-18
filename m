From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Jan 2016 13:00:31 +0100
Subject: [Cocci] script code on metavariables
In-Reply-To: <alpine.DEB.2.10.1601181138430.2520@hadrien>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
 <569CBA51.2040303@users.sourceforge.net>
 <alpine.DEB.2.10.1601181112390.2520@hadrien>
 <569CBEB7.1030509@users.sourceforge.net>
 <alpine.DEB.2.10.1601181138430.2520@hadrien>
Message-ID: <569CD3DF.2010600@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It is not possible to write an OCaml function definition that has the form
> of a C expression.  In practice, it is likely that one would only make a
> function call, like I showed in my example.

Are method calls are also supported there depending on the reused
programming language?


>> Does the described SmPL extension correspond to predicate functionality?
> 
> I guess.  The script code should return true or false.  If the script
> returns true, the match succeeds.

http://c2.com/cgi/wiki?PredicateFunction
http://stackoverflow.com/questions/5921609/what-is-predicate-in-c
https://en.wikipedia.org/wiki/Filter_%28higher-order_function%29

Will this kind of information matter for the outline in the evolving
documentation of the semantic patch language?



>> Will this aspect need further considerations because of the evolving
>> parallelisation support?
>> https://github.com/coccinelle/coccinelle/issues/50
> 
> I believe that parallelism with -j only fails if there is a finalize.

Would you like to clarify such an implementation detail a bit more?


> An initialize by itself should be OK.

How often will you need a corresponding finalisation action
(or destructor)?

Can the predicate function be eventually executed in parallel
(by a dedicated thread or another background process)?

Regards,
Markus
