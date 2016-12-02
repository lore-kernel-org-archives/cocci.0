From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Dec 2016 14:10:55 +0100
Subject: [Cocci] Finding missing return value checks for some function
 calls with SmPL
In-Reply-To: <alpine.DEB.2.10.1612021324520.3056@hadrien>
References: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
 <e853f47b-78be-7450-a420-b301f4f504d1@users.sourceforge.net>
 <alpine.DEB.2.10.1612021143050.3056@hadrien>
 <298f7485-a554-11ab-97f1-31e2ba2a6b0f@users.sourceforge.net>
 <alpine.DEB.2.10.1612021324520.3056@hadrien>
Message-ID: <f9862e7a-c62d-95d4-45d2-bdcb824c06a9@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> But can it be that this assignment is checked a bit too late?
> 
> Yes,

Thanks that you can agree to such a view.


> but no one will care.

I am curious if further software development opinions will appear around
similar situations.


> The code is more concise as is.

I have got an other opinion for such an implementation detail.


> If the alloc fails, the machine is already in a very bad state, so one more alloc
> attempt doesn't matter.

Would it be nicer to avoid a questionable function call (and a corresponding
variable assignment) when it was determined that the desired task could not be
completed for a moment?

Regards,
Markus
