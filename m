Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD56C7EE23
	for <cocci@archiver.kernel.org>; Sat, 25 Feb 2023 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IeKrqswpCP48KJ7xdsc98CWu2jMVk7oGFloYd7qL338=;
  b=IUW4+vXTAH1jCSvPdEQNN8PllVYDt/2ZldEwM1ZqA7UkefC8jzTyjdrw
   wYMoZqI3JBabqQEo9LMgab6ih3XkI3Ind76F0Kyw7OLuVfSkrKLtJ0jkA
   ZhyD7PxMDtKHsJIpz2HyY5m5L/U5swIwjTtYvrVs6x/uLN1vt5D8D6ypr
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.97,328,1669071600"; 
   d="scan'208";a="94345591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2023 20:17:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22AD7E0150; Sat, 25 Feb 2023 20:17:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E2DFFE0128
	for <cocci@sympa.inria.fr>; Sat, 25 Feb 2023 20:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=IeKrqswpCP48KJ7xdsc98CWu2jMVk7oGFloYd7qL338=;
  b=LsIzzOLU1UQ6QulREpDQY4TSYGFWEQhsblcFgM7E8oqFggQkCRd7op8e
   he1ujhAUSpSeG/P2L6GGEEMq8Sv5HI1gA859raLkTb6tS+Gcc8co6A9ak
   pHmOhIQuu7mUBYt0wP+VqUvs3hiaQJzLDlNODwj2tnLVG5bgFGjdFgmIc
   Y=;
X-IronPort-AV: E=Sophos;i="5.97,328,1669071600"; 
   d="scan'208";a="94345582"
X-MGA-submission: =?us-ascii?q?MDHl8OGuQespJSpiw5iWyCBv7j37eooy9yemSb?=
 =?us-ascii?q?8kPe/iOIswjwSZqYTk0NQcZnV0rN/AIYCM5irUOQEp3Nby+5bSdhxuZd?=
 =?us-ascii?q?uVeEL3KH08Y+MHQMxu42DndfJ8ziDdmL/ayp8zn6xNRVxWCDiOHpKFTj?=
 =?us-ascii?q?P2g8DMPQJtjl1kDCyBsIInvA=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2023 20:17:02 +0100
Date: Sat, 25 Feb 2023 20:17:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Deepak R Varma <drv@mailo.com>
Cc: nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr>
In-Reply-To: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
References: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [92.89.85.231]
X-Mailer: Zimbra 8.8.15_GA_4484 (ZimbraWebClient - FF110 (Linux)/8.8.15_GA_4481)
Thread-Topic: coccinelle: put_device: Include of_node_put to avoid false positives
Thread-Index: 3DXmNOMwrbdQmKUtPDQPTZ4nQdxHkA==
Subject: Re: [cocci] [PATCH] coccinelle: put_device: Include of_node_put to
 avoid false positives
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 863
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/597798313.18813704.1677352621708.JavaMail.zimbra%40inria.fr>

> The node reference increased by of_find_device_by_node() can also be
> released by using a call to of_node_put(). Hence when this exists, the
> script should not trigger a warning, which otherwise will be a false
> positive.

Could you explain more about why of_node_put is sufficient?

thanks,
julia

> Also, improve the warning message to include of_node_put too is missing.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> scripts/coccinelle/free/put_device.cocci | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/free/put_device.cocci
> b/scripts/coccinelle/free/put_device.cocci
> index f09f1e79bfa6..259195b501aa 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -18,8 +18,10 @@ type T,T1,T2,T3;
> 
> id = of_find_device_by_node@p1(x)
> ... when != e = id
> +    when != of_node_put(x)
> if (id == NULL || ...) { ... return ...; }
> ... when != put_device(&id->dev)
> +    when != of_node_put(x)
>     when != platform_device_put(id)
>     when != if (id) { ... put_device(&id->dev) ... }
>     when != e1 = (T)id
> @@ -42,7 +44,7 @@ p2 << search.p2;
> @@
> 
> coccilib.report.print_report(p2[0],
> -                             "ERROR: missing put_device; call
> of_find_device_by_node on line "
> +                             "ERROR: missing put_device or of_node_put; call
> of_find_device_by_node on line "
>                              + p1[0].line
>                              + ", but without a corresponding object release within this function.")
> 
> --
> 2.34.1
