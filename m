From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jan 2018 10:58:21 +0100 (CET)
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
 <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801141056190.7902@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 14 Jan 2018, SF Markus Elfring wrote:

> >>> + at initialize:python@
> >>
> >> The added script rule should get a condition.
> >> Would the specification ?depends on report? be appropriate there?
> >
> > To my recollection,
>
> I wonder about this wording ?

Well, you didn't keep the semantic patch in the message.

>
>
> > which is defined in the initialized is used in all of the cases,
>
> I imagine that you could know it better.
>
>
> > so there is no need for a depends on.
>
> The default usage mode for the affected SmPL script is ?report?.
> https://bottest.wiki.kernel.org/coccicheck#modes
>
> But can an other mode also be occasionally selected here?
> How do you think about to avoid the extra initialisation
> when only the operation mode ?context? or ?patch? would be active?

context and patch use the regular expression too.  All forms of the rule
need it, to keep the casts that contain sparse annotations.

julia
