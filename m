Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC9EC5DF81
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=V2ryJ5H/5IomQR49UoYtHG1N1D5/YISPkFCTmUOSdPo=;
  b=aLrWHNma0jlyu86lV8B0wWJIOI563q56+jx0XMPrkL33qw3iHvlSfEx9
   Pm1gZTAVU5GLjVSfyc4bS1N/Pqk7H6tuVapmXuljiPd4Vmt/0xj23qX3d
   C8QNDRxHhpJKdsJ6yzgEI0de0Jhygtm6SQ6hT6hndwIlDc3H7xHgzIdsT
   8=;
X-CSE-ConnectionGUID: 5Lr14FgoQXq6NF7neDeHwQ==
X-CSE-MsgGUID: HD/bneG1T9+qr3+fYGajFA==
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
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291207157"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:18 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 09A2F80135; Mon, 24 Aug 2026 09:35:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 57770805B3
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:18:47 +0200 (CEST)
X-CSE-ConnectionGUID: lOwcHCpuT1G2F9EPAAaTHA==
X-CSE-MsgGUID: 9aSRPjLmTm+FgEleie8FCg==
IronPort-SDR: 6a8b1d66_Mzf9h04fjrjf9Z1UqlQwoqAncMlkSB2f68l9//+X6DFjePA
 jFWe5oEwahx6Hq0Zg3ZNRA87e0jsRE6AvS/HwCA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EvBQCUG4tqfK7SVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIhSBKz0CDwEDAQsBAU8CBAEBAQIEOoREAo1tAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw4SKYZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAzIBDQEbHQEDDAYQOyACEQEFARwGARKDAoIjAQYQAQM3AgGxP?=
 =?us-ascii?q?I0GBQIWgQGCDQaCatgAChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0DgjyFI3aEA?=
 =?us-ascii?q?nongRiBEIEVg2mCH4IKL4YwBIIigQyTWAEHBx8SCAEcBggCAkgVEgMEAwQEA?=
 =?us-ascii?q?QILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhIrCgMqCxIPA?=
 =?us-ascii?q?w0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYD?=
 =?us-ascii?q?AsHMQMQCQMfAxQcCEUIBhYBGgYFBgs3FQUMEQECGwIgBB0RCAMBGwQCAQkDA?=
 =?us-ascii?q?QMBFQQCFAodAgYIDBcCAgIGAgMDAwoBAggDAwMCAxkHBgMEBAEEBAMDAgMFA?=
 =?us-ascii?q?QMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxsFAQICAwIBAggDBwgDDQMEA?=
 =?us-ascii?q?gMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMFAwMFBQICBQUDB?=
 =?us-ascii?q?QICCgIDAwMCAQMCHAgDBgMSARADAwYBAwcDBwIEAwkCCAMDCAgDFwMDBQECA?=
 =?us-ascii?q?gQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDBwIBGAMCBAgHB?=
 =?us-ascii?q?wUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABCAoFBgICAhwDHQEDD?=
 =?us-ascii?q?wYBCQUCAQUOBwUCAhgDBgIDBgUBAwEKCwEBAgMKAQIEAgUDAwEDAgMCBgMDA?=
 =?us-ascii?q?gUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEEAwQDCgMCCAMDCAMLA?=
 =?us-ascii?q?hoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMICxUlAwEFAwMCAQMCB?=
 =?us-ascii?q?QMDGAICBAUDAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKDQECB?=
 =?us-ascii?q?wwDDAYDBwMDBAQDAgUMAgIEAQcGBwcJBwMCAwgBAQsEAQMDCgMDBQIBAQcFA?=
 =?us-ascii?q?wYDBwIDAwMFBAUDAgsDBwICAwMDAikBAQEDAwMDAwQDAQMBAwMHAwUDAg4CC?=
 =?us-ascii?q?AEECQMCBgMHBgMECwkIBwwBPAwHCiQEBAwqARQUBQQlGWcHBwKOXR+CTAGBD?=
 =?us-ascii?q?hSCFYFRAQEBpE6Le5QmSR4JAQYCYYFngQoVCi+bYIV8GjOXU5MZLphaI5Fwk?=
 =?us-ascii?q?keEPgIKBwcRJBKBMjqBXDMaI4EBbYFJUAMZD5IjzCg1NT0CBwIHDgMLhV6JK?=
 =?us-ascii?q?oEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
 ZGppnNEnQlkaYxtTUQ/DKVMx1lUwKmJu33xvt0=
IronPort-Data: A9a23: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
 E4bn1ew3l0=
IronPort-HdrOrdr: A9a23:fvJofaAp5q7KQJzlHemI55DYdb4zR+YMi2TDGXoBLCC9Ffbo6v
 xG+c5w6faaskd3ZJhNo6HiBEDEewKlyXcX2/hqAV7BZniBhILAFugLhuvfKn/balbDH4ZmtJ
 uIGJIObOEYY2IK7/rS0U2XF5IPzrC8n5xARt2z856ud2xXgtlbnn5E48+gfHFLeA==
X-Talos-CUID: =?us-ascii?q?9a23=3AfqJ7q2msYE0YPmN2tfJ26bX4C7nXOXn603zwCFe?=
 =?us-ascii?q?lNT9GEpPEZGe50apYs+M7zg=3D=3D?=
X-Talos-MUID: 9a23:Nu0UcwV4HruR8YXq/G7lvwtaNuNt36HtJk8glZgHtpmqHiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="154804262"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHj+3XsXbhTCsHvx6RdqanUAJbj7aDSbWBvZW?=
 =?us-ascii?q?3wa0+z/ktAAY6jllpv3ogfc0gPYyghUCEnH7aieVWpMvkWD0MIadxVef?=
 =?us-ascii?q?AItXEzkmGYdSFNsg+DzThRuAAHrTm7CMawvP4KjFbdHI5KTEgWjQ7VPv?=
 =?us-ascii?q?N8zwdFdOb48DImsl8nOypOIg=3D=3D?=
