Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A30C61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:references:from:to:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FTHn6/xfwys+lrx2PwIo9Jrp/Uvzq79Fn9+PtwLxE5E=;
  b=ViHCqSJPwLlowkyICri7kXnpjkaMnP6oNyYnAO/UwP9pquD33lu/m4GR
   0GU/NbGyOEKd7zK6pjM4+HeMa2dYRtUZHgeVlpSPVT3A0XgnjbF6y99Zf
   U3E4/YiZPjDt3LXd3DZOI9/ztpDMuQ8kPFKtd6UXeJ9K6zGchqX7fjjMc
   A=;
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
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226896093"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C25A4E0D33; Thu, 12 Jun 2025 15:49:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D7DE7E0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 19:49:24 +0200 (CEST)
IronPort-SDR: 68487024_uYSYeMUesc2/9RRepzr8x8m6dp5imnpE+FG1rAWzOKPJuVg
 O/WEov3+Ggk6JOA41wTO5DH5Aol6VoF2M0fooKg==
X-IPAS-Result: =?us-ascii?q?A0EBAAC3bkhohbaaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgQBaMwcISQSEUYgciVUDi3SQTYFVFIEsP?=
 =?us-ascii?q?QIPAQMBUQoBAgQBAQMEhQACi2UCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQERAg1eAQEeAQEBAxESHQEBLAsBDwsOCgICJgICVgYBEgIBA?=
 =?us-ascii?q?YJ+AYIhB0YGAgydMgGHYAEBAoopeoEygQGCDAEBBtwjgWUDBoEbLgGITwGGB?=
 =?us-ascii?q?yAJglCBYycbgUlEgTwLA4I9OD5pgx1Sg0aCaYIoRFKKDZZ5UngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgEDMDKjQxI0sFLR2CDYItgmwfgXNwaQMDFg8BhAIchGKESStPgyKBA?=
 =?us-ascii?q?3xlQYNhHgZyDwctQAIBC209NwYDCxtDmHCDcIEOLIIzilyaGmufaoEhhCWMH?=
 =?us-ascii?q?ZU7Bg8EL5dfkwIuh2WQcSKLbIF5lXkYhG6CGjqBXEYHIxU7gmcTPAMZD44hG?=
 =?us-ascii?q?SWDQoUTsmQjNQIBOQIHCwEBAwmFRgEBiwOBSwEB?=
IronPort-PHdr: A9a23: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
 Z+qsmIG3gNodtkuIqLMYqFOywoJ7p8=
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:SsZM8KhTxgh+9L5R0MQDHXwyPXBQXuoji2hC6mlwRA09TyVXra
 CTdYcgpHvJYVEqKQkdcLG7SdC9qRG1z/RICOwqUItKMzOIhILFFvAG0WKm+UyHJ8SczIBgPM
 VbH5SWYeeYZTNHZITBkWuF+r0bsbq6Gc6T9IDjJjtWLD1XVw==
X-Talos-CUID: 9a23:p0IKXWyFUX39mrigQTP3BgUdRMkDbULc5U3PHB+nD3lbSLaZYwCfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AFVOilw+eGrN4bcGhFL3ERAmQf91j75aiLlpUqI0?=
 =?us-ascii?q?tvpbdaANCZ2eSvA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118689137"
X-MGA-submission: =?us-ascii?q?MDH3TCAZIPHCrMPH52u/hIkGMEU4Db/fY+p/Ej?=
 =?us-ascii?q?E2D8BBBsUWp5Hul8DmBjHW3dLxpaEFIpeZZsFPyoq/ONAFPKjTHmRGQz?=
 =?us-ascii?q?vS0QX+pviOrREuzCCJjWEC8mJ/N/gPG3AGZbToltB3wboywnowi7tuok?=
 =?us-ascii?q?HDfy9Q0Y0A6aq/9IHXQ8v0/A=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 10 Jun 2025 19:49:24 +0200
