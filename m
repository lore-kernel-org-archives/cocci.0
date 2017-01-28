From: johannes@sipsolutions.net (Johannes Berg)
Date: Sat, 28 Jan 2017 09:20:37 +0100
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <alpine.DEB.2.20.1701280743530.2822@hadrien>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261655450.3109@hadrien>
 <1485553437.14579.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701272250210.2830@hadrien>
 <1485554630.14579.6.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701272309260.3612@hadrien>
 <1485558136.14579.14.camel@sipsolutions.net>
 <1485559204.14579.16.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701280743530.2822@hadrien>
Message-ID: <1485591637.4812.3.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> It seems that the control flow was quite complete in one function,
> and the when any at the end of the rule was taking a long time.

Oh, interesting, but that makes sense.

> But actually you don't need the outer ... and braces at
> all.??Furthermore, from the initial declaration to the first
> following statement, there should be no branches,
> so it is safe to put exists on each rule, ie trace through each
> possible control-flow path individually.??The revised semantic patch
> is attached. It terminates quite quickly.

Good point, thanks!

> You can add an option --timeout 120, or some other number of
> seconds.??It will tell you if there are any timeouts, so you can see
> where there may be problems.

That's also useful, didn't know about that. :)

johannes
