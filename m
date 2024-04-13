Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57A7C04FF6
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2024 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gJigKPWIBEvqycUKO6aOcb2AXvucWmGHLCNisFtUdWc=;
  b=rqIg4etRn/LIXdpazE/pnXO0g9JAXxhBs3D9y/NTp0T9TJ8ige6kAIsY
   zgx6kLG85ruXJ0fZ1555kcENjNj2pNELOHQhIIsPDlp37ozkAkLVy1HQo
   yU3htk6vK7k8MhekpErQd8MGleuFYzR9fu/VGbmcpMdSulR5F1TEn7QqR
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.07,198,1708383600"; 
   d="scan'208";a="161387610"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2024 08:57:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3110E0AF1; Sat, 13 Apr 2024 08:57:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9D60EE0AF1
	for <cocci@sympa.inria.fr>; Sat, 13 Apr 2024 08:57:33 +0200 (CEST)
IronPort-SDR: 661a2cdd_NXyG6hDe2qCkzdGtJt6rV2yeV5RNGQmgQQzV3i7pOXvnojn
 40UvEontPkTiEyWQa6AJ4XaKpBBoHkAJ6UHQivw==
X-IPAS-Result: =?us-ascii?q?A0GDCADXKxpmkCH+dcJaHgEBCxIMggQLgkSBUTADBwhIj?=
 =?us-ascii?q?VKmd4F+DwEDAQ1EBAEBAwEDhH8CiBkgBgEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QgBAQUBAQECAQECBAYBAhABAQEBAQEgHhAKBCeFbQ2CYIENgQ0BAQEBAQEBA?=
 =?us-ascii?q?QECAQEBIisCgQkCAQMyAQ0BATcBD1FWGYMAgmAHslqBAYIKAQEGgmbZN4FhC?=
 =?us-ascii?q?YFIjQeEanqCT4JQgi2FEIVUIpdohTqEY0qBfzIBVRMOJAsEDBoCGxQNJCMCL?=
 =?us-ascii?q?D4DCQoQAhYDHRQEMhEJCyYDKgY2AhIMBgYGWyAWCQQjAwgEA1ADIHARAwQaB?=
 =?us-ascii?q?AsHdYM7BBNEAxCBMooXgz0pgXmENEuFDYE+AwkDBwVJQAMLGA1IESw1FBsoH?=
 =?us-ascii?q?24HoBJhLSqBbcZGhB2hLU2XRpJuiByQRqJ5gSmEY4FkOoFcMxojgzdPAxkPj?=
 =?us-ascii?q?iAZg2GeWEQyOwIHCwEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23:Q+YqahFWurvwYS/fmKeqFJ1GfydGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k33RmQA9iQtK8MotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmj6wbalvI
 Bi3rQjducsbjIt/Iast1xXFpWdFdOtRyW50P1yfmAry6Nmt95B56SRQvPwh989EUarkeqkzU
 KJVAjc7PW0r/cPnrRbMQxeB6XsaSWUWjwFHAxPZ4xHgX5f+qTX1u+xg0ySHJ8L2TLQ0WTO/7
 6d3TRLjlSkKOyIl/GzRl8d9ir9QrhC8qBxl24PaYJ+bOeRjcK3Tft0UQmhOXsheWCJOGY6wc
 4gCAvAdMetCs4Xxu10Dpga+Cwm2A+PvzydFiX/x3a0+3eQhCxvJ3Ak9FNwTqnvUqtr1P7oVX
 OG716nH1zLPb+lI1jf79ofIaQouoeqXULJra8XRz0YvGxrbgVWWpozlPjWV2foTvGiB7upgU
 +2vh3Q7pAF2pzii38EhgZTGiYwJ0F7L7zl5wJorKt2iTk52ecKoHZ9OuiyZK4Z7QcwvT312t
 Cs6ybAIt4O2cDYXxZopxhPRa/yKfoyV7xzsSOqcPSp0iWxldb+jhRu+7UmtxO36W8Kp01hKt
 jJInsTIu30CzRDf99WLR/ln8ku/2TuC2Brf5+9KLE0yiKHWNZohwqMrlpoPr0vDBDL4mET3j
 aCIbkgo5u6l4Pn9bLr8vJ+TLYp0hxn+Mqswnsy/Bvw1Mg0UUGia/eSwzrzi8lPkQLVRkvE7n
 LPVv43EKsgDp665BRFa0po75hqiCzqr384UkWQaIF9HYh6LkYjkNl7ULP32A/qzm1Gsny1qx
 /DCML3hGJLNLn3bnbbvZrZy8UlQyBAtwtBZ+Z1UEasOIOnoV0/qrtPYCBA5PxWqzObhB9V91
 4UeVnyRDa+DMaPSt1CI6vgzLOmLYY8ZoDD9JOM96P70kXA5gUMdfbWu3ZYPdXy0Bu5mLFmBY
 XrwntcBFn8HsRY5TOP2lFKCUCVeZ22yXqI5/jE0EpiqDYbFRoC3gbyOxj23HpNMZjMONlfZG
 nDjfISsWvEWaSvULNUyvCYDUO2eTIsvzxir/DTzzbUvevXP824CuJTuz9Fuz/bakx53+Dp7D
 sKQ3nuMSW4ylWQNEWxllJtjqFBwnw/QmZNzhOZVQIQ7D5JhVw47McSZ1OlmE5XoXQmHeN6VS
 VGgS9HgADcrT9t3zcVdK11lFYCEiRbOlzGvH6dTj6aCUYMv++HG0n78PM9m423P0qZkgl8pQ
 81COHengKE5/A/WVMbSi0vMr6+xbuwH2TLVsmKKzG6ApkZdBRFrWObfUHYSfULNhc/w4EyHQ
 rmhCLIqPxFAz8HEIaxPOZXylVsTfP74I5zFZn6p3We9ARHd3rSXcI/jYHkQxg3YAUkA1RIe4
 G3ebk4yC09Nukr4CzpjXRLqakLoq6xlrW+jC1UzxEeMZlFg0Ly8/lgUg+adQrUdxOBMviBps
 DhyEFunurCeQ9OduwpserldatIh8R9G02zerQl0Ip2nKehrmFcfdw19u06m2Q9wD81Mls0jr
 XViywQXS+rQz0hINCmV253rM6b/MWD081WibaHX3FzTyteQ9eEE7/F541TvsQe1F1Yzpm192
 oowsTPU7ZHLAQwOFJPpBx9mq14j/u6cOHRhodiPhhgOeeGuvzTP2swkHr4gwxekJZJENb+cU
 RX1GIscDtSvL+ojnx6oaAgFNaZc7v1RXYvuev2Y1aqsJOslkiihiDEN/5t0kViB8SdnQ/Xgx
 J8DzLSV2ASGUTrxllanvYb8noUONlRwViKvjDPpAoJcfPg4Yp0CSn2jJcCsz85WnJfrVDtV8
 lGiAV4Lws6vdlyZaFm3jmgynQwH5HegnyW/1Tl9lTok+7Ge0CL5yOPnbBMbO2RPSQGOlH/UK
 JOvx5AfVUmsNU0ykQe9oFz9zO5drbh+KG/aRQFJeTL3JidsSPn4ur2Has9JoJQm1EcfGPuna
 BOAR7jwuBIB+zjqGWQbyTY0djent4/4mRM8g2WYZHp+t3vWf8hsyAyXvY2AA6cIgXxcGXU+0
 mKfD0PZXZHh5diOkpbfru2yH3msUJFea2ijzI+Nsje6+Xw/BBS+m/6pndi0dGpymST/1tRsS
 WDJtEOlM9Wtjv3ld7g6Ig8zXwyZiYIyAIx1n4ouiYtF3HEbgs/Q5n8biSLpNt4d36vibX0LT
 DpNwtjP4QGj1lcwSxDBj4//SHiZxdNsItegZWZDkD0m5oNQBaGZ97VftTB8pFX9oATeYP5wk
 y0cz/Ro43kfybJs2kJl3mCGD7YeEFMNdzP3nleS4tazt6xMTH2md7f12UxxnNasAauDpA4aU
 3H8MMRHf2c4/oB0N1TC12f244fvdYzLbN4dgRaTlg/Jk+lfLJ9i3upPnydsPnjx+GE00+Nux
 wI7xom05cLUTgcltLL8GBNTMSf5It8e6i24x7gLhd6YhsiqDt17FzkKRpbjUaefCyoc8+nrM
 guCETR6rHqHU9IzBCen4Vx95zLKGpGvbTSMIWUBiM9lT1+bLVBehwYdWHM7mIQ4H0ak3p6pf
 EB87zEXrln2z3kEgvpvLAX6W3zDqR2Abz41TN6NIQdNtloE60qdPcGF7+11Fj1V5dX4/VDLc
 zXEIV4VUSdSAQSNHDWBdvG26MPF8vSEC+b2NPbIbbiU6KRfW/qO2ZOzw95m8jKLZY2EOnhvC
 eF+21IWBCElXZ2AxHNVFnBRzHmeCqzT7A2x8SB2sM2lpfHiWQa1oJCKF6MXK9JkvRa/naaEM
 eeUwid/MzdRkJ0WlhqqgPAS2kAfjyZ2enyjC7MF4GTSV6uTgKJRAgUScAtoPc1Hqq860QhLN
 MPBi9X6kLV/i7RmbjUNHUykgcyvacEQdiulM0jbAU+QKLmcDTjCwsWxc66hUuULyulZ/U7V2
 37TAwroOTKNkCPsXhakPLRXjS2VCxdZvZm0bhdnDWWwBMKjcBCwN8V7yCEn2bBhzG2fLnYSa
 HIvFiEF5q3V9y5The9zXnBM/mYwZ/fRgD6XtqHdOsQEvOZwWn8ym+8St30+z/E9BMRsX/Vzl
 27fqNFvpVyriOiJxXxsVx8c8l6jZaqOtERmf7fU64IYAjDI8UBUhY1/Iw8DodQgB9vguqZdx
 8LOkq21IzBHoYu8wA==
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:9B8PmavBBeQLxIk0t5v5UCyp7skDQNV00zEX/kB9WHVpmwKj9v
 xG+85rrCMc7Qx7ZJhOo6HiBEDtexzhHNtOkO0s1NSZLW/bUQmTXeNfBOLZqlWLdhEWtNQtsp
 uIGJIfNDSfNzZHZL7BkWyFOudl/PTCyqS0nKPlw212TQdsApsN0ztE
