Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B878C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wDObpA7RQnlY6KsOhvuFRPLttcc0bMB5PHs3ILqM3SU=;
  b=VkgURIaQ/xGw3WuZes6YcM/awgYOoJICmdoD0duIOZVmnMUKO/QXbna0
   Etcm95/r3hOCJhWiHfl55rU3u9NDWm1lCO3DOqF1iq/6uYWp2vF4DkAF3
   hByOkfK6LoFTb+pKGzhUci5vGibnun6aS8V1neX+1V8DR2whL1rQN4j/X
   U=;
X-CSE-ConnectionGUID: Gkm+FyHCRWmiln3UjI1JKQ==
X-CSE-MsgGUID: ZbAcZFw7QVyp5WWyPp00Pg==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287733726"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:22 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 95A4F8040C; Fri, 24 Jul 2026 10:54:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 45655819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:53 +0200 (CEST)
X-CSE-ConnectionGUID: x9JakMSnTIqRSZ9tliYtAA==
X-CSE-MsgGUID: CJeiT6LCR5uGvvVuvjM+Wg==
IronPort-SDR: 6a62619c_1rUxUwkecA8M/k5IdSaSOE66DCfvpmaSqi7zR9fboSTKUNW
 Y72mlwQ27frrjNLu0OXqjQ+LLHVajjYntDNoMSw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqgTPYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDjuGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMPBYFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0Dg?=
 =?us-ascii?q?jqFI3WEAnongRiBEIR+gh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDBAMEB?=
 =?us-ascii?q?AECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISKwoDKgsSD?=
 =?us-ascii?q?wMNBgUVAQgGAgIDAQQCBAwCCQICBQMBAwIEDQMEAQEIAgItAwEDGQgJCAILB?=
 =?us-ascii?q?REYDAsHMQMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdEQgDARgEB?=
 =?us-ascii?q?AIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICAgYCAwMDC?=
 =?us-ascii?q?gECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDA?=
 =?us-ascii?q?gIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICAQEBAgMBA?=
 =?us-ascii?q?wMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKAgMDAwIBA?=
 =?us-ascii?q?wIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDAwMFAQICA?=
 =?us-ascii?q?gMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDBQECBwIDB?=
 =?us-ascii?q?wIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBAgECCAUGA?=
 =?us-ascii?q?wICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFAQMBCgELA?=
 =?us-ascii?q?QECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQDBQUDA?=
 =?us-ascii?q?gUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBAggEB?=
 =?us-ascii?q?gUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFA?=
 =?us-ascii?q?wMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgHD?=
 =?us-ascii?q?AE8DAcKJAQEDCoBFBQFBCUZZwcHAo1oI4JAAYENgil9VAEBAaROoCFJHgkBB?=
 =?us-ascii?q?gJggWeBChUKL5tfhXwaM5dTkxmZCCORcJJHhD4CCgcHESQSgTI6gVwzGiOBA?=
 =?us-ascii?q?W2BSVADGQ+SI8wVNTU+AQcCBw8CgXODdokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:FSuOXKEteJKjOxTapLqEzMeALOsnbusQ8zAXPo5KOHlom6uj5r
 2TdZEgvyMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKPjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHyTj9PdJl7tfvys+VbCTlo0uFjzsGV0gZ1XYBNu9TKCNLeDU=
X-Talos-CUID: 9a23:Fkm7YG+R3R4tfzWWe4eVv15FOMkmV0bb8FbJGXSKWHptSYyJYHbFrQ==
X-Talos-MUID: 9a23:dxCuTgQfKzX5TxRwRXTHpjxjCJlMyJ7zFW8Tj6sbpcuhdhN/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815287"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE9uQDw5/b7V6FElE0Sw2iBhRnvpzQg++nbVO?=
 =?us-ascii?q?tAjp8LjSpxT83KycKy/qGDf+4DfDXJw9ht/xOBm49Mv3CE/3YPtLUEUW?=
 =?us-ascii?q?w146KU84nH6hddorsgiu0cOyPgR46XMWrgpHidZulNeZYsTTmMLEgQlu?=
 =?us-ascii?q?G3g/PkPHpJ7lTEY/m2OGUbIw=3D=3D?=
