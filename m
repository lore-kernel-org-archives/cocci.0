Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ADFC369D8
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yiVm/qo8c+x7rGClKcN3itMCXTg6zKC2txm6G5ApZjA=;
  b=GWdUXplUYvTFCiPo5QMoWeG+2VSKHyXsiH14xWaWD28l9Lo5M9I5ZZ19
   rQV9ItWwpzcx87L/EeDedIAnXWA3GIeNgzQjbmhul2eM9XPWaR/Jngbn5
   sZ3eaCcUeBItJCNrpdmSdLE4Nvn9Djgat/Tsze5BaLiaT0IG69y3mvX0m
   k=;
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
   d="scan'208";a="219055866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1026E0D21; Wed, 23 Apr 2025 10:51:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2BFD9E0261
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 12:47:46 +0200 (CEST)
IronPort-SDR: 6800dc4b_dwQtvmaslpjcWaFxqOdgtC0Y9I7xV2XBPNHLW+ZFlD5qINA
 lN5Sf4HdWTSC6Qjfr1YlbGSPgRv5uZlnXFvZL6w==
X-IPAS-Result: =?us-ascii?q?A0EFAACz2wBog4O03M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgT8GAQEBCwGCQ4IKBAtIHYQ4iBxfhlWeYYFVgX4PAQMBCwEBRAQBA?=
 =?us-ascii?q?QMEhQACiysCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBATkHDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQIIYwEBHgIBAxIRH?=
 =?us-ascii?q?QEBNwEPJQImAgJGEAYBDQUigmCCZQMFpHhDZypZAYEgQokSAQEBeIEygQGCD?=
 =?us-ascii?q?AEBBoJo2xwJgRsuAYhPAYFtg387hDwngiiCUIItgVKGTIJpgzQUgy2BJYELg?=
 =?us-ascii?q?XOEP4FVg1yCboF7gj+IbQk/gQUcA1ksAVUTDQoLBwVkVTMDIAoLDAsSHBUCF?=
 =?us-ascii?q?B0PBg8EFjUdgXqDcoIwT4I3ghFwiieEVC1PhDkPcR1AAwsYDUgRLDcGDhsGP?=
 =?us-ascii?q?QFuB5dAhBiBDpk3SY1QaKELDYQYohaqVy6YUCKjNA2FJwIEAgQFAhiBZzqBX?=
 =?us-ascii?q?E0jgzdPAxcCD44hDA0Jg1iPPQG3MjY1PAIHCwEBAwmQHC6BHQEB?=
IronPort-PHdr: A9a23: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
 59Lm6+8Tl0ux7qXHFICMs+QcWlo
IronPort-Data: A9a23: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
 vSRD6ACOXm4
IronPort-HdrOrdr: A9a23:0UMxaKueWt5J47F8gwphXrBs7skD1NV00zEX/kB9WHVpmszxrb
 HXoB19726QtN9xYgBDpTnkAsO9qBznlKKdjbN+AV7mZniBhILKFvAA0WKB+UyFJ8SWzIc0vs
 oNHJSWSueAamSS5vyb3ODXKadY/DEFm5rY9ts3mBxWPH5XQpAlwgtnBgOcC0FsACtLFfMCZe
 ehz/sCija+dXEQd8ihQkMEUe/KusHRmPvdEGQ77mYcmXKzZGSTmcLHOind5wwZVTxXx7ck7C
 zqryzVj5/Twc2T+1vkzGnU4I1RmNz9jv15JOLJpPQ0B1zX+3aVjKIIYcz3gNnwmpDfmSMXue
 iJmz0BONl+8HTYewiO0GXQ5zU=
X-Talos-CUID: =?us-ascii?q?9a23=3ACuXtcWgt9DzTsS5Ll3OejCLsCTJuW22CxUbfBVC?=
 =?us-ascii?q?BO0kxR4a0F0Cg4K9WnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AHAPHaQyIeG9C8BlrInUw9oU9i+maqP2NFnoKz40?=
 =?us-ascii?q?lgOe7EndvARWFlivuE5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="114510230"