X-Talos-CUID: 9a23:key1qW4kF2OBpzigWNss30cuCp4eI3/h9Uj9ekSRCm9gZ7uvRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AwhpQ5wwOvNUBgh42X+RxInfxtUGaqP+TCQcisZM?=
 =?us-ascii?q?WgcqnZAdJGiulzxmOR5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,198,1708383600"; 
   d="scan'208";a="161387585"
X-MGA-submission: =?us-ascii?q?MDHbmnALlEmGq+Z2EadOhV2mZRebVlITqeitTW?=
 =?us-ascii?q?ZthEPYMx1v60SkQ/wHkiizGc1g/bguUbwaJGtD+29aQ/38otw2MsnrAg?=
 =?us-ascii?q?Sgf+m01Kug6qPzEw4rnMO2WYOmVxJQLbqMK+s9CYoYKa0XtVO5aJQm7G?=
 =?us-ascii?q?rFRnLfDNnBTJ4VAzmdLTfc3w=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 08:57:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=gJigKPWIBEvqycUKO6aOcb2AXvucWmGHLCNisFtUdWc=; b=j+eaJ9
	G7/xZF04fcenS6esnqJsCEea6RHzWFLQm+x2AhwQiA14v8tzK3vXfavZVcv/B/mI
	QZv5ZMh9DSJnwZHlY9VpWaboHCZNItSyUq7ghYETcLQOarvLSRhlWBIpgksaCJNC
	wNPXcDOGURygAWSO2ZpWAD+D3+E2DU9MDqmW29CovIjeIN8huOmp9kDfzkgcZ2KK
	AXBTl+IE84M4gL5eqseUgWLMF5ZjO1cg7KFHYWKrmXct4VPMvmvHgTLU7WpkTvwV
	LWjpZE8DnQQam8BSgjwNY9L2E9eGJd0XBfb02Ro71PotL/tHWYgaBReNaDUIAF0v
	nh3PSux3jqfRkCrg==
