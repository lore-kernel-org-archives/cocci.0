Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA48AC3DA4A
	for <cocci@archiver.kernel.org>; Fri,  9 Aug 2024 06:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Faq+jYXXBixwdbKunQI/jxT0vGKYhjeXzO03JqMVC+g=;
  b=LlO0bnxaebBlB22s9tzWWwXGQ99iSm1brMijrnDts6FHuDyWYmp0p854
   uweUN7/7qvaxVkGAoh82ZPKAvwMwt751OwbCaaqzU0ExjvRkpBro7Sx8w
   T/t0JZYb7TTzfhawkVEXpzWcpH3PuaakcOEK+XJ/5/ttGZhVwzqXCiCB2
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.09,275,1716242400"; 
   d="scan'208";a="178540857"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Aug 2024 08:14:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8AD34E0133; Fri,  9 Aug 2024 08:14:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E3B4BE0035
	for <cocci@sympa.inria.fr>; Fri,  9 Aug 2024 05:22:35 +0200 (CEST)
IronPort-SDR: 66b58b7b_Vn7Mor9O4vHB52bF69OFeRNjf1z4J2j0coKEsk8pUniN3Sq
 Al0BlDyEv3YL+Hzgjy9JAooGw1fTZgnXT2ilgyw==
X-IPAS-Result: =?us-ascii?q?A0FXAQC+irVmh7vU+S1SCIJYgkSBVzMEC0gdsmaBVoF+D?=
 =?us-ascii?q?wEDAQwBRAQBAYFTgzOJVgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQEBOQcOO4YCgmcBhAA2AUaBPQENBYMAgmUDsFSBAYR62?=
 =?us-ascii?q?yOBSIhLAYRzgSsJhFmCKIEVg2iEHIZrBJpFA4NMJol0iAJIgQUcA1khEwFVE?=
 =?us-ascii?q?w0KCwkFiUmDLSmBcYQXhS6BZwxhh3JngQktgRGBIT1KgT2BOkuFXYEBgll0V?=
 =?us-ascii?q?kgCDQJRHUADCxgNSBEsNRQbBj5uB6Yrgi8HgQ6BAIJ6AaQNoHsGBCiDbKE5G?=
 =?us-ascii?q?jOEBZN9kj0BLodekGMipA+EOwIEAgQFAheBZzqBXHCBboFJTwMXAg+OOtAqN?=
 =?us-ascii?q?jU7AgcLAQEDCYtSLoEdAQE?=
