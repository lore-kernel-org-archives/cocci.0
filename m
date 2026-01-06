Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30C7D2ED12
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lhwaSoSDcJzaU6emLiSJOWLUcyi9EjvkM7Ru1loqRjM=;
  b=As5kpCOSWDtTDemSR+Gb56wNsgRlguftPANvzGt4VjCyspH3KVAdhfEP
   j8aM1ARX6MffLkkgzMhb4xT8wiyI1xlw/mCXvfhLh48biVAiCN2Sf+BX2
   2Z0RL3AQgbM652dqZm51UtQU8KK4LHOUDyISTeU+EoHKcfgW5npCjqLgZ
   w=;
X-CSE-ConnectionGUID: bG+T5obmQTesFypbhVvsAA==
X-CSE-MsgGUID: kYD2/1xuT6mgBFZw4FoW/g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259430440"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 11:48:39 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5BEAD83A04; Tue, 20 Jan 2026 11:48:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3965981EB1
	for <cocci@sympa.inria.fr>; Tue,  6 Jan 2026 20:09:18 +0100 (CET)
X-CSE-ConnectionGUID: 0GjaJlIiSjmuDcaqJumqrw==
X-CSE-MsgGUID: wBoSYw+zSKCa3BlF7RhMRQ==
IronPort-SDR: 695d5ddd_zktJKoWO1TamAU9CU1oSzYIyJjSs2v9twX5oX9KV+yhWpHA
 kCGcROxfutozjoYCxr1cEeRnnjD955eMBm9QG4Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GZBACkXF1pga/WVdFaglkCgj8WgVAzBFSiFjACh1OKT?=
 =?us-ascii?q?oFAPQIPAQMBCwEBTwIEAQEDBDiESAKMagIeBwEEMgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGTw1JAQwBCAGCAgGBJGECB?=
 =?us-ascii?q?QM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIsXwIBA?=
 =?us-ascii?q?xIgAQ0BGx0BAwwGEDsgAhEBBQEcBgEKCCKCYIIjAQYQAQM2AgGkfYEFQoxTB?=
 =?us-ascii?q?QIWgQGCDQbaYwoZKA1uA4FgAQICBwkBCgEBgTcBhHUpTw6COAGFHXGDfnong?=
 =?us-ascii?q?iiEfYIfgjmGDSIEgiJ6FIEfgyCQUwEHBx8SCAEcBggCAkgVEgMEAwQEAQILE?=
 =?us-ascii?q?wkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhICKQoDKgsSDwMTB?=
 =?us-ascii?q?RUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYDAsFA?=
 =?us-ascii?q?gonAw8BCQMfAwwIGAoBAQUWOAIJBgQVASAJBQMGAgULAg4BDwIUAgEDAQEGA?=
 =?us-ascii?q?gQEAwoGAgYFAgIBBAMHAgECAQIIAwIHAwIDAgEPGAMCAwoCBgUEBgICAwMEA?=
 =?us-ascii?q?gICCQEDBgEBAQECAgIDAgIFBgYIBAQEAQERCiABAwUCBAcCAQMCAgEEAQEDA?=
 =?us-ascii?q?wIBAgECAwECAgQCAwMDAwMEBQMBAQMCAwUCAgMCAgICBAEBAwsBAgQDAQUBB?=
 =?us-ascii?q?wUDAQMFAwQEAwIEBQMKAgIEAgMDBgMDBgMCBQIHAgIBBQUCAQEBAQwJAgICB?=
 =?us-ascii?q?wMOAwICAgMEAQIDBAMFAgMEAQEBAQQFAgMDAgIBAwUCAgEBAgIEBAIDAwYCB?=
 =?us-ascii?q?AIOAgEFGhEBAgYGAwIBAwUDAwMDAwIEAgICAgYHCwwEBAQDBQMDBQYDAQMEA?=
 =?us-ascii?q?wgDCgIEGAYFAgICAQIMDwMBAgoEBAMCBQIGCQMCAwMEAQM5HBMEBQIFAwMBO?=
 =?us-ascii?q?gMOBAMIHgIBAQIGAgEDAwMFAgMBAwIHAxQGAQYIAgQECgIDAwcGBQcCESgEA?=
 =?us-ascii?q?gICAgQDAwMKCAcEAwEHAwMMAgIQAgMHBAIDEwYDAwQDDAYDAQISGAYBAwcDC?=
 =?us-ascii?q?AMCBwQCCAcNAgQCCQMFBQEVBAIEAwICAgIBMQMDAwUHAgQBBAYBAwMDBwMCD?=
 =?us-ascii?q?AICAhIDBQIFBgIBAwwDBAMDBQULLRAEBxMKBgQDAwcFAgMCAhQGAgYMEgMDB?=
 =?us-ascii?q?AEEAgECAgI6BAMDCAENGg4CBAYFCgMDBAYBGAUCAwIDBQEDAQcHEgIKCAMOH?=
 =?us-ascii?q?gEDAgYCCQEDAQIBBxMPAwsJCAcMATwMBwokBAQMKgEGDhQHBCUZZwcHApALg?=
 =?us-ascii?q?ncBgQ0Bg3kBAQGVPY8PoCBCJQkBBgEBgkeBChU4gWSZeIV8GjOXUpMZmQYik?=
 =?us-ascii?q?XCSR4Q9AgoHBxEkEoE5ByyBXDMaI4EBbYFJTwMZD5Ihw2k7NTwCBwsBAQMJh?=
 =?us-ascii?q?UMmE4RZhVWBdIFLAQE?=
