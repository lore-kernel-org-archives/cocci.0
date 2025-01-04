Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10758E7719F
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2025 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Arz7UH5V0R/QtRgjMHXv0sSR73DFlldxjby2FSghGEU=;
  b=MYAkeczdo8GXTWyLMckPm3fPHc4sJKIys8veeDCS74/tUjp4SxWsmIwN
   H4Imnx1ofnAP4CGG1lvM3sCqnxPWO7LAol7OhRNWzTkE4OW0lYL4PRbYH
   icw+ZFJY/rI2x3nrW+ll/IkVPZxu4nF6lTcyAsqhOU/jtI5rJWw1oVXu6
   k=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202787938"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jan 2025 13:03:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CF38BE0D1D; Mon, 13 Jan 2025 13:03:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82DDBE0077
	for <cocci@sympa.inria.fr>; Sat,  4 Jan 2025 15:14:18 +0100 (CET)
IronPort-SDR: 6779423a_D1w/g0Gjn3qK2tTGwmDgaKC76Zcv4fkrMIr/RlmaqcBGQMR
 n0ttDKHl42jcLL6tHtTVJ4c5h8UnJoDoCFywzjQ==
X-IPAS-Result: =?us-ascii?q?A0HuAQBHQXlnfCzdVdFaglyCRIFXMwRTrwKFXYF+DwEDA?=
 =?us-ascii?q?QsBAUICBAEBAwEDhQCKcwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABASIZBw4SKYV7DYJiNIIWLA2BABYgAQ0BATcBgRMBBQEiA?=
 =?us-ascii?q?RIigl+CZQMEpESBBUKMcIEBggwBAQbcH4FkCQkBCoE0hWuHX4RtgSEPgVVEg?=
 =?us-ascii?q?lCCLYRYhi+HcYh/eIkBik9IgSEDWSwBVRMNCgsHBWFYOgMiCwsMCxQcFQIVO?=
 =?us-ascii?q?BV4fYJIaUk3Ag0CNoIeJFiCK4RehEeEVYJJVYJIghd8gR2CREADCxgNSBEsN?=
 =?us-ascii?q?wYOGwY+bgeaWjyDboEOgUWUQpAJom80B4QegV0GDIMAnFcaM5dEkw4BLodkk?=
 =?us-ascii?q?GoipCWEPAIKBwYRI4FEOoFcTTCDKk8DGQ+XL6loQjU8AgcLAQEDCYVgikWBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bjLq6dhLoxYNrH/eUfkhj7xvZJJNA==
IronPort-HdrOrdr: A9a23:bgbGEaxs34Q6QLZMcdu7KrPw5b1zdoMgy1knxilNoNJuA6ulfq
 eV7YkmPHrP4gr5N0tQ4OxoVJPwJE80lqQFm7X5X43SJDUO0VHAROoSj7cKqweQeBEWndQts5
 uIHZIObOHYPBxUi93l6BK0H9tl7N6M67CwmOvSpk0AcShaL49lqyl2Yzz0LqS0fmZ77FgCea
 Z0KvAnm9PZQwVtUi1zPBk4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A1vQPn2vfHY8M3jsC9C9al25u6IsVNWSB5VaBIHS?=
 =?us-ascii?q?5ImJNd5utZ0GIoK9rxp8=3D?=
X-Talos-MUID: 9a23:uFJ5BARCQk2RZJ+lRXTUjgs/Mt5pwpifCUM8s6kfuJTabHJvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,288,1728943200"; 
   d="scan'208";a="201409563"
X-MGA-submission: =?us-ascii?q?MDFaCfYeMRaDctSfZEu6a/bIPRnK/UiAb7EVjL?=
 =?us-ascii?q?H42Lu0Ph2f2eSdPQFbkno7+nkR72nK8x/PD64QPNQ2Qzs5ozqhSYmxJ1?=
 =?us-ascii?q?8ZDbj4A4jOwIe0rBDhFpklgHvHQhVUUclewr4Dvx2LNSDhxOSawERJkZ?=
 =?us-ascii?q?faSWzOW0XCT/Kaw3MaLIAPyQ=3D=3D?=
