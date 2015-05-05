From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 May 2015 23:46:41 +0200 (CEST)
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <5548EEFE.8070106@users.sourceforge.net>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1505051633550.2640@hadrien>
 <5548EEFE.8070106@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1505052346220.2915@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 5 May 2015, SF Markus Elfring wrote:

> > Then Coccinelle will find the cases where the types are wrong, rather than
> > requiring a test in python.
>
> Do you need a minus character in the first text column of the SmPL scripts then
> to mark corresponding update candidates (instead of the mentioned warning printing)?

He has a *, as he should.

julia
