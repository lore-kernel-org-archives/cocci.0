Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DEEC71148
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=x1aM1/RH/pAvF5wMxosW5xMQEnEHvU9V8b+/IGhMbko=;
  b=T+ESsKt4UDa+WDe1IyTsNvXcFzIbls6WnBDJUEcXhujvtWmO3WBInZ+b
   ZreN5K+7wAtQQtAg1OUgiomFJ+E2EhSy4ZoxZ5yqOOAvrPbYXo3+ZYGuQ
   9us1Aq79Pe5QgpX3hJQ+OE0BFQco6GBvSaKrwnza02qflhuUL6pHGpavS
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226896246"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 33622E0D82; Thu, 12 Jun 2025 15:49:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 78C86E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 15:46:37 +0200 (CEST)
IronPort-SDR: 684ada3c_WMxPZt6kYeyGQ1dCzcIO42CrQw6CcDae0eNpVQQQSTC0yOk
 9ENJHYzl01wIcGWjv6jHpFU4SrhYEY4n1BLQaww==
X-IPAS-Result: =?us-ascii?q?A0EBAADl2Upoe4Oo3M1AGhkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBQIE/BAEBAQEBCwGCQ4INBAtJHYQ4iBxfhlWDN5sug?=
 =?us-ascii?q?VUUgWkCDwEDAQsBAVEEAQEDBIUAAotnAh4HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAEBQg47hXsNgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CCGMBAR4CAQMSER0BATcBDyUCJgICRhAGAQ0FIoJggilGAwWjKENnKlkBg?=
 =?us-ascii?q?SBCiRIBAQF4gTKBAYIMAQEGgmjbIAmBGy4BiE8BgW2DfzuCWYFjJ4IogRWBO?=
 =?us-ascii?q?4E3doFSgjSEGIJpgyoUig2XEQk/gQIcA1ksAVUTDQoLBwVeUjMDIAoLDAsSH?=
 =?us-ascii?q?BUCFB0SDwQWMh2CDYItT4IdghJwihiEA0YrT4QlD22BJoNhERNyDwZHQAMLG?=
 =?us-ascii?q?A1IESw3Bg4bBj0BbgeYCYNwexOZOUmNU2ihDg2EGKIgqmEumFYio3aEdQIEA?=
 =?us-ascii?q?gQFAhiBaDqBXE0jgzdPAxcCD44hhACPPQGoJjY1PAIHCwEBAwmQLy6BHQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 9ViD7XSxKhIFayJ5ICr9A==
IronPort-HdrOrdr: A9a23:fxSYQqOqmmZH1cBcT4T155DYdb4zR+YMi2TC1yhKOGRom6uj5q
 WTdZUgpH3JYVMqMk3I9urgBEDtex3hHNtOkO8s1NSZLWrbUQmTXeVfBOLZqlWKdkGQygce79
 YGT0EUMr3N5DZB/L/HCIrSKadU/DHRm5rY+tv2/jNBQR5nbqd44xw8KAqKe3cGOTVuNN4VGI
 WR48xfqyHlQ3QYacynGmIINtKz3eEj7KiWGiLuUCRXlDWmvHeQ87j9HAGf3hACFx1y4ZpKyx
 m3ryXJopy5tfe10xnd0HKWya93tp/O9vtvbfb8+PT8DF3X+3GVTbUkYqaFuj8tpuGp9RIRid
 HJ5zotIsxy7mmUUma+yCGdqzUIFAxemg6X9XaoxUPIgcvlSCk8A88pv/MmTifk
X-Talos-CUID: =?us-ascii?q?9a23=3A6GLYxWuGhWm8AS9dQYtuyedn6IsZbmXa9i3hAXW?=
 =?us-ascii?q?EAEJ7VefLClKf+a1dxp8=3D?=
X-Talos-MUID: 9a23:cEbtUgsM+qiQck1F2s2nujZEKfpT5f2VBU1cr7VftOKObyBSJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="118901663"
X-MGA-submission: =?us-ascii?q?MDFD9NSR5LLt9EFkxVxNcTcZmT9dE00k9vmhpv?=
 =?us-ascii?q?sV1jQ2xnvHYrdTD8HTGSkKn0lr8ehXeIMd3+eAdb52iWSYGpxu2p9gLB?=
 =?us-ascii?q?IvVR++tWRlmf6Lp4HjMQk4NnhHJKnFfRuW93MhcGRVCHTlrxh+ZKB6ZL?=
 =?us-ascii?q?8w3P1gROGXffLrQzUk5Sj18w=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:46:36 +0200
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7emFn026020;
	Thu, 12 Jun 2025 13:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x1aM1/RH/pAvF5wMxosW5xMQEnEHvU9V8b+/IGhMbko=; b=RQ6PsOvPbmUc2k63
	MpaiDqoVd+/4Ms7pv7QZ9CEB+A2PSsbkfhBO0L8H5rhO3GOE+znwNsvfiyuZ3xbY
	IiWpS/OR7M/tbz67azpmbIot2y7DTfOc5+yxcxpr0fVpFt0RoFin+NRcPHAzYq91
	a4Qolrx1D4/zcqkndchg+oVoLLnDkSqdog7ri4WJlsRdj4BDjuzwysAYMsXr0owi
	J/6dlv25/CbbDCqTmGz6GDCQrev8sE9OKxbCvT22Nt/1lX+I3N/knjgQxqrf0upw
	JlTZvifj/xU73mlhmu1XsjZ8OQIrwpU1RGVm5796k6g4bmgNDEUzPGp9+cagrUJ0
	bmstMA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2ybhe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CDkMTi030294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:22 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 06:46:18 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 12 Jun 2025 21:46:08 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-field_modify-v4-1-ae4f74da45a6@quicinc.com>
