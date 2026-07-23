Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD3C531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HKOpKrXMKalCtRmZui9w1egs82pTtvh6125mPB+gO/Q=;
  b=aAuQhnP++rJt1OlRmU8a+jEIrvDk5On/c7ZgSSsj8F7HvrJiS045yOJB
   XmDp7K6lM+MppioYCqTK54rqPyAuiOCeVD/2j9sg5D6OnYFraelLuXWKS
   /BeqdwWRRv27F5m3YJ0ymIPYlIOSyc+J6kyUuZA/jU+xXvp3rGNBIVGrC
   c=;
X-CSE-ConnectionGUID: dVBgOgrsQK6KfwIIYGp+8A==
X-CSE-MsgGUID: bmL8TDKiTQ+u/QNHmmgbAw==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734370"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:52 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 16DE5803EC; Fri, 24 Jul 2026 10:54:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8E34680642
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 21:44:31 +0200 (CEST)
X-CSE-ConnectionGUID: m9kaNQgUT4+dvYN/mMQRvg==
X-CSE-MsgGUID: M0xam6uHR7S2lZVqj/4rFg==
IronPort-SDR: 6a626f1e_TniIV9pTgS83zDkZ9JQ2sxdUyfrdjhvopRF/qtwCJlQ4BDG
 /VQqndIESr7rt18lgfCpJT34jQmuqAWLh0hdlMw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GVAQCGbmJqhWxxbUFaglmBblOBCl8zBAtJhFiIeoZYg?=
 =?us-ascii?q?iSCPQGJJpI3gXwCDwEDAQ09EgIEAQEBAgEDgUoBgzMCjWACHgcBBDAJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBQEmGTw2CY?=
 =?us-ascii?q?gEzcXQwASoCDX4BAQEDIwQZAQE3AQ8LGAICJgICIDYGE4MCAYIiBxEDNwMBE?=
 =?us-ascii?q?MJ+fzOBAYIMAQEG2zINcoFpAwYUAYEKLog8IAGFd4QCeicbgUlEhEA+gh8rh?=
 =?us-ascii?q?VSCaoImgQySLlJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFh5YGwcFE?=
 =?us-ascii?q?iAqQUUjA0EmEDgLQwWBVgKBeD8jHwM5f4EvdUp3LWkBAhAXSjgkg0kCgTcDC?=
 =?us-ascii?q?209NxQZjyIjgkABgQ0sgX2mJaAecYI/gWiMIY8+hXxNl18CkwuZCI4KhAmXM?=
 =?us-ascii?q?IFDJTqBXDMaCBwUgyISPgMZD446hByEYMceJDU+AQcCBw8CgXODW4wnLQWBT?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjxw==
IronPort-HdrOrdr: A9a23:5JUn162k02AC/L9efdFKewqjBI8kLtp133Aq2lEZdPU0SKGlfg
 6V7ZYmPDvP+U4ssRAb6Km90cy7Lk80mqQV3WB8B9eftUzdyRCVxeJZnO3fKl/baknDH4dmvM
 8KH8ZD4Z/LfD9HZK3BkWyF+rgbsbq6GX+T79vj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3A7W6ATGoevGq3VQGZeCDijSnmUcV0cXT79XjtHxP?=
 =?us-ascii?q?7BXhYbvqQbGaq5qwxxg=3D=3D?=
X-Talos-MUID: 9a23:qeM5Gwv2nYZt/44HN82noWlyPcI2/oSUV3tXlac4osvDaTZeNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152817720"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHXHOycA4zB/hVeqUF9ZojdB1E0EaViKKt8Sf?=
 =?us-ascii?q?X4q7JqOTcfXJ7BhkjOkBeurxXMgBT9d89aSrkJjLs74k7ZrhtdHgf4se?=
 =?us-ascii?q?pqRqolbQhEgwWPO91HVRQihxQZRSaKL0LiCWFX6JyCZHHYFzwue+324W?=
 =?us-ascii?q?QKZK7QNM9xxpBGDh/eMPgDnA=3D=3D?=
Received: from mail.alien8.de ([65.109.113.108])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 21:44:31 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5F9140E014C;
	Thu, 23 Jul 2026 19:44:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C6EJLK6xjcRB; Thu, 23 Jul 2026 19:44:19 +0000 (UTC)
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0949740E00DC;
	Thu, 23 Jul 2026 19:44:10 +0000 (UTC)
Date: Thu, 23 Jul 2026 12:44:07 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Yazen Ghannam <Yazen.Ghannam@amd.com>,
	Tony Luck <tony.luck@intel.com>, cocci@inria.fr,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20260723194407.GDamJvBzzMfuyu-NTQ@fat_crate.local>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-28-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-28-ekffu200098@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 27/36] RAS/AMD/ATL: remove conditional return
 with no effect
Reply-To: Borislav Petkov <bp@alien8.de>
X-Loop: cocci@inria.fr
X-Sequence: 3635
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/QUg1m5_4ZJH_5olfRa8apg>

On Fri, Jul 24, 2026 at 03:45:29AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/ras/amd/atl/map.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
> index 24a05af747d5..4ec9333ef745 100644
> --- a/drivers/ras/amd/atl/map.c
> +++ b/drivers/ras/amd/atl/map.c
> @@ -771,9 +771,5 @@ int get_address_map(struct addr_ctx *ctx)
>  
>  	dump_address_map(&ctx->map);
>  
> -	ret = validate_address_map(ctx);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return validate_address_map(ctx);
>  }
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
