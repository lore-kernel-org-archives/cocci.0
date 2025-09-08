Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644F4CAC5A0
	for <cocci@archiver.kernel.org>; Wed, 17 Sep 2025 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=jD6ByExhZVwQlGpLHFGQjP44ok8RQvvCqWB7DPZxKZ8=;
  b=MJ9h11ShVPBLAvFC0+/yukxxXLpX03OIgs9O1OaMAx5dQ8f9f5i/50Pe
   nbVMtT6TddcFuzLO+QA8gN8P7Tjn6A4y7ykghbNKrPAijHHFNZu2I/ZZ5
   N5C1DigqS6TLnGVE66qcuUt6z5GPooRo4ESnhkSO3Dbhb8rDX5xsaSiEV
   8=;
X-CSE-ConnectionGUID: MZg9usFBRvaLdbccCNiNgQ==
X-CSE-MsgGUID: MxgE1UCzTIC7gNqsY2ZRNg==
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
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="scan'208";a="239634536"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2025 14:46:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B588E0CF9; Wed, 17 Sep 2025 14:46:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 908B9E0171
	for <cocci@sympa.inria.fr>; Mon,  8 Sep 2025 22:42:57 +0200 (CEST)
X-CSE-ConnectionGUID: jMFwHUm3R1iYxjB4Cb5hbw==
X-CSE-MsgGUID: 3RpyS8wGQpmduTpOUzjLxw==
IronPort-SDR: 68bf3fd1_jBnreyrKJepkVC4t9Z/BXN6+yBdSxlUbfcO54LLN8Ft5NB8
 JVRcEsvqomP3FW+oXQdSr3uhzM19UB7p4bLwQAQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FJAABLPr9ohbM6119aHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?gQBAQsBgj+BWjQHCEm2SxUCDwEDAQ1RBAEBhQcNjCMCHwYBBDMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgmIBhAI2A?=
 =?us-ascii?q?Q0BATcBgTwBgxSCIwdJB7BTgiyBAYIMAQEGgmjZPYFkCR6BKwGFa4tlaXonD?=
 =?us-ascii?q?4FVRIJQgTd2aYMhToYvgiaBFpAxi0GBZgNZLAFVExcLBwWBYwMqNDFuMh2BJ?=
 =?us-ascii?q?4UNhB4rT4UAhGokaw8GgRWDXQaEWUADC209NxQbBpYxgy97E8kmNAeEH4FeB?=
 =?us-ascii?q?gyfZxozqmoBLphYIqkfgX4kgVwzGoNaTwMZD44hGYQouE5EMjwCBwsBAQMJk?=
 =?us-ascii?q?Wo0gUsBAQ?=
IronPort-PHdr: A9a23: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
 oOw6isfikRmcNdsY6nRK6NF0x5bgafc50eV
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:BNcNS6ONRH0JzMBcTgKjsMiBIKoaSvp033AA0UdtRRtJNumVkM
 6ynZ0gpGfJYVcqKRYdcLW7U5VoLkm8yXcY2+ks1NSZLW3bUQmTXeNfBOLZqlWPJ8S9zJ866U
 4KSdkaNDSfNykYsS+D2njAL/8QhOOg14CDwcr971ModyFFTMhbhTtRO0KgFEp3Tk1nKPMCe6
 a01458oT2hczAyQa2AakXsC4D4yuH2qA==
X-Talos-CUID: 9a23:dGsmBGHO8SlBnISRqmJl0WALOv0gKUeEzUbAIWXkImw0SLeKHAo=
X-Talos-MUID: 9a23:B4o+jwhQx6WRhti5gLECrMMpb/1w8p/+F280iZAKpvWcEhFiORONk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,249,1751234400"; 
   d="scan'208";a="124976914"
X-MGA-submission: =?us-ascii?q?MDFIxz96k9XBhWsjl4K2hzPJC9k1OOuWlLSWPk?=
 =?us-ascii?q?vum8493bvfqqq3bCbk0hqQjwhPbqBRc7Tpk57bKfND8Nt+9JLt0TwJuG?=
 =?us-ascii?q?zqQNizem+lk+Yctw++gJtFUQvzNpQmSyQJ5zgmi4dVdhUf35gpuYswoo?=
 =?us-ascii?q?OoWncrjyqXeF/8r+l9z0CBSw=3D=3D?=
Received: from out-179.mta1.migadu.com ([95.215.58.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 22:42:57 +0200
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757364166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jD6ByExhZVwQlGpLHFGQjP44ok8RQvvCqWB7DPZxKZ8=;
	b=jg/+o7q9dj/+8g+9xTe/qdOqGgLHCUcmMv5/6CNKBrTiX2j8yuA1no+qEOhGceuPG9+1q1
	5DMxdPdExMhbky7lRx/X07zWWx0/rSc0JA+Dr6L/RWOOG/SGrMdsnHnrl8/BCyr3/DXyPi
	iShxSJDuQ4DEIONvkTi7Zldnc6bnUTA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon,  8 Sep 2025 22:42:23 +0200
Message-ID: <20250908204225.476116-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] Coccinelle: pm_runtime: Fix typo in report message
Reply-To: Thorsten Blum <thorsten.blum@linux.dev>
X-Loop: cocci@inria.fr
X-Sequence: 3024
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/20250908204225.476116-2-thorsten.blum%40linux.dev>

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

