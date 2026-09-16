Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81738C982C1
	for <cocci@archiver.kernel.org>; Wed, 16 Sep 2026 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=/vzELjvxkLjKklSg3OZap3PZaxFxyxgcG6xlOQMfPgM=;
  b=JmBSVLyZqtJ7/OGYuSDBY5DuB/iwi6lKKup75VG1Ru5Y7k58jqxskr+O
   CkdK3ydyh64eV7wvyLN83vtuUT9ZZOrYVZh5g2sCN7lF+si45t4SpAV1k
   yHF/205rwtB3f+pDC5D44x3a/llDjeFUouEF6A0YDPif98YpuihDLDEDV
   c=;
X-CSE-ConnectionGUID: ovm8Ro29RVCrgL5AI7w7LQ==
X-CSE-MsgGUID: a0wDfLakTLG4fhNlCD8h7g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="295251557"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2026 11:57:07 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 93D33827F8; Wed, 16 Sep 2026 11:57:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BC59D82718
	for <cocci@sympa.inria.fr>; Wed, 16 Sep 2026 11:56:22 +0200 (CEST)
X-CSE-ConnectionGUID: uogLaGxxSm+ZTfV5gvxBew==
X-CSE-MsgGUID: 7cXjazibSmyn6fXwi3MeAw==
IronPort-SDR: 6aaa67c6_OWIS3XTWyQ1RqbgxxTQ+C58WwCv02glsOwcbbSr4le1Ozhk
 CgyY+a/5ieciVRlHyHOOIyHFtskuSZz6qdNWCmQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H+BwBYZqpqd6DkfUpaglkCgj+BC2EzBFQEjU6IeWyLE?=
 =?us-ascii?q?IxEhV4UgSs9Ag8BAwELAQFEDQQBAQECAwE3AYRGjgoCHgcBBDAJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABIhwFDjuGTw1JAQFKh?=
 =?us-ascii?q?kWCLQcBggsBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAg0fPwEhNgENARsdAQMSEFsCEQEFASIBEoMCAYIiAQYQA?=
 =?us-ascii?q?QM3AwMOtjyNBwUCFoEBgg0GgmvYAAoZKA1yA4FmAgIBBgkBCgEBgTeEeCpPD?=
 =?us-ascii?q?oI/AYUidkSCVWmBIYIogRWDaYIfK4E8UoYwBIMulEUBBwcfEggBHAYIAgJIF?=
 =?us-ascii?q?RIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISK?=
 =?us-ascii?q?woDKgsSDwMYFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIA?=
 =?us-ascii?q?gsFERgMCwcxAxAJAx8DFBYIRQgGFgEaBgUGCzcVBQwRAQIbAh8EHREIAwEbB?=
 =?us-ascii?q?AIBBwIDBBYEAhQKIQMDAgMFAQMDAwUCAgoGBwEBAQMCAggDBgMKCQIFAxsYB?=
 =?us-ascii?q?AECAgMCAQIIAwcIAw0DBAIDAwMEAQICAQEBAgMBAwMEAwEDAwIBAwcCAgMDA?=
 =?us-ascii?q?wsBAgMDBQMDBQUCAgUFAwUCAgoCAwMDAgEDAhoIAwYDEgEQAwMGAQMHAwcCB?=
 =?us-ascii?q?AMJAggDAwgIAxcDAwUBAgIEAwMICAQDAwQCAgMMBQMCAwMFAwMHAgQCBAMDA?=
 =?us-ascii?q?QUBAgcCAwcCARgDAgQIBwcFAgsEAggEDQkEAgQCAg8EBgMDBwEBAgEHBQYDA?=
 =?us-ascii?q?gIQAQgKBQYCAgIcAx0BAw8GAQkFAgEFDgcFAgIYAwYCAwYFAQMBCgsBAQIDC?=
 =?us-ascii?q?gECBAIFAwMBAwIDAgYDAwIFBQUDCQcFDgkBAwMGBQICAwIDAQIIBAYFAwICA?=
 =?us-ascii?q?wUBBAMEAwoDAggDAwgDDAIaAgUDAwMGCQMHBwIDBwMCBQIHBQMDBQMGAQMCA?=
 =?us-ascii?q?QMDCAsVIgMBBQMDAgEDAgUDAxgCAgQFAwMDAwMIBAICAQcGBAICAgEFBQUEB?=
 =?us-ascii?q?QYCBAMIAQEFAwMKDQECBwwDDAYDBwMDBAQDAgUKAgQBBwYHBwkHAwIDCAEBC?=
 =?us-ascii?q?wQBAwMKAwMFAgEBBwUDBgMHAgMDAwUEBQMCCwMHAgIDAwMCKQEBAQMDAwMDB?=
 =?us-ascii?q?AMBAwEDAwcDBQMCDgIIAQoDAgYDBwYDBQMDAgECAwMFEQMGBAUGGQIGEToBC?=
 =?us-ascii?q?AIDAwEUBAQFBQIFFQIIAQMDBQMDAwMCBQMBBQEBAwMFAwMDAwMDBAEDBAIDB?=
 =?us-ascii?q?wYIAQEBAggDAwIFAwMDBAMDAgECDQQCBQMGAgIEAgQBBwMJCQgHDAE8DAcKJ?=
 =?us-ascii?q?AQEDCoBFRQFBCUZZwcHj0QfgmCBDixQgS01gRwBkhwLsko0MwoGAYJJgQpOg?=
 =?us-ascii?q?WaKPI8+hXwaM5dTkxouh2aQdCOLbYF6hAmSEDeEPgIKBwcRJBKBMjqBXDMaI?=
 =?us-ascii?q?4EBbYFJEgE9AxkPkiSBPoNVxwZENQIBATkCBwIHDgMLiAKCUYdJgUwBAQ?=
