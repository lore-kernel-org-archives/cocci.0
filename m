Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9053CAC5A5
	for <cocci@archiver.kernel.org>; Wed, 17 Sep 2025 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=+2hRnWl9DPmgNwOJ9eqmgc5MwP0KykD19C+0v95Q7Lk=;
  b=i2MXg6sSTvZx0bIZujY/Eu0hrWMEMSOZOQ1ImFFcbCwPzg3NZ51ix4E8
   kzM0XZVsyCvKDCRs0Z3nEFzu7grp4p8wiX5eBfF0R0L07aUHwUBq/jHTX
   96gtuuQw1VwVaOQESnQpRP4OvxvTRVlh47xLF25eK1wv0i/ZPfGPbVb07
   Q=;
X-CSE-ConnectionGUID: FJniUZNeR3SuoY7CIyg0uA==
X-CSE-MsgGUID: hUZs4iquRt+Lf0/72chgQg==
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
   d="scan'208";a="239634612"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2025 14:46:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6A46CE0D14; Wed, 17 Sep 2025 14:46:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 013FAE0171
	for <cocci@sympa.inria.fr>; Thu, 11 Sep 2025 21:34:00 +0200 (CEST)
X-CSE-ConnectionGUID: Y4gcrKCSR9yWviqwLFFdzQ==
X-CSE-MsgGUID: JeDuK2m0QDWoHFvVcjUemg==
IronPort-SDR: 68c32427_FxKUdplFDjd2nLDwFv4K7N65NU3p2ad3IDus7/R5Pct54+G
 ubxHwudeOGdr/jLRhQBmINKaVCFGTBd0DGPhz5g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HvAQB4IsNogSvdVdFaHgEBCxIMgggLgkCBXDMEVLRjg?=
 =?us-ascii?q?X0CDwEDAQsBAU8CBAEBAwSFAIwyAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBDQEBBQEBAQIBAQIEBgECEAEBIhkHDjuGTw2CYoElgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAg2BABYgAQ0BAS4JAYETAQUBIgESIoJggiMBBkkDBKRegQVCjHCBAYIMA?=
 =?us-ascii?q?QEG3CWBZAkJAQqBNYVsh2GEbYEhD4FVRIEVgTuCLYRYhi+DPIg/h3GLVEiBH?=
 =?us-ascii?q?gNZLAFVEw0KCwcFW1UzAyAKCwwLEhwVAhQdEg8EFjIdcwwoEoR7hB0rT4QOd?=
 =?us-ascii?q?IRqERNrDwaBFYEbgkAFAYR9QAMLGA1IESw3Bg4bBj5uB5UQgy+BDpYNsxk0B?=
 =?us-ascii?q?4QfgV4GDIMAnGcaM5dSkxgBLodckHwio3RChD4CCgcHESSBRDqBXE0wgypPA?=
 =?us-ascii?q?xkPjiGJE4oqAaoxQTU8AgcLAQEDCYVgjD6BSwEB?=
IronPort-PHdr: A9a23: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
 ZP3btt0BTQRInK7VFWljHQyVcijZL6Q
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CRuB76HSVDf2snGBpLqEcceALOsnbusQ8zAXPo5KOHtom6uj5r
 +TdZEgvyMc5wxhIU3I9erwXZVoIkmsj6Kdg7NhRYtKNTOO0ADYTr2KhbGSoAEIcBeOkNK1u5
 0QF5RWOZncAUd3iMDi7BL9MdoxqeP3jJyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2eKYRJd
 6y4NFYryGsdXlSQsOwHWkdQuTPzuemqLvWJTADQzAogTPhsdpq0tHH+tqjsyv2nwkv/V5byx
 m/r+Ux3MWej80=
X-Talos-CUID: =?us-ascii?q?9a23=3AZtz6c2kxKs2r7iMg4m4suJ0GMEXXOUyBw3zKAGS?=
 =?us-ascii?q?DMzd4d6OUUEC01o1ogfM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AoPtC6A6Aj9u2yiGxn6BX7GawxoxK7oizKxoIyaw?=
 =?us-ascii?q?qhM6kGzJOMDWggTG4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,257,1751234400"; 
   d="scan'208";a="238689530"
