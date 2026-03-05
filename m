Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C36FEFCD76
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=URQi63qdCO11Zg6SqxKUaGNlPDki8/9krZmgRyy06AA=;
  b=qpXS0oBJVraM52HzLv+QrY7832SkRYSSFXAeMc0/EQKS1X+6kt2WK5G7
   VmdYpI4ujQ40BJWtMeGXjmuZwRiXmKesby+UGSrpZyAUnZeeTg9Xe+dZd
   UFRAkIZgVFZAPYOTMIt298g0xnega2h+a2kWiGYin1i5n5sr8r4Q6PeRa
   w=;
X-CSE-ConnectionGUID: MOADekGbRa+oOJ5OWekykQ==
X-CSE-MsgGUID: xxansxQbSz+nkPurp6izuw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266839748"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 10:49:34 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0451E805AF; Mon,  9 Mar 2026 10:49:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6FA5083953
	for <cocci@sympa.inria.fr>; Fri,  6 Mar 2026 00:20:29 +0100 (CET)
X-CSE-ConnectionGUID: HGHDF6ShRiaFsYObWIQspA==
X-CSE-MsgGUID: WpOLAbrNSIuS0aGbV7wrZg==
IronPort-SDR: 69aa0fbd_eBqMAuuDsWTFGSFOTu1s+NuB/lOhF1qq3sQNUYYqQka6dQF
 IoQAZX8kMHbUFmQ7o90xxxdRnWEnGce7PTFpsJw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EhAQDQDqppj/4EaaxagQmBUIJBgWYzBAtJhFiIe4ZYX?=
 =?us-ascii?q?AEGjTWQUYFVFIFpAg8BAwENUQQBAQMEhQACjSACHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDX4CAQMjHQEBNwEPJQImAgJWBgESgwKCIwdKA6wog?=
 =?us-ascii?q?TKBAYIMAQEGgmjZQoFlAgkUAYEKLohUAYUAdDsJglNpeicbfYEQgRUygzaEB?=
 =?us-ascii?q?oQYgmmDNJMqSIECHANZLAFVEw0KCwcFXlUzAyoLEhIYFW4yHXAzEiwPCDNYG?=
 =?us-ascii?q?wcFhUoPiHOBYoETgncDCxgNSBEsNwYOGwQ+bgeNfD6CNIEOgT2UWpAUoy+EJ?=
 =?us-ascii?q?qFyM5dSkxkumFgipAA3hGiBaDqBXDMaCCgIgyJPAxkPjjqIesMIQjU8AgcLA?=
 =?us-ascii?q?QEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:cKc/XqoDO30+HXeNyI8F4LWUvSheBmIBYRIvgKrLsJaIsI4StFCzt
 garIBmGOfqIZGKhLtEladvg8BsH7J/Tz9JqHAZurn9nH35G8OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVaiZfHk3HVI5IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7kk01BjOkGlA5AJmPqgW5AS2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 L2hhrTsIesdBZAgrcxGO/Vu/46SCoUdkFPPCSDXXcV+VCQqeVO0qxllJBle0YH1Zo+bqIyBn
 BAVAGllU/yNuw656JKUasVC2P8jFsjiEpgunXtf7AjCFd9zFPgvQ42SjTNZ9Cs3nIZVGuvEb
 Mdfajd1ahnEJRpVNT/7Crpnw73u3yGiNWEe8g/JzUY0yzC7IAhZ2bz9GNnYYNqHQYNShEnwS
 mfupTqnXkFKb4bGodaD2k20ocvmlzndY6MPL+Wx2fRU30KJ9GNGXXX6UnPg/abl2x/lMz5FE
 GQQ8zUnqawa5k2uRMP0GRy+un+N+BAGM/JbFOYx6SmW26/M6kCYAHIFR3hPcrQbWNQeWTswk
 ESOgsniCHpsvaeTRHbb8a2bxd+vBcQLBU8tRQMqEzAF2djqjpoCqRjwb+94CIfg27UZBgrML
 ya2QD8WrJx7sCLm/7m85xbchC+2rZWPTQMv4AjTGGW/4WuVhbJJhaT3szA3Dt4Zce51q2VtW
 lBZw6ByC8hSXPmweNSlGrllIV1Qz6/t3MfgbaFT82kJrGjypy/yJui8ERl3J05sO8dMZTLiY
 EnUvQRe5ZJIdHqsZukfXr9d//8ClPC6ffy8D6i8RoMXMvBZKlTdlAkwPhH44owYuBR3+U3JE
 cvAKZ70ZZvbYIw7pAeLqxA1iOFxmXphnDuIG/gWDX2PiNKjWZJccp9dWHPmUwzzxPrsTNz9o
 okHZfiZgQ5SSvP/aSTx+IseZwJCZ3siCJy874QdeuefK0A0UCssGt3A84MHIoZFpqVykvuX3
 3efXkQD9kHzq0eaIiq3a1diSojVY7BBkVwBMxcBB22Yg0oYXd737YM0VYcGQr08xekykd92V
 6YkfuuDMNRuSxPG2S4vXbvgnrN9aR7wpwSvPjWkUhc7bZVPVwzEwf66XwrNpQ0lLDu7its6m
 JKkjjjkeJskQx9zKvrWZNaE7UKDjVJElM1cB0L3c8RuImPy+41UGgnNp/4QIfBUDy7cxzGfh
 j2kMT1Bqcbj+4YKocT034aapIKUEsx7LEpQP0/fyZ2UbSD63G6S8bVsYdayXwL2dT3Lof25R
 OBv0fvDHuUNnw9Kv6pCAr9b9/8CyOW1lYBK7DZPPSvtVEuqOINCM3Pd/Mhot49x/JF7lzaye
 Hqy/oh9Be3UFuLjSEUcNSg0XNSljPs0oATf3d4xAUf95RJ0woa5bFVvD0GyrxJZfZRIM9ID4
 OY+ucQpxRS1pTg0P/2n0C1F1WS+AUYRcqcgt5hAPp7hjzQw7lQTcK7NKzTX5auXYI5mKXgaI
 T6zhYvDiY9Dx0HETWEBKHjV0cdZhrUMoBpvzmJeF2+Wm9HAuOA77CdR/RszUA5R6BdNiMB3B
 URGKGx3Iv+o0wpzpc0eQV2pJR5NNCeZ9mP11VENsm/TFGusd27VKVwCKfS/x18Y/01cbwpk0
 umhkki9agnTfeb1wicWcmxmoaa6TdVOqyvzqPr+FMGBR5QHcT7ph5G1XlUxqjzlPNgQgXPWr
 uw77cdybqzGbRQrmZMZMLXD97osS0GjHldgENVB56ICGF/OdA6igQauL1+DQeITBvjo33LhN
 elQCJNubSmu7AePsTEROoAUKZBWgvMCxYQPa5HrF0E8opqdqTtln8PB0i7YmmMbYddcqpsnG
 LPzagC9DXGa3llSum7SrftrPnizTskEaTbdgsG00rQtPLASvN58dXod1uOPgEyUFw987jSov
 A/nTI3H/dxIkIhDsdPlLfReOl+SN9j2atWtzCmylNZ/NfX0LsbEslIumGnNZgh5E+MYZIVqq
 O6rrtXy4ULiuYQ2WUD/n72qNfFAxee2bdptHvPHFltotgrcZ5a0+DoGwX6yFrJRmtAE5sWHe
 RqxWPHtSfErAeVi1F9nQAkANS0CCpbHTLbq/gK8iPWuNiIz8yL6KPGfyHu4Sl0DKwEpPcTyB
 Dah7rzqrppdoZ9XDRAJO+B+DtUqaBX/UK8hbJvquSPeEmCshUiYt6D/kQY7rwvGEWSADN2w9
 KetqsISr/hukPqgIBBlX41OUtk/EHFnx/I3Y1gW9ph1hiq8AWpAKv4SWXnD5le4jQSqvKwUp
 hmUBIfhNck5dTdJaxPx5JLkRAj36ikmJILiPjJwl6+LQ37eOW5DaYeNMg9j7m1wdz+ly/uoQ
 T3bFrscITDpqqxUqS0vCjBXTAupKj42Bp7FxKwlr/HPPg==
