Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6FEC10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 05:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=eDGIBeLtVzLdSWFyq0jOnYuUG8IMcTzgPeUdQr6gA8g=;
  b=SjcOMfvX2KVI+QR5TOfjzCLb1mueJkT20S90GOgyxKiZKjxNUW0sQpbA
   POgrMFiV0wKHNxGH7mtv0HXs+Vl0w+KzNIVZUjsR84qvSRfGOzakdenPT
   0KL2/4TiPp6/FtDj7/BHh2nHlPSninhvKBuR18asYeY4yzUzgExrY+4gg
   g=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165223344"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 07:11:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 64800E0AF1; Sun, 12 May 2024 07:11:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BFEE4E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 07:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eDGIBeLtVzLdSWFyq0jOnYuUG8IMcTzgPeUdQr6gA8g=;
  b=HWTBo+46fsDFeEf9FubPtipj+OKeiiYhhHLDRTy4pRh+3gdBA4uHiPxW
   kaSUN3omWW1Aiqxhxk6Sj+2N9Mb/EW6Kjb0oRHwWGqt+WUueRNACXBRlv
   ohqKsJxJGZF9zu1ntHLuceyKL6L5RBwnWhASrRJGIBChscHNmNzcYQfWg
   U=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165223343"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 07:11:34 +0200
Date: Sun, 12 May 2024 07:11:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thorsten Blum <thorsten.blum@toblux.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20240511213117.2710-3-thorsten.blum@toblux.com>
Message-ID: <alpine.DEB.2.22.394.2405120711250.3457@hadrien>
References: <20240511213117.2710-3-thorsten.blum@toblux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] Coccinelle: pm_runtime: Fix grammar in comment
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1721
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405120711250.3457%40hadrien>



On Sat, 11 May 2024, Thorsten Blum wrote:

> s/does not use unnecessary/do not unnecessarily use/

Thanks.

>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  scripts/coccinelle/api/pm_runtime.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
> index 4b9778874453..2c931e748dda 100644
> --- a/scripts/coccinelle/api/pm_runtime.cocci
> +++ b/scripts/coccinelle/api/pm_runtime.cocci
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/// Make sure pm_runtime_* calls does not use unnecessary IS_ERR_VALUE
> +/// Make sure pm_runtime_* calls do not unnecessarily use IS_ERR_VALUE
>  ///
>  // Keywords: pm_runtime
>  // Confidence: Medium
> --
> 2.45.0
>
>
