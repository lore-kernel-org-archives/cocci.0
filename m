From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jan 2018 10:04:32 +0100 (CET)
Subject: [Cocci] [PATCH] Coccinelle: alloc_cast: Add more memory
 allocating functions to the list
In-Reply-To: <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801141003270.7902@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 13 Jan 2018, SF Markus Elfring wrote:

> My software development attention was caught by another implementation detail
> in this evolving SmPL script.
>
>
> > + at initialize:python@
>
> The added script rule should get a condition.
> Would the specification ?depends on report? be appropriate there?

To my recollection, which is defined in the initialized is used in all of
the cases, so there is no need for a depends on.

julia
