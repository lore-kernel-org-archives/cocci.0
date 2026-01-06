Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ACFD2ECF7
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BATdJWgJUwnMbHLsMBqXXAerZpaNwXBAjVbJPcNyAvU=;
  b=vJlj8eqnaWR08LR4J2Nj0WZFN3T5Vy9gFgVnbYxrAM6eDRkyEigbrV+Y
   FWyT6uz8JkzaL7mkFe/sInCFvb2SPrqkAW0HhsFKSXMvCJKlW1HRzG8bu
   Vg3HGqfMLXqWng5s2CgyMzYaf0k8pmuAF44EVLEwPE9CwpZBj2iovY5KU
   4=;
X-CSE-ConnectionGUID: C8pOqOvOSp2zoAwr5azuuQ==
X-CSE-MsgGUID: qcD6hDOlSEq6jQhSbfnBKw==
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
   d="scan'208";a="259430463"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 11:48:41 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3CF4483A04; Tue, 20 Jan 2026 11:48:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3D6A181EB1
	for <cocci@sympa.inria.fr>; Tue,  6 Jan 2026 20:09:26 +0100 (CET)
X-CSE-ConnectionGUID: mPFXPz8uRi+kypXEaelqLQ==
X-CSE-MsgGUID: YQTcYcJvQrOR+SuseHReUg==
IronPort-SDR: 695d5de5_dATw8Rq+tuvigYeFGuTFmFMV4/z+PqgrjkrMOnwi6vvZhZV
 XzXLEXI7ieGYzMwGgHYAF6s80pbMmzr9dXRb2Dw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GXBAAcXV1pgbPWVdFaglkCgj8WgVAzBFSiFjACh1OKT?=
 =?us-ascii?q?oFAPQIPAQMBCwEBTwIEAQEDBIUAAoxqAh4HAQQyBw4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOO4ZPDUkBDAEIAYICAYEkYQIFA?=
 =?us-ascii?q?zsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAixfAgEDE?=
 =?us-ascii?q?iABDQEbHQEDDAYQOyACEQEFARwGAQoIIoJggiMBBhABAzYCAaR7gQVCjFMFA?=
 =?us-ascii?q?haBAYINBtpjChkoDW4DgWABAgIHCQEKAQGBNwGEdSlPDoI4AYUdcYN+eieCK?=
 =?us-ascii?q?IR9gh+COYYNIgSDHBSBH4MgkFMBBwcfEggBHAYIAgJIFRIDBAMEBAECCxMJA?=
 =?us-ascii?q?wMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyoLEg8DEwUVA?=
 =?us-ascii?q?QgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBAxkICQgCCwURGAwLBQIKJ?=
 =?us-ascii?q?wMPAQkDHwMMCBgKAQEFFjgCCQYEFQEgCQUDBgIFCwIOAQ8CFAIBAwEBBgIEB?=
 =?us-ascii?q?AMKBgIGBQICAQQDBwIBAgECCAMCBwMCAwIBDxgDAgMKAgYFBAYCAgMDBAICA?=
 =?us-ascii?q?gkBAwYBAQEBAgICAwICBQYGCAQEBAEBEQogAQMFAgQHAgEDAgIBBAEBAwMCA?=
 =?us-ascii?q?QIBAgMBAgIEAgMDAwMDBAUDAQEDAgMFAgIDAgICAgQBAQMLAQIEAwEFAQcFA?=
 =?us-ascii?q?wEDBQMEBAMCBAUDCgICBAIDAwYDAwYDAgUCBwICAQUFAgEBAQEMCQICAgcDD?=
 =?us-ascii?q?gMCAgIDBAECAwQDBQIDBAEBAQEEBQIDAwICAQMFAgIBAQICBAQCAwMGAgQCD?=
 =?us-ascii?q?gIBBRoRAQIGBgMCAQMFAwMDAwMCBAICAgIGBwsMBAQEAwUDAwUGAwEDBAMIA?=
 =?us-ascii?q?woCBBgGBQICAgECDA8DAQIKBAQDAgUCBgkDAgMDBAEDORwTBAUCBQMDAToDD?=
 =?us-ascii?q?gQDCB4CAQECBgIBAwMDBQIDAQMCBwMUBgEGCAIEBAoCAwMHBgUHAhEoBAICA?=
 =?us-ascii?q?gIEAwMDCggHBAMBBwMDDAICEAIDBwQCAxMGAwMEAwwGAwECEhgGAQMHAwgDA?=
 =?us-ascii?q?gcEAggHDQIEAgkDBQUBFQQCBAMCAgICATEDAwMFBwIEAQQGAQMDAwcDAgwCA?=
 =?us-ascii?q?gISAwUCBQYCAQMMAwQDAwUFCy0QBAcTCgYEAwMHBQIDAgIUBgIGDBIDAwQBB?=
 =?us-ascii?q?AIBAgICOgQDAwgBDRoOAgQGBQoDAwQGARgFAgMCAwUBAwEHBxICCggDDh4BA?=
 =?us-ascii?q?wIGAgkBAwECAQcTDwMLCQgHDAE8DAcKJAQEDCoBBg4UBwQlGWcHBwKQC4J3g?=
 =?us-ascii?q?Q6DegEBAZU9jw+gIEIlCQEGAQGCR4EKFTiBZJl4hXwaM4QEk05HklKZBiKRc?=
 =?us-ascii?q?JIQN4Q9AgoHBxEkEoE5CCuBXDMaI4EBbYFJTwMZD5Ihw2k7NTwCBwsBAQMJh?=
 =?us-ascii?q?UMmE4RZhVWBdIFLAQE?=