Received: from mail-wr1-f44.google.com ([209.85.221.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 15:14:18 +0100
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385d7fe2732so1223458f8f.1
        for <cocci@inria.fr>; Sat, 04 Jan 2025 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736000058; x=1736604858; darn=inria.fr;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Arz7UH5V0R/QtRgjMHXv0sSR73DFlldxjby2FSghGEU=;
        b=dLQfjGMF0UA1fxy91hQltBfnN3y5ISnqpgBD6HeQjfYy/BvLVy9OgmnnLjf9uXDxqP
         IuZKLY+N3C3ukJyehgFhNyb9KFslPpFF32eosmIduqMCWTqVbrZrhyD5UnCBFc/yNOYs
         0dRl0AsVszSX7DM8FD2cimNZnuJ5I5F9LUILM30GsWGOu2FLG3syT0NBNyWRcwsqBt4e
         NaWRDDWBEtAqbkQjSTHsZBb5aWXaaljfuiR3lMXSmSKlv9jzECatgVh6YXi1Oqq9FED1
         DZO9Z0gbCLdHWBm6XQAXhiXdnbOIJtfOOqUKhcEmh8WxuYbSR2jPrBSMrnwycbzHtgGZ
         Qhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736000058; x=1736604858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Arz7UH5V0R/QtRgjMHXv0sSR73DFlldxjby2FSghGEU=;
        b=UWm33x3Gv7Leu3Urn4JjKPfWgjBIGGTCzqXFB8dNg7yLFKCRHuJ2oWd+mwnoc/c49r
         mlxx6HwyQLj4vP6Sqw9CAomR2b37p9tGuK0rq//MHudWv+0GmujLEEsIDyukm6NyNBmx
         i4keKVRBVT0GqvC06uZhAmEgAI1hfvYT+UIh0XuB3Teceqf6IfD7/UwfyR4umbOeJcsA
         UqUK4o+ujFCMCQ9XsYHInxRSm9TGZgVrz8lmdxJ4Lwui3uSM9uLvlgSkGn00gt94ulTC
         x9dXtjI7VTp3rrYZKMZb5Ls32XL19ji/MQqyxwwes4Ob+Jo7HhwlQqEInDHsoSOQRh0P
         3yAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiNNwO3lg5jn94pcFymMvCId9JcISRr7SByfSE0G0jvGaoo42cP/FzayvTiNMdZ0UtV/PBiw==@inria.fr
X-Gm-Message-State: AOJu0Yyp7iEPkuvyERZkbIWIWXXM6XciPfr9wXsbQtbhPZ7MLIETng8A
	bKiQqLH5tKqcQ+ljHiTvGPqaxnNj4fQGbLORHcHb3CHWSKrGFPXUPu9pe1gINI8=
X-Gm-Gg: ASbGncsWQJ/oDfQe59E6IgIabciksoGr9K07S39jKJpqbBJQG0HJ6txqylTNShbTnB/
	IN+85NlHeSd9/xZUiDnTI3vbhOTTyY+/lZeQXLXY8sDrUBIIgYN1F9mlSXFJ2q3GNDnFRWxPmVl
	d+uMNVA7+ZpVqnfz2FVsA8/7Oe6arNOywWxszye06EwMyIxlXv7ZBoSxUmanfgw+G7okLoTao6r
	JeUEIm85js06ti6oWGCDyqBMgwHZqPScFYLrhm8X0ldoBcaJwi3+FkdjbaSR9AbHvCcELo=
X-Google-Smtp-Source: AGHT+IERntYolr/hyWXdngG0D2K9j63kKng280g8bHrpnSl9cEopIlz5IwybNnf8vAnOOpfA4Wvl7A==
X-Received: by 2002:adf:9d84:0:b0:385:ed78:e17d with SMTP id ffacd0b85a97d-38a2213dfc3mr13593423f8f.0.1736000057707;
        Sat, 04 Jan 2025 06:14:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm545316105e9.32.2025.01.04.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 06:14:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat,  4 Jan 2025 15:14:14 +0100
Message-ID: <20250104141414.114971-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: platform_no_drv_owner: Handle also
 built-in drivers
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2197
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250104141414.114971-1-krzysztof.kozlowski%40linaro.org>

builtin_platform_driver() and others also use macro
platform_driver_register() which sets the .owner=THIS_MODULE, so extend
the cocci script to detect these as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.43.0

