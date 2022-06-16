Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A66C43334
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=oOsNaGsJko0QUgTQ4bK+rBWarGLelbeLlPtxnBt8AeI=;
  b=c/jdocnkHwzoOSXNZC2hBP9FTJQRJY4KdKOIowbqVHYhR0gX4kBEwJ1z
   mPuOPZC0ZjJkSXhPQYZkIohZ1r3AKmwABlcpIuynhRb0RBoJnA9yffoul
   c9INPC2MHqzCetuZhf2KEvH9J/UGXD9DUJIZqaLPjOQ37CRoIx/htPjGa
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="42838392"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 14:33:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D358E033C; Sat, 25 Jun 2022 14:33:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 43335E00BA
	for <cocci@sympa.inria.fr>; Thu, 16 Jun 2022 03:15:39 +0200 (CEST)
IronPort-SDR: mjIaU4Z94ImG3UI2ZcGH0IBv61CRN3CBzs8h9ZpUZWoX4lhHkYlRxPGDAJfTCCmARjkRYDW5IB
 KygcDQiR8dshUxWuIn9HYvlYJcwoqWKppRjrFkzsdNkJ0Zi+7+3sQj+QnBY1aNm660o4OitbRx
 fOaJW5ctmmQa0vt27HPlkf7Dz75swqgMT05OpBGSRxGeN9XEYgcsRpxzBtBmdQPeVPJyhMlcMZ
 R6p+bsaM+aETgsuTEPhNxKWRUTKltJvvR4vpClKVZbFMLlfQ7Vdox7BsD6+MPole1CpR+o7dQ7
 yXzLdg0AVk151LasLKk4Srxz
X-IPAS-Result: =?us-ascii?q?A0AmAQAfg6pih//U+S1aHgEBCxIMggQLgiSBVi8EC0QXl?=
 =?us-ascii?q?UOcbhSBaAsBAwEMAUIEAQGFA4VLAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBAQsNCQUICgcOEAU8ZGiBT4F0C0GCNSKEJAFGg?=
 =?us-ascii?q?T4BDQWCfYMZA7A2gQGEbYURgT2JVoM8ggqCKYEVgTyCLIEPgniGeASNF4ljg?=
 =?us-ascii?q?h85AwkEBwUuNBKBIXEBCAYGBwoFMgYCDBgUBAITEk0GCxICEgwKBhYODjQSG?=
 =?us-ascii?q?QwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDFwkHCgMdCAocEhAUAgQTHgsIA?=
 =?us-ascii?q?xkfLAkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMFDw0BBgMGAgUFAQMgA?=
 =?us-ascii?q?xQDBScHAyEHCyYNDQQjHQMDBSYDAgIbBwICAwIGFwYCAhknLwomDQgECAQYB?=
 =?us-ascii?q?B0kEAUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQYLC?=
 =?us-ascii?q?SEWBikRBQYWAyNMJwUHQQ8pNTY8LyEbCoEPFyoGP5ppBwGBDRQSpUGeOweDU?=
 =?us-ascii?q?Z95GjGoXwEtlUp1IKIRNIQlAgQCBAUCFoFhghUzGiODOE4BAgECDQECAgIBA?=
 =?us-ascii?q?QIBAgkBAQKONo5ENzE7AgYLAQEDCY1vgRIBAQ?=
IronPort-PHdr: A9a23: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
 SSM0R/EWrtOgromfmdu2le0hA==
IronPort-Data: A9a23:5jDIvq6A+RNUeYQHp9AfRwxRtB3BchMFZxGqfqrLsTDasY5as4F+v
 mcfC2uDPK2JZGH9eN5wbd608U8EuceGzdBiGQA9rykxZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2+aEvfDjW1nX4
 Y2r/pWEULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 MoWtM3gbycPB7ySydQNcRBYUCMlAKITrdcrIVDn2SCS51bUY3Tlm6UrDUdwPZAR5et2R2pJ8
 JT0KhhRM1bZ27PwmuvhDLMx26zPL+GzVG8bkm5hyTXYBPNgUY3KRbfL9NZe0x8wm8lREPeYb
 M0cAdZqRE2eM0wTaw5HYH44tPyBpEe8LjpbklSQmrYVyVrPwgB+/6e4ZbI5ffTQGJkJwB/Jz
 o7cxEz9Cw4TMNi32zuA+GilwO7JhyLyHowIfJWz8fVhgXWI12kLAVsXU0G6qL+3kCaDt8l3M
 F4E9SN2/e0z8gqrU9DiUhz+q3mB1vIBZzZOO/Jh6VDd7Iry2hfHV1gUbDdBK959icBjEFTGy
 WS1t9/uADVutpicRnSc6qqYoFuOBMQFEYMRTXRYElReubEPtKlq10mQFIw7eEKgpoStQWmY/
 tyckMQpr5415fPnOo2g70DIimr845nPCA4o7xraXySu6QYRiG+Zi26AtwmzARVodtzxory9U
 J4sx5T2AAcmUcrlqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRk0b51dJm+1O
 BKK4Gu9AaO/2lP3NsebhKrsUawXIVXIT4y5Bpg4kPIXPPCdizNrDAk0OBLMgTm8+KTduaEiM
 IiWcI6wAH0aD6NjyzW3SvxV2rhtrh3SNkuOLa0XOy+PiOLEDFbMEeltGALXMogRsf3YyC2Ir
 Yc3H5bbk313DbylCgGKoN57BQ5RdxATW8upw/G7g8bYf2KK7kl6V6SOqV7gEqQ595loehDgp
 SDmBx4AmAag3hUq62yiMxheVV8mZr4nxVpTAMDmFQ/AN6ELbdn94aEBWYEweLV7puVvweQtF
 6sFZsyfD/UJQTPComxPYZ74pY1kVRKqmQPfY3X4MWdvI8JtF17T59vpXgrz7y1SXCC5gs0z/
 u+73QTBTJtfGglvVZ6EaP+mw16rk2IaneZ+AxnBLtVJIR2+8JVjNCHwyPQwJphUexnEwzKb0
 SeQAAsZ9LWS/t5qoIWViPnd/YmzEuZ4Ek5LJEXh7O67ZXvA426u4Y5cS+LULzrTY2X5pfe5b
 uJPwvCgbfAKkQoYs4d4FLo3n6sy68G1/u1B3BRrFS2bKlWtTLN9K2aL3I9EsagUnu1Vvg6/W
 0Su/NhGOOTVZ560Tw5NeAd1PP6e0fw0myXJ6ahnKkvN4iIqrqGMVl9fPkXRhSEBfqF5Npgpn
 bUotMIMsVXtkQg6Pd/e3mVV8SKMM3UfXqRhvZYfWde5hg0uw1BEQJrdFi6nvM7SOoocbhUnc
 m2Oma7Pp7VA3U6eIXA9In7AgLhGjpMUtREWkVIPKjxlQDYeaiPbAfGQzdg2cuiR5g5Vw+16Y
 jguNkszJbiH4DppwsNEWghA3u2H6AKxoiTMJ5khzQU1jHVEkkTNMWQiNOfL90ccm46ZViYO5
 6mWkQ4JTh6zFPwcHUIOtYpNq+HqUtFwsAbFnahL2ihD84YSOVLYv0NlWYbER9YLzy/8aI0ra
 NSGJNpNVJA=
