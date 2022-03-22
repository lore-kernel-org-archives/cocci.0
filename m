Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10934C433F5
	for <cocci@archiver.kernel.org>; Tue, 22 Mar 2022 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=mwOby9IVwYJiCSfVcktnzuwgksnwt4ejyOiDrK7Boqc=;
  b=gPuKIpm1foyUMHzMV2LcaAg/09lPWH5hQBdRHS9Aq+p6wpsvTxLq6Cy3
   gKzziKQAdz8jGZZM32CJ+LesGzFu6WQnHvcdGlZIyNZrHj3cfVFsSHLbN
   BtlUSW+zyp+Q/PeBjR4gswiXLYMLY2xrne4ARuHMy9Uda5RUMbJfypa4U
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.90,201,1643670000"; 
   d="scan'208";a="27376576"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2022 09:04:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ACA36E0219; Tue, 22 Mar 2022 09:04:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ED43DE0069
	for <cocci@sympa.inria.fr>; Tue, 22 Mar 2022 08:59:28 +0100 (CET)
IronPort-SDR: l8WIcecCUefcROvEEOJeqfyEY8QfAAQwU6Q33sDCP+SQMG9f8z8FAAMaJ+l8F0o3uKALtRlUUX
 +YslwP+Ed372kE64QT9yQFylQTxG8mvesu63aKZ5YMfZoPMeNWVo02v6R8QVXQ/d9cSnKwZtXC
 23qvGs7xwvWTmAhl2UD9batSR1cPopgeWc6AXHOwKzoScGVWzH/fdzEqiB7+8fPwOWuhrm4uHa
 cErmqwt5aHhgQ/ynd4orX/uZz7lQFwUob/uhxdDQa7+/0XMH+kuLIXissdx/bgMf6dIwdb+SSc
 qFJpMyFLLCKSaxIlW52swuJ7
X-IPAS-Result: =?us-ascii?q?A0DsAQC3gDlif6neVdFagmOCKHgGVysET6IXkDsUgWgLA?=
 =?us-ascii?q?QMBCwEBMQ4CBAEBPAGESoQ/Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhAwFEgU+BTyULAzENgjUpAYNmF?=
 =?us-ascii?q?iABDQEbHQEDEhpUEQEFATUigmIBgmQBAy4En1SBBD2MRwUXgQGCCQaBFIM1C?=
 =?us-ascii?q?hkoDWoTgRksAgcJAQiBKoYSgyiCZkZpeieCKYEVNoEGgiyBD4J5gQqFMgSYE?=
 =?us-ascii?q?4EOK4F+wSYHjUCBG5RKTYVCkHsMkXcBlluNFZUhhCMCCgcGECMSgSyCFXCDO?=
 =?us-ascii?q?QlFAQIBAQENAQIBAQMBAgECCQEBApIPgT6JIEE0OAIGCwEBAwmFRj6KTgEB?=
IronPort-PHdr: A9a23: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
 sNmdw==
