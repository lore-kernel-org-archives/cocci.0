From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 6 Nov 2017 16:57:31 +0800 (CST)
Subject: [Cocci] Setting the section for a function with SmPL
In-Reply-To: <41b71f07-b1da-55ea-5ae1-4fc14d1dfe0f@users.sourceforge.net>
References: <dae0fefb-6920-8e6a-76c6-b02b5fb0d4df@users.sourceforge.net>
 <alpine.DEB.2.20.1711022226360.4551@hadrien>
 <41b71f07-b1da-55ea-5ae1-4fc14d1dfe0f@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1711061657020.2005@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 2 Nov 2017, SF Markus Elfring wrote:

> >> @section_specification@
> >> type T;
> >> @@
> >>  T rcar_pcie_enable_msi(...)
> >> + __attribute__((section ("my_update")))

This works now.  It should have worked before, but the change was done
incompletely.

julia
