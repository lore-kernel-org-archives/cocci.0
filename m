Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57328C47DD3
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=HK0EnkWoA29dqUqfBgOmizDiiBsLBH05UicuuS1m/D4=;
  b=jIyQJWl7YhfH1P6W0k5NMgp8JprBGpcwp1Bw2c4l8at1l93rJbzORWwU
   71w1f+QD+0y6pDqB4jlNa/gsAojsqA07jqygfw4RHnVFNrr1An/9jdF0b
   S5IZS4Ljcbs94fK+cmEAbqimPEo1ctzwdUKcM+yZ9jDg2N1gorSD+gbw5
   g=;
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
   d="scan'208";a="147851088"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:50:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4546FE0CD8; Mon, 22 Jan 2024 08:50:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1250DE00B6
	for <cocci@sympa.inria.fr>; Fri, 19 Jan 2024 07:21:10 +0100 (CET)
IronPort-SDR: 65aa14d5_jnz7QasCC5qMD8y54rdIIv6KlqD8Cj7ZEqggCAXD9f72abY
 si5uFFak4zU+gSPchmKeio9vQ7xp30vHrYC87fQ==
X-IPAS-Result: =?us-ascii?q?A0FKAgBPFKplmC9aNs9aHgEBCxIMggQLAoI3fFcuAwcIS?=
 =?us-ascii?q?ASNS4hnmC2FWhSBag8BAwENOwkEAQEDBIR/h0gCHwYBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBAQEeGQUPDyeFbA0/FgGCB?=
 =?us-ascii?q?gGBHIEeAQEBAQEBAQEBAQEBHQINfhYVCwFGgVAigl4Bgl8CARGocAGBKz8CK?=
 =?us-ascii?q?AFAAQyBC4sLMxoCZbMugWQGgUgBjGGDeoIlgUlEgRWBO4ItgkqBPIZeIgSBF?=
 =?us-ascii?q?3+DGSmKFiaGdEiBKQOBBW8bDx43ERAFDg0DCG4dAjE8AwUDBDIKEgwLIQUTQ?=
 =?us-ascii?q?gNABkkLAwIaBQMDBIEwBQ0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2UfG?=
 =?us-ascii?q?hgJPA8MGgIbGw0nIwIsQAMREgIWAyQWBDQRCQsmAyoGNwISDAYGCV0mFgkEJ?=
 =?us-ascii?q?QMIBANUAyN0EQMECgMUBwsHeIMaAwkDBwVJQAMLGA1IESw1FBsGPm8HlUIBg?=
 =?us-ascii?q?juBDiyCSKRhoGKEG4FhiQOBIZURTYQBjHWGPR4DkkAuhQSCUBaQO4JRiSWBd?=
 =?us-ascii?q?5U3OTSEXIFqAzCBXE0jL4MIEgE8AxkPjiwNCRaIVIpyNTQCATgCBwsBAQMJh?=
 =?us-ascii?q?zKBcIFGAQE?=
IronPort-PHdr: A9a23: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
 sIH6cFTRvFEP2nWMMXmMKUYjx4q4VayTGg=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Cfy/5a/d5dBDjvURc4Zuk+ADI+orL9Y04lQ7vn2ZhyYlEPBw8P
 re5MjzuiWE7Ar5NEtBpTniAtj4fZqjz+8T3WB5B97LMWWI1gqVxepZnO7fKlPbak7DH+hmvs
 1dmtBFebvN5I9B/L3HCMPRKadb/DH8mprY+Ns3Ch9WPH9Xg2UJ1XYHNu4wencGNTWvwvICZe
 ah2vY=
X-Talos-CUID: 9a23:DVdLAmHo7sy1tAGJqmJezk0eFYchb0TGkliKAHCVU38zE6OsHAo=
X-Talos-MUID: 9a23:LC7TNgt9/P4/OGVZcc2nuyFzN+kv85iVS2MHi5ZdkNS4Gyx/JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,204,1701126000"; 
   d="scan'208";a="77233099"
