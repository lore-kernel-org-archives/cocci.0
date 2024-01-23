Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E35C47DB3
	for <cocci@archiver.kernel.org>; Fri,  2 Feb 2024 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+JeEyKGn0lV8WeyRQc6wAgA/9wi6Y7j/WpnhdAob6+w=;
  b=hpGWFdMBPKTSAUAUww1S8L3/DCXgvAmdamfKCi83V3kfidVAkuE2obX1
   yQb5in0yxpdvJFifVk6juCRrJnB5uZLuHIjiN8bkx34nriAoOLxp0vGvd
   KPaP/NI9YS85nDtk+j9YoTyivzj9f2lu46BkRXXqM3ZWzbxcYIo4+dS66
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=permerror (signature expired) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="149964983"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Feb 2024 12:32:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EE5C2E00B7; Fri,  2 Feb 2024 12:32:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2929EE0035
	for <cocci@sympa.inria.fr>; Tue, 23 Jan 2024 01:28:50 +0100 (CET)
IronPort-SDR: 65af0841_78ebb+UXCWu3WAzo1ebjpabuu1wCaFjjGwlztZxwAfRCzXJ
 8638PSFK+IiTBsI+CtxhLc8+fRIlvXw2f2fB82Q==
X-IPAS-Result: =?us-ascii?q?A0GxAgCgB69l/yuhVdFaHgEBCxIMggQLgjkHdVYyBFOWN?=
 =?us-ascii?q?p4HgSUDGD4PAQMBDAE5CwQBAQMEhH8Ch0YCHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEIAQEFAQEBAgEBAgQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARcCDXwCAQMSIAENAQEqDQEPPxIzAQUBHBkigl4Bgl8DEakbgQVCj?=
 =?us-ascii?q?G2BAYIKAQEGsRyBYQMGCQEKgTSMYoRjeicbgUlEgRWBO4ItgmECgi2FdoEbf?=
 =?us-ascii?q?4NCijuHOEqBJgOBBW8bDx43ERATDQMIbh0CMTwDBQMEMgoSDAshBRNCA0AGS?=
 =?us-ascii?q?QsDAhoFAwMEgTAFDRoCECwmAwMSSQIQFAM4AwMGAwoxMFVBDFADThcfGhgJP?=
 =?us-ascii?q?A8MGgIbGw0nIwIsQAMREgIWAyQWBDQRCQsmAyoGNwISDAYGCV0mFgkEJQMIB?=
 =?us-ascii?q?ANUAyN0EQMECgMUBwsHeIFYgXsEE0oDBwMJAwcFSUADCxgNSBEsNRQbBj5vB?=
 =?us-ascii?q?5YjAYI7gQ4sIi5BPJcZjkegX4QbgWEMihmVEU2XJ5JtmFSNbZYkhDMCCgcGE?=
 =?us-ascii?q?COBQD05gSAzGggoCIMiTwMZD44gg3iFFIsGIDU7AgcLAQEDCYkigUYBAQ?=
IronPort-PHdr: A9a23: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
 klQqVsdBY8TLIr+2lFnLF5gk9aSc3c=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GHAro6ob7KSPXIoJecxXgUwaV5rWeYIsimQD101hICG9vPbo8v
 xG+85rqiMc7Qx6ZJhOo6HmBEDtewK+yXcx2/hoAV7AZnidhILXFvAF0WKK+VSJcE3DH6xmpN
 xdmsBFaeEYZmIK6foSjjPIceoI8Z2r/L+lgOHGw2wobw17ApsQkztRO0K3HlJ7QQ9eCYF8Lp
 qT4cJbuyGtEE5nE/hTxUNoYwEAnbD2fV7dDiLufyRXkTVmRAnH1ILH
X-Talos-CUID: 9a23:nGaO120rpaVcjrmC0C3sX7xfROsUc1f/wV7sDVaICiVAcaWzbHyewfYx
X-Talos-MUID: 9a23:m+SSFAgVOPxblDpbrvgPFcMpDOFEpISyDBgxzJgClc+bdjYoKg7MpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,212,1701126000"; 
   d="scan'208";a="148063642"
