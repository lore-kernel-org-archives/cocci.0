Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775AC433DF
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:28:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17926214DB
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17926214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HKRn12007098;
	Wed, 17 Jun 2020 22:27:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E92CB7577;
	Wed, 17 Jun 2020 22:27:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A76AA3D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:27:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HKRhnM010890
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:27:43 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; d="scan'208";a="455254845"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 22:27:43 +0200
Date: Wed, 17 Jun 2020 22:27:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200615130242.11825-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172225570.3083@hadrien>
References: <20200615130242.11825-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:27:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:27:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api: add device_attr_show script
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Mon, 15 Jun 2020, Denis Efremov wrote:

> According to the documentation[1] show() methods of device attributes
> should return the number of bytes printed into the buffer. This is
> the return value of scnprintf(). show() must not use snprintf()
> when formatting the value to be returned to user space. snprintf()
> returns the length the resulting string would be, assuming it all
> fit into the destination array[2]. scnprintf() return the length of
> the string actually created in buf. If one can guarantee that an
> overflow will never happen sprintf() can be used otherwise scnprintf().

The semantic patch looks fine.  Do you have any accepted patches from
this?

julia


>
> [1] Documentation/filesystems/sysfs.txt
> [2] "snprintf() confusion" https://lwn.net/Articles/69419/
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 scripts/coccinelle/api/device_attr_show.cocci
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> new file mode 100644
> index 000000000000..d8ec4bb8ac41
> --- /dev/null
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// From Documentation/filesystems/sysfs.txt:
> +///  show() must not use snprintf() when formatting the value to be
> +///  returned to user space. If you can guarantee that an overflow
> +///  will never happen you can use sprintf() otherwise you must use
> +///  scnprintf().
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +
> +virtual report
> +virtual org
> +virtual context
> +virtual patch
> +
> +@r depends on !patch@
> +identifier show, dev, attr, buf;
> +position p;
> +@@
> +
> +ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	<...
> +*	return snprintf@p(...);
> +	...>
> +}
> +
> +@rp depends on patch@
> +identifier show, dev, attr, buf;
> +@@
> +
> +ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	<...
> +	return
> +-		snprintf
> ++		scnprintf
> +			(...);
> +	...>
> +}
> +
> +@script: python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
> +
> +@script: python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
