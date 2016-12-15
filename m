From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 15 Dec 2016 08:39:36 +0100 (CET)
Subject: [Cocci] non-static data structure selection by SmPL
In-Reply-To: <666a6647-cc34-2862-2896-f78a9e116066@users.sourceforge.net>
References: <a0aae8e0-28f3-d841-8750-3b56333bf07a@users.sourceforge.net>
 <alpine.DEB.2.10.1612142235170.4147@hadrien>
 <666a6647-cc34-2862-2896-f78a9e116066@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1612150838090.3359@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 15 Dec 2016, SF Markus Elfring wrote:

> > I have no idea what you are talking about.
>
> I got the impression that recent extensions for the Coccinelle software could
> increase the chances to update the support for special constraints a bit more.
>
>
> > What is wrong with the rule that is shown?
>
> This SmPL specification is still working for a while.
>
> I became curious once more if there are further possibilities to select in
> a single SmPL rule if a storage-class specifier like ?static? was not (!) specified.
> How do you think about to reduce the dependency on position variables (or internal
> database tables) for such source code checking?

disable optional_storage

It has probably existed for the last 10 years.

julia
