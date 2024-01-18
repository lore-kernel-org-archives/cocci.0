Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2DAC47DB7
	for <cocci@archiver.kernel.org>; Thu, 18 Jan 2024 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oniM1tHRWysCpGkdbeyIlaVHtdrTecB+D1XxrJxUmwQ=;
  b=Y+P8w+xb/v/6PZ7PwYCCDqstmy3Nt5E1U12LOBfMotwn2lixLJXkUJve
   NZT82ZGvrXuHlVZTZOQkz07QO1XcrHduSWNkx7wZKceltEqsIl7Wyo2FT
   FpDS5SzB8C6s0OmhvroDlukUc39dhF5tvo5cG7sh/+eLTNLyeXmSOZ8ZG
   4=;
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
X-IronPort-AV: E=Sophos;i="6.05,203,1701126000"; 
   d="scan'208";a="147468860"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Jan 2024 21:27:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D19E8E0CCA; Thu, 18 Jan 2024 21:27:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59BA5E004E
	for <cocci@sympa.inria.fr>; Thu, 18 Jan 2024 21:26:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oniM1tHRWysCpGkdbeyIlaVHtdrTecB+D1XxrJxUmwQ=;
  b=GcMuP6v/mQZS2lVkPP8Lqtmczbc/jyYzEZN+c5PbtZm0I7tRFgbnfO2K
   V0wA7jwC6iRd0hEAZbsSXkYHGSTDa9+RzF6TTkdp0bZZHYUOvJ1MTHXD6
   XlBZ1EHdz6+Rig3IgSBfHWgVFqR3kb3BSoBh6jvZl0T0iSN/ehMFeWAyd
   o=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701126000"; 
   d="scan'208";a="147468856"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 21:26:59 +0100
Date: Thu, 18 Jan 2024 21:26:59 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
In-Reply-To: <20240116041129.3937800-2-lizhijian@fujitsu.com>
Message-ID: <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com> <20240116041129.3937800-2-lizhijian@fujitsu.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 01/42] coccinelle: device_attr_show.cocci:
 update description and warning message
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1458
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401182125480.3296%40hadrien>



On Tue, 16 Jan 2024, Li Zhijian wrote:

> Update them according to latest Documentation/filesystems/sysfs.rst.
>
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: cocci@inria.fr
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> index a28dc061653a..a621e9610479 100644
> --- a/scripts/coccinelle/api/device_attr_show.cocci
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -1,10 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
>  /// From Documentation/filesystems/sysfs.rst:
> -///  show() must not use snprintf() when formatting the value to be
> -///  returned to user space. If you can guarantee that an overflow
> -///  will never happen you can use sprintf() otherwise you must use
> -///  scnprintf().
> +/// show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> +/// the value to be returned to user space.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
> @@ -46,10 +44,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit")
>
>  @script: python depends on org@
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
> +coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit")

Thanks for the suggestion, but it's not really consistent, because the
patch rule still generates a call to scnprintf.  Would it be possible to
fix that up?  Or should it be removed?

thanks,
julia
