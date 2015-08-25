From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 25 Aug 2015 09:20:38 +0200
Subject: [Cocci] release: 1.0.2: Software evolution around
 parallelisation support
In-Reply-To: <alpine.DEB.2.02.1508250850490.2049@localhost6.localdomain6>
References: <alpine.DEB.2.10.1508220653050.2531@hadrien>
 <55DA0DFD.8090005@users.sourceforge.net>
 <alpine.DEB.2.10.1508231227480.2916@hadrien>
 <55DC0E6E.10405@users.sourceforge.net>
 <alpine.DEB.2.02.1508250850490.2049@localhost6.localdomain6>
Message-ID: <55DC1746.2020503@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The problem is that the scripting language environment is separate from the 
> environment of Coccinelle itself.  So there is no easy way to get the 
> right values into the right variables.

I can also understand corresponding software development challennges to some degree.


> Coccinelle doesn't know anything about the variables of the ocaml or python scripts.

How do you think about possibilities to extend its knowledge?
Can an improved software design help to achieve the needed data exchange?


>> I propose to reactivate the support for the SmPL rules "initialize" and "finalize"
>> for all uses cases without unwanted software limitations.
> 
> There is no way that Coccinelle can tell what is a "use case with an 
> unwanted software limitation.

Can the exclusion of these rules be seen as a temporary software restriction
when the parameter "--jobs" to the program "spatch"?


> Coccinelle doesn't know what the scripting code does.

But you have still got control on the data which are transferred between
the involved subprocesses.


> I would prefer not to promise a behavior that is not implemented.

I hope that corresponding technical concerns can be improved.


> As I said before, if an unshared initialize and finalize are acceptable to you,
> then just use the preexisting parallelism solution, which is still supported.

I am using this approach with a make script for a while.

How do you think about variants for these actions at the "unshared" stage
and the task/subprocess level?

Regards,
Markus
