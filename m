From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 26 Dec 2015 22:59:04 +0300
Subject: [Cocci] [PATCH] coccinelle: api: check for propagation of error
 from platform_get_irq
In-Reply-To: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <567EF188.7020203@cogentembedded.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/26/2015 10:24 PM, Julia Lawall wrote:

> The error return value of platform_get_irq seems to often get dropped.

    Maybe it was intentional (see my recent follow-up to your netdev patch). 
But if an error gets unconditionally overriden, deferred probing can't work. 
So your patches seem good things in the end. Thank you!

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

[...]

MBR, Sergei
