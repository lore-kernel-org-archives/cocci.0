Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EB6C04FFF
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:to:cc:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=noGDNhlYTVCOxYMkKSiuv/88YZjTVfCnIqr69mquf1I=;
  b=lw/ZkXFVeI2RJVL18ArCztZjllbv+FsaXCBGItFxivyjJXMj0iv6PWk/
   DEItwpMR1UlVXRoDpN6b5KfzLho+nrRt/oxB854C8RRutbrlM6pT9OWfw
   5xV7oAx37RzmgJGVZ8KfFU9W3NS7nhA4Ri38D9E+wpSx9jOHkDITzhZ4P
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161851053"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:14:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 663D5E0CD0; Tue, 16 Apr 2024 14:14:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C5CBE004E
	for <cocci@sympa.inria.fr>; Mon, 15 Apr 2024 23:15:21 +0200 (CEST)
IronPort-SDR: 661d98e8_JIC46ghIvpDXzCYHNSBp7tdYWOYihyIiq8dz912ic/W8wxC
 13lC4Ad46y+Edbomb3qpiDfLn2zoWAHSEfC0q1Q==
X-IPAS-Result: =?us-ascii?q?A0EvAgBLmB1mhjShVdFagQmBT4JEfFYyBFOEVoh8hkqgL?=
 =?us-ascii?q?YF+DwEDAQsBAT0FAgQBAQMEhH+IGwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QgBAQUBAQECAQECBAYBAhABAQEBIBkHDhAnhW0NgmcBgR6BJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CDX4WER0BATcBNAIYDgI1AQUBDBYBEiKCXgGCXwMDDqZ7gQVCizuBM?=
 =?us-ascii?q?oEBggoBAQaCZtk3gWEDBgkBCoEGLoguAYFZhCyDPYEhG4INglCBN3ZpgXgEh?=
 =?us-ascii?q?TmCaIEWmmVSaIRiCUGBBxwDWSERAVUTDhQLBAwaAhsUDSQjAik+AwkKEAIWA?=
 =?us-ascii?q?x0UBDARCQsmAyoGNgISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WBRIF1B?=
 =?us-ascii?q?BNEAgENA4EyihWDPSmBd4QyS4UNgVQDCQMHBSwdQAMLGA1IESw1FBsGIh4Bb?=
 =?us-ascii?q?gedBAGCfwGBDiwElVKDY40koVSEHYRshyKVOjKXOJJ7AZhiIItdgXeWLoQ5A?=
 =?us-ascii?q?goHBhEjgUE6gVwzGggoCIMiEzwDGQ+OOYh1kkxDNQIBOAIHCwEBAwmFSIEAg?=
 =?us-ascii?q?lqBSAEB?=
IronPort-PHdr: A9a23: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
 BkshVknCdk=
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:F7xOEawb/0I/o3HOifgiKrPw6b1zdoMgy1knxilNoNJuA7Glfq
 eV7Y0mPH7P+VAssRQb8+xoV5PwJE80maQFg7X5Xo3SOzUOxlHYVL2KhLGKq1aQeBEWntQ86U
 4KSdkbNDSfNykBse/KpCLkV+s6yNOE8Ken7N2utEtFfEVEbbp/5xx1BgvePkp9XxleGJY1fa
 Dx2iOFnVWdkLYsA/hTykNqYwG6nay2qHsuW387OyI=
X-Talos-CUID: 9a23:90Qumm/aRcTwvPR7AaKVv2I9Jvk9W0Ca9SzvIEvpJVpQaryqQEDFrQ==
X-Talos-MUID: 9a23:R7bIDArn0t830x9Ir8Uez25Td9pLuL+WNGIit7wqhcapOBdzKg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,203,1708383600"; 
   d="scan'208";a="161733421"
X-MGA-submission: =?us-ascii?q?MDEzgySmsKCAHg/USsCpnEmLoOcDLB1oo0pTx4?=
 =?us-ascii?q?Bn6kcn51HH/umREJi51jhiBfvPFKUSwBaQ6ZYPkHvv5BODfDZ+WGU9+8?=
 =?us-ascii?q?ROEUzGiiLoMK77ZrO2IsMFXV25RO2fmpznc0foYZV7gmekgd1mocI0nU?=
 =?us-ascii?q?xbyhrUfjxn2A7JFuRBK9qXZQ=3D=3D?=
