Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34990CFA466
	for <cocci@archiver.kernel.org>; Mon, 24 Nov 2025 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=cydIk6Z1z9GXF5ZLDMKKZHeBCtPJ+8n4DUMOXggGlk0=;
  b=J0QSsDmcMe+lfI5kx2YgHtgpgzwBIRtmVHI4OjNGjBItt02jMlBtHFLy
   TNriMSZFNdrE+wTK/quPrv5NiQzvKfIDAi0gK7EQlSBwNa08sDFC0sIj4
   qUn9VTyj10UQdZp4CwCRBZquuhby1lPlrjoGqwuxLNF6LheuMPMfgyOFO
   M=;
X-CSE-ConnectionGUID: mwaU+xCcTO6oivL0ippeIQ==
X-CSE-MsgGUID: EPeoq8CtTGaBZZeg6Csz5A==
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
X-IronPort-AV: E=Sophos;i="6.20,222,1758578400"; 
   d="scan'208";a="250813924"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2025 11:30:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 265ABE0CD5; Mon, 24 Nov 2025 11:30:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C2C65E0171
	for <cocci@sympa.inria.fr>; Sat, 22 Nov 2025 12:50:02 +0100 (CET)
X-CSE-ConnectionGUID: jlmCnttzSWm2XAbb+psDcA==
X-CSE-MsgGUID: AMM1KnFwQ22MRzlQCMNwQw==
IronPort-SDR: 6921a36a_J0ig+gAD/8zx0v3AUtErK5WF2Vo3mfoQ8aLjQJvsqXRX7Gl
 fPODosczZ6o2CVx5DDlQKGhhVur8Bfd2+DyjqaQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFAQBYoiFphb2v2ltaglmCQIFfNAcISbRmgSUDQBUCD?=
 =?us-ascii?q?wEDAQ1RBAEBhQeMYgIfBgEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQEBQEmGTw2CYgGEAjYBDQEBNwGBPAESgwKCIwdKB7FPg?=
 =?us-ascii?q?iyBAYIMAQEG3CWBZAkegSyFbotpaXonD4FVRIJQgTd2aYMhToYvgiaBDoYnk?=
 =?us-ascii?q?0CBZgNZLAFVExcLBwWBYwMqNC1uMh2BJD4YcYRdI2gPBoESg1EGiRMPinADC?=
 =?us-ascii?q?209NxQbBpVZUYIuexOCQMZmNAeEH4FeBgyfZxozqmoBLphYIqkfgW8CMYFcM?=
 =?us-ascii?q?xqDWk8DGQ+OOoQoxk9FMjwCBwsBAQMJkWo0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:0eX/uqjk6qYS9zcUgU+Qp5t19HBQXtgji2hC6mlwRA09TyVXra
 +TdZMgpH3JYVMqMk3I9urgBEDtex7hHP1OkOos1NWZPDUO0VHARL2KhrGN/9SPIUHD398Y8a
 dve6VjTPL0C0YSt7ee3OBOKb0d/OU=
X-Talos-CUID: 9a23:V5Mi3G2IgKX2+RUpUhYsMLxfGMQgWXvB0GXrHEriOU9jQv6NUnOb0fYx
X-Talos-MUID: 9a23:GxCCtApB6W1+xgxEG94ezxhHEZ5L5YqxMRpXtK8Uv/CvEApvAijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,218,1758578400"; 
   d="scan'208";a="250632226"
X-MGA-submission: =?us-ascii?q?MDEItWoFEq+mqh6GC2rpIcmgjeu6eHaRHrRcbW?=
 =?us-ascii?q?zYItcom+iC2MEvJgeT5NhofsROK0o9Of3Ijl28rao4j998WBaObQtuYM?=
 =?us-ascii?q?qPTFIMRyIx7LSgx4ZJy1IQw37YXOJ8qKs6sQgCaWBn7ug2IeSvZklt6E?=
 =?us-ascii?q?AydXbwkQKVH3HjlJFqzFMCOw=3D=3D?=
Received: from out-189.mta0.migadu.com ([91.218.175.189])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 12:50:02 +0100
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763812192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cydIk6Z1z9GXF5ZLDMKKZHeBCtPJ+8n4DUMOXggGlk0=;
	b=bddVMRaKV/LVrbO8c9vUadaF8hiVkBuCrrCaJT8NZeB28ih/MiVqzd4uubTuXxRDu0g8Po
	dji1j0DPRlijNqPufDGyHlV3/sPQKAnq3UcXGcdxVF2y2FgBFSjihKctYNTOlQFGWFBRg3
	LDFXPhZw9/kxSHuEDDrZiWJdQ1lh0uU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Julia Lawall <julia.lawall@inria.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sat, 22 Nov 2025 12:48:04 +0100
Message-ID: <20251122114806.447303-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH RESEND] Coccinelle: pm_runtime: Fix typo in report
 message
Reply-To: Thorsten Blum <thorsten.blum@linux.dev>
X-Loop: cocci@inria.fr
X-Sequence: 3196
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/20251122114806.447303-2-thorsten.blum%40linux.dev>

s/Unecessary/Unnecessary/

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
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
2.51.1