X-MGA-submission: =?us-ascii?q?MDFuqJoXXBebT/Lb+3o7sYtobaeza0SkqaxjX9?=
 =?us-ascii?q?2o6pBaFk1VdeJqETSh50Cx4KKhZmo2NYv7k93bChQmirUJY5keRSw8ub?=
 =?us-ascii?q?lajGAo/6pO8WYw87KpznZMlVZQ2q/tre4iYjlP/ZsutpuN+AzWSaH5BN?=
 =?us-ascii?q?r5gvtLLH9bYYZXVPXzKil8QQ=3D=3D?=
Received: from mail-wr1-f43.google.com ([209.85.221.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 21:33:59 +0200
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ce208c7505so154261f8f.2
        for <cocci@inria.fr>; Thu, 11 Sep 2025 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757619239; x=1758224039; darn=inria.fr;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2hRnWl9DPmgNwOJ9eqmgc5MwP0KykD19C+0v95Q7Lk=;
        b=O9aitLfpV6EIcHLgjlXOfHROkVdE7bJgez9NqAkcYZ6IyPTZZ4w8MvyowQZ86CpaNT
         /Epv11bXLg6BWjTUese98wuwjxoch+d1+XNjdLwn77dMo4hDnBCODPLhSpmoU4IAJSP7
         qZhoTHf0nB/QLQObu5s6acxwNrYeV4jxVNg+IEYa7JDDEerEZEt3Rp0zMGtuXSBzdtV9
         nf+pAbie6S3+10EmAO0A152uVJsU3If8OAAzdvqr6cLtTWokiKfpiLCQWS/JuNfJJE2V
         9Lxfq52BcFzfW2RUZWAvI1EoGIz2KqUcbZ4UE81cUvE0R/s4iXNhRKHrnTykw1dwVO8d
         dScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619239; x=1758224039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2hRnWl9DPmgNwOJ9eqmgc5MwP0KykD19C+0v95Q7Lk=;
        b=usmvKQ9qqEuVntx/Ksa4gK4shxD3IwFZ6fdoo/wRAAl6ABaFTl/m/D9xFd038Z+8r9
         1NZmrRbYtRvKlNQgvaZgyij11EknNKGx83FMN9vGEpWfckDaOIxhA5wo8901PSsNvzU+
         irhkzxvcorvVxAcG04ESmXXpITvdKOqz1AvSlVT0NOnr+iHmWrUswabVQGGn0nYpZFG5
         DAvyMGV0LFkWDh04Xu4QRkWnQy6UKGSVFAqU15dr7+ENflEY1XbjHkhjryMrXIlWL2gx
         E58gsc0MtEW6ZyuqX4cbBu0kWdkyreWKJD0RZGm9i4V32ii5EGodUID5k8D3rbjoWRj9
         KsrA==
X-Forwarded-Encrypted: i=1; AJvYcCXO4T24F3GgGEyCxwQNeaEwLqt03SfZRmoX+Dr8VM+tN60kDZO7hxdaZlzavlJT+lhGZuf31Q==@inria.fr
X-Gm-Message-State: AOJu0YxLs/w8I5+dAEDC2nIY/3RZAl3+ZXhZyQog8FTyWpCmlzipf1Bq
	Ib3dx1bv/UkLeKrXaf2+6OECYOy0IzzjVYZL7y7un/8IMIOr2FSq/+HLzdsn628RFyI=
X-Gm-Gg: ASbGncvtlCMW1N9DjQBBoRtLq4OnxmslV2vH1Q/G286SvZJYKxNN9EfnHGBGBrFQDBR
	Hro/PLiUo1h6L77vbf9lByI2fwB0WbvVGe3v3uFf2i4BnnxXals7FCs8uZMjHUTWA19g8BG4RPJ
	H/PSyfiemdnp72sRHcDE6mkyP816GSxTTfxawhE0WbDVUSpiWI/0MyuuidRqdWnVdmSaWE8OdME
	J/Vx2fr5jkvkMgICi/6h1AFd5VCtTIMw3HcMwHUtinnpFH2Pq/PWow7HBenZ8gtTZ+827Gmf5wc
	62axFWl8R34dITmzxFPPyGwqySRQ5qUpgWVqU9h12UbKKhoJcXtmoZPJjLYlNQhumMDvIBri/1k
	nF9nWd8Y4q0YZQ1j4z9BUKjAUNBEtCu8lkwiwQ1jA1Mtxl18bUEJCI/E=
X-Google-Smtp-Source: AGHT+IFGziCCby5D2Qd9w4NHMZF8PAOpitnAJxu/QUYRHu3OcmybUGvrHEdGkUEWhZ4AJdmxmzRrBg==
X-Received: by 2002:a05:600c:6090:b0:45d:d289:f505 with SMTP id 5b1f17b1804b1-45f211f859dmr2930595e9.4.1757619239071;
        Thu, 11 Sep 2025 12:33:59 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015313aesm21482975e9.1.2025.09.11.12.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:33:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 21:33:55 +0200
Message-ID: <20250911193354.56262-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Y05O7Ah8m3VrEBiRrZdSc+R+4Iv9NkkVIZ6x07U3YEQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowyQi+cSPrAv1rp5UH7+T2nsmq+xlq6yAIsx8P
 Qozzjt5QfuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMMkIgAKCRDBN2bmhouD
 166OD/9YQ0dD2iuqqC+ZD585xgymLed/9O9kWjjSX7YCQy28HGCLCSvlMY/pYzOl7IOhZ1bAgyH
 149EUs50IFMsFXPfofEnW/Y6dHjiNO5C8lD9F4NeycppZ1P0VbLOL3EIjoQfW83sP0EXT+hCbW1
 SJhUSPYjh7jLNKoorDG1oJiCZwc60G10DK+vG2KwKUC18PksmSUSXe8rog+C8KJO1LyhqmmhRmu
 FUVRa6cs1doCz3nEfssqNdS5SPn2tPBY52U4pJHEZxIkT8KlQjQ6B8kjLfnYtm5T9rCNq2kHg28
 tp4/x3RCWyOKQ5Jv3ZHy39kqSJ2Ud2U+5uF2J6O4CH6/O4Jt/mVAy2Y6bdbvw4Pq5iAH30BAbok
 CULqzqvuOw6s7GmRgC/XuoAAkQiWm9ArksRn5Z+5hboIMV6qtTn1u4cxtTDLwEe3OUa6vwAho47
 tag7LElYHUmuRgQFv7FROGw4qC4ZcLpyj5gfIh5Zffm12rlsARWMwvm6DSZJcNJC78yjpNq/SZU
 /nxAKmoHEGQLt8pwiVqY/lAc+2peYG9akyzMoz0Tlsb7BNp7AVvNt26ifsTDqvvNPl+g3Kf9w2S
 GsrPklvGEXuF2mPhDn7ABd/mt1gLw5GrykSMz0zVn9I52/coYtmU8Pg+Y7r3fh0b6pdsg2/ZLpP fR46MfihNPN+m+A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] coccinelle: of_table: Handle SPI device ID tables
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 3026
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/20250911193354.56262-2-krzysztof.kozlowski%40linaro.org>

'struct spi_device_id' tables also need to be NULL terminated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 scripts/coccinelle/misc/of_table.cocci | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 4693ea744753..17881cb0884b 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/// Make sure (of/i2c/platform)_device_id tables are NULL terminated
+/// Make sure (of/i2c/platform/spi)_device_id tables are NULL terminated
 //
 // Keywords: of_table i2c_table platform_table
 // Confidence: Medium
@@ -15,14 +15,14 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
 *	}
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 *	{ ..., E, ... },
 };
@@ -33,7 +33,7 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -42,7 +42,7 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 +	{ }
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{ ..., E, ... },
 +	{ },
@@ -55,7 +55,7 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -63,7 +63,7 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	@p1
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id \| spi_device_id\) arr[] = {
 	...,
 	{ ..., E, ... }
 	@p1
-- 
2.48.1

