From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 18 Dec 2016 21:43:18 +0100 (CET)
Subject: [Cocci] Checking incidence for SmPL initialisation rules after
 parallel script execution
In-Reply-To: <e5afa762-47cd-8473-4912-dd10aefc6e1f@users.sourceforge.net>
References: <da6cd1b6-17a0-d5e9-3ba6-7565cc80ce39@users.sourceforge.net>
 <alpine.DEB.2.20.1612181659510.1965@hadrien>
 <4a2af4ea-01ab-3e47-845e-15dae185791f@users.sourceforge.net>
 <alpine.DEB.2.20.1612182004360.2075@hadrien>
 <e5afa762-47cd-8473-4912-dd10aefc6e1f@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1612182142260.2075@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 18 Dec 2016, SF Markus Elfring wrote:

> > Without having the semantic patch and the .c file, ideally with both
> > cut down to a minimal version that shows the problem,
> > I can't answer this question.
>
> Can you generally clarify current consequences from usage of a SmPL rule ?initialize:??
> together with the parameter ?--jobs? for the program ?spatch??

It should happen only once.  Thus without your semantic patch and your .c
file, I can't tell why it doesn't behave as expected.

julia
