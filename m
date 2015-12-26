From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 26 Dec 2015 23:29:09 +0300
Subject: [Cocci] [PATCH] coccinelle: api: check for propagation of error
 from platform_get_irq
In-Reply-To: <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
Message-ID: <567EF895.6080702@cogentembedded.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/26/2015 11:24 PM, Julia Lawall wrote:

> The conclusion seems to be that it is useful to override the value, so we
> can just drop this semantic patch.

    No! As I said, unconditionally overriding an error value breaks the 
deferred probing. It's actually a bug to override it, so the patch seems 
*very* useful.

> julia

MBR, Sergei
