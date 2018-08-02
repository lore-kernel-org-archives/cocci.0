From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Aug 2018 22:33:25 +0200 (CEST)
Subject: [Cocci] Code wrapped in macros ignored by script
In-Reply-To: <e0920777-4b76-dfa3-03fa-97d1d76cd229@nvidia.com>
References: <e0920777-4b76-dfa3-03fa-97d1d76cd229@nvidia.com>
Message-ID: <alpine.DEB.2.20.1808022232230.2301@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 2 Aug 2018, Timur Tabi wrote:

> My cocci script (attached) ignores lines that are embedded inside other
> macros.? Example:
>
> #define DB(x)?? x
>
> void func()
> {
> ??? DB(if (DEBUG_IO_TRACE())
> ??????????????? DBG_PRINTF((DBG_MODULE_GLOBAL, DBG_LEVEL_INFO, "inb %#04x \n",
> addr));)
> }
>
> Is there a way to get coccinelle to ignore the DB( and )?

No.  Either Coccinelle can parse the macro use as is, which is not
possible here, because an if can't be an argument to a function call, or
it expands the macro, in which case no transformation is possible.

julia