IronPort-PHdr: A9a23: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
 ZPqpHVFiVoLUQ==
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:5sJvl6gP13tnNyOSEdDQcCd+c3BQXvcji2hC6mlwRA09TyXBrb
 HWoB1p726NtN9xYgBdpTnkAsO9qBznhPlICOUqXYtKPzOWx1dATrsSi7cKqgeIc0aTmYA96U
 4KSdkdNDSENykfsS+M2njcLz9P+qjlzEniv5ak854kd3ARV0i+1WpE4yigYzBLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3AAkPAGWvRk8SbgYtDjDJC1T316It9XX/U7nPxInS?=
 =?us-ascii?q?6DHtFQ7SMa0KV4bl7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AIG/q6Q//pMULOk2XHA0dUo+Qf9hC5J+fFwMfqrY?=
 =?us-ascii?q?tspKuMQIvATe4tg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,206,1763420400"; 
   d="scan'208";a="257289667"
X-MGA-submission: =?us-ascii?q?MDHijl4FWaj+G4S9N9NObXgys8Lr9GdB2BqvMo?=
 =?us-ascii?q?ukrIH+XDH+liOfwqOyd7LxCNoUxZlbE6FZF9YjTZDe8X7wqCiPRvPL5s?=
 =?us-ascii?q?W15w7zUexz1HhD1+BrLORlF9RyWa49Xr5R45FHW81cuL490OGqhPuYdi?=
 =?us-ascii?q?shdYscJnBpUIdYoCd2jREznw=3D=3D?=
Received: from mail-pl1-f175.google.com ([209.85.214.175])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 20:09:17 +0100
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a07fac8aa1so12842685ad.1
        for <cocci@inria.fr>; Tue, 06 Jan 2026 11:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767726556; x=1768331356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhwaSoSDcJzaU6emLiSJOWLUcyi9EjvkM7Ru1loqRjM=;
        b=Qy7c0ceZY07MmtE6oRARxopObZT4FzD/o9lJ0JvD071Uu9C7CVA1I+4UhRVjxhGpVa
         Y1aUxi2P8ttP+pXg1MV/OL3tyZlSeY3CyOluaDJ1tgXXyie2/p//al3LCAF4q/q3KbJn
         VWpB8Dv3WA0lFmboTj62LnCZ+DF1AF5rRH52Lwm8l3zHkTblbaageYuhCyhQpwhEHdcG
         FCXZ7/Mar9ykZIncVbWVJNRWRMIuqkTiXk3wXe/R9FcReOX56aqhwijmvW2agEHybFP8
         CtgFYeDerk9hRAnWYHhLdTXkBov5UZdjywfOCQftILQkHNaXjVvrcDpYQoX/YU5uEtFy
         OWKg==