IronPort-PHdr: A9a23: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
 JD18CMG1AVkY9o4Y6fXIfgRpmU=
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:5OimWas1S8u7zdp35kXcWGIA7skDrNV00zEX/kB9WHVpmwKj5q
 STdZMgpGPJYVMqMk3I9urwXpVoLUmsl6KdpLNhRotKPzOWxVdATrsSlLcKqgeIc0aOldK1l5
 0QCZSWYOeRMbEQt7ec3ODXKadE/PC3tI6twcnRpk0DceioUc1dBsVCZzpz3ncZeOA/P+tAKH
 NU3Kt6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3ADFxyXGjTlERbMAEj5PDlkKJVMDJud0Xz/E/Cc1K?=
 =?us-ascii?q?CCCVqWaWlZFad/LpAqp87?=
X-Talos-MUID: 9a23:sc64RghuTy/umob5Zt9IcsMpBf5U6JWlKl40i7I8+PKZLiFQATqgg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,206,1763420400"; 
   d="scan'208";a="135232658"
X-MGA-submission: =?us-ascii?q?MDGmMrZvMMKhdwljydyoXwc89rb/zIn9hegws5?=
 =?us-ascii?q?mHy47LELHUPbNxgjuH5N99NKvhK4IFLeNQtKvQhzSWrW0YY4nzucqb52?=
 =?us-ascii?q?3zd0BCu0PfSGKWyqGaeG0RtRWWxIYQCf3o0YrYN0DPwSF2xT/sPn6mSs?=
 =?us-ascii?q?EJNF2Y+gBzsl6D4XNtoL1DpQ=3D=3D?=