IronPort-HdrOrdr: A9a23:TxED3qOmGLWyesBcTsSjsMiBIKoaSvp037Dk7SFMoDhuA6qlfq
 GV7ZMmPHrP5Qr5N0tNpTntAsa9qDbnhOdICOoqTNOftWvdyQiVxehZhOOIqQEIWReOk9K1vp
 0BT0ERMrPN5CBB/KTH3DU=
X-Talos-CUID: 9a23:zcjwymMLtApPm+5DeAZH2GBKIcAfc3Tz10b3KXCZMH1xYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AvcmGDw+2eB8bpjefnZfVSjuQf/hwxICHAlorqrQ?=
 =?us-ascii?q?bgJGNGiZOZCiHvjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,103,1770591600"; 
   d="scan'208";a="266488321"
X-MGA-submission: =?us-ascii?q?MDGdd4T8OQ9MxXohQOlLFEw+bgCQMyfyLjOJ5A?=
 =?us-ascii?q?wJmQ8Kc59PA18boVwUBhrfD5KV1ge2ohFwUolcutReS0MLYMy4ROd7My?=
 =?us-ascii?q?W+ew+ey1nUeoCq12k0pOPjtONsch+zleRrmOvmEw1ejn/qPyc3tcPKsm?=
 =?us-ascii?q?4fsE3WxYCcpX/u2myiER91CA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:20:29 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B1DB60127;
	Thu,  5 Mar 2026 23:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82413C116C6;
	Thu,  5 Mar 2026 23:20:26 +0000 (UTC)
