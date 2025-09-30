Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7908CCA470
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Y/Rs5WoF+wLZrzN8PlphZNOI7hxIXeNc83w/Hb0puDs=;
  b=SH8Kp1NTDm56ALBa/JpndxfFRa3P+/ZR4XErr6pn7k09e8YoF9VDQkLd
   728QyND95wAllEpiX4JyVMDUoycbOJ3DorLZYiyINtUsD9oeZTRo2Uv9l
   F9vtBF/FiVNGMRX2hhAFR+Su/+jBQ+FXDokz2xR99v6SW3p1Ci8jVHVk7
   4=;
X-CSE-ConnectionGUID: ECApLjnESuylf5HtOB9zKA==
X-CSE-MsgGUID: hfJc8q7DTGS7aTYVEeHAEA==
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
   d="scan'208";a="241840694"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 19:35:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 722D7E0C55; Tue, 30 Sep 2025 19:35:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9603AE0171
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 19:35:35 +0200 (CEST)
X-CSE-ConnectionGUID: 2TiOF6VYRMCAeKl1rPPHUA==
X-CSE-MsgGUID: rVLI8O3uRTOE8ZdQC/8K0w==
IronPort-SDR: 68dc14e7_2xhTE0MNtp/7BEhABJ54FXrDJ85MjxprNBSDqxmcU/zWvfb
 Bd48tEbxQAVmxNP7fxGNiLT+jZZZ6hcv/zgobVg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ELAADtE9xogAQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYI/ZSNUMwQLSYRViByHNIIkhDuHPIdViHmBV?=
 =?us-ascii?q?RSBaQIPAQMBDU4BAgQBAQMEOIQ+CgKMRgIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CR0QCAQMjHQEBESYBDx8BBQImAgJWBgESAgEBgn6CIwEGEAEDN?=
 =?us-ascii?q?Qe5cYEygQGCDAEBBtpfHywiWYFkCYEbLgGFbIJkAYVcEDuEPCcPgVVEgTyBF?=
 =?us-ascii?q?IE+b4QGhBiCaYM8iECHcX2OGYFKHANZLAFVExcLBwWBMDMDIAo0MQIUHRIPB?=
 =?us-ascii?q?BYyHXMMKBKDbIENhB4rT4QOdD5ag1Mkaw8GgRWBG4JABQGJSyAPgQ0CAQttP?=
 =?us-ascii?q?TcGAwsbBj2YeINGgQ6CdpZEAY0eok00B4I4gWeBZAyfbAYTL5dSDgaTBS6HZ?=
 =?us-ascii?q?ZBzIqkfNoEyOoFcMxokgzZPAxkPjiE+g3WPCgG5I0E1PAIHAQoBAQMJAYFVg?=
 =?us-ascii?q?3ABAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:EP5NBaCsn5+IKKnlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOos1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:btuFBG4zcmkI1Yx3VdssrnIVPe57TEzn6Vz5Lmy8UHxRcJ2oYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AE13y9g9Qr8JBoJJ/zrWpyVWQf91Wx4X+LxsQq6k?=
 =?us-ascii?q?hlpm2ORVbfGe+1CviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="241840631"
X-MGA-submission: =?us-ascii?q?MDHIW937Vi9jddTLA+vj4K47CDdsqc69XDyXQp?=
 =?us-ascii?q?UgvNrDMLdGYxDgZf2l6Wq4fcU7nw6piK2GYE+ud3N1fZF/QH21LGoG0U?=
 =?us-ascii?q?ZE76mjHt5pKdT6FWvtaaeV8A/lBDCRz8I35F7UGbif0l+ENd86RTErTm?=
 =?us-ascii?q?wMV560/001VEvR//oDckCPmg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:35:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253732; x=1759858532; i=markus.elfring@web.de;
	bh=Y/Rs5WoF+wLZrzN8PlphZNOI7hxIXeNc83w/Hb0puDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FvZ/vxC6eeZIiVNnQBOctyVHHPU0TMYKCkd7zccGBikMfFSM3IYqIiuBYboU8qFV
	 D0x72RO5ywmYUCkLhCvIWlXJjx3R8+e7Cax83jOd9OW+Ii5QEbgO70JuP08ufdyRO
	 HhqP/R81K9t29s6uMlzhcruiv9aql5GL/+lbPZkrZEk3bYFyVGaT8yojn+bW1lI+R
	 zUCQJc6h12cPQEze8DWCx3oMA12BBLqTRoTBqcJJJtQaJ6aqW10+fbJOTTHq7X5SL
	 gTMD30PZymk4d5vg2SKcaDadXFzB6J3+iIEgqYeInOfRstJ2as+ujbNPGMEBesbLv
	 51aaRIm8EDQLHE1bYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1uG6wR0CJn-017zxZ; Tue, 30
 Sep 2025 19:35:32 +0200
Message-ID: <fdde8ee1-b531-47b2-86af-9f2229351631@web.de>
Date: Tue, 30 Sep 2025 19:35:30 +0200
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
X-Provags-ID: V03:K1:fUE0+nNNqjgkL4JVVlPEmUziqhzZ3XUqlFsHjUHsB0Ki7Pz4b/e
 eaXs6IUCyBkHNz4jc5dvRvB+4n+rytSiyyh89oOrntqmJjUdRZ3TOx3yr25Lf3vz55T/2/v
 6tMgOFlrF8pFsaNyfVLgufAO7wkSPnFyQCwsJmCX2cimfqiITElf/3GL1Z1hfa+CuRbvvWD
 qbSxXu2pBn3UYcI9hVGiw==
UI-OutboundReport: notjunk:1;M01:P0:k2GxwOgLr9o=;cNbNzKq7qGmAOgVGh88eLUmSwsj
 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
Subject: [cocci] [PATCH 2/6] Coccinelle: ptr_err_to_pe: Reduce repetition of
 the key word =?UTF-8?Q?=E2=80=9Cvirtual=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3058
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/fdde8ee1-b531-47b2-86af-9f2229351631%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:11:48 +0200

This SmPL script is using three input variables. They can be specified
in a more succinct way. Thus adjust the corresponding SmPL code layout.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index 1a373c0a8180..26888d2c9c83 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -10,9 +10,7 @@
 // Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
 // Options: --no-includes --include-headers
=20
-virtual context
-virtual org
-virtual report
+virtual context, report, org
=20
 @r@
 expression ptr;
=2D-=20
2.51.0


