From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Dec 2015 21:38:19 +0100 (CET)
Subject: [Cocci] [PATCH] coccinelle: api: check for propagation of error
 from platform_get_irq
In-Reply-To: <567EF895.6080702@cogentembedded.com>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
 <567EF895.6080702@cogentembedded.com>
Message-ID: <alpine.DEB.2.02.1512262137320.2070@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 26 Dec 2015, Sergei Shtylyov wrote:

> On 12/26/2015 11:24 PM, Julia Lawall wrote:
> 
> > The conclusion seems to be that it is useful to override the value, so we
> > can just drop this semantic patch.
> 
>    No! As I said, unconditionally overriding an error value breaks the
> deferred probing. It's actually a bug to override it, so the patch seems
> *very* useful.

Ah, OK, I'll send an improved version then :)

julia
