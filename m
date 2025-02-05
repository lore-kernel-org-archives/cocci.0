Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E38C02194
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2025 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=itgBDC2ytdn3pApg+pHXH0qGhVL8pA2oRw6633a5lAI=;
  b=XicoBLo1FRMRxLfGtyYVr8tjNicAG36/4v9EVtuvege7iB0sR21e4TI+
   y5M7h/bqeP38UZZoHmOjPRnJCpo6glnAaTbj8pGcDWs4vQbYYNtpr0ZNt
   gadva7IhYG4grf5CsNCABXxMGa3LBUiG7M1qMuL3k6TfO+MKMfLYT+vzh
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206751303"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Feb 2025 15:36:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99D29E0D1D; Wed,  5 Feb 2025 15:36:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ABFCBE0260
	for <cocci@sympa.inria.fr>; Wed,  5 Feb 2025 15:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=itgBDC2ytdn3pApg+pHXH0qGhVL8pA2oRw6633a5lAI=;
  b=OthwYV5wrElKxcU5ZzK55lkxWqcJr2FwvnedSBKAOTKkwRxKFoq92Yt5
   Q0nt+fykWP9tIpdTWySA2aWO1Hzl/aORwpFmfm7Y3KD/N8taGfDnDqGZH
   szkQAn+uGcj3L79tlOtjStzc2JuZW2xukWRLcScNTsfyyMRwQw6ilWOGI
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206751283"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 15:36:36 +0100
Date: Wed, 5 Feb 2025 15:36:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Geert Uytterhoeven <geert+renesas@glider.be>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, Rob Herring <robh@kernel.org>, 
    Saravana Kannan <saravanak@google.com>, 
    Wolfram Sang <wsa+renesas@sang-engineering.com>, cocci@inria.fr, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f4d11c2e43697681678cf3fe0b2781bcd3bf3884.1738765482.git.geert+renesas@glider.be>
Message-ID: <6abd97ee-b9fe-d2eb-4486-b1c43efc0e5@inria.fr>
References: <f4d11c2e43697681678cf3fe0b2781bcd3bf3884.1738765482.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH/RFC v2] coccinelle: of_table: Do not add commas
 after sentinels
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2350
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/6abd97ee-b9fe-d2eb-4486-b1c43efc0e5%40inria.fr>



On Wed, 5 Feb 2025, Geert Uytterhoeven wrote:

> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.  Hence do not add the comma
> when adding the sentinel.
>
> Include the comma after the previous entry, else it will appear after the
> sentinel.
>
> Add a comment to clarify the purpose of the empty element.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add devicetree people.
>
> This is a patch I wrote last year.
> My original intention was to create a Coccinelle script to remove
> commas after sentinels, and annotate them, to automate the creation of
> patches like commit 0256b6aeee11d705 ("pinctrl: renesas: Annotate
> sentinels in tables").  Unfortunately I could not get that work (blame
> it on this being my first experiment with Coccinelle).  Hence I gave up,
> and instead settled for adapting the existing script to not add these
> commas in the first place...
>
> Known issues:
>
>   1. This generates patches like:
>
> 	+	{/* sentinel */}
>
>      while I would prefer to see:
>
> 	+	{ /* sentinel */ }
>
>      Is there a way to do that, or should I just post-process the
>      generated patches?

Try running with --smpl-spacing.

julia

>
>   2. If the array contains a "{ NULL }" element, this is still flagged
>      as a missing sentinel:
>
> 	-	{ NULL }
> 	+	{ NULL },
> 	+	{},
>
>      Note that this is a pre-existing issue.
> ---
>  scripts/coccinelle/misc/of_table.cocci | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
> index 4693ea7447534144..7ade9766dee89c70 100644
> --- a/scripts/coccinelle/misc/of_table.cocci
> +++ b/scripts/coccinelle/misc/of_table.cocci
> @@ -37,15 +37,14 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
>  	...,
>  	{
>  	.var = E,
> --	}
> -+	},
> -+	{ }
> +	},
> ++	{ /* sentinel */ }
>  };
>  |
>  struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
>  	...,
>  	{ ..., E, ... },
> -+	{ },
> ++	{ /* sentinel */ }
>  };
>  )
>
> --
> 2.43.0
>
>
