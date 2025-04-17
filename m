Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46927C369D7
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=joqHxGXRXWUcgQSeYf7DKuVd+np3iIts6YQmP7x6K7c=;
  b=LQecu71jhRZKmocR3wAkAz6UYGPxhn/pKUnhKO1hSM7gXjGbj6f2PRRw
   RLaiVLHMXtyRnNvGpd3Msr7L1ya+lCm4Ky4b0+AJoBwbv2NIuR+Pcsh+y
   KTdtbNyy/Te+gaW/29DD7BEtclEsi2gzMtav/Kc1nuZQaku+4IKFaGNbg
   o=;
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
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219055831"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C5336E0D1F; Wed, 23 Apr 2025 10:51:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C67F5E007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 12:47:45 +0200 (CEST)
IronPort-SDR: 6800dc52_aRf6cPmgFw0pvvZEEQvFp4FRxj+DxH+JjBsbpHrnXHXAAKE
 2Xhm1vjntJX5I3iIFJ6pPH2R0vHzNl1B5OJVOTQ==
X-IPAS-Result: =?us-ascii?q?A0EEAAA52wBog4O03M1AGhoBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBQQMBAQEBCwGCQ32BDQQLSB2EOIh7hlWDN5sqgVUUgWoPA?=
 =?us-ascii?q?QMBCwEBOQsEAQEDAwGFAAKLKwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQEBOQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIIYwEBHgIBAxIRHQEBNwEPJ?=
 =?us-ascii?q?QImAgJGEAYBDQUigmABgmQDBQykY0NnKlkBgSBCiRIBAQF4gTKBAYIMAQEGg?=
 =?us-ascii?q?mjbHQMGgRsuAYhPAYFtg387CYQzJ4IogRWBO4E3doFSgjSEGIJpgzQUoVUJP?=
 =?us-ascii?q?4EFHANZLAFVEw0KCwcFZFUzAyAKCwwLEhwVAhQdDwYPBBY1HYF6g3KCME+CN?=
 =?us-ascii?q?4IRcIonhBBELU+EOQ9xHUADCxgNSBEsNwYOGwY9AW4Hl0CBZ4IxgQ4slXODG?=
 =?us-ascii?q?EmNUGihCw2EGIwZlX2qVy6YUCKNZJsEAgQCBAUCGIFuCSqBXE0jgzdPAxcCD?=
 =?us-ascii?q?44hGYNhgT6NfwG3OTY1AjoCBwsBAQMJkBwugR0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:gQesP6FsmrzlaVgrpLqExceALOsnbusQ8zAXPmRKOHpom6uj5r
 mTdZUgpHvJYVkqN03I9ergBEDiewK6yXcW2+cs1N6ZNWGM1QeVxepZnOjfKlPbexEWutQtt5
 tIQuxfLOS1K0N7g8b8iTPIduoI8Z2iyojtv8fmpk0GcekHBpsQlztENg==
X-Talos-CUID: 9a23:b7K8qm1Dod4Y/75c+LnEkLxfK+0pSmb68W/qJUKUCExiZpTWV1qi9/Yx
X-Talos-MUID: 9a23:v70SIAnJ2ED/K0A/6vmvdnoyJuMvspaoBHkIqpg/teuoJXZLB2+C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="218296315"
X-MGA-submission: =?us-ascii?q?MDEG6ZmhA46akPRXZq/wZWQbFEuGlVgXUY66J+?=
 =?us-ascii?q?BsK5lH+zFCXhno/vqpXQChtEOkg8Gj8kJmEE8a2NLcc0Ngt2eQejNZOB?=
 =?us-ascii?q?EqAHkGhsPRNqFnMZnO7mlFJAVllB8957c4nbfPv7SXhN2nLMKF5975Ti?=
 =?us-ascii?q?iDxQzMyZgHHtstMgNpSna3Sw=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:47:45 +0200
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l5mI026055;
	Thu, 17 Apr 2025 10:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	joqHxGXRXWUcgQSeYf7DKuVd+np3iIts6YQmP7x6K7c=; b=Jx69SiQHMpE/wWCt
	zhJ7k3NwYmTdkSiwCAe9wp/l2NVyo3Vn/tIaZGuDvqDpaJHvHj6YUajRZ/2feNxe
	dgy+a0tRZ4VvJVEPnnlO1R2XCZ6VgLHqXZQH8tydryExXh0ldcGWhJwPMLT3CIbR
	bBanSofECfTj1oukWwpflMg6sLZ1oS3l3EF+dBJSelUEhnVoJQR5wJRbGef/dpJr
	5yzb9Pk3SvtGDOmwwxPHuTWG65awKm4GZ02bNNdeTGpn5KNefs0ma6FLkks5F6zq
	t3Ri59TvQZyFRqehnC41obrUdIvNOsQbXv80J279glP6GuCFRJPfWt+76ZHzB+HC
	fBswoA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wpmhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HAlVik011151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:31 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 03:47:26 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 17 Apr 2025 18:47:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-field_modify-v3-2-6f7992aafcb7@quicinc.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
In-Reply-To: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744886837; l=1254;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=FsqgMOWA6HwEOqiI8oCsrw/0ONab4Rl0yNuVIkWVLF0=;
 b=fd62gXaWDF5y19XxQ7te/YJZc6YSFjACMSUUigIxJUXrnJdk7ngf0rnpLQ5LMdJDvnN3vkrw3
 bVNw2Sd2LhICLPbxvNh48NxeuuRY/IGya097fHXozJxW9ubsHf/9YHq
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=6800dc44 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ZOzjf2MOAAAA:8 a=COk6AnOGAAAA:8 a=V_falgm8geQyOEPxdJ4A:9
 a=QEXdDO2ut3YA:10 a=1Mhi-5-LkjG4w5oc0yAU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Frky8NHfJUnkO57daYP_0bmOxq9dDigo
X-Proofpoint-GUID: Frky8NHfJUnkO57daYP_0bmOxq9dDigo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=730 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170080
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 2/6] coccinelle: misc: Add field_modify script
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2690
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250417-field_modify-v3-2-6f7992aafcb7%40quicinc.com>

This script finds and suggests conversions of opencoded field
modify patterns with the wrapper FIELD_MODIFY() API defined in
include/linux/bitfield.h for better readability.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 scripts/coccinelle/misc/field_modify.cocci | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/coccinelle/misc/field_modify.cocci b/scripts/coccinelle/misc/field_modify.cocci
new file mode 100644
index 000000000000..9022c1b23291
--- /dev/null
+++ b/scripts/coccinelle/misc/field_modify.cocci
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
+/// - reg &= ~MASK;
+/// - reg |= FIELD_PREP(MASK, val);
+//
+// Confidence: High
+// Author: Luo Jie <quic_luoj@quicinc.com>
+// Copyright (C) 2025 Qualcomm Innovation Center, Inc.
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Keywords: FIELD_PREP, FIELD_MODIFY
+// Options: --include-headers
+
+virtual patch
+
+@depends on patch@
+identifier reg, val;
+constant mask;
+symbol FIELD_PREP, FIELD_MODIFY;
+@@
+
+- reg &= ~mask;
+- reg |= FIELD_PREP(mask, val);
++ FIELD_MODIFY(mask, &reg, val);

-- 
2.34.1

