From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Aug 2017 12:15:22 +0200 (CEST)
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <9b9a69c1-105a-47e5-099e-816efd08d8f4@users.sourceforge.net>
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
 <d0047ca8-e724-af6b-26ac-a297ae2c34c8@users.sourceforge.net>
 <alpine.DEB.2.20.1708221202380.3178@hadrien>
 <9b9a69c1-105a-47e5-099e-816efd08d8f4@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708221215070.3178@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 22 Aug 2017, SF Markus Elfring wrote:

> >> * A test result was shown from two function implementations.
> >>   It can be nice to compare several functions.
> >>   Is it also possible that the comparison will be only performed within
> >>   the same function bodies?
> >
> > If you make a single rule then it will only applied within individual functions.
>
> How do the presented functions ?usb6fire_fw_ezusb_upload? and ?usb6fire_fw_fpga_upload?
> fit to this information?

The pattern matched in two different functions?

julia