IronPort-Data: A9a23:+Xh6Sq3HjhsiFLx9VPbD5RF3kn2cJEfYwER7XKvMYLTBsI5bpz0Ex
 zQZXm2OaP3ZYGD9c9ElOorl8UJV7cPVyNQ1HQY/3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jX4
 4uoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt5dU9
 uQSk4DvczYoA4vUwLslSxMGTggraMWq+JefSZS+mcmazkmDani1hvs3UhBwMoof9eJ6R2pJ8
 JT0KhhXNkHF17/wmujhDLAy16zPL+GzVG8bknpvwDWfH+oraZ/GSqTOo9Rf2V/cg+gfR6yGO
 5ZBAdZpREngPQVXJEgPM7QFpviGvGv2fgZS+HvA8MLb5ECKlFAruFT3C/LRc8ODQcF9jEedr
 HjPuWX/GBATctKFoRKO9Xmnh8fUjCbjUcQTEqe5/7hkmjWuKnc7DRQXUR6ioqD8hBfgCpRQL
 Esb/idopq83nKC2cjXjd1qdnk/bmAJDYetRLssisF610qCKvi/MUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9GSL1GlC8/WPaBMQFEYMRTXRbElZdsrEPtKl2302fFI8yeEKgpoStQWmY/
 tyckMQpa1wuYSMj0qy6+RXegGvpqMGXH0g64QLYWm/j5QR8DGJEW2BKwQiGhRqjBNzBJrVkg
 JTis5bGhAzpJczc/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43bplUKWC1O
 BaJ5Fs5CHpv0J2CPf8fj2WZW5RC8EQcPYmNug38MoIeM8EpKmdrAgk3PBTMjggBb3TAYYlmY
 cvBGSpdJXkdDqtjwVKLqxQ1gNcWKtQF7TqLH/jTlkz5uZLHPSL9YepbbTOmM79hhIvZ8V292
 4sObKOilkQPOMWgOXK/2dBIfTg3wY0TX8+eRzp/Lb7dfGKL2QgJV5fs/F/WU9c8zvoPybuQo
 C3Vt40x4AOXuEAr4D6iMhhLAI4Dl74mxZ7iFSBzb1uuxVY5ZoOjsPUWe5ctLOso8eViybh/S
 PxcI5eMBfFGSzLm/TUBbMml/NYyKkjz3Q/ebTC4ZDUffoJ7Q1Ob99LheDzp/nZcAyeys/w4v
 LD9hBjQRoAORlg5AcuPMKCvwlq9sGIzguV3W0eUcNBfdF+9oodvIi31yPQwJphUexnEwzKb0
 SeQAAsZ9bGd+d9rrIGRiPnd/YmzEuZ4Ek5LJEXh7O67ZXvA426u4Y5cS+LXLz3QUWXD/q/9N
 +hYyvfLNuJewARHvo96JLZczawk4uzpqbIHnB9vG2/GbgjyB75tfiuG0M1IuvEfz7NVo1HqC
 EeG+90fILbQfc28Tg9XKw0iYeCOk/oTn2CKv/gyJUz74g5x/aaGARoOZUjS0HQFIesnKp4hz
 McgpNUSt161hC0sP4vUlStT7WmNciENXvl1rJ0cG4O32AMnxksYPc7ZAy7ypYiMMpBCaxd7Z
 DCTg6XGivJXwU+bKyg/En3E3Ox8g5USuUAVkAVTeQzRwteV1OUq2BBx8CgsSlgHxBtw1e8ua
 HNgMFd4JPnT8jpl7CSZs7tAx+2c6NylFk3NJ58hkWTYSwyxVTWIIjRjaKCC+0cW928adT9el
 F1dJKAJTh6yFPwdHANrMaKmlxAnZdN0/wzG3sugGqxp2rEkNCH9jPbGiXUg8nPa7ABYuKEDj
 eZv9ed0L6b8MEb8ZkH955ayjdwtdfxPGICOrTyNMk/E8aEwtQxeAQSzFn0=
IronPort-HdrOrdr: A9a23:PPPboq257JlcB+QDjUz44QqjBJokLtp133Aq2lEZdPWaSL39qy
 nIpoVg6faQslwssR4b6La90cW7MBDhHP1OkPIs1MmZLXDbUQKTRekIjbcKqweAJ8SUzJ876U
 4PSdkaNDQyNzRHZATBjTVRV7sbsbu6GWyT6ts2t00dNT2CopsP0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,201,1643670000"; 
   d="scan'208";a="9220440"
X-MGA-submission: =?us-ascii?q?MDHBBS//EFWL6xAc7zqHXqMrNI2331gEMf9xGp?=
 =?us-ascii?q?kx8go5fG2hEjJuGpVZjFIZYu+UjSqOOlwOrj8dyTBeXsZaX8rQ88ginR?=
 =?us-ascii?q?bu2mid2sp2bbpLo9GTGeg1hz/oKSSzhcsYmVA306am7izQ8423JFeESK?=
 =?us-ascii?q?WQFarHuSMVZlFfIpxOyprFYQ=3D=3D?=
