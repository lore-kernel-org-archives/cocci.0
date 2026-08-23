Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD278C5DF8C
	for <cocci@archiver.kernel.org>; Sun, 23 Aug 2026 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RIDPl9unTqh3/j6eZq3uLYNyg6i9YaspRc2c/8REKvo=;
  b=rsjRZsbNq1Mk0rMlg2luG4BSAMm9WsHGtyOLZJQLZ9sdxb5gNzpOFexo
   xaPTvlHiM+vtUnMx7c3FJjJQmYw69oaJxOi7XORczhshyxbvAarraYaeM
   I7WoIhgPyE6Xi60dEchXOf9B3AYw7/gWdhWbzUPs95lJrAuFclUt3HDpX
   0=;
X-CSE-ConnectionGUID: uo396zh7St+nvs6pWkDhQw==
X-CSE-MsgGUID: g2CRuDafTkudbNwI2JseDg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="291153108"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Aug 2026 21:31:33 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 69FBD80F00; Sun, 23 Aug 2026 21:31:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 61F7E802CD
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 21:31:29 +0200 (CEST)
X-CSE-ConnectionGUID: 7EZLx/i0RhK7NKphGzh+iA==
X-CSE-MsgGUID: SDfPKePLRZaIEExqxVFhew==
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="154809879"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 21:31:29 +0200
Date: Sun, 23 Aug 2026 21:31:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260823161826.3805598-4-ekffu200098@gmail.com>
Message-ID: <1a42788d-89a6-393d-a3aa-effee35f894@inria.fr>
References: <20260823161826.3805598-1-ekffu200098@gmail.com> <20260823161826.3805598-4-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 3/7] coccinelle: zalloc-simple: drop the
 kmem_alloc rules
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3692
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/0Oyu818QdxHceawNfK9e5Q>



On Mon, 24 Aug 2026, Sang-Heon Jeon wrote:

> - kmem_alloc() was removed by commit f078d4ea8276
>   ("xfs: convert kmem_alloc() to kmalloc()")
>
> - kmem_zalloc() was removed by commit 10634530f7ba
>   ("xfs: convert kmem_zalloc() to kzalloc()")
>
> So drop the kmem_alloc rules.
>
> No functional change.

Applied

>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  .../coccinelle/api/alloc/zalloc-simple.cocci  | 41 +------------------
>  1 file changed, 1 insertion(+), 40 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index d66c45356691..ae1d39e71e31 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -35,7 +35,7 @@ statement S;
>  @@
>
>  * x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
> -  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
> +  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|
>    devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|kvmalloc_node(E1,...)\);
>    if ((x==NULL) || ...) S
>  * memset((T2)x,0,E1);
> @@ -88,15 +88,6 @@ statement S;
>  - x = (T)kmem_cache_alloc(E3,E4);
>  + x = (T)kmem_cache_zalloc(E3,E4);
>  |
> -- x = kmem_alloc(E1,E2);
> -+ x = kmem_zalloc(E1,E2);
> -|
> -- x = (T *)kmem_alloc(E1,E2);
> -+ x = kmem_zalloc(E1,E2);
> -|
> -- x = (T)kmem_alloc(E1,E2);
> -+ x = (T)kmem_zalloc(E1,E2);
> -|
>  - x = devm_kmalloc(E2,E1,E3);
>  + x = devm_kzalloc(E2,E1,E3);
>  |
> @@ -290,36 +281,6 @@ x << r4.x;
>  msg="WARNING: kmem_cache_zalloc should be used for %s, instead of kmem_cache_alloc/memset" % (x)
>  coccilib.report.print_report(p[0], msg)
>
> -//-----------------------------------------------------------------
> -@r5 depends on org || report@
> -type T, T2;
> -expression x;
> -expression E1,E2;
> -statement S;
> -position p;
> -@@
> -
> - x = (T)kmem_alloc@p(E1,E2);
> - if ((x==NULL) || ...) S
> - memset((T2)x,0,E1);
> -
> -@script:python depends on org@
> -p << r5.p;
> -x << r5.x;
> -@@
> -
> -msg="%s" % (x)
> -msg_safe=msg.replace("[","@(").replace("]",")")
> -coccilib.org.print_todo(p[0], msg_safe)
> -
> -@script:python depends on report@
> -p << r5.p;
> -x << r5.x;
> -@@
> -
> -msg="WARNING: kmem_zalloc should be used for %s, instead of kmem_alloc/memset" % (x)
> -coccilib.report.print_report(p[0], msg)
> -
>  //-----------------------------------------------------------------
>  @r6 depends on org || report@
>  type T, T2;
> --
> 2.43.0
>
>