Received: from [100.65.129.218] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5AE8A2113091;
	Tue, 10 Jun 2025 10:49:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AE8A2113091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749577761;
	bh=FTHn6/xfwys+lrx2PwIo9Jrp/Uvzq79Fn9+PtwLxE5E=;
	h=Date:Cc:Subject:References:From:To:In-Reply-To:From;
	b=Amvd2k9jBCeg177sVrWdLDHxUbqaIxECM99fJ3cFBtsRrB+mXiEPV2z+rcLL5qstH
	 D2Vq80ftLF6ACvcjf1T/OeSz4JQqvj+6bKR1OdHKXgCdRWR9RUQPqjHi6jT/pyWy6D
	 MWsZfypaA+DnXGTXKHWlNUdRZ5LvZbCJGChiCamg=
Message-ID: <00e40c21-4797-41df-b082-318f474f76ae@linux.microsoft.com>
Date: Tue, 10 Jun 2025 10:49:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250610174521.12294-1-eahariha@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Ricardo Ribalda <ribalda@chromium.org>, Jakub Kicinski <kuba@kernel.org>
In-Reply-To: <20250610174521.12294-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies: Implement
 context and report modes
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2771
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/00e40c21-4797-41df-b082-318f474f76ae%40linux.microsoft.com>

On 6/10/2025 10:45 AM, Easwar Hariharan wrote:
> As requested by Ricardo and Jakub, implement report and context  modes
> for the secs_to_jiffies Coccinelle script. While here, add the option to
> look for opportunities to use secs_to_jiffies() in headers.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Closes: https://lore.kernel.org/all/20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org/
> Closes: https://lore.kernel.org/all/20250221162107.409ae333@kernel.org/
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  scripts/coccinelle/misc/secs_to_jiffies.cocci | 49 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> index 416f348174ca..f3241ce75a7b 100644
> --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -7,26 +7,65 @@
>  // Confidence: High
>  // Copyright: (C) 2024 Easwar Hariharan, Microsoft
>  // Keywords: secs, seconds, jiffies
> -//
> +// Options: --include-headers
>  
>  virtual patch
> +virtual report
> +virtual context
>  
> -@depends on patch@ constant C; @@
> +@pconst depends on patch@ constant C; @@
>  
>  - msecs_to_jiffies(C * 1000)
>  + secs_to_jiffies(C)
>  
> -@depends on patch@ constant C; @@
> +@pconstms depends on patch@ constant C; @@
>  
>  - msecs_to_jiffies(C * MSEC_PER_SEC)
>  + secs_to_jiffies(C)
>  
> -@depends on patch@ expression E; @@
> +@pexpr depends on patch@ expression E; @@
>  
>  - msecs_to_jiffies(E * 1000)
>  + secs_to_jiffies(E)
>  
> -@depends on patch@ expression E; @@
> +@pexprms depends on patch@ expression E; @@
>  
>  - msecs_to_jiffies(E * MSEC_PER_SEC)
>  + secs_to_jiffies(E)
> +
> +@r depends on report && !patch@
> +constant C;
> +expression E;
> +position p;
> +@@
> +
> +(
> +  msecs_to_jiffies(C@p * 1000)
> +|
> +  msecs_to_jiffies(C@p * MSEC_PER_SEC)
> +|
> +  msecs_to_jiffies(E@p * 1000)
> +|
> +  msecs_to_jiffies(E@p * MSEC_PER_SEC)
> +)
> +
> +@c depends on context && !patch@
> +constant C;
> +expression E;
> +@@
> +
> +(
> +* msecs_to_jiffies(C * 1000)
> +|
> +* msecs_to_jiffies(C * MSEC_PER_SEC)
> +|
> +* msecs_to_jiffies(E * 1000)
> +|
> +* msecs_to_jiffies(E * MSEC_PER_SEC)
> +)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for secs_to_jiffies()")

Sorry, I was testing sending this to myself before sending to the list, I've added the mailing lists now.

Thanks,
Easwar (he/him)

