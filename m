From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Feb 2015 13:31:25 +0100 (CET)
Subject: [Cocci] Software evolution after Coccinelle 1.0.0-rc24?
In-Reply-To: <54D1E253.4050708@users.sourceforge.net>
References: <alpine.DEB.2.02.1502032259220.2026@localhost6.localdomain6>
 <54D1D876.2070305@users.sourceforge.net>
 <alpine.DEB.2.10.1502040934340.2394@hadrien>
 <54D1E253.4050708@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1502041330490.2394@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 4 Feb 2015, SF Markus Elfring wrote:

> > Initialize is often used to create variables that are intended to be used
> > in multiple script occurrences and finalize may accumulate their results.
>
> I like this functionality.
>
>
> > So the safe thing is to simply disallow initialize and finalize.
>
> I guess that another safe design option is to achieve process parallelism
> by passing command-line parameters like "index" and "max" as before the
> current software release.

That's fine, but you get static parallelism.  That is, you often end up
with only a few cores that are doing something.

julia
