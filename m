From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 21:55:24 +0100 (CET)
Subject: [Cocci] Checking for questionable error messages after failed
 memory allocations
In-Reply-To: <ac659e87-6e0a-8c7a-dcd9-fe79035123d6@users.sourceforge.net>
References: <96508c06-9473-e558-fba1-7e4db6646ee7@users.sourceforge.net>
 <alpine.DEB.2.20.1802171703560.2205@hadrien>
 <2b678153-b7c0-6100-6d9c-624bd61e2b78@users.sourceforge.net>
 <alpine.DEB.2.20.1802171741560.2205@hadrien>
 <a3c2fbd6-00f4-0113-aab8-4caeed631e1c@users.sourceforge.net>
 <alpine.DEB.2.20.1802171808110.2205@hadrien>
 <b65bd20c-de90-2136-b375-246b873cf2a3@users.sourceforge.net>
 <alpine.DEB.2.20.1802171842050.2205@hadrien>
 <2a43676a-fdee-236c-221e-f75a6bcd24f2@users.sourceforge.net>
 <alpine.DEB.2.20.1802172047020.12418@hadrien>
 <5e69411a-310d-f80b-6bd6-48158f5a1afd@users.sourceforge.net>
 <alpine.DEB.2.20.1802172124410.12418@hadrien>
 <e0b2f3b9-28bc-f4d4-01fc-f80317926bc4@users.sourceforge.net>
 <alpine.DEB.2.20.1802172135190.12418@hadrien>
 <ac659e87-6e0a-8c7a-dcd9-fe79035123d6@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802172154220.12418@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, SF Markus Elfring wrote:

> >>>> Which confidence categorisation would fit here?
> >>>
> >>> Low.
> >>
> >> May scripts with this view be integrated?
> >
> > It's possible.
>
> Will the integration make more sense when the duplication of
> regular expressions for SmPL constraints can be avoided?

This point is completely irrelevant.

> > It depends on the benefit of the transformation provided.
>
> Should the benefit be clearer after I published hundreds of update
> suggestions for this change pattern?

Well, many people have rejected the patches as well.  And checkpatch
already highlights the issue.

julia