Received: from mail-qk1-f169.google.com ([209.85.222.169])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 08:59:28 +0100
Received: by mail-qk1-f169.google.com with SMTP id v15so13411836qkg.8;
        Tue, 22 Mar 2022 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwOby9IVwYJiCSfVcktnzuwgksnwt4ejyOiDrK7Boqc=;
        b=Ova7SGpSJ7NF6kHqOnkA8W+/64yrl1WL/dF0LltcbckpdSux3J8hjlcnKanzu7dHKI
         HaCJB/OJsZA/8ejdupwJrke4RBInT8UJd06Pb91hkAzsCsMn60rJ+h+m4+Oe4kLHc3Ls
         zhDdwbAH1ZBI5KdUdpk/8fhBfYogp6t7RRA2KQe+H7MTUBxaXO90ke2m3y3KnzzDFah3
         tEx2TZbnk0giHWUgbXgNar9XoE3dFIcWhtkX/nAWkrPzbnqVgiRpes586KuoJuJEsi+D
         iplsMwpI2LbGiFmVu/PzFpFEWsxx4oleHsBXgtt6ro8kedJ2yWm/fqgvs8dSoX6WDtWL
         UhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwOby9IVwYJiCSfVcktnzuwgksnwt4ejyOiDrK7Boqc=;
        b=WbI7rADP+sdWCxEolJxVsZsnCu5MfL5JLXRCIQIlIC7mKw0ThXaxWZDhSyKdWn4tqH
         yoJ/7sdg+PDPOCyXzijDrSf7CJJhFYacSZi50JQMxwbTAEndVfpgVTBFVItZEVXYGPbK
         95KwpL7I2Q5YCUUNGKoEpc4Bk7XxADqKla0ANckD1+4mjnU12SOvqOXXDoIlQNTXJ1cZ
         Vqj2tWTW/p+9ZB/s1Ml/kr5YNr5teaRpFBAzypAxpdgykxdkfLtAWooNBYWFwy6A2E/i
         UYY/ni1t3siAdESX1v0nusbkoSz94zapN9g/J4jYZYEoxaeJEdf13ct58RsKAf1xSgCM
         4xBg==
X-Gm-Message-State: AOAM530MzoiWKeIc/4uunr/q+eMLgHKmvtdkVH7JUFPpgcmOklvaTayR
	93qlILNJ8UX8zijS5f3fpqv0BIsxbBU=
X-Google-Smtp-Source: ABdhPJwDX3Wucs4JsC7GHfKymDfnnUli4DVPYCEkwVuUuYMEHJmndYOskvta09i3l0gzRCYQ+9QuGg==
X-Received: by 2002:a05:620a:144c:b0:67d:f6b5:1e9c with SMTP id i12-20020a05620a144c00b0067df6b51e9cmr14606576qkl.704.1647935966005;
        Tue, 22 Mar 2022 00:59:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 64-20020a370343000000b0067b31f32693sm8933455qkd.109.2022.03.22.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:59:25 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: Julia.Lawall@inria.fr
Cc: nicolas.palix@imag.fr,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Minghao Chi <chi.minghao@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>
Date: Tue, 22 Mar 2022 07:59:15 +0000
Message-Id: <20220322075915.2338847-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccicheck: Add redundant return variable test
Reply-To: cgel.zte@gmail.com
X-Loop: cocci@inria.fr
X-Sequence: 283
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/20220322075915.2338847-1-chi.minghao%40zte.com.cn>

From: Minghao Chi <chi.minghao@zte.com.cn>

This semantic patch looks for variables that are only used
as parameter returned by the function.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 scripts/coccinelle/misc/redundant.cocci | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 scripts/coccinelle/misc/redundant.cocci

diff --git a/scripts/coccinelle/misc/redundant.cocci b/scripts/coccinelle/misc/redundant.cocci
new file mode 100644
index 000000000000..57a4546783cb
--- /dev/null
+++ b/scripts/coccinelle/misc/redundant.cocci
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Remove redundant variables and return the value directly.
+///
+// Confidence: Moderate
+// Copyright: (C) 2022 Minghao Chi, ZTE.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@dislike@
+position p;
+identifier var;
+expression E;
+@@
+
+if(...)
+{
+ var = E;@p
+ return var;
+}
+
+@hope@
+identifier var, stru;
+expression E;
+position p!=dislike.p, p2;
+Type T;
+constant C;
+@@
+
+...when != T* var
+   when != struct stru* var;
+   when != var=C
+(
+ var = E;@p
+ return var;@p2
+)
+
+@script:python depends on report@
+p << hope.p;
+p2 << hope.p2;
+var << hope.var;
+@@
+
+coccilib.report.print_report(p[0], "Redundant variable: \"" + var + "\". Return \"" + var + "\" on line " + p2[0].line)
+
+@script:python depends on org@
+p << hope.p;
+p2 << hope.p2;
+var << hope.var;
+@@
+
+cocci.print_main("redundant \"" + var + "\" variable", p)
+cocci.print_sec("return " + var + " here ", p2)
-- 
2.25.1


