From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 21 Jun 2016 22:36:53 +0200 (CEST)
Subject: [Cocci] [PATCH v3 8/8] scripts/coccinelle: require coccinelle
 >= 1.0.4 on device_node_continue.cocci
In-Reply-To: <1466536893-23355-9-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-9-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.02.1606212236260.2040@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:

> Make use of the new Requires: tag to be able to specify coccinelle binary
> version requirements. The cocci file device_node_continue.cocci requires at
> least coccinelle 1.0.4.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/iterators/device_node_continue.cocci | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scripts/coccinelle/iterators/device_node_continue.cocci
> index 38ab744a4037..a36c16db171b 100644
> --- a/scripts/coccinelle/iterators/device_node_continue.cocci
> +++ b/scripts/coccinelle/iterators/device_node_continue.cocci
> @@ -5,8 +5,11 @@
>  // Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
>  // URL: http://coccinelle.lip6.fr/
>  // Options: --no-includes --include-headers
> +// Requires: 1.0.4
>  // Keywords: for_each_child_of_node, etc.
>  
> +// This uses a conjunction, which requires at least coccinelle >= 1.0.4
> +
>  virtual patch
>  virtual context
>  virtual org
> -- 
> 2.8.2
> 
> 