Date: Fri, 6 Mar 2026 00:20:24 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>
Message-ID: <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
X-Mailer: git-send-email 2.53.0
References: <cover.1772752564.git.alx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1772752564.git.alx@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v1 1/1] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3350
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/-vBxzc9wmxJIRehy-wJEOg>

Recently, we added an ARRAY_END() macro to simplify finding a pointer
one past the last element in an array.  Such a pointer is often called
the 'end', and thus the macro name.

This script makes it easy to find more places where that macro should be
used.

See also:
436debc9cad8 ("array_size.h: add ARRAY_END()")
8118f197b7b7 ("mm: fix benign off-by-one bugs")
a9e5620c9a9e ("kernel: fix off-by-one benign bugs")
61e9210e2392 ("mm: use ARRAY_END() instead of open-coding it")

Cc: Kees Cook <kees@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 scripts/coccinelle/misc/array_end.cocci | 93 +++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_end.cocci

diff --git a/scripts/coccinelle/misc/array_end.cocci b/scripts/coccinelle/misc/array_end.cocci
new file mode 100644
index 00000000..2474b7e6
--- /dev/null
+++ b/scripts/coccinelle/misc/array_end.cocci
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
+//
+// Confidence: ???
+// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@i@
+@@
+
+#include <linux/kernel.h>
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@depends on i&&context@
+type T;
+T[] a;
+expression b;
+@@
+(
+* (a + ARRAY_SIZE(a))
+|
+* (&a[0] + ARRAY_SIZE(a))
+|
+* (&a[ARRAY_SIZE(a)])
+|
+* (&a[ARRAY_SIZE(a) - b])
+)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@depends on i&&patch@
+type T;
+T[] a;
+expression b;
+@@
+(
+- (a + ARRAY_SIZE(a))
++ ARRAY_END(a)
+|
+- (&a[0] + ARRAY_SIZE(a))
++ ARRAY_END(a)
+|
+- (&a[ARRAY_SIZE(a)])
++ ARRAY_END(a)
+|
+- (&a[ARRAY_SIZE(a) - b])
++ ARRAY_END(a) - b
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r depends on (org || report)@
+type T;
+T[] a;
+expression b;
+position p;
+@@
+(
+ (a@p + ARRAY_SIZE(a))
+|
+ (&a[0]@p + ARRAY_SIZE(a))
+|
+ (&a[ARRAY_SIZE(a)]@p)
+|
+ (&a[ARRAY_SIZE(a)@p - b])
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING should use ARRAY_END")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: Use ARRAY_END"
+coccilib.report.print_report(p[0], msg)
+
-- 
2.53.0