X-MGA-submission: =?us-ascii?q?MDFzZyX3xCUYBiFm+MhbB/Xkc+rq2+7su3rLsR?=
 =?us-ascii?q?vjLIV1ma+pH8YVfmueAMCDHCBqkcMALEr+MUR3JeVfWBXOq7WjA0yq9N?=
 =?us-ascii?q?DFA6A3XZQqdRSmQePc2C+kAGeXn3zPUlbXQTRvui2/rDZPNTqCc+hlN7?=
 =?us-ascii?q?VIy3cyuFm4a+5J8ViNuJ0m0Q=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:47:38 +0200
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l3db022746;
	Thu, 17 Apr 2025 10:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yiVm/qo8c+x7rGClKcN3itMCXTg6zKC2txm6G5ApZjA=; b=Efl2sYz2bdcXONUA
	BdxahmYJbO+DPxQkmjEDvG5L0Wud+P5kxdFhRFLzu9HXk0PjKEbS7Te2ZD4cvAxs
	Q7RBhyhq27cH/GTtw6kga+3mpS6FHKEEtf7v34K0ujq5CuuzftNcSGtoXlzfaC7Z
	FutZXe0RQ/M+21i0gVXlaXUTXnkMQ5ZBWJNort4U2VIqkQO1GEBaYol2l6/6hHdB
	QC7hrL9dUTTXsKTTzGdPw6NDiqy2vx/vRLlew04z0N5iri0SOzCECW9KhQ+zBnhW
	nr8trckcGgN48MNS+JoE5P8JS6EBNL80uavQPCqo7FZB4Ehepe/ySYH6YX+82gZv
	dO+X3A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9ek03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HAlQ9I019727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:26 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 03:47:22 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 17 Apr 2025 18:47:08 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-field_modify-v3-1-6f7992aafcb7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744886837; l=2268;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=XqzeltOC1Zkgsh2BrcPOXdm5N2R/wIhJqoHDe6dtw+Y=;
 b=9IzZjSlW5yjd7751JIfknwqV1vLuyiGlF+29QONHWIKVYOwVHAUF2BXkXXd1I3uJJL+SY5ijZ
 I4dTJYHzh5kCs81yntSxU2bVyECkiVc3YvIx6GZCLd+5CPFa0yqx1Dx
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7jZWPg1HNGZFTxuXBfHc0Cpmo5p70edG
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=6800dc3f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=bpWgvMM22m3vV3Jt9xMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7jZWPg1HNGZFTxuXBfHc0Cpmo5p70edG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170080
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 1/6] bitfield: Add FIELD_MODIFY() helper
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2691
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250417-field_modify-v3-1-6f7992aafcb7%40quicinc.com>

Add a helper for replacing the contents of bitfield in memory
with the specified value.

Even though a helper xxx_replace_bits() is available, it is not
well documented, and only reports errors at the run time, which
will not be helpful to catch possible overflow errors due to
incorrect parameter types used.

Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
macros. It is functionally similar as xxx_replace_bits(), and in
addition adds the compile time type checking.

FIELD_MODIFY(REG_FIELD_C, &reg, c) is the wrapper of the code below.
reg &= ~REG_FIELD_C;
reg |= FIELD_PREP(REG_FIELD_C, c);

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 include/linux/bitfield.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f173223..2eaefa76f759 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -8,6 +8,7 @@
 #define _LINUX_BITFIELD_H
 
 #include <linux/build_bug.h>
+#include <linux/typecheck.h>
 #include <asm/byteorder.h>
 
 /*
@@ -38,8 +39,7 @@
  *	  FIELD_PREP(REG_FIELD_D, 0x40);
  *
  * Modify:
- *  reg &= ~REG_FIELD_C;
- *  reg |= FIELD_PREP(REG_FIELD_C, c);
+ *  FIELD_MODIFY(REG_FIELD_C, &reg, c);
  */
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
@@ -156,6 +156,23 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
+/**
+ * FIELD_MODIFY() - modify a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg_p: pointer to the memory that should be updated
+ * @_val: value to store in the bitfield
+ *
+ * FIELD_MODIFY() modifies the set of bits in @_reg_p specified by @_mask,
+ * by replacing them with the bitfield value passed in as @_val.
+ */
+#define FIELD_MODIFY(_mask, _reg_p, _val)				\
+	({								\
+		typecheck_pointer(_reg_p);				\
+		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
+		*(_reg_p) &= ~(_mask);							\
+		*(_reg_p) |= (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask));	\
+	})
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")

-- 
2.34.1

