Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ED3C5B549
	for <cocci@archiver.kernel.org>; Fri,  6 Jun 2025 07:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qVVrpG48yuZqf0eYBT0/zjA8F6zUQL/OyDtqbl1skaY=;
  b=psR/+tDRMyOWEpDCOuPW0/45JLaX3T7eXX4xVP0Xwd4MdW+gFP7bDjWq
   C3HXX9+SsYtkoz4nJU5ZxkvIp262ubG+59ouihuNvr9XgCM0bAYzvDXz8
   zgG/pXO4ybfLgzeGYJAj2rgk74qjhNnxyh+xl7NaXD2GIALmUFSeSCppT
   U=;
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
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="225594117"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jun 2025 09:26:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8777BE02E4; Fri,  6 Jun 2025 09:26:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 93C58E0131
	for <cocci@sympa.inria.fr>; Fri,  6 Jun 2025 09:26:07 +0200 (CEST)
IronPort-SDR: 6842980f_skxVpqFfqhJQOhGhMjFdPtbdGaLuWdHRx/9QjwF9Qx/op5t
 f3k475fm6wu8+bXpQ2TOBhnd7EMdVp+X4xevrKg==
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="118372368"
X-MGA-submission: =?us-ascii?q?MDEJRloQH49gHenHmJx0H7jX3SZQncSaGhJGFb?=
 =?us-ascii?q?6UnTCbq/aoezd9rUfDFLetDNSMIQFDdmk0exyhVofz0j/Jr8NJt0AU9O?=
 =?us-ascii?q?Vgkq1BlbADtETqehQry4hU2iq/kwCixOLNKxTZ9buDzCwt/kctZ5aW6H?=
 =?us-ascii?q?YwLOkTvUfzN7Vhm0U5bjqehQ=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 09:26:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
	t=1749194766; bh=pqT/dZ8MQ0553PB7mS7ex1pcWsm6e5wUh41kLMj5oW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgjqmxcQUaC8STOfd05tri/ZpoCR6dXHcIFeB+IlqgFllZUC/Ja9D2cCHQMUDGt3x
	 uGblyaNgzXZ11GW1IKy1oWvaAasgdqQLy3z1IulIv8LFjRXYLQ2uj7onb653nDae3t
	 /2F7h5frzzy2V0G2LFSOiirHEwv9KPrf4cV9eI9YHsudCxp+2AAIQv1NGAIKUyDS3f
	 TlsU37XTpyRWaPZ3HWPbzNeQgSlP4hWMI0MjKuKGhTwW/Gt3y4JhlkaviSi7kcbu1I
	 s3h17m5prx9P0lZCenY5NABvON9g/5o+1+SuVk6PlrGBfqmMP3Ujl3fmd9BrN6PXAQ
	 sZKJhAC4S+46A==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id E564440225;
	Fri,  6 Jun 2025 09:26:06 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
	by mailhub-2.u-ga.fr (Postfix) with ESMTP id D842BFF993;
	Fri,  6 Jun 2025 09:26:06 +0200 (CEST)
Received: from [129.88.53.236] (erods-yttrium2.imag.fr [129.88.53.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id B4BDA1400A2;
	Fri,  6 Jun 2025 09:26:06 +0200 (CEST)
Message-ID: <54b6e30f-a194-4f5f-9df4-5df0d3d4d738@imag.fr>
Date: Fri, 6 Jun 2025 09:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Songwei Chai <quic_songchai@quicinc.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 quic_jinlmao@quicinc.com
References: <20250606060936.2756980-1-quic_songchai@quicinc.com>
Content-Language: en-US, fr
From: Nicolas Palix <nicolas.palix@imag.fr>
Organization: LIG
In-Reply-To: <20250606060936.2756980-1-quic_songchai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (41)
Subject: Re: [cocci] [PATCH v2] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Nicolas Palix <nicolas.palix@imag.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2749
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/54b6e30f-a194-4f5f-9df4-5df0d3d4d738%40imag.fr>

Le 06/06/2025 à 08:09, Songwei Chai a écrit :
> Enhance the coccicheck script to filter *.cocci files based on the
> specified MODE (e.g., report, patch). This ensures that only compatible
> semantic patch files are executed, preventing errors such as:
> 
>      "virtual rule report not supported"
> 
> This error occurs when a .cocci file does not define a 'virtual <MODE>'
> rule, yet is executed in that mode.
> 
> For example:
> 
>      make coccicheck M=drivers/hwtracing/coresight/ MODE=report
> 
> In this case, running "secs_to_jiffies.cocci" would trigger the error
> because it lacks support for 'report' mode. With this change, such files
> are skipped automatically, improving robustness and developer
> experience.
> 
> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> ---
>   scripts/coccicheck | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 0e6bc5a10320..89d591af5f3e 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -270,7 +270,11 @@ fi
>   
>   if [ "$COCCI" = "" ] ; then
>       for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
> -	coccinelle $f
> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
> +                coccinelle $f
> +        else
> +                echo "warning: Skipping $f as it does not match mode '$MODE'"
> +        fi
>       done
>   else
>       coccinelle $COCCI
> 

