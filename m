Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43740C5DF8C
	for <cocci@archiver.kernel.org>; Sun, 23 Aug 2026 19:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/GZ6G5Mr+p39QiWcnXVEBHojx9PNJ3nlo70kO0B4Mdk=;
  b=eFhknHZwi0/0jYgOFO/sLbgIYmHFBADgwGiEdIiCGD5tAy9uAyldGKCw
   YnWvFUWzldg+SALBRhy+QTC/9cJoYmLG8xOKdVL5U/aiq/uD4RLuFsklM
   5D/ichOdGxaG7v585cLx2fy5lsmoWyCilYACt8Yy9tVYRAHsGrtizWSIf
   s=;
X-CSE-ConnectionGUID: i/FtiraQRQ2gGV0ZpLKjXg==
X-CSE-MsgGUID: n1aesVT9RL6x+hVCcxyDSA==
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
   d="scan'208";a="291153063"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Aug 2026 21:31:17 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BFCE380EE0; Sun, 23 Aug 2026 21:31:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9DC03802CD
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 21:31:15 +0200 (CEST)
X-CSE-ConnectionGUID: OLvIRMlAS5WM3drpGxALXA==
X-CSE-MsgGUID: hX/0qz9yQrGYrctbYB5VfQ==
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="291153054"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 21:31:15 +0200
Date: Sun, 23 Aug 2026 21:31:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260823161826.3805598-3-ekffu200098@gmail.com>
Message-ID: <71b15b64-46fa-86a3-8261-835062a2e678@inria.fr>
References: <20260823161826.3805598-1-ekffu200098@gmail.com> <20260823161826.3805598-3-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 2/7] coccinelle: alloc_cast: drop removed
 allocators
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3691
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/W4qp1GA_yiO6SCMCSieiig>



On Mon, 24 Aug 2026, Sang-Heon Jeon wrote:

> - pci_alloc_consistent() and pci_zalloc_consistent() were removed by
>   commit 7968778914e5
>   ("PCI: Remove the deprecated "pci-dma-compat.h" API")
>
> - kmem_alloc() was removed by commit f078d4ea8276
>   ("xfs: convert kmem_alloc() to kmalloc()")
>
> - kmem_zalloc() was removed by commit 10634530f7ba
>   ("xfs: convert kmem_zalloc() to kzalloc()")
>
> - kmem_zone_alloc() and kmem_zone_zalloc() were removed by commit
>   bae633a4a283 ("xfs: remove xfs_zone_{alloc,zalloc} helpers")
>
> So drop them from the rules.
>
> No functional change.

Applied

>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  scripts/coccinelle/api/alloc/alloc_cast.cocci | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> index 958c914f8ba6..a4b83cc8ea01 100644
> --- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
> +++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> @@ -53,9 +53,8 @@ position p != {m1.p1,m2.p2};
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
>     dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> -   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> -   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> -   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
> +   vmalloc_node\|vzalloc_node\)(...)
>
>  //----------------------------------------------------------
>  //  For context mode
> @@ -76,9 +75,8 @@ type r1.T;
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
>     dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> -   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> -   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> -   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
> +   vmalloc_node\|vzalloc_node\)(...)
>
>  //----------------------------------------------------------
>  //  For patch mode
> @@ -99,9 +97,8 @@ type r1.T;
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
>     dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> -   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> -   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> -   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
> +   vmalloc_node\|vzalloc_node\)(...)
>
>  //----------------------------------------------------------
>  //  For org and report mode
> @@ -116,9 +113,8 @@ position p != {m1.p1,m2.p2};
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
>     dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> -   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
> -   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
> -   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> +   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
> +   vmalloc_node\|vzalloc_node\)(...)
>
>  @script:python depends on org@
>  p << r2.p;
> --
> 2.43.0
>
>
