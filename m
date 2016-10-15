From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 15 Oct 2016 13:21:24 +0200
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <alpine.DEB.2.20.1610151029570.9280@hadrien>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
 <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
 <alpine.DEB.2.10.1610141101550.3272@hadrien>
 <3c66ad10-02bf-84a0-4ba3-56a5f74dd643@users.sourceforge.net>
 <alpine.DEB.2.20.1610151029570.9280@hadrien>
Message-ID: <6696e3bf-e399-dfd9-a692-364d7c5db196@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I have got a few concerns for further software development considerations.
>> How do you think about to support also an advanced interface by which it could be
>> determined if a preprocessor symbol would correspond to such a desired character
>> (instead of fiddling with regular expressions within a rule for the embedded programming
>> language script)?
> 
> What C code are you concerned about exactly?

I guess that this "story" affects some general aspects. After I got a better understanding
of related software dependencies, I begin to think also about further possibilities to
make such a source code search pattern safer and more efficient.
How much would you like to increase the support for data processing around macros
with your software?

Regards,
Markus