Received: (qmail 1439136 invoked from network); 13 Apr 2024 08:57:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Apr 2024 08:57:32 +0200
X-UD-Smtp-Session: l3s3148p1@3yL85vQVBa5Qk7GI
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: cocci@inria.fr
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sat, 13 Apr 2024 08:57:26 +0200
Message-ID: <20240413065726.2197-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
References: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH 2/2] install.txt: mention 'hevea' as dependency for
 HTML docs
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1648
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/20240413065726.2197-3-wsa%2Brenesas%40sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 install.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/install.txt b/install.txt
index d55b7b2b..ba5d1127 100644
--- a/install.txt
+++ b/install.txt
@@ -19,6 +19,7 @@ On Debian/Ubuntu, install the following packages
  - libpcre-ocaml-dev (optional, bundled)
  - libparmap-ocaml-dev (optional, bundled)
  - texlive-fonts-extra (for the documentation)
+ - hevea (for HTML documentation)
 
 On Fedora, install the following packages
  - pkgconfig (optional, but strongly recommended)
@@ -29,6 +30,7 @@ On Fedora, install the following packages
  - ocaml-ocamldoc
  - ocaml-menhir (optional, bundled)
  - ocaml-pcre-devel (optional, bundled)
+ - hevea (for HTML documentation)
 
 It may be necessary to install libpython2.7-dev
 
-- 
2.43.0