Received: from mail-pl1-f179.google.com ([209.85.214.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 20:09:25 +0100
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d5c365ceso13244595ad.3
        for <cocci@inria.fr>; Tue, 06 Jan 2026 11:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767726563; x=1768331363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BATdJWgJUwnMbHLsMBqXXAerZpaNwXBAjVbJPcNyAvU=;
        b=V21dQXzQMCY8nwrq5Yrn5OuPfhttzW28s+AzR6pGhZwAsj7KCj3r+JzPMdnYdLTNf1
         tN22Cki7ItX5wRTcWyNv/BzEHA+GSxTVtG+Fbc+fjt/7FikigP7Ee5FpW/ZeCnGUn2sh
         ymvsohq+KY37hrsUy/xKyhN/PEeK6z0YI4ryLPHi6IsJJ1ZpJEj1S8jiCwjbN0W9Vat3
         72SOfFB2VwPAOvMM0hl+pmS9e34M/cjnSsBt34gpxQZaT8sqPxeLtW9fCJR0wNHVfsmm
         3qMyG+r3s7ppoyHC3GyOT6ljBWRzuwz6MyVv8/7FIYlOVTSzrFUluJrKeV25cIjgQnS3
         EeWg==
X-Gm-Message-State: AOJu0Yzm9NsrxNjaxn5WGX9RKbsBsuTx+gEA5yLNB5YWaE/1E92AiU+8
	TOMSPRTOn0AHnVy7JKzinVJiSm/tbY0WJSweULxgwImZxn+QYaVyV5MS
X-Gm-Gg: AY/fxX56cesUUeuiTNV9Z0IhYp4X2O0qjSznDRuYQE9FyGWoip+PHBmLueH3ANSLhk/
	dDR7UYH7jAXELCiI+26apWeZi3EhpNI7sheDVNtHHXFsNC7zNqf28vGkxorZKPDnmgRb1j0zxxx
	AntMtDAwCEIiBsgmqlJnYkHWlzpgawxxMzQj6jjmQyCd+6fSthlT7W0X6rrpZsmViZWVzDmpRnD
	Dm9dfnlLMDT6pBlml+HanNfC7ozxQCkshwodAVOiNupm85MsD8cOsBCDC4RiWLvdN2OlBXLEMv+
	5Jph6tPsi/uoDf0A24/Cvu6s5b9SD/h07t19ZSEeJ+bmEvezJRcDddIFY31psmOdBf2Fp25ykdC
	zY0o1TIGAMyIZ0Do1DUbsFP+/j8eVHLbYo4ZEgfVRIEmVdXFFA/A0kAhW1ql1cLq2ya8f5UZ5sj
	f6em3ahQoj4sq2z6pOtA==
X-Google-Smtp-Source: AGHT+IEv3DyNwRK5RvEmcexsucGDjZhsLc4jeZexw6MFns14bMGlit2ognMpseLu1Intl2qBeIsDAw==
X-Received: by 2002:a17:903:2c5:b0:295:fe17:83e with SMTP id d9443c01a7336-2a3e2cbb647mr42089515ad.19.1767726563165;
        Tue, 06 Jan 2026 11:09:23 -0800 (PST)
Received: from rivendell ([101.0.62.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc78c0sm29380975ad.69.2026.01.06.11.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:09:22 -0800 (PST)
From: Benjamin Philip <benjamin.philip495@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cocci@inria.fr,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Philip <benjamin.philip495@gmail.com>
Date: Wed,  7 Jan 2026 00:38:35 +0530
Message-ID: <20260106190836.36630-3-benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106190836.36630-1-benjamin.philip495@gmail.com>
References: <20260106190836.36630-1-benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH RESEND 2/3] scripts: coccicheck: warn on unset debug
 file
Reply-To: Benjamin Philip <benjamin.philip495@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3283
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/AnqP0HYK2r9NhY-RjZ6Y2A>

coccicheck prints debug logs to stdout unless a debug file has been set.
This makes it hard to read coccinelle's suggested changes, especially
for someone new to coccicheck.

From this commit, we warn about this behaviour from within the script on
an unset debug file. Explicitly setting the debug file to /dev/null
suppresses the warning while keeping the default.

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 2efb74afef2b..8dd766009de1 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -260,6 +260,11 @@ coccinelle () {
 }
 
 if [ "$DEBUG_FILE" = "" ]; then
+    echo 'You have not explicitly specified the debug file to use.'
+    echo 'Using default "/dev/null" as debug file.'
+    echo 'Debug logs will be printed to stdout.'
+    echo 'You can specify the debug file with "make coccicheck DEBUG_FILE=<debug_file>"'
+    echo ''
     DEBUG_FILE="/dev/null"
 fi
 
-- 
2.52.0

