From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 17 Aug 2017 21:43:15 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708172130300.2068@hadrien>
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
Message-ID: <9920adb8-0af4-ef20-f5f2-2fc3d73073b2@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> * Are there further development challenges to consider for the safe identification
>>   of unique statements by metavariables?
> 
> If you want to ensure that two metavariables match things in different
> places, then put a position variable on each match and use apython rule
> afterwards to discard the occurrences that are both in the same position.

I hoped for a more convenient search specification to reduce duplicate
source code a bit.

Regards,
Markus