IronPort-PHdr: A9a23:gHf7+xM0lBdE0BCYBEUl6nYpBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvq0r3QSCA9uTwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDebRlEiCC5bL58I
 xm7rATcvdQKjIV/Lao81hTGrnxUdupMwm9mOUydlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q
 6FGATo/K2w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWTmn8
 qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSXddUspNUiBMBJ63Y
 YkSAOobJetWr5fzqkUToxWwBgeiA+zgxDBUiX/3xqA6z+csHBva0AE6A94CrHLZp8j1OqcIV
 uC1ybHFwTvCYf1PwTnz6ZDEeQ09r/GRXLJwaMvRxUcyHA7CgVWQrorlPzyP1uQQsmib9utgW
 f+0hm4ntgF+uDauydktioXTmo0VzVXE+Dx/zY0oKtK2VFR1bsS4EJtMqS6aLY12T9sgTmx0p
 is3yaMKtYO1ciQXypkr2QLSZvyHfYWJ7R/uSeifLCpkiXxqfL+zmhe//FWjx+D9S8S5zlVHo
 jZbntXSsH0Gyh/d6tCfR/Zy/kqtwyiD2g/X5+1eP0w4iLTXJ4Q8zrMzlJcfqVnPEjPslEj3j
 qKabFgo9+qn5uj9bLjrqIeQOo1uhg3gLqgihNazDfk7PwQTRWSW+eax2bv+9kDnRLVKk+Y2k
 rXHv5DAOMobp6+4DBFN34o/7Ru0Ei2o384CnXYdKVJIYBKHgJbtO1HJOP34Fva+glujkDhx2
 /zKI6TtApTLLnTZkLfhYKxy6kBCxwoy19xQ+5VUCrQZLPLyXE/+qsDYAwc2PgG02errFtpw2
 4cEVW6RH6OVLrnevUKL6+8tO+WMYZUauDf5K/gr/f7uino5lEcSfamu25sXZ2q4HulnI0WAY
 Hrgn8wMEWcXvgUkQu3lllyCXSRPaHa1WqIw/jc7B5m+AofZWo+tmKCB3Du8HpBOeGxKEkqMH
 mvwd4WYR/cMbzqfIst7nT0KT7ehT4sh2AqvtQ/7zrpoNfDU9TcCuZLi0th1/ezTmgso+Tx6F
 cSRy3uNQH1snmMUWz8227hyrlB6ylifzad4gudVFcdT5vNMSgc1L4TQz+18C9DoWwLOZM2FS
 Fi8QobuPTZkbM81wtZGR09iEtGmxkThwi6rCvkxnqOCAJgc86TG3nG3Kdwrjz7g1aImi1A9C
 vNGMWy2zvp59gPUA4fS1V2Qk6e6XaUZ1SGL+n3VnkSUu0QNGiFXd4qBFUoCZ1LX55yt6UTEQ
 KWzCK0mayNB1MedJ6oMYdrs2wYVDMz/McjTNjri01y7AgyFk/bVNNKCkwQ12SzcDBNBiAUP5
 TOdMhB4AC69omXYBTgoFFT1Ykqq//Mt4GijQBoSyAeHJ1Zky6Lz4gQc0PObTfwJw7MduX4Jq
 yh9A1u8mdnRDonIvBJvKZ1Vesh1+1JbzSTcvg15MIanKvVtgVgRaRl2pkK3/xVqA5pNkI4hq
 3Z5hBFqJ/e+11VMPyidwYi2OrDTLTzq+wuzbqfNxlzE+M2E6qgGsK19qlOlvBygCUcjtX5g1
 rG5ylO64ZPHREoXWJP1CQMs8gRi4qrdem877p/V0ntlNe+1tCXD0pQnHrltzBHoZNpZPK6ec
 W26W8QHG8ijLvArkFm1f1oFOu5V7qs9I8KhcbOPxqeqOO9qmD/ug35A5chx1UeF9iw0TeCtv
 d5NzPae0RGaVi791X+hr8nolIECbjYXXyK+xSXiGI9Nd/hqZ49YbAXma8azx9h4m9vsQysEq
 Rj5WwJAgpbzP0PCMA+Yv0UYz0kcrH25lDHtyjV1l2psta+DxGnVxPykchMbO2lNTW0kjFH2I
 IHygcpJOSrgJwUvihah4l73gqZBo6EqZWbUR0hSYinvLjhKUra5qbeDJcVI7dl71EcfGPT5e
 l2cRrPn9lEV1CXsBXZf3TFiXzG3s4r0nlpxj2fXfxMR5DLJPMp3wxnY/tnVQ/VciyEHSCdPg
 j7SHlGgPtOt8L14jr/7u/ulHyKkX5xXKmzwyJ+Y8TC8/StsCAG+mPa6npvmFxI72Gn1zYsiW
 SLNpRf6Ko7lssbyee1geEZyGV7l6pNSGpx3jYYxwpoX3DAWi46U8nwOjWroeYkGn/iiPTxXH
 GRNmo6KqAH+kFVuNHeI2570WhD/ioN6at+2b3lXkiMx4sZWCbuFublNnC97uF29/kraZflwm
 CtYyON7tCNc2b1Y/lB0lGPEUu9BeCsQdTbhnBmJ8d2k+aBeZWL0NKO1yFI7hte5SreLvgBbX
 n/9PJYkBy55qMtlYzeumDX+7J/pfN7IYJcdrBqRxl3PiO5aMo8wj/tTrSp6MH3wvDsuzOtx3
 nkMldmq+ZOKLWlg5vfzDRleOSfoZtoSoxntkK9Bk8fQ1IeqVMYEeH1DTN7jSvSmFygXvPLsO
 lOVETEynXycHKLWAQ6V7Eo152KKCZ2gMGubYWUI1dg3DgfIP1RR2UpHOVdy1o58DA2hw9btN
 Vt09ixErECtsQNCk6ppL0WtDjqZ/lv5LG1tEt7EdlJX9l0QuxqTa5DPqLgqRWcDo/jD5ESMM
 jDJO1kOVz1YHBbdXRa5Y+Tm5MGcobTFQLDifr2UOO/I8LwBEK3ZjZO3jtk6onDWapTJZCA4S
 aRqgy8hFTh4A5iLwmtfDXVGymScNIjH+1+94nEl95Ditq20BkSwtM3SVfNTKYk9oknnx/fFb
 rHBwnwldlM6ntsN3SOakeFOmg5U23AoLmLzVu9Z/S/VEPCJw/4RX1hLOmUqb5YA7rpgjFAUa
 IiLzIqqifgj0LluUjInHRTggp37PJVbZTH7bQyYQh3bfPGPITmBqy3uSYW7T7AYzOBdthnr/
 C2eD1emJTOb0T/gSxGoN+hIyiCdJh1X/o+nIF5rDiD4QdTqZwfeUpc/hCAqwbAymnLBNHINe
 Tl6fURXq7SM7CReyvxhEm1F53BhIKGKgSGcp+XfL58Xt7NsDEEW36pC528mzrJO8CxebOdni
 CTb9ocrolfgkvSG1TdmFhFJr3cDhY6Gu1ljJbSM9pREXiWhnlpF5mGRBhIW4tp9X4Gy/foMm
 56Vzfi1cWcdoLe2tYMGCsPZKdyKKi8kOBvtQ3vPCRcdCCWsLSfZjlBcl/eb8juUqII7o97ig
 slrKPcTWVorG/cdEkkgEsYFJcI9UTQinqSGjdcJvFK+sRDOScQctZfCHKH3Y72nOHOCgL9Ia
 gFdi6v/NpgWP5bn1lZKcUtqk42SQg/RW5ZNvyR+Yw5yq0JIuisbLCV7ywfubQWj52UWHPi/k
 0stiwdwVu8q8S/l/1Y9IleiTMoYi1shlty92HWQdnjxMa6vUIAQAC3x5RBZ2nbTQxt8cgCz2
 0djMWWcL1q+p7t9fH9miUnXvp4dQJZh
