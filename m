Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11CCC48BEB
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9htNDVcJiQzKBjSTYnGyY/LGt51cX11VDgmsH2O6NIU=;
  b=fnqwtqBISNKhG7sRluSs3Vo+yLX2A/XJt14VWZmZqttnjRZtdd2G7qkb
   zi02ceRVx7a11w2lq//veutAlpg671IrIachOvo9gWYp+enLQ8YjDi7+V
   mu3xBfvXeP3pJ37MyC+fM0/RGtTCilGAS4Hh7BxN/mkMAX8j1lFB4p0J6
   M=;
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
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152260591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 09:56:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2F0CE00B7; Fri, 16 Feb 2024 09:56:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D847EE008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 19:02:06 +0100 (CET)
IronPort-SDR: 65ce519e_N2TSPAz7KitSIfU3SUcR9WxZBTXxrfYSMsAU5cdrsM9NkAU
 qCqw5TUL454uy6fgyMdbLAQlvSem1X6WIymLohg==
X-IPAS-Result: =?us-ascii?q?A0ECAwAmUM5lf7LSVdFaHgEBCxIMggQLgjl8VjIEUwSWN?=
 =?us-ascii?q?YEWnHMUgWoPAQMBDAE7CQQBAQMEhH+HXQIeBwEEMQgOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQgBAQUBAQECAQECBAYBAhABASIZBw4OKYVsDYJcAYEegSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAg1+FiABDQEBLgkBTkUBBQEiEyKCX4JfAxGmPoEFQoxtgQGCCgEBB?=
 =?us-ascii?q?rEegWEDBgkBCoE0jHSBK4JQaYEhG4FJRIEVMoEJgTd2hCkvhi6CFoM7hFuFU?=
 =?us-ascii?q?Y8uSoEmA4EFbRsQHjcREBMNAwhuHQIRIjoDBQMEMgoSDAsfBRJCA0MGSQsDA?=
 =?us-ascii?q?hoFAwMEgTAFDRoCECwoAwMSSQIQFAM4AwMGAwoxMFVBDFADTRcfGhgJPA8MG?=
 =?us-ascii?q?gIbGw0kIwIsQAMJChACFgMdFgQyEQkLJgMqBjkCEgwGBgZdIxYJBCUDCAQDV?=
 =?us-ascii?q?AMhdBEDBAoDEwcLB3iBUYF1BBNEAxCBNIongTUDCQMHBUlAAwsYDUgRLDUUG?=
 =?us-ascii?q?wY+bweeDAGCSAeBDgErUJgZjk6gZIQbgWEMihuVGBozlzCScgEumCqLeIF3l?=
 =?us-ascii?q?imENgIKBwYQI4FDAzWBXDMaCCgIgyJPAxkPjiCJDosGIjUCOQIHCwEBAwmJI?=
 =?us-ascii?q?oFGAQE?=
IronPort-PHdr: A9a23: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
 Ro7zAB5ZLZ1nN8Jy1w3PF3PpTY11k4rloe96Q0=
IronPort-Data: A9a23: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
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:7ajlF6t93jDD6aq6h0zSH4KA7skDmtV00zEX/kB9WHVpmwKj5q
 STdZMgpGPJYVMqMk3I9urwXpVoLUmsl6KdgrNhRotKIjOWwVdARbsKheCSoAEIcxefygc379
 YGT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5ai815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 vn2uN34xWnYmoedcm2Cz0oWOLZt8TXmJ+OW3I77t0chzVmTwnE1Fc3KXalN28lIktyKH4ZkF
 T4rw==
X-Talos-CUID: =?us-ascii?q?9a23=3ACfxiOms7KW5NCEufzsOiebTu6IshcXDP53D5J3P?=
 =?us-ascii?q?lGF5jT5/OTFKev6FNxp8=3D?=
X-Talos-MUID: 9a23:pQgxcQWai0if4Dbq/Cfq2i1jaOhD2LW3In5QzJQUmubbFQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,162,1705359600"; 
   d="scan'208";a="152194888"
X-MGA-submission: =?us-ascii?q?MDG+rgjBbpZhbT+TzttgLvr+CP+GKBsrUZlTjy?=
 =?us-ascii?q?x5nszOh4dpq7hHuF6gUOBvAUpUN0qnaTdw/pwyT9hDD3Z1H+JJ/FsrUb?=
 =?us-ascii?q?Xzk06wS2Nr/oZWbeiaJvLQhnYYXmx44NpvbypvFScy22jH1qqhVOoo9d?=
 =?us-ascii?q?1NsHAyQogavWbFFc8wF5Gorw=3D=3D?=
