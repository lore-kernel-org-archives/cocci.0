Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57261CAC5B8
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UdXAcy60pbXLM1GQoLBtLI/y16G6uwx1OVabU2xuMpw=;
  b=bBYAwthRFW2xara256EMPDqEmz16Bc6oTzJonKxNWBiF4W1HCXChu0+b
   RLeo5zLxttEPAXrGTaIMkbqwYiQDA+oI0igGAuCLqqGLXd047FZYCYVgV
   TZzUCBg7URkg9Wj43PMknjBoKZkAqi5Hy0HJFpCDutuof/JLfh7bsU3OT
   8=;
X-CSE-ConnectionGUID: u0SWDCKLSkyVMQzfsz3vww==
X-CSE-MsgGUID: FhysQ4aTTMq/09sm/3yFlA==
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
   d="scan'208";a="241841327"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 19:42:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6D30E0CD5; Tue, 30 Sep 2025 19:42:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CA63DE0171
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 19:42:26 +0200 (CEST)
X-CSE-ConnectionGUID: BASn8Bh+T6K0BaqLS3hAUA==
X-CSE-MsgGUID: hr6fk/7LTZqE4nHb20A4Mw==
IronPort-SDR: 68dc1682_6WxCJLrCJRDqZAksqQfQJR/5EVkKfOSdhoHVt2hWJhi1eYF
 WdtKe/vAlTJX/EHXrvW/QmiIedIOhevDxGnYWIQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ELAABaFdxogA4P49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAQGCPmUdBlQzBAtJBIRRiByHNIIkh?=
 =?us-ascii?q?DuPEYh5gVWBfQIPAQMBDUQKAQIEAQEDBDiESAKMRgIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NSQEQAYIHA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg06RAIBAyMdAQERJgEPHwEFAiYCAlYGARICA?=
 =?us-ascii?q?QGCfgGCIgEGEAEDNQcNuWaBMoEBggwBAQaCadd2HywiWYFkAwaBGy4BhWyCZ?=
 =?us-ascii?q?AGFbDuCWYFjJw+BVUSBPAuDNogegmmDPJAxfY4ZgUocA1ksAVUTFwsHBYEwM?=
 =?us-ascii?q?wMgCjQxAhQdEg8EFjIdcwwoEoNsgQ2EHitPhA50PlqDUyRrDwaBFYEbgkAFA?=
 =?us-ascii?q?YlLIA+BDQIBC209NwYDCxsGPZh4g0aBDiyCSpZEAa9rNAeCOIFngWQMii6VP?=
 =?us-ascii?q?gYTL5dSDgaTBS6HZZBzIotsgXqWGYUggWg6gVwzGiSDNk8DGQ+OIT6DdYRgi?=
 =?us-ascii?q?ioBuSlBNQI6AgcBCgEBAwmFRgEBilCCBoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2QMIFKNL1EGTzsBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL3+qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFgrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:NIfvVW2I+wl9IP5ZZ1ONmbxfMOkedC33zDTsfWzgI29wbIbOSXat0fYx
X-Talos-MUID: 9a23:i4fLEwTBr1Jlpz1XRXTsnm9sN4A3x5icEW1Rl7UM4ZGtaQlvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="126969445"
X-MGA-submission: =?us-ascii?q?MDFgThY9SN1u958fJ0YkuYsXOu244zeRU7GG9a?=
 =?us-ascii?q?PwJKwYLIGyYzjSunsadjnueujFNvUHC1GdjU4l1+wkMf99UaBv8pHIzO?=
 =?us-ascii?q?ZkC6obyGRj0qjeBUaMzkdrF2HXu6PHTm5DFm7ck1VooehDLQ/7z4gEUe?=
 =?us-ascii?q?LiK6u+f/Pbq+P54BsNWx6JCA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:42:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759254132; x=1759858932; i=markus.elfring@web.de;
	bh=UdXAcy60pbXLM1GQoLBtLI/y16G6uwx1OVabU2xuMpw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U3Vzja7HqwFjJ1iJ30RDBFlT9K/GHyuulFZADG5oY4ShWtN7/A/U76nuXmvItZ+b
	 n5tj08npO2xwZUBL4/xvk0u0SeM/ciwqHW/z64p9nWzDkXU4Kt+BMq11NrDCCB2Z2
	 6IrlseuIO8gGzyvtGtmEGt+CBcqW79DlCaBu8HToZM9VkcUpBGGMCEtYGpjbhZHag
	 /iwj76QmGVRFLvs1cJztSfNKThbFxXxAxeP02WRnoRx3zxAvGk5fOgwV5h44w2iS0
	 1XJ6Gwn9S2oBHtMIs+S9SOTdccBHfzKdCiy4gNja2Gyz0HohDxijW/Zgf/ZGUSiLz
	 F/wtsldisMH13c9JOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3ox-1v7mom3Vv5-00Don7; Tue, 30
 Sep 2025 19:42:11 +0200
Message-ID: <e8a3b5c5-4667-40ea-913d-737b58401f79@web.de>
Date: Tue, 30 Sep 2025 19:42:07 +0200
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
X-Provags-ID: V03:K1:15pAcpfSZQjBI8xXlLm2tTzkOeZpZ7eY43IUVzBTdhRKcsqDW+Q
 qjKJH3QWe+x/ddq507uOeDSS9w0bAzTGx1CSj2/Ppwh/8nqkkxpjAXIlyCf0QNeXkMmWaSD
 45cyAxSPpnKuvMnxgOGXG6HS27IiBeqgkOd06To4gKOrUtLvs+/55S2uagwK8wuqzLdTqkl
 qZFrnJN90yriDJY7Lg+RA==
UI-OutboundReport: notjunk:1;M01:P0:pr+UgT/XXl4=;HEzWpmvAAXi/cjdINT6Hxs3KoOt
 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
Subject: [cocci] [PATCH 5/6] Coccinelle: ptr_err_to_pe: Simplify two SmPL
 dependency specifications
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3061
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/e8a3b5c5-4667-40ea-913d-737b58401f79%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:46:55 +0200

Omit the explicit specification =E2=80=9Cr &&=E2=80=9D from two SmPL rules
because the references are sufficient according to data declarations
for Python scripts.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/6b2eb2c2-15e7-49b4-aaca-6fd58af9ec6c@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index b2db0dc3395e..f0bd658c7edb 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -20,12 +20,12 @@ identifier print_func;
 @@
 *print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
=20
-@script:python depends on r && report@
+@script:python depends on report@
 p << r.p;
 @@
 coccilib.report.print_report(p[0], "WARNING: Consider using %pe to print =
PTR_ERR()")
=20
-@script:python depends on r && org@
+@script:python depends on org@
 p << r.p;
 @@
 coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_E=
RR()")
=2D-=20
2.51.0