X-MGA-submission: =?us-ascii?q?MDF91GJlQbZBlGFBEIAarl+7DXHeEbe5NhOFGa?=
 =?us-ascii?q?CkiagRIR5hIE+0PPtB7e4Y51bmbOeS0ToG02d4qubzGEjx1XhNrLaeqy?=
 =?us-ascii?q?Tzo3UzOpClRtcf4fbwied56w/Kk5X/BkEovvnDrTiYM14zF7bQ8L9/Kz?=
 =?us-ascii?q?q3c/hCCfBcV/PpnG3q6O9Dvg=3D=3D?=
Received: from mail-oo1-f43.google.com ([209.85.161.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:28:49 +0100
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5997492d71cso1323738eaf.2
        for <cocci@inria.fr>; Mon, 22 Jan 2024 16:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969719; x=1706574519; darn=inria.fr;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JeEyKGn0lV8WeyRQc6wAgA/9wi6Y7j/WpnhdAob6+w=;
        b=OeUQEJkASZE5i92DZjc47bvK5ITNJBzApWroM6EnP6AXn/uZn90kv4yH6cBkIOLKOC
         BqNZOPEtARTzow6lcceQXhVI4Y0fwBkTDM7JlsBEBPFT9mSvPSqis5hxzMZvgb/sXKAC
         BJwSB7JY/gyfKS8/hQqckcZ9zxcVKnu8F363c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969719; x=1706574519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JeEyKGn0lV8WeyRQc6wAgA/9wi6Y7j/WpnhdAob6+w=;
        b=o6LqldJjXBKX5Yb1pVseWM64j4GeS7Cv+1hwq1CA0iFRM5E4ykgdu5Dh+Ww6Ara/9r
         hyOhniOhMAJLnFIhtJwYrMy7u3s3QIofbJvnhay+KGLWTIgcpuPjM9V8dIgAIlko2BA0
         xdxKWAbADr0kg2FBnCWYOmnSROfQ5+0qGpp28wuNgJRRvLohovkM+xyVLoCmYbuRpAXp
         Sys4fDtLULIS1koJiOwVI2oDvwWDT0D7Zeb4EgME/0Q8FljiicSv6241SW1OrmDNX6fo
         FlMV/Y0G9L+m5pGVXY5hRIwj0SF+XQkM8necwpKJzv6FUuHVXeHtnBzeOh/ZO80m8XnB
         8/lw==
X-Gm-Message-State: AOJu0Yz6fAs2d9imftPJ/Qxkiylnj6T3XsFWud7WjO5LtUbzCfaqLRh9
	lDjLN4MeMFhPB0w7Eue3GzN7fyn0XAry+wrZD+eBt/+v1c4plsJKww+1VZYLtA==
X-Google-Smtp-Source: AGHT+IGXnjsVjmGefwUz4NLOYBkk1Pkgc02KLFnPxshR1dbCC7oBkGzlRDt2GgPOlPOZXTHSoOTbOQ==
X-Received: by 2002:a05:6358:ca5:b0:176:70d4:eb64 with SMTP id o37-20020a0563580ca500b0017670d4eb64mr388585rwj.10.1705969719547;
        Mon, 22 Jan 2024 16:28:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rs14-20020a17090b2b8e00b0028c465b050asm10217097pjb.54.2024.01.22.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	cocci@inria.fr,
	Bill Wendling <morbo@google.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2024 16:26:40 -0800
Message-Id: <20240123002814.1396804-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=keescook@chromium.org;
 h=from:subject; bh=l7HVvTdScmVUEBhzQFpCKcbiCA9potNAVoRVMmpE5Cw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEsqMAH8qryJJXGj8e8QN0W9DMFFKrS9uda
 cVz4Vs0YzeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 JsTiEACd8SkTPHWAe1kX56wx0lNF5c674TcY9C2ijoqRJGl/0QtJHQVrBWgFzStTMFRvdjVmSft
 OhisPGmKR6BjwIhxS8K5uADuSfceqnrcsSEq4gyGDysofHMym4LMXl0gyup0oUDHnTxmzDDExp8
 axLDbZ1DRxktaofds7/FAwvtSg9Npx8Xq5Zx4tpivhC+OR8ZgYaUX0FnfXi8mzwN5bhbZAMP3qH
 zi0ast7Pgu3OHTsqOvXYYT87SM3mnt0N24+ILjlZAdKkVKotxC/m33ndLhs9LII8dKzdCfL29Rs
 VdZmA4MtigsvUnzrrfEjFbZIMynSrgWPIUe2gFy1mJy2dkam07GXcuXbtLldd2EeuZN7D+r7RVd
 4+vlNouoeK8rsf39E9wUneF9w8ZEtnDG9Td4520g5ev1+d7MN2kp8jJVnYTIJLZFYRcpFk8LygE
 uf/9zPB/2zREBkdwxAKTln0vcFw6GHYhZi2F56FRL2tHXmxxw81CdKjM2fsB19JV5iG94WNZCGO
 Zu2C1agT5RsXzn+z37spD9fyW0/F1jNBMeiUiXU9IW8erIHEQqyA3HieDE8casRZj64hSFICMOa
 cLCu/yo1/gx4lr5s6qpSm4oZrC88HxZZVlZvy1WK6SRp2cGdT2tEJvOCA98bxxqAyXYYEoa1IrG FsID4fl2hSNgW1w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 05/82] cocci: Refactor open-coded arithmetic
 wrap-around
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1493
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/20240123002814.1396804-5-keescook%40chromium.org>

In pursuit of gaining full kernel instrumentation for signed[1],
unsigned[2], and pointer[3] arithmetic overflow, we need to replace
the handful of instances in the kernel where we intentionally depend on
arithmetic wrap-around. Introduce Coccinelle script for finding these
and replacing them with the new add_would_overflow() helper, for this
common code pattern:

	if (VAR + OFFSET < VAR) ...

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: cocci@inria.fr
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../coccinelle/misc/add_would_overflow.cocci  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 scripts/coccinelle/misc/add_would_overflow.cocci

diff --git a/scripts/coccinelle/misc/add_would_overflow.cocci b/scripts/coccinelle/misc/add_would_overflow.cocci
new file mode 100644
index 000000000000..b9b67c9c3714
--- /dev/null
+++ b/scripts/coccinelle/misc/add_would_overflow.cocci
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Replace intentional wrap-around addition with calls to
+/// check_add_overflow() and add_would_overflow(), see
+/// Documentation/process/deprecated.rst
+///
+//
+// Confidence: High
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@report_wrap_sum depends on !patch@
+type RESULT;
+RESULT VAR;
+expression OFFSET;
+@@
+
+ {
+        RESULT sum;
+        ...
+        (
+*       VAR + OFFSET < VAR
+        )
+        ...
+        (
+        VAR + OFFSET
+        )
+        ...
+ }
+
+@wrap_sum depends on patch@
+type RESULT;
+RESULT VAR;
+expression OFFSET;
+@@
+
+ {
++       RESULT sum;
+        ...
+        (
+-       VAR + OFFSET < VAR
++       check_add_overflow(VAR, OFFSET, &sum)
+        )
+        ...
+        (
+-       VAR + OFFSET
++       sum
+        )
+        ...
+ }
+
+@report_wrap depends on !patch && !report_wrap_sum@
+identifier PTR;
+expression OFFSET;
+@@
+
+*       PTR + OFFSET < PTR
+
+@patch_wrap depends on patch && !wrap_sum@
+identifier PTR;
+expression OFFSET;
+@@
+
+-       PTR + OFFSET < PTR
++       add_would_overflow(PTR, OFFSET)
-- 
2.34.1

