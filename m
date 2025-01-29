Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76960C0218F
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cJ9d+E1dSYsxptXRTXBxxtRku+LQhMlnWswfyOTmi6c=;
  b=X/Pkg0Xw76N9ZM4stNLTDrzHVjDHHW3n/5nTkirvhFykgvrGU9JTHyr+
   S1gbdMym7lS6e1PxMAJHLi9F1z22fh/btj7hCWgdMQfi0IGfUpq3dCm3X
   n3OlZHAZl4WqJM7maDmzZgw0V90XpgyopIuYrjtch9/GfFu0zXc20gKMF
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="205646131"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 18:38:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1F53E0D21; Wed, 29 Jan 2025 18:38:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 756A6E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 18:38:38 +0100 (CET)
IronPort-SDR: 679a679d_fulYQ8Z2Xj7r3WmKqPbsAqpn774QgmzU9gDjMegp/Vhnfof
 j4ToIzVFPg9KNkwPIm5bUPpWSIPqJFqbI5KXnTQ==
X-IPAS-Result: =?us-ascii?q?A0EBAACqZppnhbaaTQ1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYJDgVczBwhIhFaIHYlTAxOBAIpgk?=
 =?us-ascii?q?iSBQD4PAQMBTgECBAEBAwSFAAKKdQIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJFENSAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARECDV4BAR4BAQEDERIdAQE3AQ8LGAICJgICVgYTAgEBg?=
 =?us-ascii?q?n6CZQYCpCsBh2ABAQKKKXqBMoEBggwBAQbcH4FkCYEaLgGITQGGL4QzJxuBS?=
 =?us-ascii?q?USBFScOgQaBNzg+aYNvg0aCaYIzgUQvg0ChQFJ7HANZLAFVExcLBwWBKUgDg?=
 =?us-ascii?q?REjgSYFNUE6gg1pSToCDQI1gh58gR2BDmsEBYEtgjuERYRRhVuCFIFlAwMWE?=
 =?us-ascii?q?AGDJ3gcgjgdQAIBC209NwkLG0OdbjyEA3sTgkALkxgdkUVrgTSfT4QloUsGD?=
 =?us-ascii?q?wQvl1iSey6HZJBqo0qFMoIYOoFcRgcjFYMiTwMZD44hGYNhygUiNTwCBwsBA?=
 =?us-ascii?q?QMJhUYBAYpPgUsBAQ?=
IronPort-PHdr: A9a23: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
 QQxkQxwfaIm8zK+uz8K
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:mexU2ay80Mr9lmxmQ4jwKrPwHL1zdoMgy1knxilNoNJuEvBw5P
 re+8jzsiWE8Ar5OUtQ4OxpWsG7K080kKQZ3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXY+EYT2IK6PoSizPIcOrIruP3kpxAyd2+80tQ
X-Talos-CUID: =?us-ascii?q?9a23=3Ap24hpWnCFlnF1G1gEJcTXdJfKIDXOUH30GjwKWK?=
 =?us-ascii?q?VMmlwC7CXc3iT9aUnnPM7zg=3D=3D?=
X-Talos-MUID: 9a23:l2bVCAiD0D9CDCDIGzpa68MpN9g1zq/3Ihg3z7ICpvLYFjJiHwfDg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="107689078"
X-MGA-submission: =?us-ascii?q?MDHwQ5IKfJ+GF5LLfEc8NYd8z7/6c3FfiVHNyZ?=
 =?us-ascii?q?rdTvB+FxAQ23ZnoxsLXkjEM+lDzVYfIzOsmM5I/FuG1VJr2Qu+4aZbFJ?=
 =?us-ascii?q?fpVXeqL8w5X5qdJnnyvtrQ4wVw+8hP3N4iSEjvxjx7od0licasaAKqP2?=
 =?us-ascii?q?nugEJ2jjpWRW6wF0XliPyIfA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 29 Jan 2025 18:38:37 +0100
Received: from [100.65.98.224] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4F5C2066C19;
	Wed, 29 Jan 2025 09:38:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4F5C2066C19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738172316;
	bh=cJ9d+E1dSYsxptXRTXBxxtRku+LQhMlnWswfyOTmi6c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cka0X3ia5zuKwc49NhO3HaYx1RAPzX2iRa1EYwvFydXDPmAA9IegmYFa2wPEz8amY
	 DYdpS76JZiBrUp4Jy11PFVBeTL32p/wRw54zjg0GfQlgNDmjLyYE9WYtEU3rpCoon6
	 jMEytwbHb7HAzb6KrCubUrhxJ6kdzGxyecCT7eeE=
Message-ID: <aeacb653-efb8-42ed-a7ed-3e7be31b8f9d@linux.microsoft.com>
Date: Wed, 29 Jan 2025 09:38:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Andrew Morton <akpm@linux-foundation.org>, eahariha@linux.microsoft.com,
 cocci@inria.fr, linux-kernel@vger.kernel.org
To: Ricardo Ribalda <ribalda@chromium.org>
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies script:
 Create dummy report
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2314
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/aeacb653-efb8-42ed-a7ed-3e7be31b8f9d%40linux.microsoft.com>

On 1/29/2025 12:06 AM, Ricardo Ribalda wrote:
> When running cocci in report mode, eg:
> $make coccicheck M="$dir" MODE=report
> 
> It returns this error:
> virtual rule report not supported
> coccicheck failed
> make: *** [Makefile:251: __sub-make] Error 2
> 
> Create a dummy rule to avoid this error and run the other cocci scripts.
> 
> Fixes: 551dbd1ec7ff ("coccinelle: misc: add secs_to_jiffies script")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  scripts/coccinelle/misc/secs_to_jiffies.cocci | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> index 8bbb2884ea5d..2d85dca16418 100644
> --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -10,6 +10,7 @@
>  //
>  
>  virtual patch
> +virtual report
>  
>  @depends on patch@ constant C; @@
>  
> @@ -20,3 +21,8 @@ virtual patch
>  
>  - msecs_to_jiffies(C * MSEC_PER_SEC)
>  + secs_to_jiffies(C)
> +
> +// Dummy rule for report mode that would otherwise be empty and make spatch
> +// fail ("No rules apply.")
> +@script:python depends on report@
> +@@
> 

Sorry about that, and thanks for the patch!

FWIW,

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
