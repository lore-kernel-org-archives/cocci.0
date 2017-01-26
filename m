From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 26 Jan 2017 15:28:02 +0100
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <alpine.DEB.2.20.1701261518560.3109@hadrien>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
Message-ID: <1485440882.14760.8.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Try for the braces.??Maybe something like
> 
> {
> ? ... when != { ... }
> ? T x
> -?????= {0}
> ? ;
> ? ... when != S
> ??????when any
> ++ memset(...)
> ???S1
> ???... when any
> }

Yep, thanks! (I'm on the phone, and didn't get a chance to try yet)

That works for anything that's actually "= {0}" today, but for I can't
even match "= {}" properly, it seems?

johannes
