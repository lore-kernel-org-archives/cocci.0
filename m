From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 22 Aug 2017 12:00:35 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708221128420.3178@hadrien>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <be855581-e22e-2b58-8565-68412ae590b3@users.sourceforge.net>
 <c5f3c8db-e5ec-47c1-3d84-8392a7101645@users.sourceforge.net>
 <alpine.DEB.2.20.1708172043460.2068@hadrien>
 <b4451f01-e10a-c0f3-91ff-f49e185b3644@users.sourceforge.net>
 <alpine.DEB.2.20.1708172130300.2068@hadrien>
 <fda11784-5ed9-33ae-7beb-b5714abb11bc@users.sourceforge.net>
 <alpine.DEB.2.20.1708221128420.3178@hadrien>
Message-ID: <d0047ca8-e724-af6b-26ac-a297ae2c34c8@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How would you like to treat variations in such log messages?
> 
> They look fine as they are.

I have got other development opinions there depending on the preferred design goals.

* The mentioned small SmPL script can also help to find special differences.

* These log statements are similar (and not identical) in the code structure.
  I wonder also about other marked code places how they would fit to
  the search pattern.

* A test result was shown from two function implementations.
  It can be nice to compare several functions.
  Is it also possible that the comparison will be only performed within
  the same function bodies?

Regards,
Markus
