From: christof@warlich.name (Christof Warlich)
Date: Fri, 02 Jan 2015 12:11:48 +0100
Subject: [Cocci] adding function declarations
In-Reply-To: <alpine.DEB.2.10.1501021130150.2558@hadrien>
References: <54A55D15.5020306@warlich.name>
 <alpine.DEB.2.02.1501011829330.2060@localhost6.localdomain6>
 <54A67151.5080408@warlich.name> <alpine.DEB.2.10.1501021130150.2558@hadrien>
Message-ID: <54A67CF4.4040008@warlich.name>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

 > Interesting. For me, without the patch, it crashed.

That's strange indeed. I'm running Kubuntu 14.04 on x86_64:

$ uname -a
Linux shrek 3.13.0-40-generic #69-Ubuntu SMP Thu Nov 13 17:53:56 UTC 
2014 x86_64 x86_64 x86_64 GNU/Linux

and I don't see a crash with neither the precompiled Coccinelle Ubuntu 
PPA nor with building it from the current (1.0.0-rc23) source.

Anyhow, I've applied the patch now, even if it may only be to have the 
proper base for subsequent patches.

Cheers,

Chris
