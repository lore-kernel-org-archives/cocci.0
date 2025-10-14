Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B718FCCD199
	for <cocci@archiver.kernel.org>; Mon, 20 Oct 2025 08:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=hrjgueiBLkXU10BqzBn/2RVF4iuicSRkbKJQK3vrWCA=;
  b=Q6+XJqxvhdm+J9PJ/4/l8jgwddgfv2Xyc3eRC0kEvClob7B70GY1NB7m
   6KqLo8Erepp3Vfb75teJvzrp9AN7QdVIp7iviUB355FigdJcF1M8/ay0E
   uV2iYd1FWSLYwRBGo1hf0KODURhCZ0kgWYbwiRRihgmT8T8N6w7d1qiBi
   A=;
X-CSE-ConnectionGUID: S/OZd+BBRXiYd9Aehr4q5g==
X-CSE-MsgGUID: 6FnzmyTQTAaWl00QXyctSg==
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
X-IronPort-AV: E=Sophos;i="6.19,242,1754949600"; 
   d="scan'208";a="245166521"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2025 10:45:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ECE6DE0D73; Mon, 20 Oct 2025 10:45:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 034ECE0171
	for <cocci@sympa.inria.fr>; Tue, 14 Oct 2025 17:12:11 +0200 (CEST)
X-CSE-ConnectionGUID: 2WxKcTUAQcOBMsxXpIlE7A==
X-CSE-MsgGUID: MqbJ8Y1UQOKn/T6M9nti+g==
IronPort-SDR: 68ee684a_aTEGIKN5UnUByNEBLx6UAhPZ1WzhROBXYGud4jt4DaXN9Rl
 RJFOE1waQV2afYpszUIXfwhuTvLJNin89SXxz7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EKAAAkZ+5oj/4EaaxaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgj+BYDMEC0mMcV+nFYIOAQMBDVEEAQGRVQIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBAQE5BUmGXIJiAYQ4A?=
 =?us-ascii?q?T0JgT0BEoMCgnQDsQaBAd45gW2BSgGFbIdhZ4UogiiBFTKBCYE+b4QKhn0Eg?=
 =?us-ascii?q?xwUhjSQNkiBHgNZLAFVEw0KCwcFgTAzAyAKCwwLBgwYFQIULw8aMh1zDCgSM?=
 =?us-ascii?q?R5zhF0haA8GgRODVAUBg3iFbA+EbAMLGA1IESw3Bg4bBj5uB5FcgnyBDoJpk?=
 =?us-ascii?q?ySzTYQmgWSgDTOEBJNOkxgBLodckHwigjahPkKEaYFoOoFcbYM6TxwPz1dBN?=
 =?us-ascii?q?TwCBwsBAQMJkWo0gUsBAQ?=
IronPort-PHdr: A9a23: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
 BcFbp59ZgTn5V1W30mXLwOZ3ti0BWyge2M+cg==
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:MST2OK0xzhquX2AyY6jqTQqjBEwkLtp133Aq2lEZdPU1SL36qy
 jN9M5w6faQslsssR4b9exoVJPufZq/z/9ICOAqVN/IYOCMgguVxe9Zg7fK8nnJAC30/qpxyb
 xpeK1zJNn5DV0/sN3z6gu1CPYsqeP3lJyAtKP31HdnRUVNcKFv7wBwFwadHAlfXRBCBZAwCZ
 qb4aN81l+dUEVSRt+6DXFAefPCqd3NnI/nZhBDPBIu7Q3mt0LL1ILH
X-Talos-CUID: 9a23:rokbom6iEW810wiextssrnEEOcsZT1Tkx1D6BlSoOX5ITJDKYArF
X-Talos-MUID: 9a23:iOvtdQXrev0YRVTq/Br1jhMyBZ5V2oONDgcxz7BXvdWFdiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,228,1754949600"; 
   d="scan'208";a="244211926"
X-MGA-submission: =?us-ascii?q?MDG/snapwj5lIs2XbuAkrdEpTADP+BDvtwNTJ0?=
 =?us-ascii?q?E3NMCKcpArwSFuRd7kazsg9m67pQmZB8DxYh/XGQ6jpFDSrIcL6Ryz25?=
 =?us-ascii?q?Gv2471jwJOPKjwVlXWZoiqEZNRxjnfPOCfpvpWtLFNPslu7fsUGTEHyG?=
 =?us-ascii?q?h7zX1tBnwRPXWKEXjvtTtQxw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 17:12:10 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F01B62310;
	Tue, 14 Oct 2025 15:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3AC4CEE7;
	Tue, 14 Oct 2025 15:12:06 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 14 Oct 2025 17:12:03 +0200
Message-ID: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] coccinelle: of_table: Update Keywords for SPI
 device ID tables
Reply-To: Geert Uytterhoeven <geert+renesas@glider.be>
X-Loop: cocci@inria.fr
X-Sequence: 3087
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert%2Brenesas%40glider.be>

When adding support for SPI device ID tables, the keywords in the header
were not updated.

Fixes: 347b564599fb01d8 ("coccinelle: of_table: handle SPI device ID tables")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/coccinelle/misc/of_table.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 7ade9766dee89c70..9de406b692a590ba 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /// Make sure (of/i2c/platform)_device_id tables are NULL terminated
 //
-// Keywords: of_table i2c_table platform_table
+// Keywords: of_table i2c_table platform_table spi_table
 // Confidence: Medium
 // Options: --include-headers
 
-- 
2.43.0

