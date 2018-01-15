From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Jan 2018 12:18:52 +0100 (CET)
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <5ffcc601-e80b-7860-659c-ed6572be470a@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <9eb82024-38fe-19d0-2aad-2e19869cf5a2@users.sourceforge.net>
 <alpine.DEB.2.20.1801150736580.2637@hadrien>
 <545310fc-d64e-a970-3c76-6dfd15f9a8b3@users.sourceforge.net>
 <alpine.DEB.2.20.1801151015581.3305@hadrien>
 <502cdb22-4fc3-6802-bb05-a6d90b5fbe77@users.sourceforge.net>
 <alpine.DEB.2.20.1801151137430.3305@hadrien>
 <5ffcc601-e80b-7860-659c-ed6572be470a@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801151216570.3305@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Jan 2018, SF Markus Elfring wrote:

> > In the report rule we print the position, so having the position among the
> > inherited metavariables is useful.
>
> Do position variables influence (in a positive way?) how fast a source code place
> is matched in a non-script rule?

To some extent.  You are welcome to compare the performance.  I expect
that the difference would be small in this case, because there would only
be a few of these calls per file anyway.

> >>> If no index is available,
> >>
> >> How often will this be the usual case?   ;-)
> >
> > It depends on the user of Coccinelle.
>
> Can SmPL scripts adapt to the situation when an index was selected (or not)?

It doesn't really matter.  The point is that constraints are arbitrarily
complex, and the filtering, however it is done, is intended to be a simple
and fast process.

julia