IronPort-HdrOrdr: A9a23:Xsmc5a8a7PDc2d1ggbBuk+DhI+orL9Y04lQ7vn2ZKCYlC/Bw8v
 rFoB1173/JYVoqKRYdcPq7Scq9qArnhPxICOoqU4tKPjOW3VdARbsKheDfKlbbaknDH4BmpM
 FdmmtFZOEYz2IWsS832maF+h8boeW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,302,1647298800"; 
   d="scan'208";a="16894918"
X-MGA-submission: =?us-ascii?q?MDGRoNcp3JXDg1LVtSVjPhtEfgjBF0g5TgfN83?=
 =?us-ascii?q?wyGz0JwU3ECCQdgqMNNEsBT13SZSoGTLD5u4qUg6HpKMuQs05FCEuFeA?=
 =?us-ascii?q?DrBDd9YOKRAG25LZX8nFwTAnhJ4vUU4tPvYe+2dJdJQAnUL4hLIwRrrX?=
 =?us-ascii?q?yphNStSbQiRzAWQiN7KnDh8A=3D=3D?=
Received: from szxga08-in.huawei.com ([45.249.212.255])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 03:15:38 +0200
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNkhD5BmFz1K9sx;
	Thu, 16 Jun 2022 09:13:32 +0800 (CST)
Received: from container.huawei.com (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 09:15:31 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <fabf@skynet.be>, <william.xuanziyang@huawei.com>
Date: Thu, 16 Jun 2022 09:32:53 +0800
Message-ID: <20220616013253.520310-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] scripts/coccinelle/free: add NULL test before
 dev_{put, hold} functions
Reply-To: Ziyang Xuan <william.xuanziyang@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 453
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/20220616013253.520310-1-william.xuanziyang%40huawei.com>

Since commit b37a46683739 ("netdevice: add the case if dev is NULL"),
NULL check before dev_{put, hold} functions is not needed.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 scripts/coccinelle/free/ifnulldev_put.cocci | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 scripts/coccinelle/free/ifnulldev_put.cocci

diff --git a/scripts/coccinelle/free/ifnulldev_put.cocci b/scripts/coccinelle/free/ifnulldev_put.cocci
new file mode 100644
index 000000000000..7ff36e6212ba
--- /dev/null
+++ b/scripts/coccinelle/free/ifnulldev_put.cocci
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Since commit b37a46683739 ("netdevice: add the case if dev is NULL"),
+/// NULL check before dev_{put, hold} functions is not needed.
+///
+/// Based on ifnullfree.cocci by Fabian Frederick.
+///
+// Copyright: (C) 2022 Ziyang Xuan.
+// Comments: -
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual org
+virtual report
+virtual context
+
+@r2 depends on patch@
+expression E;
+@@
+- if (E != NULL)
+(
+  __dev_put(E);
+|
+  dev_put(E);
+|
+  dev_put_track(E, ...);
+|
+  __dev_hold(E);
+|
+  dev_hold(E);
+|
+  dev_hold_track(E, ...);
+)
+
+@r depends on context || report || org @
+expression E;
+position p;
+@@
+
+* if (E != NULL)
+*	\(__dev_put@p\|dev_put@p\|dev_put_track@p\|__dev_hold@p\|dev_hold@p\|
+*         dev_hold_track@p\)(E, ...);
+
+@script:python depends on org@
+p << r.p;
+@@
+
+cocci.print_main("NULL check before dev_{put, hold} functions is not needed", p)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING: NULL check before dev_{put, hold} functions is not needed."
+coccilib.report.print_report(p[0], msg)
-- 
2.25.1