IronPort-PHdr: A9a23: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
 55LTg==
IronPort-Data: A9a23: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
 uGQ3kUD
IronPort-HdrOrdr: A9a23:hhbc56xSKpi0oP5arU7XKrPxDOgkLtp133Aq2lEZdPULSL38qy
 n+poV46farskdzZJh5o6H/BICpWnnc9YF47M04IN6ZLSPbUQuTQeFfBYuL+UyaJ8SMzJ8t6U
 4ASdk1NDSUNykfsS+U2njFLz9L+ra6GZ6T9LnjJhtWPHhXg08J1XZTNu60encGEDWuL6BJQa
 Z1fqF81hKdkU1+VLWTOpHuN9Kz8OEj7aiWNyLuZCRXpTVm7wnYl4ISSCLoj2ZPb9on+95Lmg
 Kq8n2fl8OeWpeAu0LhPkDonsdrcbDau4F+7bm3+7Uow0LX+3yVjepaKsW/VA5empDy1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6xmxLY0IPEbQN/L/AEqZNScxPf5UZllsp7yr
 h302WQsIcSJQ/cnR76+8PDW3hR5wSJSDsZ4K8uZk5kIMgjgYxq3M4iFYRuYdI99RfBmcAa+S
 9VfYXhDbhtABSnhjvizxlSKZSXLwcONybDZFMDtMyT2z0TsVRQ9GFd/8AUmGwMnahNZqWsit
 6pDk0vrsADcuYmKZlmHe8ETI+eAHHMRxWkChPKHX3XUJocInrIptrO/Lko6KWLdfUzvcAPsa
 WEa0lAvWo+P3jjEtKDx/Rwg0jwqG7WZ0Wz9uhuo6JhsrnwAIHmKzGHVTkV4o2disRaBcueU+
 24OZJID5bYXDnTMJcM0AvkV5ZIL34CFMUTp9YgQlqL5tnGM4vwq4XgAb3uzRXWYEAZs07Ecz
 I+tQLIVY19x1HuXmW9jAnaWnvrdEC695p0HK/W9/NW0oQXNoFX9ggTk0mw4cuGbT1O25ZGCX
 eWDImX5Z9T/1PGj1ogx18ZTiZgMg==
