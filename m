Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25845CAC59A
	for <cocci@archiver.kernel.org>; Wed, 17 Sep 2025 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=W2UE2EJKPpq1S9gnJdsu0dJ1Z4DfGYOoCX7LvS+GczM=;
  b=jL0dPUzqhH/Jo4it+NZquBuWlI3S6mN3JIFUKoDYZ4qIkF8Hp+0As1LY
   WQcHrhcQ/hzYdsqSwQwx+iGtcmxG39F9G0dueJL30jOinUAkgeEzdG/5y
   BmAZUzsvq2MdjIn5H8O4UXupfWiorxzmyy/eYmhqbB2XKfB15TWCF0Hua
   0=;
X-CSE-ConnectionGUID: eLkLrEiLQliIbCSf1FsLGQ==
X-CSE-MsgGUID: OQ6Pqi6aRSKoZzMw9HJ5cw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="scan'208";a="239634563"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2025 14:46:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6BC97E0CD8; Wed, 17 Sep 2025 14:46:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 06952E0171
	for <cocci@sympa.inria.fr>; Thu, 11 Sep 2025 20:47:38 +0200 (CEST)
X-CSE-ConnectionGUID: Kkp44oWARWStuet5V3DDXg==
X-CSE-MsgGUID: EGv5obAaT2aLNtiVQNqH0w==
IronPort-SDR: 68c31949_z2YxZlfyjJSKQw5E1/AxfOrFDcVBjCeE2ehRtF7xZkOvBVP
 wfpwedAigUeXxkZ7o98y7xOlyVUKqEwun5CcBtA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EWAAD+F8NogTHdVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgj+BAlozBFQEjG2iFIVegX0CDwEDAQsBAUQLAgQBAQMEhQCMMgIeB?=
 =?us-ascii?q?wEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABASIZB?=
 =?us-ascii?q?w47hk8NgmKBJYEmAQEBAQEBAQEBAQEBHQINgQAWIAENAQE3AYETAQUBIgESI?=
 =?us-ascii?q?oJgAYIiAQZJAwQNpESBBUKMcIEBggwBAQbcJYFkAwYJAQqBNQGFa4dhhG2BI?=
 =?us-ascii?q?Q+BVUSCUIIthFiGL4ImgQIUiD+HcYJbiHlIgR4DWSwBVRMNCgsHBVtVMwMgC?=
 =?us-ascii?q?gsMCxIcFQIUHRIPBBYyHXMMKBKEe4QdK0+EDnSEahETaw8GgRWBG4JABQGEf?=
 =?us-ascii?q?UADCxgNSBEsNwYOGwY+bgeVEIMvgQ4sgRmUSJAeons0B4QfgV4GDIMAhy6VO?=
 =?us-ascii?q?Rozl1KTGAEuh2WQcyKLbIF6llCEPgIKBwcRJIFEOoFcTTCDKhM8AxkPjiGJE?=
 =?us-ascii?q?4oqAao/QTUCAQE4AgcLAQEDCYVgjD6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:F+1rL6z1/129V0LrMdqRKrPwtb1zdoMgy1knxilNoNJuA6ulfq
 eV7YsmPHrP4gr5N0tQ4OxoVJPwJE80lqQFm7X5X43SJDUO0VHAROoSj7cKqweQeBEWndQts5
 uIHZIObOHYPBxWgdn35Q+gH81l4tWWmZrY+dv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJaa
 a0145poSG/cW8bYsn+Kn4ORPjbutHH/aiLXTc2QzAirCeB5AnH1Fc4KXelN9UlPg+nDY1CzY
 G8qX2D2kxriZGG9iM=
X-Talos-CUID: 9a23:Ywt9N22jo1C/uF55tuECD7xfOcM9LiHa817qHHSkFGt1FYPOZXOg9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AybQyVg5ZoaIuU5l9ybpSr2nGxoxFzLrzD0okmKl?=
 =?us-ascii?q?csu2iKS1OAhGErGyoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,257,1751234400"; 
   d="scan'208";a="238687089"