Received: from mail-oo1-f52.google.com ([209.85.161.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:15:20 +0200
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa1b7a37b3so2294968eaf.0
        for <cocci@inria.fr>; Mon, 15 Apr 2024 14:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713215719; x=1713820519; darn=inria.fr;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noGDNhlYTVCOxYMkKSiuv/88YZjTVfCnIqr69mquf1I=;
        b=RwQsFT0DVZ4SE8MrOa3gMp4no1kPPf9WflvBYmCHzE1O8j76wgqKqSYJ6qRSTgnYC/
         ECA7hp3+dTjnAn5baIfPP7qgSmx3isuit+9RhGx+PD0OfF2NmFy4UOojcz/lokaSG/3f
         Ihf/QDVXS2nDOmeluspvb+OBFQ3hDTmz9D1Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215719; x=1713820519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noGDNhlYTVCOxYMkKSiuv/88YZjTVfCnIqr69mquf1I=;
        b=nznsyZGsEIltpI1WvWPlbcBF6A9+J9j/zsd/cCT0QjEJt0so1dYjxF69Ty4V21WO5d
         A9BtLLNI6IueuUbi8RB4JuzqoqmBOVandKASUA7lcLqa7odDrpRg/ss6XJP/hBAahVni
         j91G2c4AxYdtTq1pmWnQ8ckNrElqrWVB5OnggFiAziOg7zLlv6uV9SUCnM52DV+LvgG9
         EzJ4x1a72b+c2wwqP1MarRcbT1NDajyOhJM3wywh7jTTfQty1AxaEyZPJNxyWeWQqjU+
         m2CJBRFPfewR4jf9PnJCOwVlVHR2mNm4/CJmp0CiBf9A9IHZoU+HxJZDjwVLxNy1m7N7
         +WGw==
X-Forwarded-Encrypted: i=1; AJvYcCW5bHYRmXUYRD0bE1UjQCqBkmhHtZBL1oULcgfikR0u16/JIOrwkpX3cUyhPhcBUqGFSG7MhLboFuXyvFMgcQ==
X-Gm-Message-State: AOJu0YxRt03JMbh7HDxTn659B3ww1VJldiBHpuyiAmpMxbIRp3rpwdK2
	HDgQLw1mt6UpHtG4HETCEBGTQx9ocOH+3qsWMcaaQimsHOPjmJGZpd4kc1jpUQ==
X-Google-Smtp-Source: AGHT+IHf1qn76SCzUXH6Z1+2/uU02m8Fl85aGDYYCydfcEn0/Vn+rHDNiaMu2dloPj2wsKVWi8Ejmw==
X-Received: by 2002:a05:6820:1a0b:b0:5a2:37c9:d91f with SMTP id bq11-20020a0568201a0b00b005a237c9d91fmr12909057oob.5.1713215718858;
        Mon, 15 Apr 2024 14:15:18 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id c15-20020ac853cf000000b00434ec509ce9sm6500847qtq.46.2024.04.15.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:15:18 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 21:15:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
X-B4-Tracking: v=1; b=H4sIAOWYHWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0NT3dzMvMzcxApdw1RLQ0ODFBMzS/MkJaDqgqLUtMwKsEnRsbW1ANT
 b+lpZAAAA
To: Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>
Cc: Denis Efremov <efremov@linux.com>, cocci@inria.fr, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for err
 returns
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1659
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/20240415-minimax-v1-1-5feb20d66a79%40chromium.org>

Most of the people prefer:

return ret < 0 ? ret: 0;

than:

return min(ret, 0);

Let's tweak the cocci file to ignore those lines completely.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Following discussion at:
https://lore.kernel.org/linux-media/20240415203304.GA3460978@ragnatech.se/T/#m4dce34572312bd8a02542d798f21af7e4fc05fe8
---
 scripts/coccinelle/misc/minmax.cocci | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
index fcf908b34f27..ca4830ae3042 100644
--- a/scripts/coccinelle/misc/minmax.cocci
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -50,11 +50,26 @@ func(...)
 	...>
 }
 
+// Ignore errcode returns.
+@errcode@
+position p;
+identifier func;
+expression x;
+binary operator cmp = {<, <=};
+@@
+
+func(...)
+{
+	<...
+	return ((x) cmp@p 0 ? (x) : 0);
+	...>
+}
+
 @rmin depends on !patch@
 identifier func;
 expression x, y;
 binary operator cmp = {<, <=};
-position p;
+position p != errcode.p;
 @@
 
 func(...)
@@ -116,21 +131,6 @@ func(...)
 	...>
 }
 
-// Don't generate patches for errcode returns.
-@errcode depends on patch@
-position p;
-identifier func;
-expression x;
-binary operator cmp = {<, <=};
-@@
-
-func(...)
-{
-	<...
-	return ((x) cmp@p 0 ? (x) : 0);
-	...>
-}
-
 @pmin depends on patch@
 identifier func;
 expression x, y;

---
base-commit: 71b3ed53b08d87212fbbe51bdc3bf44eb8c462f8
change-id: 20240415-minimax-1e9110d4697b

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

