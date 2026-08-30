Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CE3C61DB9
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2026 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wKanZT1RXGv/VQBqsk2MRwPINnZZKd+OPyx386S5ZPc=;
  b=fltYHODDOXX52RcY1O1blDa1hu/cHcyZC81ISv4uP01XhmDM6jxvfwkB
   VEGEXJN4TQQtNKrP683DAzEqwlhvYA6bARS2uW6BWMKaQbhfrHPfZL2Je
   WQF2Tlohm6+vf5trJDIHPq8kIXSpTOky4QWGf1dlOlXiTWpMKc2EFsYjB
   s=;
X-CSE-ConnectionGUID: 2QiKxoRuTniorTKHxa23hQ==
X-CSE-MsgGUID: jJhxLWzgTZCAhQKx3hmIMg==
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
X-IronPort-AV: E=Sophos;i="6.25,252,1779141600"; 
   d="scan'208";a="292188251"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Aug 2026 14:10:10 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id ADBB08050F; Sun, 30 Aug 2026 14:10:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A16C380476
	for <cocci@sympa.inria.fr>; Sun, 30 Aug 2026 14:10:08 +0200 (CEST)
X-CSE-ConnectionGUID: XVaBxPN/QNagcr7ToBetSA==
X-CSE-MsgGUID: LolSKyHQQ1Wcg+mbWf+CSg==
X-IronPort-AV: E=Sophos;i="6.25,252,1779141600"; 
   d="scan'208";a="155404682"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 14:10:08 +0200
Date: Sun, 30 Aug 2026 14:10:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260823161826.3805598-6-ekffu200098@gmail.com>
Message-ID: <4d9d25-b8d1-6e5e-f1-d86396d6386c@inria.fr>
References: <20260823161826.3805598-1-ekffu200098@gmail.com> <20260823161826.3805598-6-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 5/7] coccinelle: kfree_mismatch: drop
 vmalloc_exec
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3724
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/eH3r16eF6q-IOqNMhrVYsA>



On Mon, 24 Aug 2026, Sang-Heon Jeon wrote:

> vmalloc_exec() was removed by commit 7a0e27b2a0ce ("mm: remove
> vmalloc_exec").
>
> So drop it from the rules.
>
> No functional change.

Applied.

>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  scripts/coccinelle/api/kfree_mismatch.cocci | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/coccinelle/api/kfree_mismatch.cocci b/scripts/coccinelle/api/kfree_mismatch.cocci
> index d46a9b3eb7b3..bc90d0c071ac 100644
> --- a/scripts/coccinelle/api/kfree_mismatch.cocci
> +++ b/scripts/coccinelle/api/kfree_mismatch.cocci
> @@ -29,7 +29,7 @@ position kok, vok;
>    } else {
>      ...
>      E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
> -          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
> +          vzalloc_node\|vmalloc_32\|
>            vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
>            __vmalloc_node\)(...)@vok
>      ...
> @@ -42,7 +42,7 @@ position kok, vok;
>    if (E == NULL) {
>      ...
>      E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
> -          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
> +          vzalloc_node\|vmalloc_32\|
>            vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
>            __vmalloc_node\)(...)@vok
>      ...
> @@ -68,7 +68,7 @@ position f != free.fok;
>  * E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
>  *       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
>  *       kcalloc_node\)(...)@a
> -  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
>        when != is_vmalloc_addr(E)
>        when any
>  * \(vfree\|vfree_atomic\|kvfree\)(E)@f
> @@ -82,7 +82,7 @@ position f != free.fok;
>    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
>          kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
>          kcalloc_node\)(...)@a
> -  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
>        when != is_vmalloc_addr(E)
>        when any
>  - \(vfree\|vfree_atomic\|kvfree\)(E)@f
> @@ -95,7 +95,7 @@ position f != free.fok;
>  @@
>
>  * E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> -*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +*       vmalloc_32\|vmalloc_32_user\|__vmalloc\|
>  *       __vmalloc_node_range\|__vmalloc_node\)(...)@a
>    ... when != is_vmalloc_addr(E)
>        when any
> @@ -108,7 +108,7 @@ position f != free.fok;
>  @@
>
>    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> -        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +        vmalloc_32\|vmalloc_32_user\|__vmalloc\|
>          __vmalloc_node_range\|__vmalloc_node\)(...)@a
>    ... when != is_vmalloc_addr(E)
>        when any
> --
> 2.43.0
>
>