X-MGA-submission: =?us-ascii?q?MDEy728FUvqSEArvV2cYFmk+C/Z92Zj5XtR6GN?=
 =?us-ascii?q?Jwv30PWUKL5ROT2MxxmhDUNqef6LRMuDQnA5iR/F3y+p2H/awkVHRea1?=
 =?us-ascii?q?zkRyglf9F7nBrHE16AMcC7ocYgffCL+at7mGjqOB47ptZTPuPuTwolnr?=
 =?us-ascii?q?YrMW3dzTcYY7yRW5cxbOzAfQ=3D=3D?=
Received: from mail-wr1-f49.google.com ([209.85.221.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 20:47:37 +0200
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e35d87f961so148289f8f.1
        for <cocci@inria.fr>; Thu, 11 Sep 2025 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757616457; x=1758221257; darn=inria.fr;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2UE2EJKPpq1S9gnJdsu0dJ1Z4DfGYOoCX7LvS+GczM=;
        b=DQAlyMsnIv2VQD9IEP/OsSleWpXpQj2bDu9hxWjhewm92U4SpSpnvd2q2xQhM/d77y
         /ho5Iu0fR0s7lUpMb2sWRHgFhtGlkDuHHh71Tb8LXslDejfNP5z9xXJBSAWO4LOmXCH7
         ILIcfG10lpwhI67maHlbpFVmkPwk9pMP+OC36KzEmiMszJrCZa72TUHyOoMgyzeVm1rv
         2howcHisACrSLJC15JCVSfoR3GqZIkTXMSWi+6/c3oxDtlidw53LzyMIuxqm7mDw1KHY
         xg+5SGS2aGkergHUXEgAaID9OQxjpaGEn9nmFAHDhMAUHkAfDbrOz9QSLZ4mik4Xm9lj
         C3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616457; x=1758221257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2UE2EJKPpq1S9gnJdsu0dJ1Z4DfGYOoCX7LvS+GczM=;
        b=YpGMFGdudBb6qpyjVEWmQkucJeankxjtrFnaBKKfU5eMup5JSYv6Xh40VS0lUtbiLT
         BUfoc3utt/o63LdRTsOII+17sqSmcFJ66nKStiC0amUQUu/UCBZefMiZSui3x69iLHom
         9DK8wzMJqdOJAKnYs6I/Sc05unRYsQ/pPoZtjsNyEFldwmD0p83ajvb82IxR9gBLRhNI
         bPdPQ/agwhF8Bvpr3S964kLm4pX585hoat648Rw76HSiJHmS0GWGjJN+IUT++u97jH/6
         KBoYnRvCqhIlM8Phyep9W8DqKlDKqUTitWkvipFjXlzcLSvBTWXz1nALaHo0/SDs2goQ
         BcjA==
X-Forwarded-Encrypted: i=1; AJvYcCULu8nqoEcMJsXbybBZ8y25csHGiEXN0xxAUnihigSElvYKeXzhwW7Me0oJ5eoVJQ8w4rlQcw==@inria.fr
X-Gm-Message-State: AOJu0YyCfa3OLqqmC0IyeqadAsiZ8o5a7l7J1isNYyERb0k9qeJEQZPB
	SfqZj+3Heiofe6gv0sSCjuK6VMPCEjiPJ+QhXrvVSnL12X4yxtWDfbh0aA0MPHxDXjs=
X-Gm-Gg: ASbGncvaeZCm+f6H0xAMFLNoF8wg26ah2Zj4t7vWhS2NmkAigkpFZYgNJBgakHknowU
	OdjTiWxRgCSj5RqCi2EhGzCQjAnaNH65FeM5QLil9f+huk9WPzFgqaWJwRcAjr6Bl2D2wpWfwhy
	25Y/v3IkpJtCGEdzX23kBkdjxZyuQp7X+OqXzPB7ALnO2Ueh3RGoHQd9JXQUV9C4+b8RMGonDJL
	eTi0+MTF3ZDSdBB8ajeJbDfjAopMATpIKuSPUs2WIyd6Qj0TqHM4sLI8szo0zZKdAkT3DHIp15l
	ff66dqUyHTlYht6S/lA/xQIGzX/Fh1dUVIHIJ7rAckjY1AHJCdRE1KkkcQnw7UJoHVIckpS46zJ
	8lpbHhsRUK/kzP0WQtxcuGbKo2iOFba5eAisHN7NpgQ7p
X-Google-Smtp-Source: AGHT+IFUaxkecG3V9o6+bVPeZDWAqajmD00QZvBD8CYcgBRH3e9Vfm6uVKqxAjJUMo1/Cyhpr4sgzg==
X-Received: by 2002:a05:6000:4023:b0:3e0:2a1b:7b07 with SMTP id ffacd0b85a97d-3e765797d70mr178766f8f.3.1757616457114;
        Thu, 11 Sep 2025 11:47:37 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786cddsm3562001f8f.14.2025.09.11.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:47:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 20:47:27 +0200
Message-ID: <20250911184726.23154-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=3M9K3F1kTJYmrAesnwnHviXjE3PWS9elA9lI7mW4vXw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowxk/vGxcb5jgZY8zT8BEND0CwtbRzOckZpklU
 FK+TSDrIbiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMMZPwAKCRDBN2bmhouD
 18NREACIejZutmdOQHrpyXcdsUsoWqL3HKIhXmLRZthH/fTdLEwPgmsZrl7wBJNHQbBo4lX1icG
 +vqD6mf7aLW2Cc/HC6Ghc9dFv3+9tP3ef9GwHuD62rmZhykBYqixnPuDJvYBbgRoh3IWEEKLt+C
 P+3wRiMj7uzP2Q2ECEjusXQ3kB49EW9A5eRYAm4xYsGXgzz3x8tPafrcJxD4arLVlHcPA/xQkyR
 RAqIbF/xKADBwJqDdXzez+HmTgEKbK8bxLRQbj2cin2iiseNAWMzSD6LAjixduXOjyEHzu+hDBL
 9n7gIDEa9cShB4m7dY4PPF1O8yXgln2759iAYnLQBNNcu4yKTNR1wE5hX1ltB4HInf0dAxvOeny
 GBuM9oBXw4X07HNQlABfug5Hon7t7MbypfKKOyyYBz5I8KVd9zHg+2lX/27P6duuM5Hkb403J4f
 KXb7rNpvb0qTIazYBOTGr4KPVDbVJinlmQGWn0ESCOUHovgZZhTvGXEjo9fkGkomQwhG/A3uWBU
 m0WH85MlHGFJ7Bu1hAA2HwRDd3sRjGyVVkLi4i0A9sOuXXJ7KXjspp6Kd8klRQ4/MwBijHymHL+
 CIM9YMsmVGfgkgcVVZrneAUNxOXnXB9pefyw4R8YGVd1vMipsCtm2WYTipISuTRy1vO3PJNduM0 uUdaXy9qagGQ8Qw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH RESEND] coccinelle: platform_no_drv_owner: Handle
 also built-in drivers
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 3025
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/20250911184726.23154-2-krzysztof.kozlowski%40linaro.org>

builtin_platform_driver() and others also use macro
platform_driver_register() which sets the .owner=THIS_MODULE, so extend
the cocci script to detect these as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resend of resend, so I think Julia does not pick up Coccinelle patches.
Andrew or someone from KBuild maintainers, maybe you could grab it?

previouos tries:
https://lore.kernel.org/all/20250104141414.114971-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/20250501145810.73031-2-krzysztof.kozlowski@linaro.org/
---
 scripts/coccinelle/api/platform_no_drv_owner.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/coccinelle/api/platform_no_drv_owner.cocci b/scripts/coccinelle/api/platform_no_drv_owner.cocci
index 8fa050eeb7e5..5e869858bda8 100644
--- a/scripts/coccinelle/api/platform_no_drv_owner.cocci
+++ b/scripts/coccinelle/api/platform_no_drv_owner.cocci
@@ -10,12 +10,21 @@ virtual org
 virtual report
 
 @match1@
+declarer name builtin_i2c_driver;
+declarer name builtin_platform_driver;
+declarer name builtin_platform_driver_probe;
 declarer name module_i2c_driver;
 declarer name module_platform_driver;
 declarer name module_platform_driver_probe;
 identifier __driver;
 @@
 (
+	builtin_i2c_driver(__driver);
+|
+	builtin_platform_driver(__driver);
+|
+	builtin_platform_driver_probe(__driver, ...);
+|
 	module_i2c_driver(__driver);
 |
 	module_platform_driver(__driver);
-- 
2.48.1

