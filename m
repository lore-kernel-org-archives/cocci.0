Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9045BCCD1A5
	for <cocci@archiver.kernel.org>; Mon, 20 Oct 2025 08:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=jD6ByExhZVwQlGpLHFGQjP44ok8RQvvCqWB7DPZxKZ8=;
  b=OljsWxdfO3sFPgATCFdbnIH2h19i7dGXiiq+TAl2R5aGCJ42oq/1A+dr
   +sgrIsIzXQJhtgsmxFGrpxMNDLjr6XeHO04Qn7A5iCC6TYx4zxGXF74ma
   36Rg/PtXM6IAs92635l21urn6UGyDyoIqzrro/6guyjIrW7Q4HALvUSQi
   0=;
X-CSE-ConnectionGUID: cQLbm6knSWWmZHUz8Amx2Q==
X-CSE-MsgGUID: t1PeVbxUQCiY4sfHtaRZxQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.dev
X-IronPort-AV: E=Sophos;i="6.19,242,1754949600"; 
   d="scan'208";a="245166589"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2025 10:45:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 227B6E1171; Mon, 20 Oct 2025 10:45:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 58478E0171
	for <cocci@sympa.inria.fr>; Fri, 17 Oct 2025 12:30:55 +0200 (CEST)
X-CSE-ConnectionGUID: Q+cyK4EPRFOSoCNcbkRYsQ==
X-CSE-MsgGUID: PyLyZhHURXOLGOW/awGuXw==
IronPort-SDR: 68f21ade_YBcC9SJOsonvIDB23buvinZsDlnmMcehkBUNTfhvc4dDb4q
 OSJOvbctIe1Gj0sl20f0gSv9SCaPKwHB+tCMG7A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EiAAAiGvJoj7Sv2ltaHQEBAQEJARIBBQUBgX4GAQsBg?=
 =?us-ascii?q?j+BXzQHCEm0ZYFoFQIPAQMBDVEEAQGFB4xOAh8GAQQyBw4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYZPDYJiAYQCNgENA?=
 =?us-ascii?q?QE3AYE8AYMUgiMHSgevD4IsgQGCDAEBBoJo2T2BZAkegSwBhWyLZml6Jw+BV?=
 =?us-ascii?q?USCUIE3dmmDIU6GL4ImgQ6GMJEagWYDWSwBVRMXCwcFgWMDKjQtbjIdgSdBH?=
 =?us-ascii?q?HOEXSFoDwaBE4NUBolhD4YqAwttPTcUGwaTaIJ7exPJJjQHhB+BXgYMn2caM?=
 =?us-ascii?q?6pqAS6YWCKpH4FvCyiBXDMag1pPAxkPjiEZhCjCFEQyPAIHCwEBAwmRajSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:Ps8xRKwIOXvPgmfwIIHeKrPw+b1zdoMgy1knxilNoG9uA6ulfq
 GV7Y8mPX2dslwssRQb9OxoV5PwI080maQV3WBzB8bHYOCFghrKEGlihbGSuwEIcheWnoUwus
 ldmsNFebvN5DZB7foSyzPIaurJT7S8gdqVbJ/lvhJQpW0GUdAe0y5JTjyDGkkzfRJBD5YiDp
 aQj/A32wZIZ05nE/iGOg==
X-Talos-CUID: 9a23:aAZyBm5lIQAGG/Anr9sszQ0fC+N5X0Xn4lDrJGSeAmxqcoyOcArF
X-Talos-MUID: 9a23:KwbaWAXyZ6zpQabq/Af9oCBQNOdV2ZSJLG8qrtIPpOaZBTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,236,1754949600"; 
   d="scan'208";a="128488812"
X-MGA-submission: =?us-ascii?q?MDGTxBkP1kI7PxBroA3PSpqVcy3M+avW6g8kYh?=
 =?us-ascii?q?/evLbfTw4oE85FzC3qdISqAeVr1IB869lX0G9TzbZwlKIL585AZDQ2cI?=
 =?us-ascii?q?xgG1Cr8knLeQ+FN/9S0NfhzPmYZVzVHW++KeXIsnzy8wb8T/IOEjMn7J?=
 =?us-ascii?q?HZB0ttSIhi0fTz9IEarTzqaw=3D=3D?=
Received: from out-180.mta0.migadu.com ([91.218.175.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 12:30:55 +0200
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760697053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jD6ByExhZVwQlGpLHFGQjP44ok8RQvvCqWB7DPZxKZ8=;
	b=Lws5ZyzqAFII3Xwx+Pj9x0HSXMqWQ152JNcmntX8R8Z7dOcPurrfhYNaNWTwilv3vDKUdg
	jngMc0JQ51CGLQo1mhV7iqRye44c73r2w2p/Ummfp/ftXHUcuJRIk2jTktqQSvteBuwOhZ
	EuUIklBTTV9XrRGYJkDeZ0xTbAFWtvU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 12:30:30 +0200
Message-ID: <20251017103032.75686-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH RESEND] Coccinelle: pm_runtime: Fix typo in report
 message
Reply-To: Thorsten Blum <thorsten.blum@linux.dev>
X-Loop: cocci@inria.fr
X-Sequence: 3089
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/20251017103032.75686-2-thorsten.blum%40linux.dev>

s/Unecessary/Unnecessary/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 scripts/coccinelle/api/pm_runtime.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index 2c931e748dda..e29ac3a87d96 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -110,5 +110,5 @@ p2 << r.p2;
 pm_runtime_api << r.pm_runtime_api;
 @@
 
-msg = "%s returns < 0 as error. Unecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
+msg = "%s returns < 0 as error. Unnecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
 coccilib.report.print_report(p1[0],msg)
-- 
2.51.0

