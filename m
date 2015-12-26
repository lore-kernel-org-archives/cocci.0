From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Dec 2015 21:08:27 +0100 (CET)
Subject: [Cocci] [PATCH] coccinelle: api: check for propagation of error
 from platform_get_irq
In-Reply-To: <567EF188.7020203@cogentembedded.com>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
Message-ID: <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 26 Dec 2015, Sergei Shtylyov wrote:

> On 12/26/2015 10:24 PM, Julia Lawall wrote:
> 
> > The error return value of platform_get_irq seems to often get dropped.
> 
>    Maybe it was intentional (see my recent follow-up to your netdev patch).
> But if an error gets unconditionally overriden, deferred probing can't work.
> So your patches seem good things in the end. Thank you!

Actually, this semantic patch overloos the case where a constant is 
returned directly, which is apparently also popular.  I can update this if 
the whole concept is useful, but that's not clear at the moment...

julia
