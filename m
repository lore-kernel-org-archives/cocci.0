From: johannes@sipsolutions.net (Johannes Berg)
Date: Sat, 28 Jan 2017 00:02:16 +0100
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <alpine.DEB.2.20.1701272309260.3612@hadrien>
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
Message-ID: <1485558136.14579.14.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-01-27 at 23:09 +0100, Julia Lawall wrote:
> 
> Ok, sounds good.??Let me know if you encounter further problems.

I've now ended up with the following overall:
https://p.sipsolutions.net/15e6265ea961d9a6.txt

Interestingly, that takes minutes to run on this file:
https://w1.fi/cgit/hostap/tree/wpa_supplicant/dbus/dbus_new_handlers_p2p.c

Not that it matters much to me, but I can't really explain it, all
other files I found finish quickly.

johannes