X-Talos-CUID: 9a23:ZJncomC0W0ieJPX6EzRg+2odNdA1SXie/kveHRK3F3ZDRaLAHA==
X-Talos-MUID: 9a23:x6zaeQWS7/MCLknq/GDntDNrJsZi2KG/Dh4DoYoH4OyJHDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="157070757"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHR+r2RrkimyKUtCSuET8M8Kd18qUYNdAH06r?=
 =?us-ascii?q?lxrH8SJzlGT6N1wyGf0JsHsxg04X0VU4WcXZz1iyCs8LYPX75rP2Kds2?=
 =?us-ascii?q?CfSgHi7GpVZ1TizJnrTPvNM/De9h3KZU9hpjQkuXKLcBJzeLgC0knw9J?=
 =?us-ascii?q?icHbzEO1+dqqr47IvvxnPhbQ=3D=3D?=
Received: from mail-ej2-f32.google.com ([74.125.228.160])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 11:56:23 +0200
Received: by mail-ej2-f32.google.com with SMTP id a640c23a62f3a-c254f55efebso123501666b.1
        for <cocci@inria.fr>; Wed, 16 Sep 2026 02:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552581; x=1790157381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vzELjvxkLjKklSg3OZap3PZaxFxyxgcG6xlOQMfPgM=;
        b=2034xOttRbmIGugj4dSutbstojYLU9A6mh81bUBLA4v//06K6V4tYdxHtt0lrJR+Rg
         1bCg3voRr5h4aAT3xWW9le5K2rhmo+wawt9Ayda7Cq92lMCIyO+hwh3ERFt1NlrVjo/t
         essbDiX4yd+rSloeFCwEgpJXAej2SJLVthLHeshgc8nIrKttZG6tiE+7SxCxIbe2AdcS
         pDpLAQUL8Mw/CnV867UVRW7d4yLWZA8KdC0WaVL1T8hGAsXjO9NoG6xspKKX2JQKvxL0
         4qmnaVEnX9h2ROP/MwfqgX4fL6a8oLu+JIWS8GhtYqN9sDIQot5JPEq6o+aETByHGXFx
         t9Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwQ2Yn28r0xgverHu6Vh8JgS3vddH1+sMOKcNZAfTPCWyxjnLpz4uqtCCK+gA+GSHCjle05Hw==@inria.fr
X-Gm-Message-State: AFuF++l6VRSA5RGd/XytDU/hOjxWfh5iEr6xP/lwnCzMDnUCD52pivTO
	/MDbVmb9XeOHktvkmJGPMxffXuRfU5jjE8kjbmNTE5g5RMMWktmeAFlb
X-Gm-Gg: AYBFou1BPvPEToEilT6pJTb58bnRVzt6krcGvBf10FZkhlhZnsec55WFtfdxTOvy8Bz
	kIUv7Q3beKF2uAxhVbGs/3FhbBtwJ9rieAlCqGF7CRKzHDxmTfNdisqmlxTj+QgJsVcZ/W3Z09G
	3QzLdpbtTR7OSBLX7IkdlT0zlBB3s39fDP3iB9a/MzAiT/RFKIOfJsBOp+1cQj0zivIWZMo8XdX
	Y17zrPF3mF/G/8bHmEBjgYJ4Zto0vY/dviFI4Y5ZbaaINYqtul3HZDQWORYDA3Di4XkF40RZsff
	oZynf8u5PSTaMa0rdvIMDbbWlYLkKO7SqVsVpwWiOdz7NHGKpyU/cUV7vz8EXh4vWyHMyDCfrjE
	HA5t8DvWm3EmcrUMuAajrsTAQYfH/UMg47+R5LPX4wnn0Q4JAnPrsCqnk6Iq+GGonCdZxxFnXvo
	gxHTuSDJT7qseU4qNb6wvwftWabnI+y9leVfGQNInF9WZT0gykNiGTCcqAbXvqPiqmCAt7f7Unk
	IwDgSX9vWR2YVL2RBo9BzIXX+8h8KL6W0z/KmKXu7DE/EDalY/mEkix9TAXD9QUb769AlMA29i2
	HAGMHNQwklcab6XE6ACARFz71T9H0KiWIMInPidFEBHgK18SnfYG9SJ0qOhBhIba2iyNzOTRx90
	nZp4Mlh6zpTok6dOoRUPe6Nwhf9BVxASkBWZjd4YYNqkeyj0HSri4WWhyWrtP095Vx/TtpFZijP
	GrXP4hQiC/6pax9yRilxMTzIxA8bHWKuLHJv7dgo4FcCj86kjbBNoiCnI9pHQS6BuDhhL/2hK1j
	RPujt/vwTTcDdRFwH9h1H41
