Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3239DCAC59D
	for <cocci@archiver.kernel.org>; Wed, 17 Sep 2025 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:message-id:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=qCb3LGYSgfnLMPEWKwIEOTiS7lDhw2WFR5yuYthUrv8=;
  b=BTV2mkRKZQbgG/LIrcwiowm+d0W05/prDMrBpxepq6v8wFN/P9QMd4qZ
   oWlCSEuKUaOYBEhZrNnenLbgPfF6RpWj4nSn62KWKe4gHnNfwppI6Y4X9
   FalSjWyhm4//tKx6J36UzlKNFeNB/3GRiUyAOHyLlXZp4azBnNB5Vmpid
   w=;
X-CSE-ConnectionGUID: HcSMkrUjQriYwpnzGhUl3w==
X-CSE-MsgGUID: XOT9UdATTau04rJrhLD6zw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ispras.ru
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="scan'208";a="239634478"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2025 14:46:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7BE0E0CD9; Wed, 17 Sep 2025 14:46:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C0D52E0171
	for <cocci@sympa.inria.fr>; Fri,  5 Sep 2025 16:06:43 +0200 (CEST)
X-CSE-ConnectionGUID: 6hjfZk4gRXKO3/BStF7zkQ==
X-CSE-MsgGUID: 3kLkB4KkRjSXQP+yepBsSw==
IronPort-SDR: 68baee72_GAiom2DxhCQkSvSr0gonkoEfTZVwhA1/8LijjKuGRJgoB74
 ftHa8pTLdX5TOJ2bwbaGbDEdvBtCguCRxVr4lrg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GmBQAO7bpoclTHlVNagQmEE4FbMwQLSZQlnmmDVA8BA?=
 =?us-ascii?q?wENUQQBAQMEhQCMKwIeBwEENBMBAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAGBDIZPDYJbgSyBJgEBAQEBAQEBAQEBAR0CFIE1AgYBATgTO?=
 =?us-ascii?q?4EJhR0CTgeyIYE0gQGCDAEBBoJo2TyBZAmBSYg2GgEFboU9hFqBZESEfYRYO?=
 =?us-ascii?q?IV3gRKBFIEWg1iEAIhbhF2GWSyBHhwDWSwBDwc/ExcLBwWBYwOBDzI8Mh2BJ?=
 =?us-ascii?q?4UNhB4rT4UBgReDUyRrDwaBFYFkgXmES0ADCwdmPTcUGwYCAYE1lHSDKAaBD?=
 =?us-ascii?q?4JLWJMCkTxloRQHhB+KeJZnEhwXmRORWJkGo2iFWYF/I4FcMxoygyhPAxkPm?=
 =?us-ascii?q?DezIUA1PAIHCwEBAwmGSItWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b8biodDD616GpDehEfxh+8UvA==
IronPort-HdrOrdr: A9a23:EQm0dK8+0AW6yEVpAUVuk+DXI+orL9Y04lQ7vn2ZLiYlFfBw9v
 re+Mjyt3fP4gr5PUtMpTnuAsa9qB/nm6KdgrN8AV7BZniEhIJ5FvAG0WKK+VSJcBEWndQ86U
 4PSclD4I2ZNykZsfrH
X-Talos-CUID: 9a23:2nzpXm+j49i0eubtLX+VvxAUGM4XcSHS9kfzBBT/I111ZuKHSmbFrQ==
X-Talos-MUID: 9a23:mCpp/QuQ80UD/ZC65s2n3zJGN+00wKeUCns9qK1FqsScHzdLJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,241,1751234400"; 
   d="scan'208";a="124758841"
X-MGA-submission: =?us-ascii?q?MDFvbpPCAHcjd5JxbiDgN+VVZ/k1/A+fGtkzpJ?=
 =?us-ascii?q?zQrVKiZ10SLlnUH5a5qAGxsC+Fhyx99cqTG7nl8JwgMf0Oqycy9JIkXE?=
 =?us-ascii?q?F0EY3CSPySowT6Q1VhKQS+30kchI5PhM7hh90SsBwJQByO/2OW6cyPrD?=
 =?us-ascii?q?TLVJuMUzdDFwzgns3jvyl8CA=3D=3D?=
Received: from mail.ispras.ru ([83.149.199.84])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 16:06:42 +0200
Received: from mail.ispras.ru (unknown [83.149.199.84])
	by mail.ispras.ru (Postfix) with ESMTPSA id B000740D3C55
	for <cocci@inria.fr>; Fri,  5 Sep 2025 14:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B000740D3C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1757081200;
	bh=qCb3LGYSgfnLMPEWKwIEOTiS7lDhw2WFR5yuYthUrv8=;
	h=Date:From:To:Subject:From;
	b=egpVogSGuXDAyenMaAPFMSDcO4cI9F7j8ECuroexA/LIypv2lcaWhzkAMGsdZTb0x
	 cSLEDqdexYPRlb4kRZHfcZuUUNfnY3hxO4CMxGWWLN0HsDFPvD9epm90/yG/66wZKv
	 Kzt6Kl9KTIgxo6xPlYAooO1oX/62o1Gp1UgMK4Wc=
MIME-Version: 1.0
Date: Fri, 05 Sep 2025 17:06:40 +0300
From: Oleg Petrov <o.petrov@ispras.ru>
To: cocci@inria.fr
Message-ID: <3addf44d4f2524588d664102d5109aad@ispras.ru>
X-Sender: o.petrov@ispras.ru
Organization: ISP RAS
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] devm as drm-init arg: rule with expression finds less than
 rule with identifier
Reply-To: Oleg Petrov <o.petrov@ispras.ru>
X-Loop: cocci@inria.fr
X-Sequence: 3023
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/3addf44d4f2524588d664102d5109aad%40ispras.ru>

Hello,

TLDR A rule finds a match with identifier, but not with expression.

I'm using Coccinelle to search for devres-allocated arguments for
drm*init functions. I have a simple rule which seems to work fine:

@badarg exists@
position p,q;
expression devm,e;
@@

devm =@p devm_kzalloc(...);
...
drm_crtc_init_with_planes(@q e,<+...devm...+>,...)

@script:python@
p << badarg.p;
q << badarg.q;
@@
print(p[0].file + ":" + p[0].line + "," + q[0].line)

But then I'd like to find a similar thing, but when another
intermediate variable is used somehow:

@badarg2 exists@
position p,q,r;
expression devm,e;
identifier local;
@@

devm =@p devm_kzalloc(...);
...
local =@r <+...devm...+>;
...
drm_crtc_init_with_planes (@q e,<+...local...+>,...)

@script:python@
p << badarg2.p;
q << badarg2.q;
r << badarg2.r;
@@
print(p[0].file + ":" + p[0].line + "," + r[0].line + "," + q[0].line)

This last rule finds two matches:
drivers/gpu/drm/tilcdc/tilcdc_crtc.c:1005,1018,1031
drivers/gpu/drm/meson/meson_crtc.c:680,686,687

But if I change local to be expression, the rule finds only
drivers/gpu/drm/meson/meson_crtc.c:680,686,687

I wonder, why is that the case? As I understand it, identifier itself
should match expression.

Best regards,
Oleg
