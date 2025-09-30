Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23599CCA470
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dJ22hKA0Pw46/eMtwHJfDRVC5brR1Fd+Ptpn07rVw+A=;
  b=BTo9YcpFuGxdJP8EH1mimyGKH4fdi68xwYYp3zphJCNjE5uO4Fgd2PTJ
   79CS9v7NqNyGqUFAF17wbJ673fp3XpRCc79EghZRaark6suRztiDyoG8u
   m/Lx6rVuxheak8+YoyhufQr4CF9a34y0hhD6zcbQCNkU+lcHxPk7JXaE8
   4=;
X-CSE-ConnectionGUID: IQvkV1ELRaGsDla3gelGXg==
X-CSE-MsgGUID: C2s5dW6yR7SFLnFxut8b1A==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="241841072"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 19:39:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A28F0E0171; Tue, 30 Sep 2025 19:39:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 818B1E0171
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 19:39:25 +0200 (CEST)
X-CSE-ConnectionGUID: jKzMk3TWS9iIaMuQD2UptQ==
X-CSE-MsgGUID: 0CsNy1ZsSXGnKZ4vFBwwOA==
IronPort-SDR: 68dc15cd_MKFympFEWX/o742SXvOgDnLCSPpGkyD0ZvzgkoVGGB5VHgc
 qmTBc1dFvZh8XSCEdH/e7XnPag7RXHrS9z7iIWA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ETAABaFdxogA4P49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUECAQEBAQELAYI/ZSNUMwQLSYRVj1CCJIQ7hzyHV?=
 =?us-ascii?q?Yh5gVWBfQIPAQMBDU4BAgQBAQMEOIRIAoxGAh4HAQQyBw4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAIBAyMdAQERJgEPHwEFAiYCAlYGARICAQGCfoIjAQYQA?=
 =?us-ascii?q?QM1B7lzgTKBAYIMAQEGgmnXdh8sIlmBZAmBGy4BhWyCZAGFbDuEPCcPgVVEg?=
 =?us-ascii?q?TwLgQmCLYQKhBSCaYM8kDF9jhmBShwDWSwBVRMXCwcFgTAzAyAKNDECFB0SD?=
 =?us-ascii?q?wQWMh1zDCgSg2yBDYQeK0+EDnQ+WoNTJGsPBoEVgRuCQAUBiUsgD4ENAgELb?=
 =?us-ascii?q?T03BgMLGwY9mHiDRoEOgjBGlkQBr2s0B4I4gWeBZAyfbAYTL5dSDgaTBS6HZ?=
 =?us-ascii?q?ZBzIqkfgW8DMIFcMxokgzZPAxkPjiGEM48KAbkpQTU8AgcLAQEDCYVGAQGMI?=
 =?us-ascii?q?jSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mp1wxar18hSpwmYfO+S5pKcaV5r/eYIsimQD101hICG9vPbo8v
 xG785rsiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWrbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AnrpPQ2mAo+PX5qhkleW76SDbrHbXOX/+3lLTeHO?=
 =?us-ascii?q?HMjdoabSwVGa8op58j/M7zg=3D=3D?=
X-Talos-MUID: 9a23:r5if/wmM78cTn1BnzEA6dno6H9xO8v2cE3s9vpMliZWaGwZvJBC02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="126969296"
X-MGA-submission: =?us-ascii?q?MDFJchxTvx6YXVRsAPlxiqbww7DwGXpKzZswo6?=
 =?us-ascii?q?p6EAUg5wDqsaCxK7kDN769uWOAtFxY8ikWhr6hFyQGfXhqoMun9Eeojn?=
 =?us-ascii?q?IIYL/L+3JTZ73XLHrnnCg/aYtPX5+QwZcbCa2AXaEdHl3pOVoaCWDEsq?=
 =?us-ascii?q?2gyYCtmRICWtyxMJ0Fafsl+g=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:39:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253951; x=1759858751; i=markus.elfring@web.de;
	bh=dJ22hKA0Pw46/eMtwHJfDRVC5brR1Fd+Ptpn07rVw+A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XZgU4oaW7BOwhHTup9t5ED9kRtmQRwaLIt55LbrgDlNFj2cTpUJLM3rmF4K7nwe7
	 mzhsRicpsyW90HLjXAhPnzh6uL88b9OtuNvyZXvdkiQjnqed+GP+vUezVxLQQwsSH
	 9IE3X6RRWecjefupjbGE6xef8EUrQFj1HYGxfrk4CzH6wS87YV9FEY7f6I3oGg8jZ
	 zFhmhyt+cx593TSFStQReFII59EXGjy3oTDmVqpNS0eKqDH7RIiSGLXdpzt/r4xH8
	 nup5qK7G+tPL+nw4k10p45y+vbNLMJBney+zVxYJ2Z85beI83r7yukT3QDOUouDLm
	 459RYsd3StOH2D2E1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1uTDts2lzP-00aR68; Tue, 30
 Sep 2025 19:39:11 +0200
Message-ID: <277fbd11-6533-4f45-a846-cf31abfb06d9@web.de>
Date: Tue, 30 Sep 2025 19:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O58Z0tenR95pqkFlVQReIQKIrnCZPgmwLTINoBPLcq/rz6je78X
 I9wlB7XA+mOUULOWmo/zNnlAqjvgJ/txjtA1iKXNU43DPWWayOHLH8SqA/o9T+zYgyhf4iW
 YIwasVpMiD3uBhIsx+vbs/6BzPtSHptLfo/2wdfN5jWR1DhrrGiYKrfx4gTCINK2HtLkg46
 wXj6BsU8PCxu3kgTMh7nA==
UI-OutboundReport: notjunk:1;M01:P0:YGCqnEc+tpA=;J/TcG41QIuUmuFRkbV688znzMJ4
 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
Subject: [cocci] [PATCH 4/6] Coccinelle: ptr_err_to_pe: Omit a redundant
 space character
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3060
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/277fbd11-6533-4f45-a846-cf31abfb06d9%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:33:10 +0200

An extra space character is not required after an SmPL asterisk.
Thus omit it.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index fb4b5bf91081..b2db0dc3395e 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -18,7 +18,7 @@ constant char[] fmt;
 position p;
 identifier print_func;
 @@
-* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
+*print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
=20
 @script:python depends on r && report@
 p << r.p;
=2D-=20
2.51.0