X-Gm-Message-State: AOJu0Ywkonf9obz1yTXtA7kSXiFvS8DC5nitbNWh1XwT3AVmfhhdMmhT
	YkmXJttcLFihkQvHQVCdYyhX/OaoJyV/odNeKe9T+gd5Ih8htqgg6LAq
X-Gm-Gg: AY/fxX6S2CKwNHlIJSAxJHKTEnbTf70kKJSiC2zH1DrcBwCkz7BM//P2KqgnIx5RuSv
	/PyCcwV9TEDAM4HJsdQbMdHa6kXNhVcX/ngCxfhzn9gl3U94qyPJGM/RFasbfIMv64/3iMT1gv3
	r6+ftwL4eru5eOWAR7LDMFjZfpVm7WehJZXx8TxQ7WJLeiw2cJrBPQ+rZZ9TPs1eWuV+ppzdsKT
	LhTC9rsT+wm2amuLQtH+qI4ljuEcg+pjpzg4uCI3bQD+GHUsoN2rtpyDXja+fyvq3QHdArPirpw
	FMhbDZk9uQTH9gkPMQVZWgxrSiYt/QLRk3F6s7KpupjNU/Mnokfabexdcq7ngtPtf2XFvVedQiZ
	kaIwLxLtpaidJKtP47Y/Olft/iYzumIrgsxO69nHZqOSh8QJow5dPL4Cd8HuNOmN41eRCgJozJj
	eE3C+B141DfrngTXuDSA==
X-Google-Smtp-Source: AGHT+IG/FutjzhU827sNvJPVoR5OnV23bzd0idPEqRV+0+0JnOaD0+CqzPWXI3rmEXY695v5Rtx7sQ==
X-Received: by 2002:a17:903:b45:b0:2a0:b62e:e016 with SMTP id d9443c01a7336-2a3e2cfcf9dmr34016045ad.32.1767726556016;
        Tue, 06 Jan 2026 11:09:16 -0800 (PST)
Received: from rivendell ([101.0.62.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc78c0sm29380975ad.69.2026.01.06.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:09:15 -0800 (PST)
From: Benjamin Philip <benjamin.philip495@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cocci@inria.fr,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Philip <benjamin.philip495@gmail.com>
Date: Wed,  7 Jan 2026 00:38:34 +0530
Message-ID: <20260106190836.36630-2-benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106190836.36630-1-benjamin.philip495@gmail.com>
References: <20260106190836.36630-1-benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH RESEND 1/3] scripts: coccicheck: simplify debug file
 handling
Reply-To: Benjamin Philip <benjamin.philip495@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3282
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/vHWT8u9X29U5h9fBvnTjpA>

This commit separates handling unset files and pre-existing files. It
also eliminates a duplicated check for unset files in run_cmd_parmap().

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 scripts/coccicheck | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 89d591af5f3e..2efb74afef2b 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -138,7 +138,7 @@ run_cmd_parmap() {
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
 	fi
-	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
+	if [ "$DEBUG_FILE" != "/dev/null" ]; then
                 echo $@>>$DEBUG_FILE
                 $@ 2>>$DEBUG_FILE
         else
@@ -259,13 +259,13 @@ coccinelle () {
 
 }
 
-if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
-	if [ -f $DEBUG_FILE ]; then
-		echo "Debug file $DEBUG_FILE exists, bailing"
-		exit
-	fi
-else
-	DEBUG_FILE="/dev/null"
+if [ "$DEBUG_FILE" = "" ]; then
+    DEBUG_FILE="/dev/null"
+fi
+
+if [ -f $DEBUG_FILE ]; then
+	echo "Debug file $DEBUG_FILE exists, bailing"
+	exit
 fi
 
 if [ "$COCCI" = "" ] ; then
-- 
2.52.0

