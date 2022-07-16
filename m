Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E856DC433EF
	for <cocci@archiver.kernel.org>; Sat, 16 Jul 2022 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MwH9K92hQ9GopCmpbiXeve6TLbY3YJb/kuoiWq4tAwI=;
  b=j57YZtF/uKXgUy17daF1Jsy1fwFxvv0zzOiL9+6T/Bx46WlxyqBBwMUR
   SzRLaXfkb9pchmel9uH7ilnAoCMI0bm85K+6xvR78EEcGNdXPcaHnvQdq
   uASp/CQUkD3xv4SpSVv/zie7uvZqjq9/0Dg3XvNSMA5Az2bMae6uiCdwZ
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.92,277,1650924000"; 
   d="scan'208";a="45763039"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jul 2022 15:39:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3A17E0261; Sat, 16 Jul 2022 15:39:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 45786E0260
	for <cocci@sympa.inria.fr>; Sat, 16 Jul 2022 15:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MwH9K92hQ9GopCmpbiXeve6TLbY3YJb/kuoiWq4tAwI=;
  b=uviYBdKEhnAJ7WgPcWiT28v40TJOkiy8Dsc2hKvVFwKrMhmpx/9kZG/y
   31BAFlJ6wavxVvLcRBVMV3J2AI+Tyk0U0Palgv9v8CeU02o+8qbzlS3pB
   ROvaKkXVUJo5kZKh4pv1JnPu6C1HEAQ05O33yEjAdvQWfefwIc2TH08OY
   s=;
X-IronPort-AV: E=Sophos;i="5.92,277,1650924000"; 
   d="scan'208";a="19465409"
Received: from 150.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.150])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 15:38:55 +0200
Date: Sat, 16 Jul 2022 15:38:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ziyang Xuan <william.xuanziyang@huawei.com>
cc: nicolas.palix@imag.fr, cocci@inria.fr, fabf@skynet.be
In-Reply-To: <20220616013253.520310-1-william.xuanziyang@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2207161538100.3842@hadrien>
References: <20220616013253.520310-1-william.xuanziyang@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] scripts/coccinelle/free: add NULL test before
 dev_{put, hold} functions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 496
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207161538100.3842%40hadrien>



On Thu, 16 Jun 2022, Ziyang Xuan wrote:

> Since commit b37a46683739 ("netdevice: add the case if dev is NULL"),
> NULL check before dev_{put, hold} functions is not needed.

Applied.

I also added a Version min comment to indicate that this only applies
starting in v5.15.

julia


>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  scripts/coccinelle/free/ifnulldev_put.cocci | 54 +++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 scripts/coccinelle/free/ifnulldev_put.cocci
>
> diff --git a/scripts/coccinelle/free/ifnulldev_put.cocci b/scripts/coccinelle/free/ifnulldev_put.cocci
> new file mode 100644
> index 000000000000..7ff36e6212ba
> --- /dev/null
> +++ b/scripts/coccinelle/free/ifnulldev_put.cocci
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Since commit b37a46683739 ("netdevice: add the case if dev is NULL"),
> +/// NULL check before dev_{put, hold} functions is not needed.
> +///
> +/// Based on ifnullfree.cocci by Fabian Frederick.
> +///
> +// Copyright: (C) 2022 Ziyang Xuan.
> +// Comments: -
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual org
> +virtual report
> +virtual context
> +
> +@r2 depends on patch@
> +expression E;
> +@@
> +- if (E != NULL)
> +(
> +  __dev_put(E);
> +|
> +  dev_put(E);
> +|
> +  dev_put_track(E, ...);
> +|
> +  __dev_hold(E);
> +|
> +  dev_hold(E);
> +|
> +  dev_hold_track(E, ...);
> +)
> +
> +@r depends on context || report || org @
> +expression E;
> +position p;
> +@@
> +
> +* if (E != NULL)
> +*	\(__dev_put@p\|dev_put@p\|dev_put_track@p\|__dev_hold@p\|dev_hold@p\|
> +*         dev_hold_track@p\)(E, ...);
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +cocci.print_main("NULL check before dev_{put, hold} functions is not needed", p)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg = "WARNING: NULL check before dev_{put, hold} functions is not needed."
> +coccilib.report.print_report(p[0], msg)
> --
> 2.25.1
>
>
