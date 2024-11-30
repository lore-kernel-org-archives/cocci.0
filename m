Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A93DE77177
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h65E59UzPZDDCledz2xxcEnpRXnN9xAVUQaOPRK7D58=;
  b=WPUROuVwaWw1o97PoTxLGWHx20LMPyUksJkwTnXaTLC6CbvslZ1GtVsb
   gjjSOYs4Gqtw4Hth3pqlhVOt919L6RBOqr3zhL2QNzVg+pnUsAg346lbG
   2/Hhm4m9rrr8o5+ghmD56MEk3X+cKlIyKMLHX6AHhrxTbTzkDOYqSbH4R
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421355"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9233CE0D60; Wed,  4 Dec 2024 23:28:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 29831E00B6
	for <cocci@sympa.inria.fr>; Sat, 30 Nov 2024 05:08:54 +0100 (CET)
IronPort-SDR: 674a8fcb_BcjCIrtSP1jyxI6h4pVnoNmWOMh6m22TJmYbE+nU34iN2+I
 OKQawwATtEKtD8r5FJ4LqpkTlP7c4FazXLxw6jg==
X-IPAS-Result: =?us-ascii?q?A0EtAAAkj0pnYzVCP7JaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDB4FPNAcISIxziVEDgROQN4xNFIF5AQMBDUQEAQGBUgGDQYpYAh8GAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECA4EahgiCYgGDfwEBA?=
 =?us-ascii?q?QEDMgFGEAsVAxwSKysZhTIDMQewUXiBNIEB3ToNglmBSAGISwGFaYMUgWMnF?=
 =?us-ascii?q?QaBSUSBFTWBBoE3OD6CH4FnFIQ+gi8EgkCBMYNeJYU2AYNJnA1SexwDWSERA?=
 =?us-ascii?q?VUTFwsHBYEpISwDgkd/gTYogSkBgxBKgy6BXgU3Cj2CSmlLOgINAjaCJH2CT?=
 =?us-ascii?q?YUXgQuDXmUvAwMDA4IRgSuGLkIdQAMLbT03FBuiE0aDRAcBgQ0BGxQdLmBlC?=
 =?us-ascii?q?w2TCi6SG4txlQ8HA4QaoUQaM6pRiC+QTKN0ARiFHYFnOi6BLnAVO4JnTwMZD?=
 =?us-ascii?q?9kNJzI8AgcBCgEBAwmRMzSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QgHuy6q4aGawR0hgT97CTJQaV5omeYIsimQD101hICG9vPb2qy
 mLpoV/6faSskd0ZJhAo6HjBEDuexnhHPJOjLX5eI3SOzUO21HYT72Kj7GC/9SIIUSXndK1l5
 0BT0EUMrPN5DZB4frH3A==
X-Talos-CUID: 9a23:li5JpWBTS2smLA/6EwJl8mgoPvB9Tl/+6n7PJ0GfFG1oVLLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AejLEFwwzdrVMP0qjQrwXFQeCbimaqKiTCGNOv58?=
 =?us-ascii?q?cguOvHzBfADG4sBeJYqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,197,1728943200"; 
   d="scan'208";a="196602950"
X-MGA-submission: =?us-ascii?q?MDErdwDBJFQDqIiQ+Vkfid1gYYDyEQZm62myqT?=
 =?us-ascii?q?5AFbe8xumd0wMZrLtFrq+2Kk0UcTYPEKJf0z40ch5EcZM1p3ZR+qW9yT?=
 =?us-ascii?q?TAEOPqmwUbjhceHnPxJ8nwuB3xri5FucHi/TX6rQEIqTrVdScrrNcObn?=
 =?us-ascii?q?biP2VaIm0VZBzAVlULeencKw=3D=3D?=
Received: from mail.hallyn.com ([178.63.66.53])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 05:08:43 +0100
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 118AD654; Fri, 29 Nov 2024 22:08:42 -0600 (CST)
Date: Fri, 29 Nov 2024 22:08:42 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Message-ID: <20241130040842.GB65112@mail.hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: "Serge E. Hallyn" <serge@hallyn.com>
X-Loop: cocci@inria.fr
X-Sequence: 2152
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/20241130040842.GB65112%40mail.hallyn.com>

On Mon, Nov 25, 2024 at 11:40:04AM +0100, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Hi,

these all look good to me.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Except for, in fact, this patch, as I'm not versed in .cocci and
can't tell whether it's doing the right thing.  Looks like it is,
based on the patches you sent...

> ---
>  MAINTAINERS                                |  1 +
>  scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 scripts/coccinelle/api/capable_order.cocci
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7f017097701..ab5ea47b61e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5106,6 +5106,7 @@ S:	Supported
>  F:	include/linux/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
> +F:	scripts/coccinelle/api/capable_order.cocci
>  F:	security/commoncap.c
>  
>  CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/coccinelle/api/capable_order.cocci
> new file mode 100644
> index 000000000000..4150d91b0f33
> --- /dev/null
> +++ b/scripts/coccinelle/api/capable_order.cocci
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Checks for capable() calls of the left side of a binary expression.
> +/// Reordering might avoid needless checks, LSM log messages, and more
> +/// restrictive LSM security policies (e.g. SELinux).
> +/// Can report false positives if the righthand side contains a nested
> +/// capability check or has side effects.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2024 Christian Göttsche.
> +// Options: --no-includes --include-headers
> +// Keywords: capable, ns_capable, sockopt_ns_capable
> +//
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  Pattern to ignore
> +//----------------------------------------------------------
> +
> +@ignore@
> +identifier F1 = { capable, ns_capable, sockopt_ns_capable };
> +identifier F2 = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E;
> +position p;
> +@@
> +
> +(
> +F1@p(...) op F2(...)
> +|
> +E op1 F1@p(...) op2 F2(...)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@ depends on patch@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E,E1,E2;
> +expression list EL;
> +position p != ignore.p;
> +@@
> +
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E, E1, E2;
> +position p != ignore.p;
> +@@
> +
> +(
> +*  F@p(...) op E
> +|
> +*  E1 op1 F@p(...) op2 E2
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For org mode
> +//----------------------------------------------------------
> +
> +@script:python depends on org@
> +p << r1.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for capable reordering",p)
> +
> +
> +//----------------------------------------------------------
> +//  For report mode
> +//----------------------------------------------------------
> +
> +@script:python depends on report@
> +p << r1.p;
> +@@
> +
> +msg = "WARNING opportunity for capable reordering"
> +coccilib.report.print_report(p[0], msg)
> -- 
> 2.45.2
