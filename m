Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5140C43217
	for <cocci@archiver.kernel.org>; Mon,  7 Nov 2022 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9KonJ34QfgPDfIJuoNhPmpY9xXFmGAUYSZ6OQb3Nbz4=;
  b=dOT9lM5gcIlPUxgOFE102F6LOfjddjWD3onvZKkbzjObxvCInD0voAo8
   kqdHKDvbJ30ZHjNmVbGod8Yobr+UxyFnsqR+y9GPrVDcHnQrKCcOYhfZe
   YxmBEEppHFaKwuXB8nDWjwZTB3nOnVijxLtbGS8nJTv6ZrpvF4iefL2gp
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,143,1665439200"; 
   d="scan'208";a="77014510"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2022 13:45:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98208E0157; Mon,  7 Nov 2022 13:45:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BCD30E0157
	for <cocci@sympa.inria.fr>; Mon,  7 Nov 2022 13:45:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9KonJ34QfgPDfIJuoNhPmpY9xXFmGAUYSZ6OQb3Nbz4=;
  b=VO74rI2qk2scUtuYWLPgR3k2KR2nd1LZ/T9tZva03BZmyfSKUV7ib9yj
   sSNR4+zSFDku15GSJdjiRpnjaV7yaC0s04zi/34SHbflnGEGNI3tLtWiD
   k77np/px48QkI3wbWl61W5iDwaM0WSfo1Y3Dc1Rp6ITFAT4c58vxblmDf
   s=;
X-IronPort-AV: E=Sophos;i="5.96,143,1665439200"; 
   d="scan'208";a="77014486"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:45:43 +0100
Date: Mon, 7 Nov 2022 20:45:38 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, 
    cocci@inria.fr, kernel@pengutronix.de
In-Reply-To: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
Message-ID: <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-169836557-1667825144=:3632"
Subject: Re: [cocci] [PATCH v1] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 718
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/28e17fb9-cec1-4a89-1492-cd3ece7a9487%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-169836557-1667825144=:3632
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 7 Nov 2022, Uwe Kleine-König wrote:

> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
> the shorter devm_platform_ioremap_resource(pdev, index).
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> a potential improvement is to check for invocations of
> devm_platform_get_and_ioremap_resource() where the res parameter isn't
> used afterwards, but my coccinelle foo isn't strong enough for that.

... when != res

I'm not sure where you wanted to put it though.

julia

>
> Best regards
> Uwe
>
>  .../api/devm_platform_ioremap_resource.cocci  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
>
> diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> new file mode 100644
> index 000000000000..401610b9a17d
> --- /dev/null
> +++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Don't use devm_platform_get_and_ioremap_resource with NULL as third parameter
> +// Confidence: High
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r1@
> +position p;
> +@@
> + devm_platform_ioremap_resource(...) {
> +	...
> +	devm_platform_get_and_ioremap_resource@p(...)
> +	...
> + }
> +
> +@depends on patch@
> +expression pdev,index;
> +position p != r1.p;
> +@@
> +
> +-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
> ++  devm_platform_ioremap_resource(pdev, index)
> +
> +@r2 depends on !patch exists@
> +expression pdev,index;
> +position p;
> +@@
> +
> +*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
> +
> +@script:python depends on org@
> +p << r2.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource", p)
> +
> +@script:python depends on report@
> +p << r2.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_ioremap_resource")
> --
> 2.38.1
>
>
--8323329-169836557-1667825144=:3632--
