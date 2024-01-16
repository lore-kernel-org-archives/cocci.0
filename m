Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4800BC4725D
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q3m0c/jtr4Yc2ReYUmIH2bv7st1Qbpc3rs0TX1Re2TU=;
  b=YOMs6ugsO9Wgj2B4UTuW3+gmmoxybBOavRrSbXUFgpS/tg4c8Ip6dB2R
   t3QZfeEAF1Jmf9g8TZe4BcZilbDouah+d/Ks4zpl7cBUbKiwxghfmXO76
   I5CqwXpJK9gbZFVWN41y1DL2b/xOBowPJAHEpjaZOlZBurJ6AlQxlkR5o
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147851013"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:50:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E9EEAE0CD8; Mon, 22 Jan 2024 08:50:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 43598E004E
	for <cocci@sympa.inria.fr>; Tue, 16 Jan 2024 05:11:56 +0100 (CET)
IronPort-SDR: 65a6020c_/TOdXWdBMxCpJVehgqQbZUnIiBDFfs+Uez/xRDQ/S3lNupv
 PIJqu7MZLrpR3SG8WANAHiwdIcg+Bz/Km1dfU5A==
X-IPAS-Result: =?us-ascii?q?A0EKAACqAKZlmDFaNs9aHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBgjiBUy4DBwhIjHBfoRKFWhSBag8BAwENRAQBAYUGAodFAh8GAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAQEBAQEBHhkFD?=
 =?us-ascii?q?w8nhXmCXAGDbgIBAxIgAUYQUVYZIoJegmACAaZ1AYErPwIoAUABDIELiz4aA?=
 =?us-ascii?q?mWzLoFqgUgBjGBngxOBY0KBSUSBFYE7gi2EBoEKhXYEgRd/g0KKGSaGDUqBK?=
 =?us-ascii?q?QOBBW8bDx43ERAFDg0DCG4dAjE8AwUDBDIKEgwLIQUTQgNDBkkLAwIaBQMDB?=
 =?us-ascii?q?IEwBQ0aAhAsJgMDEkkCEBQDOwMDBgMKMQMwVUEMUAMRVB8aGAk8DwwaAhseD?=
 =?us-ascii?q?ScjAixCAwIPBRACFgMkFgQ0EQkLJgMqBjcCEgwGBgldJhYJBCUDCAQDVAMjd?=
 =?us-ascii?q?BEDBAoDFAcLB3mBXQMJAwcFSUADCxgNSBEsNRQbBj5vB5cQgQ6CdKRhoGCEG?=
 =?us-ascii?q?4FhiQOWMk2EAYx1hj0eA5I+LodTFpA7glGhCjSEW4FjOoFcTSODN08DGQ+OO?=
 =?us-ascii?q?R+TRjU0OwIHCwEBAwmJIoFGAQE?=
IronPort-PHdr: A9a23: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
 ZkO79gaA9+n10SKda/a
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Lfop0aBKht+KMFnlHel755DYdb4zR+YMi2TDGXoBKyC9Ffbo7f
 xG885rsSMc5AxwZJhko6H4BEDiewKmyXcK2/h3AV7KZmCP1QfGQuBfBMnZskXd8kbFh4tgPM
 lbAstD4dvLZjJHZL7BkW+F+gEbsaS6GGrBv5aj858WJzsaFJ2JKm9Ce3am+okffng2OXKSfK
 DslfauYFKbCAoqUvg=
X-Talos-CUID: 9a23:7yc61mCFl7YxZCv6EzBk7WwbIe4pSS2e5XTCBmaAWHpxGZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AcwQNLQ4kLcGm56ldzQGrhqwHxoxayoDxKmRSn68?=
 =?us-ascii?q?IlJfdGB5PGBq6pj2oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,198,1695679200"; 
   d="scan'208";a="76879322"
X-MGA-submission: =?us-ascii?q?MDEr2KLpL38wYTD5QJkfjiit1YdTK7G+iwmqy3?=
 =?us-ascii?q?svf88kCBBAYR8GAe0uNRQbcbd+D0oBrikP/MgQz0A58ZgZ2jCIPdzfCU?=
 =?us-ascii?q?zCmvfnUWlA8RypOC9GcrWFg4n6DysZo9B6GC+CPcKez98brlaYNdA6dJ?=
 =?us-ascii?q?4GhDLaHMu4BTCKkaKI8GQVqw=3D=3D?=
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 05:11:55 +0100
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146231242"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146231242"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:11:54 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6BD9CE8BE9;
	Tue, 16 Jan 2024 13:11:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 76D6FD52F1;
	Tue, 16 Jan 2024 13:11:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D859E2C664F;
	Tue, 16 Jan 2024 13:11:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7461E1A015F;
	Tue, 16 Jan 2024 12:11:49 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Date: Tue, 16 Jan 2024 12:10:48 +0800
Message-Id: <20240116041129.3937800-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116041129.3937800-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--0.154700-10.000000
X-TMASE-MatchedRID: IFC3LZnGWUf3Ybb8DqkBoAmyVrMCuJ9STFQnI+epPIbAuQ0xDMaXkH4q
	tYI9sRE/w/kunvvd5s1nlNbmTKHyww3mZXbns8PVmIe0I1iNyQyOQOsE4nDCdHzc/BG56XhAcA7
	WCVo6LQWCHEmJAv3UX+zybZtwM2Apr9Xz9yCPONIrUvpNWR2DO30tCKdnhB589yM15V5aWpj6C0
	ePs7A07Yjdp2MG2wysi6yNzaxO813R0YoSnR2PtDxB4surgMm4mkv75gGCnQY8hk4wKydwKTQ/0
	+wkNXa38YbjvKSNI73i1wbJ9QSMPb3T15bjbgCvhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP
	4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
Reply-To: Li Zhijian <lizhijian@fujitsu.com>
X-Loop: cocci@inria.fr
X-Sequence: 1466
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/20240116041129.3937800-2-lizhijian%40fujitsu.com>

Update them according to latest Documentation/filesystems/sysfs.rst.

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 scripts/coccinelle/api/device_attr_show.cocci | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index a28dc061653a..a621e9610479 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
 /// From Documentation/filesystems/sysfs.rst:
-///  show() must not use snprintf() when formatting the value to be
-///  returned to user space. If you can guarantee that an overflow
-///  will never happen you can use sprintf() otherwise you must use
-///  scnprintf().
+/// show() should only use sysfs_emit() or sysfs_emit_at() when formatting
+/// the value to be returned to user space.
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
@@ -46,10 +44,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 p << r.p;
 @@
 
-coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit")
 
 @script: python depends on org@
 p << r.p;
 @@
 
-coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit")
-- 
2.29.2

