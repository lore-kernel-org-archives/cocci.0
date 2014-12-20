From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 20 Dec 2014 17:06:07 +0100 (CET)
Subject: [Cocci] In depth docs & question about include
In-Reply-To: <63642497-E7BD-4E63-B934-523CFE111637@gmail.com>
References: <63642497-E7BD-4E63-B934-523CFE111637@gmail.com>
Message-ID: <alpine.DEB.2.10.1412201703180.2650@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 20 Dec 2014, Eliseo Mart?nez wrote:

> Hi,
>
> I discovered coccinelle some time ago, and I think it?s an amazing tool that can make a real difference.
> Unfortunately, up until now, I?ve had to restrict myself to simple use cases, because existing documentation only scratches the surface.
> You can see there are much more advanced things you could do, but for those you don?t find an explanation anywhere. You?re left with trial & error.
> So, my question is: Are there plans to produce a book-style, really in-depth explanation of all coccinelle functionality?
> I think that would be really necessary if you want bigger adoption/usage.

It's not in our current plans.

> Now, a concrete question:
> Suppose I?m introducing changes that make use of a function declared in ?header.h?.
> How would I automatically insert includes for the header, only when it?s not already present?

Inserting includes is a little bit complicated, because everything has to
be attached to something.  You can try the following:

@r@
@@
#include <linux/kernel.h>

@depends on !r@
@@

#include <...>
+#include <linux/kernel.h>

julia
