Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AC8C61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KCb6WS8JOpbliQYVXpb9uAUS8LRp8Yteq2Aeu8n+8A8=;
  b=qRliebl03mif9LZsDuIOMqlzOyOWkvifAjzvrRmlPtaDXF3/SC81bASh
   RepNNczr6i0DuMi7KFDm3qfIAB1Ch8joh0XtWbTaiRwF66tFU3VSDjMEx
   FyFUkGLHq33VrKliherzAmVU/YCbIOUCnAMQqPXmQXS0duLIxwsR4lFGt
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@imag.fr
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226895849"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1056E0CCE; Thu, 12 Jun 2025 15:49:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 555C1E0131
	for <cocci@sympa.inria.fr>; Thu,  5 Jun 2025 19:43:21 +0200 (CEST)
IronPort-SDR: 6841d738_BSScNUoF6lPYBK7u5BpGcSHisjFR9hFh1MbX+2LmzCv7Gqu
 BD013Y64BS7rTON+IGlFZrdaQEIzE+3VwmHOXqw==
X-IronPort-AV: E=Sophos;i="6.16,212,1744063200"; 
   d="scan'208";a="118343360"
X-MGA-submission: =?us-ascii?q?MDEpnpugUJ/5dYoJXRLiiAYtD3qYcbI9tsNnYL?=
 =?us-ascii?q?6E567BhFBrUjXnDSYuwustRZFkl1kiDxJ4+pa/0hrjSI8vydJZwpt6Sm?=
 =?us-ascii?q?Ik9fxGZoXtENylCg/eG3XQpBymoftKMQ3nR6XvMayxEVzLXsMhGIgPaV?=
 =?us-ascii?q?mESqagIPB/UOpUvIVJZgbSIw=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 19:43:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
	t=1749145400; bh=477VCimCiTfccZ61itzmeWM2c2Jc7goY4wvB2OQY1l0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K8gyncPrqZOaj4hsIUmtg0P6S97JUBctmO+QyxeJaiAltO589Sdg4mBrERLp+Cgfc
	 y829XuKBvHeEJ8RZLEshyWVLqP/hqtoVOYY1ozdPpyUxL5eldWjzopDoDvElsSx7CA
	 14E/M64xDcI+Xzeha3q5zHDrIolw352D7xIcVH/Ly90sauoOJ0lzemuOgSmBD4zjsH
	 9CaSHFqZlNhGKy+Qlh1IeeFnkc5fZLUyTUi/X5FKI4YPYu8MoAzVvTgTseb4quh6tV
	 lBYMjSadeRxHmVupIK6rOPKGhHUPwdWpWOMIkWa0UoXcr1vuCw3J40X/Ce3Gdd6NQp
	 MT7iIFv+6E59g==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id A59C94029E;
	Thu,  5 Jun 2025 19:43:20 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
	by mailhub-1.u-ga.fr (Postfix) with ESMTP id A2290FF853;
	Thu,  5 Jun 2025 19:43:20 +0200 (CEST)
Received: from [192.168.1.87] (unknown [87.89.124.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 335B71400A2;
	Thu,  5 Jun 2025 19:43:20 +0200 (CEST)
Message-ID: <e8221cc5-cf5b-49f8-871d-e49d6621fc6e@imag.fr>
Date: Thu, 5 Jun 2025 19:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Songwei Chai <quic_songchai@quicinc.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 quic_jinlmao@quicinc.com
References: <20250605044405.2057511-1-quic_songchai@quicinc.com>
Content-Language: en-US, fr
From: Nicolas Palix <nicolas.palix@imag.fr>
Organization: LIG
In-Reply-To: <20250605044405.2057511-1-quic_songchai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (41)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v1] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Nicolas Palix <nicolas.palix@imag.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2765
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/e8221cc5-cf5b-49f8-871d-e49d6621fc6e%40imag.fr>

Hi Songwei,

Le 05/06/2025 à 06:44, Songwei Chai a écrit :
> Enhance the coccicheck script to filter *.cocci files based on the
> specified MODE (e.g., report, patch). This ensures that only compatible
> semantic patch files are executed, preventing errors such as:
> 
>      "virtual rule report not supported"
> 
> This error occurs when a .cocci file does not define a 'virtual <MODE>'
> rule, yet is executed in that mode.

I am fine with the idea even if the orignal idea was to be exhaustive in 
the implementation of the mode in each SP.

However, silently discarding the patch is maybe not what one would 
expect as the considered SP will vary according to the mode.

Hence, could I suggest to add an else branch reporting a warning at least ?

Regards,

> 
> For example:
> 
>      make coccicheck M=drivers/hwtracing/coresight/ MODE=report
> 
> In this case, running "secs_to_jiffies.cocci" would trigger the error
> because it lacks support for 'report' mode. With this change, such files
> are skipped automatically, improving robustness and developer experience.
> 
> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
> ---
>   scripts/coccicheck | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 0e6bc5a10320..18a69edcea66 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -270,7 +270,9 @@ fi
>   
>   if [ "$COCCI" = "" ] ; then
>       for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
> -	coccinelle $f
> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
> +	        coccinelle $f
> +        fi
>       done
>   else
>       coccinelle $COCCI
> 

