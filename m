From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jan 2017 08:09:31 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485445951.14760.16.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261644140.3109@hadrien>
 <1485445951.14760.16.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701270807230.1935@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Partial progress:  The github version will no longer match {} against
{ 0, 1, 2 }, but it persists in matching {} against { .a = 1, .b = 2 },
and will still remove the outer braces without removing the rest.

julia