Received: from mail-pf1-f178.google.com ([209.85.210.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 19:02:05 +0100
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e0cc8d740cso979144b3a.3
        for <cocci@inria.fr>; Thu, 15 Feb 2024 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708020124; x=1708624924; darn=inria.fr;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9htNDVcJiQzKBjSTYnGyY/LGt51cX11VDgmsH2O6NIU=;
        b=nb8YkGmqmF7Q6lVlpKtps9aJohnod2IgE47bZaKME0qXtHyOuZwCbvwrKgDFbXduuY
         QsVvGeqCmWSCIqfuyA7IpcQauaNcWSihqvbYxopibBLUC9nFXNVdb7vU2v3som7BG3tC
         O8MYfMNOAGDEPhIOtge2VQfZYEKddsos52AJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020124; x=1708624924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9htNDVcJiQzKBjSTYnGyY/LGt51cX11VDgmsH2O6NIU=;
        b=SkuM8SkYVdNJ1QdjA/ryPcNdZOxKVmW02AUF7mXa/29P0Se7s61HdKbwwWtWlJwXCW
         X4qm70tT+WrmumUjoJJ5AAyzWWPlr0VYfZu2KtB8bXViwbnUH9EqT9FLyYZTefZSSDug
         zSvKiTUNhsAy9gLjxLamm3DKaVUZv0K1HFGPjBGZeatbYzfbffLN+E8HHJuh25QG4DQC
         R+oxqlR9AkJnX1Afb2CvxHz9mjtXT2f/8lKFB3h0BMexWKJlsOibPrahPPFSx1iQi5GG
         uEEauwbJKYXtZ2RpzCACgRe5vjqKzvKZKupqz8AI97vKWLmsW8Xv7sWuLkvV9SO5k0gT
         Oh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6EFEkRiz0T+hLxsyIJ7bESF4r+Chcn2Xfi/cwFcSG8JsTVeGLpIPl6VshN2ZTey+WUKNm6rLSZ4NOjEoH7g==
X-Gm-Message-State: AOJu0YxhA+jTfE+pVVg49J1aUoVFr/nkawVrXu5Yy9LwhLPwhttYrh8u
	z/zKWaXKQPFv+hkp69oPzLjKJZlcn3GSq7w1y7IyCc1FSsWR1rRrbK5ML+6wQg==
X-Google-Smtp-Source: AGHT+IHqmlfDgzHmfq808+OGy+E529SMfmtYCg6JCBKR9EW/8sR8n1FqiSo9zyXjhuvT95+6WhRsVg==
X-Received: by 2002:a05:6a20:9f45:b0:19e:488f:692d with SMTP id ml5-20020a056a209f4500b0019e488f692dmr2663398pzb.7.1708020123955;
        Thu, 15 Feb 2024 10:02:03 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bn15-20020a056a00324f00b006dddd5cc47csm1618230pfb.157.2024.02.15.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:02:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Date: Thu, 15 Feb 2024 10:02:00 -0800
Message-Id: <20240215180156.work.548-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=keescook@chromium.org;
 h=from:subject:message-id; bh=uliD4n1/D3aYvE1jB8oAraADRLxzqurg0yvqaiBpYyc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzlGYk98jTaHEW82NrfdAFv/Sm9zc9XykYhgrd
 LkYJRfIhZCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc5RmAAKCRCJcvTf3G3A
 JnXaD/41Hvrpe6G5m2Hso2TQfzI332o8bu9AlSB1QVt9jUwDBVCfnIFGFx5YFH5S8whoGDwuzyH
 MzXyuJL6Wo0ElgrYoBFBBvbfR6hgq3/lUDWkFuns3+2djQnP0Y0y1zZEkzZL66aqbonYN96vXSU
 WP1MB3V3CSsHvYEhPJ8vbc/xgvNyt+fSjTRxTHdYfpd2s1YSelUcSNeEortrV0wqrdlaTQ1EPJo
 apDHtx3+ni6xq0KzZWdYV2cWCPR8LMQzNegMQ/gLJmdawEpLug6sTDESuMQcE4S2wra8u1esN6L
 ehxOV68auUh1RqpkienD+hfKX4xK2xexnCe7Lqlbu+ypCLT5wQMH4jqaugdu8/J04sbrmLFdY3y
 hB6b/u/JPVj7dgtej8NLvFNGKo67KL7c8IJui6d21ed57DNinZJX3A2DG0HG816qs2Bqq4AwFvA
 zbnL4pXXJwBbV9daOx7FuO0XitRwnubNbujsxRppJdiYEmbvbEHTILk5Fpt56urdhntiff5wLpE
 Bslc7M8miajcquF3kzkAKCg6NwnkdPDrblq//TD3aUa5UEcLx8LD/tdZOswH5TvhZYVyTPslHHH
 Zyxqv4EMNa3CmadSGR/SsA8qmcLLiEuMq0ncOfflwJCqTlpzIloclD52cvMzEDe8qiYh/Rw7/g8
 FYtvlMm as3cldQg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] cocci: Add rules to find str_plural() replacements
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1559
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/20240215180156.work.548-kees%40kernel.org>

Add rules for finding places where str_plural() can be used. This
currently finds:
 54 files changed, 62 insertions(+), 61 deletions(-)

Co-developed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://lore.kernel.org/all/fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr

Since ()s are deduplicated by Coccinelle I removed the duplicate rules,
wrapped the final rules in ()s to catch those cases, and added a "!= 1"
case.
---
 scripts/coccinelle/api/str_plural.cocci | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 scripts/coccinelle/api/str_plural.cocci

diff --git a/scripts/coccinelle/api/str_plural.cocci b/scripts/coccinelle/api/str_plural.cocci
new file mode 100644
index 000000000000..c28cb6f7b803
--- /dev/null
+++ b/scripts/coccinelle/api/str_plural.cocci
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Find places to use string_choices.h's str_plural() helper.
+//
+// Confidence: Medium
+virtual patch
+virtual context
+virtual report
+
+@depends on patch@
+expression E;
+@@
+(
+-	((E == 1) ? "" : "s")
++	str_plural(E)
+|
+-	((E != 1) ? "s" : "")
++	str_plural(E)
+|
+-	((E > 1) ? "s" : "")
++	str_plural(E)
+)
+
+@r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*	((E@P == 1) ? "" : "s")
+|
+*	((E@P != 1) ? "s" : "")
+|
+*	((E@P > 1) ? "s" : "")
+)
+
+@script:python depends on report@
+p << r.P;
+e << r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
+
-- 
2.34.1