IronPort-Data: A9a23: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
 b4biYdAD6B6F0H/YZcUhu8=
IronPort-HdrOrdr: A9a23:x0pQf6Hlux0+54XDpLqE68eALOsnbusQ8zAXP0AYc3Jom6uj5q
 STdZUgpHjJYVkqOE3I9ertBEDiewK4yXcW2/hzAV7KZmCP0wHEEGgI1+rfKlPbdBEXoYVmpN
 5dmtBFeb/N5A9B/KDH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3AhForqmoxqXxwSQbYQ1Tu1HPmUcR4fkyN1S3uH2G?=
 =?us-ascii?q?HVERnT4GfeHOc55oxxg=3D=3D?=
X-Talos-MUID: 9a23:XIEuGASqQJWtMeWiRXTj3x9BDoQ5/Z2eSxgOyZRZpO+UHwBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,275,1716242400"; 
   d="scan'208";a="93814023"
X-MGA-submission: =?us-ascii?q?MDGeRJEPkSA8PYUG6eS1NIPIHtRZ9o4CADWXWV?=
 =?us-ascii?q?n0Y7ka5e6HfbJC3pG3P0zSzslaMsOgwJcepCfia1V8GIlCjeG4ie9ry4?=
 =?us-ascii?q?3gjaxghJKxfzHYVD2fSgjcKX35nixDnf034IZTnjBh1fz1hT/CwfovQC?=
 =?us-ascii?q?Jd03ZX5Sppz8HOhyTSPDzuuw=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:22:34 +0200
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wg8NX1qkZzcd91;
	Fri,  9 Aug 2024 11:22:20 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A2DD180AE5;
	Fri,  9 Aug 2024 11:22:29 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 11:22:28 +0800
From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: <cocci@inria.fr>, <linux-kernel@vger.kernel.org>, Wang Weiyang
	<wangweiyang2@huawei.com>
Date: Fri, 9 Aug 2024 11:31:56 +0800
Message-ID: <20240809033156.2518473-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100016.china.huawei.com (7.202.181.57)
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: locks: call_kern: Add rcu_read_lock
 case
Reply-To: "GONG, Ruiqi" <gongruiqi1@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 1846
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/20240809033156.2518473-1-gongruiqi1%40huawei.com>

Allocating memory with GFP_KERNEL may cause the thread to be put into
sleep, and doing so within RCU read-side critical section is problematic
as it might cause the grace period to end early and trigger unexpected
objects destruction. Involve rcu_read_lock() into locks/call_kern.cocci,
as this requirement is analogous to other kinds of lock.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 scripts/coccinelle/locks/call_kern.cocci | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/coccinelle/locks/call_kern.cocci b/scripts/coccinelle/locks/call_kern.cocci
index 3720f86d67c5..89665ea61642 100644
--- a/scripts/coccinelle/locks/call_kern.cocci
+++ b/scripts/coccinelle/locks/call_kern.cocci
@@ -31,6 +31,7 @@ fn(...) {
      when != spin_unlock_irq(...)
      when != spin_unlock_irqrestore(...)
      when != local_irq_enable(...)
+     when != rcu_read_unlock(...)
      when any
  GFP_KERNEL@p
  ... when any
@@ -59,6 +60,8 @@ spin_lock_irq@p1
 spin_lock_irqsave@p1
 |
 local_irq_disable@p1
+|
+rcu_read_lock@p1
 )
  (...)
 ...  when != read_unlock_irq(...)
@@ -69,6 +72,7 @@ local_irq_disable@p1
      when != spin_unlock_irq(...)
      when != spin_unlock_irqrestore(...)
      when != local_irq_enable(...)
+     when != rcu_read_unlock(...)
 fn@p2(...)
 
 @depends on locked && patch@
-- 
2.25.1

