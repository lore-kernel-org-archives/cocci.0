From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 6 Oct 2013 15:53:27 +0200 (CEST)
Subject: [Cocci] [PATCH] scripts/coccinelle/api: remove
 devm_request_and_ioremap.cocci
In-Reply-To: <20131006134921.GA4173@katana>
References: <1376562633-16204-1-git-send-email-wsa@the-dreams.de>
 <20131006134921.GA4173@katana>
Message-ID: <alpine.DEB.2.02.1310061552541.2037@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 6 Oct 2013, Wolfram Sang wrote:

> On Thu, Aug 15, 2013 at 12:30:25PM +0200, Wolfram Sang wrote:
> > Use of this function is discouraged in favour of
> > devm_ioremap_resource(). Don't advertise it.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> 
> Ping.
> 
> 
