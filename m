From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 27 Jan 2017 23:23:21 +0100
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
Message-ID: <1485555801.14579.8.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-01-27 at 23:09 +0100, Julia Lawall wrote:
> 
> Ok, sounds good.??Let me know if you encounter further problems.

You jinxed it ;-)
Now with the git version.

struct foo v = {
	.nested = {
		.x = 7,
		.y = 8,
	},
};

still broke, because of course my initializer replacement rule didn't
actually find it, and then the bug hit and removed the {} anyway even
though they weren't empty :)

Similarly,

char * foo[] = {
	[1] = "name1",
	[2] = "name2",
};

was butchered quite a bit :)

The latter case - though not with strings - actually does seem to be
present in the code I care about, but I can probably just replace it
manually first.

Interestingly, this whole exercise is obviously not even a good idea
for static variables - need to see if I can exclude those somehow,
first naive attempts didn't work :)

johannes