X-MGA-submission: =?us-ascii?q?MDGUufMwD8w/UknHW2pScoNeTon+PFVSDYD5qP?=
 =?us-ascii?q?HVC+BIWMNJGQoCj+0EuXih4EFVlLEwxjY6fd+nyYZZ46oA5JPDD4Xby7?=
 =?us-ascii?q?nRXDVqFkF/JY9Fp8D2tef0KgmhvAity3fn7tIeLWE2Dvx2L2fcg0ttxP?=
 =?us-ascii?q?An+B1Ke6giKpjJ37A9zKDE/w=3D=3D?=
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 07:21:09 +0100
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="146476910"
X-IronPort-AV: E=Sophos;i="6.05,204,1701097200"; 
   d="scan'208";a="146476910"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:21:07 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 164F2D6187;
	Fri, 19 Jan 2024 15:21:05 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 452AD30E0B;
	Fri, 19 Jan 2024 15:21:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C0B2F20098993;
	Fri, 19 Jan 2024 15:21:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1946F1A015E;
	Fri, 19 Jan 2024 14:21:03 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Date: Fri, 19 Jan 2024 14:20:57 +0800
Message-Id: <20240119062057.4026888-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28128.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28128.005
X-TMASE-Result: 10--8.997200-10.000000
X-TMASE-MatchedRID: VFz6FHT9KvIRC3tpysE8AO9kW9mxCQvttOtXYgbXjde+f7ap9DJaDSxz
	RYsJiUav/17ljwcNaRm5hiunv4GcSziJuiRnf5DQKiJEqUFWRggFeeAjqMW+l8ZgSaBgziUc2d8
	mtRIRsUMkfu0SYDUi3tk+AWND1SQ/1s1AHJ9E8eDfSQNpZkETVFLiJI6ntczPeGHkpR2WBaKp7E
	+IyeS1Xt9azz0zRbyE1mLuCemy7OOnhintEWTpJ65bb5QEYSkdLYdywTHl7nvZCDeKLir288tMy
	hlcs3zJTLP4m7if3GSdqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8JU8c6O2cgtdKkXm
	cQlIhgRkwIxiFgO1Jve1LKdTmTjePJuGM8tMGsU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: device_attr_show: Adapt to the
 latest Documentation/filesystems/sysfs.rst
Reply-To: Li Zhijian <lizhijian@fujitsu.com>
X-Loop: cocci@inria.fr
X-Sequence: 1469
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/20240119062057.4026888-1-lizhijian%40fujitsu.com>

Adapt description, warning message and MODE=patch according to the latest
Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.

After this patch:
When MODE=report,
 $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=report
 <...snip...>
 drivers/hid/hid-picolcd_core.c:304:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
 drivers/hid/hid-picolcd_core.c:259:9-17: WARNING: please use sysfs_emit or sysfs_emit_at

When MODE=patch,
 $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=patch
 <...snip...>
 diff -u -p a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
 --- a/drivers/hid/hid-picolcd_core.c
 +++ b/drivers/hid/hid-picolcd_core.c
 @@ -255,10 +255,12 @@ static ssize_t picolcd_operation_mode_sh
  {
         struct picolcd_data *data = dev_get_drvdata(dev);

 -       if (data->status & PICOLCD_BOOTLOADER)
 -               return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
 -       else
 -               return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
 +       if (data->status & PICOLCD_BOOTLOADER) {
 +               return sysfs_emit(buf, "[bootloader] lcd\n");
 +       }
 +       else {
 +               return sysfs_emit(buf, "bootloader [lcd]\n");
 +       }
  }

  static ssize_t picolcd_operation_mode_store(struct device *dev,
 @@ -301,7 +303,7 @@ static ssize_t picolcd_operation_mode_de
  {
         struct picolcd_data *data = dev_get_drvdata(dev);

 -       return snprintf(buf, PAGE_SIZE, "hello world\n");
 +       return sysfs_emit(buf, "hello world\n");
  }

  static ssize_t picolcd_operation_mode_delay_store(struct device *dev,

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
- changed title from coccinelle: device_attr_show.cocci: update description and warning message
- Fix MODE=patch
- Extract patch from the patch set[1] so that maintainer can accept it separately.
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 scripts/coccinelle/api/device_attr_show.cocci | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index a28dc061653a..634514937e63 100644
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
+///  show() should only use sysfs_emit() or sysfs_emit_at() when formatting
+///  the value to be returned to user space.
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
@@ -30,15 +28,21 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
+expression BUF, SZ, FORMAT, STR;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	<...
+(
 	return
--		snprintf
-+		scnprintf
-			(...);
+-		snprintf(BUF, SZ, FORMAT, STR);
++		sysfs_emit(BUF, FORMAT, STR);
+|
+	return
+-		snprintf(BUF, SZ, STR);
++		sysfs_emit(BUF, STR);
+)
 	...>
 }
 
@@ -46,10 +50,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 p << r.p;
 @@
 
-coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
 
 @script: python depends on org@
 p << r.p;
 @@
 
-coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
-- 
2.29.2