X-Received: by 2002:a17:907:97cd:b0:c25:192:99ee with SMTP id a640c23a62f3a-c29e51f199amr125936466b.19.1789552581020;
        Wed, 16 Sep 2026 02:56:21 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (129.63.90.34.bc.googleusercontent.com. [34.90.63.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de455d58sm102564866b.16.2026.09.16.02.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:56:20 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Wed, 16 Sep 2026 09:56:16 +0000
Message-ID: <20260916095616.1394-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Joshua Crofts <joshua.crofts1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3738
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/LxELDb-BMo7-k5uZXqkd4g>

Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
called in a file if pm_runtime_use_autosuspend() is called and its
devm_* counterpart isn't present.

Assisted-by: LLM
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Running this in drivers/ yields 195 results, due to
pm_runtime_dont_use_autosuspend() not being documented well enough.

Changes in v3:
- Remove note about resource leak from commit message
- Link to v2: https://lore.kernel.org/lkml/20260915064327.1377-1-joshua.crofts1@gmail.com/

Changes in v2:
- Send correct version
- Remove unnecessary position variable
- Remove metavariable
- Link to v1: https://lore.kernel.org/lkml/20260914151145.1328-1-joshua.crofts1@gmail.com/
---
 scripts/coccinelle/api/pm_autosuspend.cocci | 64 +++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 scripts/coccinelle/api/pm_autosuspend.cocci

diff --git a/scripts/coccinelle/api/pm_autosuspend.cocci b/scripts/coccinelle/api/pm_autosuspend.cocci
new file mode 100644
index 000000000000..581e874cd10b
--- /dev/null
+++ b/scripts/coccinelle/api/pm_autosuspend.cocci
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find drivers that enable autosuspend via pm_runtime_use_autosuspend()
+/// but never call pm_runtime_dont_use_autosuspend() anywhere in the file,
+/// while not using devm_pm_runtime_enable().
+//
+// Confidence: High
+// Copyright: (C) 2026 Joshua Crofts
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Options: --no-includes
+
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+// Detection
+//----------------------------------------------------------
+
+@has_use@
+expression dev;
+position p;
+@@
+
+pm_runtime_use_autosuspend@p(dev)
+
+@has_dont@
+expression dev;
+@@
+
+pm_runtime_dont_use_autosuspend(dev)
+
+@has_devm@
+expression dev;
+@@
+
+devm_pm_runtime_enable(dev)
+
+//----------------------------------------------------------
+// Context mode
+//----------------------------------------------------------
+
+@depends on context && has_use && !has_dont && !has_devm@
+expression dev;
+@@
+
+* pm_runtime_use_autosuspend(dev)
+
+//----------------------------------------------------------
+// Org and report mode
+//----------------------------------------------------------
+
+@script:python depends on org && !has_dont && !has_devm@
+p << has_use.p;
+@@
+
+msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend() or devm_pm_runtime_enable()"
+cocci.print_main(msg, p)
+
+@script:python depends on report && !has_dont && !has_devm@
+p << has_use.p;
+@@
+
+msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend() or devm_pm_runtime_enable()"
+coccilib.report.print_report(p[0], msg)
-- 
2.47.3

