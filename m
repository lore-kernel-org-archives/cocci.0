From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Oct 2016 14:43:29 +0200 (CEST)
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <6696e3bf-e399-dfd9-a692-364d7c5db196@users.sourceforge.net>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
 <alpine.DEB.2.10.1610141019550.3002@hadrien>
 <2d2a0414-0e23-790b-e99c-0220ffda2b35@users.sourceforge.net>
 <alpine.DEB.2.10.1610141101550.3272@hadrien>
 <3c66ad10-02bf-84a0-4ba3-56a5f74dd643@users.sourceforge.net>
 <alpine.DEB.2.20.1610151029570.9280@hadrien>
 <6696e3bf-e399-dfd9-a692-364d7c5db196@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1610151443060.9280@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 15 Oct 2016, SF Markus Elfring wrote:

> >> I have got a few concerns for further software development considerations.
> >> How do you think about to support also an advanced interface by which it could be
> >> determined if a preprocessor symbol would correspond to such a desired character
> >> (instead of fiddling with regular expressions within a rule for the embedded programming
> >> language script)?
> >
> > What C code are you concerned about exactly?
>
> I guess that this "story" affects some general aspects. After I got a better understanding
> of related software dependencies, I begin to think also about further possibilities to
> make such a source code search pattern safer and more efficient.
> How much would you like to increase the support for data processing around macros
> with your software?

Ther are no particular plans in this direction.

julia