Received: from mail-pf1-f174.google.com ([209.85.210.174])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:46 +0200
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso1687700b3a.1
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501925; x=1788106725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2ryJ5H/5IomQR49UoYtHG1N1D5/YISPkFCTmUOSdPo=;
        b=XYsEP3hZ7Z7wGkF/IWOvddcadett/YSacFs39+bgMzXSFa2J/LVjWgOc3DFAerumDV
         U1KZABPZ9V3GvV5T3UBCSUF83emsDHTwv6hQQMfRtRWsEt4ZCyjOEaP352H0eD8g8zg9
         AMz2PLNKdYWSSBdkIGZH2DZNqJXCSysjaRqIpT+MMxsiFXMcpw3FyN7wL9MbscXnHBDI
         22f7T1E73kUynEZOHtcK0KgL8O5F0IJG1W4QPlumvv/RQH5/uhSPbY7vPtgmL3BJybfJ
         /0G9oSbR7rsUIJQXUDFsFfxbm0QpoDc+79klo0+tx1hWOTyxgzGmV+n6rdRoV5Plc27/
         KDBw==
X-Gm-Message-State: AFuF++mWfp+NRfMAJADK010GXFZInCQefjuwE1goA0mHoCspW9mtW+XJ
	b2huGUMqhzSGgRfJqJrF/QdiGPsQ39ssk8EFFn5bC5Am9jX9FGQ8ltvR
X-Gm-Gg: AR+sD12j+PtOCkuamDEyhKnJwIjlXb5Pi879RpxX2bFgcNEF03t/MFYVGpQRM9j6BOE
	b0VOGj8PQ5NTccaw4GZpqGtsjt6KhxM8jP6Q/iNW1uZanLYn3Y53pcjTw6FcrbSFY3g7kGPhPes
	XuQJFAr376iHRVHInO3c/Qg+kfnHYwUxTVyaGXXDF4lrrtVTUmgT6SrXA5IWaJMjTOyhAJkfJMP
	Ev9sJ5chXKEIR5RSAoQmJmToFpZxtsqTzt2JAzbhdAgEDEueYrbI+TlhnnmBrSkms3svQinH9zF
	1JnzHofpWSbbKWoZW07GPBLU/jsEgHUzxCrsPJU57GkAo+NUc5vOhBqK5SrkQJ92qHWdDD50qxQ
	zMKlL2eiV2rI5rzLdFpbhmJ8GpF62fbwd8k3IiKqE5hUj9RJmuSOawJjAZJ34YhDe8xC7o4mqsP
	58XqGL03w851cPYAp5898vL95Nrdahu6E6jqztDJfiWFhhMNHEPkAGYkA=
X-Received: by 2002:a05:6a21:6f11:b0:3cc:eea9:f757 with SMTP id adf61e73a8af0-3cd300f9e07mr38712636637.16.1787501924891;
        Sun, 23 Aug 2026 09:18:44 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:44 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:17 +0900
Message-ID: <20260823161826.3805598-6-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823161826.3805598-1-ekffu200098@gmail.com>
References: <20260823161826.3805598-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 5/7] coccinelle: kfree_mismatch: drop vmalloc_exec
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3705
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/Sz7mzOuGxIaBDgHtXLUdkw>

vmalloc_exec() was removed by commit 7a0e27b2a0ce ("mm: remove
vmalloc_exec").

So drop it from the rules.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/api/kfree_mismatch.cocci | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/api/kfree_mismatch.cocci b/scripts/coccinelle/api/kfree_mismatch.cocci
index d46a9b3eb7b3..bc90d0c071ac 100644
--- a/scripts/coccinelle/api/kfree_mismatch.cocci
+++ b/scripts/coccinelle/api/kfree_mismatch.cocci
@@ -29,7 +29,7 @@ position kok, vok;
   } else {
     ...
     E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
-          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vzalloc_node\|vmalloc_32\|
           vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
           __vmalloc_node\)(...)@vok
     ...
@@ -42,7 +42,7 @@ position kok, vok;
   if (E == NULL) {
     ...
     E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
-          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vzalloc_node\|vmalloc_32\|
           vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
           __vmalloc_node\)(...)@vok
     ...
@@ -68,7 +68,7 @@ position f != free.fok;
 * E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
 *       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
 *       kcalloc_node\)(...)@a
-  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
       when != is_vmalloc_addr(E)
       when any
 * \(vfree\|vfree_atomic\|kvfree\)(E)@f
@@ -82,7 +82,7 @@ position f != free.fok;
   E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
         kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
         kcalloc_node\)(...)@a
-  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
       when != is_vmalloc_addr(E)
       when any
 - \(vfree\|vfree_atomic\|kvfree\)(E)@f
@@ -95,7 +95,7 @@ position f != free.fok;
 @@
 
 * E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
-*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+*       vmalloc_32\|vmalloc_32_user\|__vmalloc\|
 *       __vmalloc_node_range\|__vmalloc_node\)(...)@a
   ... when != is_vmalloc_addr(E)
       when any
@@ -108,7 +108,7 @@ position f != free.fok;
 @@
 
   E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
-        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+        vmalloc_32\|vmalloc_32_user\|__vmalloc\|
         __vmalloc_node_range\|__vmalloc_node\)(...)@a
   ... when != is_vmalloc_addr(E)
       when any
-- 
2.43.0