References: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
In-Reply-To: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
To: Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Nicolas
 Palix" <nicolas.palix@imag.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton
	<oliver.upton@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <andrew@lunn.ch>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie <quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749735973; l=2080;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=67KHPK0ryj5WYDYDXexeSpchGNbTFtE5nDzepjRpz2w=;
 b=MynC0pYX9Gv44FXGa3PgGdulk7VDm8uFk33/XLd0kf5RVAs3oe7amKe2dYFqLnvfyUx8W/sO7
 coZ/hJ2Y+6NDMnBRlz8KI5Rv00X/ldzEzE+OETZwsIwzNRQF3sppunv
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNSBTYWx0ZWRfX9fjypbZRF9us
 TSdivsvAB3bdNAS/dxa3k/4waJ8PLm46wEH5ll9rscH0cPBNAm0qpQaSyq9lgMCjbVPc50L0yan
 3H2TzimlAdE4ZR2p3bJuBlteOc55c+S79y0VpU4swAbb/On/+nzuZu8kpX5BV4wVskOWbM/m2Em
 cEo2ztZ33frACuREuAeeIoO30RjEAY5G0odY+oHdvVq57zTo6vvY6w27GOeBTRZKMEivQDzD/vB
 DlH3VNKvg6f/hHorTbQH7bWnEA80VCyDbqThyRRL/ISqU1OAckF5WDuYnIcdkT3zWAlRfRqsokY
 H96EOxoC8aLjgCeao/C357UZGg6XExEp+SpWeEU9McpNIqg7SM1Mj9G0j0NjqJoUzF4huvJUiz9
 T5lEUkC87MRY9PwQbks7ZYBhRPTcOZTfwX+46GTc+7SztAUVBJmPrsRNnZ3qfS5KXAc4RcFD
X-Proofpoint-GUID: F-nCuB_1zsCz5ribdNyO6PeJKsI-5Y3m
X-Proofpoint-ORIG-GUID: F-nCuB_1zsCz5ribdNyO6PeJKsI-5Y3m
X-Authority-Analysis: v=2.4 cv=f+BIBPyM c=1 sm=1 tr=0 ts=684ada2f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=05oQ047nAAAA:8 a=l05NuDNGqYqV5CF8ttEA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=vNAg3JWiabyzeNEprMgK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120105
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v4 1/5] coccinelle: misc: Add field_modify script
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2775
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250612-field_modify-v4-1-ae4f74da45a6%40quicinc.com>

Find and suggest conversions of opencoded field modify patterns with
the wrapper FIELD_MODIFY() API defined in include/linux/bitfield.h
for catching the possible parameter type error in the compile time.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 scripts/coccinelle/misc/field_modify.cocci | 61 ++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/scripts/coccinelle/misc/field_modify.cocci b/scripts/coccinelle/misc/field_modify.cocci
new file mode 100644
index 000000000000..48b00194a265
--- /dev/null
+++ b/scripts/coccinelle/misc/field_modify.cocci
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Replace below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
+/// - reg &= ~MASK;
+/// - reg |= FIELD_PREP(MASK, val);
+//
+// Confidence: High
+// Author: Luo Jie <quic_luoj@quicinc.com>
+// Copyright: (C) 2025 Qualcomm Innovation Center, Inc.
+// Keywords: FIELD_PREP, FIELD_MODIFY
+// Options: --include-headers
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+@ depends on context && !patch && !org && !report@
+identifier reg, val;
+constant mask;
+symbol FIELD_PREP;
+@@
+
+* reg &= ~mask;
+* reg |= FIELD_PREP(mask, val);
+
+@ depends on !context && patch && !org && !report @
+identifier reg, val;
+constant mask;
+symbol FIELD_PREP, FIELD_MODIFY;
+@@
+
+-reg &= ~mask;
+-reg |= FIELD_PREP(mask, val);
++FIELD_MODIFY(mask, &reg, val);
+
+@r depends on !context && !patch && (org || report)@
+identifier reg, val;
+constant mask;
+symbol FIELD_PREP;
+position p;
+@@
+
+ reg &= ~mask;
+ reg |= FIELD_PREP@p(mask, val);
+
+@script:python depends on report@
+p << r.p;
+x << r.reg;
+@@
+
+msg="WARNING: Consider using FIELD_MODIFY helper on %s" % (x)
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << r.p;
+x << r.reg;
+@@
+
+msg="WARNING: Consider using FIELD_MODIFY helper on %s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)

-- 
2.34.1

