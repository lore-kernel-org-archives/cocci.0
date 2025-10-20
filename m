Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1AECCD199
	for <cocci@archiver.kernel.org>; Mon, 20 Oct 2025 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=F7SQR9eNbNCAD7rLP+Q07KyKtgqbnj/0w+1/RkqAeVo=;
  b=KOsozuFxeRtDQkBJKxAil3lTVmKOyvvgL8B3qMd223st4jirBIfoDFFx
   IRJ+7CA5QrvgSR/vs7K6lhB0BryApULMvybk5aVXqvF7M4GNPjNVrE0A8
   anE/EopGFQtt4d7QOpUqAvM1Ps2+qP4jv9ousamdgqigjtLO5HMSEhv8s
   4=;
X-CSE-ConnectionGUID: PPhMiFvlSTayVjmELQ3D7w==
X-CSE-MsgGUID: nmUK+wmMS72Fk9zxGrtPRg==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,242,1754949600"; 
   d="scan'208";a="245230449"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2025 13:55:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BBF39E0C55; Mon, 20 Oct 2025 13:55:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C65CE0171
	for <cocci@sympa.inria.fr>; Mon, 20 Oct 2025 13:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F7SQR9eNbNCAD7rLP+Q07KyKtgqbnj/0w+1/RkqAeVo=;
  b=MWppHG0sMYJytcT3VbERB3kUJybAwFbwoYXn3G9lTbsvKoKpkyVGBOxk
   4f0m/ZMwqD/GBUvRuyHmssjz/OEhXSc8DNdT4gu3LbztOvMeeQG0YXAsP
   ZRxhK00cGK4E2x1ELwehyYq+w/bpeYDnFjsxuX8quLl86F3zxZTR7UwgU
   M=;
X-CSE-ConnectionGUID: D2WPmbZFTu6YbDHuIt62Lw==
X-CSE-MsgGUID: Ml/iJ/hFSkWfJJFQpo8FMg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754949600"; 
   d="scan'208";a="245230437"
Received: from unknown (HELO hadrien) ([202.187.235.241])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 13:55:33 +0200
Date: Mon, 20 Oct 2025 19:55:31 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Geert Uytterhoeven <geert+renesas@glider.be>
cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Andrew Morton <akpm@linux-foundation.org>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
Message-ID: <a6974374-f24f-e677-74b-201de69862e1@inria.fr>
References: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: of_table: Update Keywords for SPI
 device ID tables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3090
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/a6974374-f24f-e677-74b-201de69862e1%40inria.fr>



On Tue, 14 Oct 2025, Geert Uytterhoeven wrote:

> When adding support for SPI device ID tables, the keywords in the header
> were not updated.
>
> Fixes: 347b564599fb01d8 ("coccinelle: of_table: handle SPI device ID tables")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>


> ---
>  scripts/coccinelle/misc/of_table.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
> index 7ade9766dee89c70..9de406b692a590ba 100644
> --- a/scripts/coccinelle/misc/of_table.cocci
> +++ b/scripts/coccinelle/misc/of_table.cocci
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /// Make sure (of/i2c/platform)_device_id tables are NULL terminated
>  //
> -// Keywords: of_table i2c_table platform_table
> +// Keywords: of_table i2c_table platform_table spi_table
>  // Confidence: Medium
>  // Options: --include-headers
>
> --
> 2.43.0
>
>
