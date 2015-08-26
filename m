From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 26 Aug 2015 12:43:40 +0200
Subject: [Cocci] release: 1.0.2: Software evolution around
 parallelisation support
In-Reply-To: <alpine.DEB.2.10.1508261109060.2334@hadrien>
References: <alpine.DEB.2.10.1508220653050.2531@hadrien>
 <55DA0DFD.8090005@users.sourceforge.net>
 <alpine.DEB.2.10.1508231227480.2916@hadrien>
 <55DD53B8.1010205@users.sourceforge.net>
 <alpine.DEB.2.10.1508261109060.2334@hadrien>
Message-ID: <55DD985C.9080300@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Can it be determined from the content of a semantic patch language script
>> if the spawned subprocesses need any more data exchange (with the parent process)
>> besides the usual files like standard output and standard error?
> 
> In the short term, there is no improvement planned in this direction.
> It is important that Coccinelle does not know anything about the script code

Thanks for your feedback.


> - we don't want to include parsers for other languages,

I assume that might mean that no such extensions will be added in the near future.
I guess that the scripting interfaces are generally extensible so that
other programming languages can be integrated in principle if someone would be
keen enough to invest further software development efforts.


> and it would further raise the barrier for adding other scripting languages.

The inherent system complexity was already increased just by the added
parallelisation support with the parmap interface.


> If you need initialize and finalize, just use the current parallelism solution.

I am using this approach around the parameters "--index" and "--max" for a while.
I came similar challenges along during the development of my make scripts.


I imagine that these SmPL rules can still be executed by the main process
while the execution of the other rules will be delegated to subprocesses
(or even threads). The scripting environments in the subprocesses would additionally
check then which variables accesses should be transformed into data processing
requests for the main process.
When would you like to pick corresponding software development challenges up
around inter-process communication?


> You will get n results instead of 1 result, but it is better than getting
> 15 000 results, as would happen with parmap.

There are some trade-offs involved. I find it nicer when the Coccinelle software
can be directly reused for more use cases.

Regards,
Markus