Received: from mail-pj1-f51.google.com ([209.85.216.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:53 +0200
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso962198a91.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832411; x=1785437211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDObpA7RQnlY6KsOhvuFRPLttcc0bMB5PHs3ILqM3SU=;
        b=peYnAtkdGm6ZCpSWs1M4PdCeSMP//0DsU+cGKr5iefSwHmyvgo5APq6KAsawXfR2rq
         p++ZSDfe8UvWRQoK2SwRUlfEzga3jlqH4Ff0sBBkLpSYpTHHXg3KTwIgNWeRWbNqJWTD
         XNGYbRsgoyLlD9QTeU/N0AWBypvOtaSjz3eVNUlzgNAaLTS6T5s4nZZmooVctnKhooQV
         XY3kq5ZId+MSz2gAG7iJUKaK3H9QEW7y0dfah1QvFEAEb2LG/5RBgjmAKMHJBb+UgJEd
         E1iq9TNyfvVcZzE/DIGRa65lKbyoBmWhhElnDr0WdBO80oDGOcw3ZUhHoCsJc5Zujbrk
         ksLA==
X-Gm-Message-State: AOJu0YwMskBYKC24RMeaIcaOYWrHUze/Qy5RrYodLMMje5h5ifNULCHJ
	wSxO/q0htGxddCl5zaCy6LbALnEFZvEJeskcjgZD0AQluiP1sbakWybDMZ5nJtgsSrU=
X-Gm-Gg: AR+sD13tyXp0KpDJSTEGJQ7d6MNxSOJHwMQ4KG1finMecGGpezT61Tu5nbfa07EkQQ1
	wcCapc3c247I0ZTNXqhE0+ahEuiaWF2p0DeBkac4q676tvJOSX49JjUigmgMJEmK6MH7G8OcFi5
	Cc/9/Xc1gjDmFKGMJeLUYZ+3d84f+0hchLhGhlUculNReB95UOT7KEjhaVowG6obBCxOyCtg/DI
	NZ0jFUdYpmXRbYxPNj+xuYL3Atwoq/pc4AAbU50+UK7XLd1tKd2BakPfif+5x/TxSAwZXdfjtcx
	Yvv+rJcujF0u7hoGJpLhstQVoVUMaOnxd/AiOvhvjZw3yzqxzcdb9yKyx7Q1C7LmPjef6SzqYfR
	0rR7EjXex5MKjGVDNUFOjnlPi7hd/IjllD3M2zjHxKtsuzTQUDEKpish/foqueJO4fAHNf0K+gL
	ujOVTMG44=
X-Received: by 2002:a17:90b:1cc7:b0:381:f7a:2e0d with SMTP id 98e67ed59e1d1-38ec66379c9mr3820244a91.33.1784832410845;
        Thu, 23 Jul 2026 11:46:50 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:50 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: cocci@inria.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Date: Fri, 24 Jul 2026 03:45:22 +0900
Message-ID: <20260723184538.3888637-21-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 20/36] stm class: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3617
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/msAuv2qMNSvXvh-Kf0MsHw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/hwtracing/stm/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index f48c6a8a0654..edf3d69a84a9 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -602,17 +602,11 @@ static ssize_t notrace
 stm_write(struct stm_device *stm, struct stm_output *output,
 	  unsigned int chan, const char *buf, size_t count, struct stm_source_data *source)
 {
-	int err;
-
 	/* stm->pdrv is serialized against policy_mutex */
 	if (!stm->pdrv)
 		return -ENODEV;
 
-	err = stm->pdrv->write(stm->data, output, chan, buf, count, source);
-	if (err < 0)
-		return err;
-
-	return err;
+	return stm->pdrv->write(stm->data, output, chan, buf, count, source);
 }
 
 static ssize_t stm_char_write(struct file *file, const char __user *buf,
-- 
2.43.0

