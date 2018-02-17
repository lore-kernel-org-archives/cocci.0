From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 20:47:23 +0100 (CET)
Subject: [Cocci] Determination for the absence of an option in a
 function call
In-Reply-To: <2a43676a-fdee-236c-221e-f75a6bcd24f2@users.sourceforge.net>
References: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
 <alpine.DEB.2.20.1802171703560.2205@hadrien>
 <2b678153-b7c0-6100-6d9c-624bd61e2b78@users.sourceforge.net>
 <alpine.DEB.2.20.1802171741560.2205@hadrien>
 <a3c2fbd6-00f4-0113-aab8-4caeed631e1c@users.sourceforge.net>
 <alpine.DEB.2.20.1802171808110.2205@hadrien>
 <b65bd20c-de90-2136-b375-246b873cf2a3@users.sourceforge.net>
 <alpine.DEB.2.20.1802171842050.2205@hadrien>
 <2a43676a-fdee-236c-221e-f75a6bcd24f2@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802172047020.12418@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> > f(...,<+...__GFP_NOWARN...+>,...)
>
> Does this SmPL specification mean that the identifier can appear anywhere
> within the function call parameters?

Yes.

> Would it be acceptable for a risk level of false positives to omit
> the check for the really appropriate parameter position?

Up to you to see what happens.

julia
