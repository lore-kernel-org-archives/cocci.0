Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF6CC369CB
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lGVJzGhFhsynORmsNgO0Ufap8ukTTN1je4VdDXycQzk=;
  b=a+kNGKDqQEOus2VE3JEryeKb7064DqFxRIzBCejaALWDWsEC6jiLAWzZ
   JEyD68rSXfOAEKlrI3wm0D11GrbwFgi/TJ10byQuel4ro8R1tpapMrUTl
   o26/OojNOqB1Qx6y3ve2aN3o/NCRjbZ2TK8qSUHiplzva7TQUuZKy0nam
   s=;
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
   d="scan'208";a="219055982"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CCF2CE0D1E; Wed, 23 Apr 2025 10:51:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 48909E007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 12:48:02 +0200 (CEST)
IronPort-SDR: 6800dc61_K8wPx0DA3OUrlxY10EGHeue8h6DM1hJ8sLVJqAukDqufs7J
 L9qYe1X+xDrMacYe3R299jwL01jSPUU6Yh3y/8g==
X-IPAS-Result: =?us-ascii?q?A0EIAACz2wBog4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgUAFAQEBCwGCQ32BDQQLSB2EOIh7hlWeYYFVgX4PAQMBCwEBOQsEA?=
 =?us-ascii?q?QEDAwGFAAKLKwIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBOQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQIIYwEBHgIBAxIRHQEBNwEPJQImAgJGEAYBD?=
 =?us-ascii?q?QUigmABgmQDBQykbENnKlkBgSBCiRIBAQF4gTKBAYIMAQEGgmjbHAMGgRsuA?=
 =?us-ascii?q?YhPAYFtg387hDwngiiBFYNogVKGTIJpgzQUhV2IB5NxCT+BBRwDWSwBVRMNC?=
 =?us-ascii?q?gsHBWRVMwMgCgsMCxIcFQIUHQ8GDwQWNR2BeoNygjBPgjeCEXCKJ4RULU+EO?=
 =?us-ascii?q?Q9xHUADCxgNSBEsNwYOGwY9AW4Hl0CBZ4IwAYEOLJVzgxhJjVBooQsNhBiMG?=
 =?us-ascii?q?ZV9qleYfiKNZJsEAgQCBAUCGIFpAjaBXE0jgzdPAxcCD44hDA0Jg1iBPo1/A?=
 =?us-ascii?q?bcyNjUCOgIHCwEBAwmQHC6BHQEB?=
IronPort-PHdr: A9a23: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
 d1k0w==
IronPort-Data: A9a23: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
 9ViD7XSxKhIFayJ5ICr9A==
IronPort-HdrOrdr: A9a23:hK0ZOKnF95aJDvaGIileOuBQdGnpDfKO3DAbv31ZSRFFG/Fxl6
 iV7YwmPHjP+VMssRAb6LK90cy7K080mqQV3WB8B9mftUzdyQ2VxeJZnOjfKl/baknDH4dmvM
 8KHsQQNDSzNykcsS+Q2mmF+rgbsaC6GCPCv5av8587JjsaFJ1I3kNVBhmWF0tuSBIDJ5Yofa
 Dsm/Zvln6MdWsaa8KjCmJAZejMoNXXiInrCCR2fSLPkDP+9g9Av4SKbySw71MmSDVIzq4l8W
 /Z1yLExojLiYDJ9jbsk1bJ6ZJYgd3gzcYGIvetpIw6FhXA4zzYFriIfdW5zUQISSWUmSda5e
 XkklMZFeR19n/LeWmxyCGdpTXd7A==
X-Talos-CUID: =?us-ascii?q?9a23=3A7k0elGo+tbAjv1Nk7/qyRwTmUdo4blfX/FOKH1C?=
 =?us-ascii?q?DVl9rFKGPYl6bp4oxxg=3D=3D?=
X-Talos-MUID: 9a23:15oLlgRlNOjFyGhpRXTM2xchc5pZwZ2oVnlOr8k8itSKCjN/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="114510246"
X-MGA-submission: =?us-ascii?q?MDGflCWpMYCf75Rgj6LPfLZ0TP8p00VZKkK/sm?=
 =?us-ascii?q?sHkvNhNVKJ+FL7UigYZAbkR3mx+tkUBjiDGbh57LpZ9jLgivWT2vgmjB?=
 =?us-ascii?q?nZAmhjLOF6RUjNMa2az0bZQ1C6eWGaO3w1nPVNwEH3o947a3KLCMJ7Ag?=
 =?us-ascii?q?/XCUrEikqWGrvRM8rJ1cjuNg=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:48:01 +0200
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5lcYN003944;
	Thu, 17 Apr 2025 10:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lGVJzGhFhsynORmsNgO0Ufap8ukTTN1je4VdDXycQzk=; b=gH9MjxeQoPvaQ8KH
	oPbcGbrJN4thAdsH/2k7VfBD1g+tdRBaFuNLAkBmckTnWPft5ene9vNIVJkLCQgM
	9T9Yf/yj8+EGUMFY/XE615241x74H7gLCk2YSrZbXhVs9u5PuxvBEEjKef+lDBry
	LYJTOIAsBmkZDyFZvkIudLhOBXwSxujk0Lk3y5D9HMgOA14BZpvtiPWpdnr2BWAl
	NIy4OdiwoGnUWkhuoqL22ruYpv26bvflRWPGQMJH0KtTLdg6V1SqodGsKf/4f++I
	EfjI+PGrSlMSoYKFQzzLjB+3CHjnTaP5NklhGp2UW4WDR05GAOxnaUN7AH3Nd1dQ
	jxjG2g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk6fn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HAlnYJ019982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:49 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 03:47:44 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 17 Apr 2025 18:47:13 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-field_modify-v3-6-6f7992aafcb7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744886837; l=1033;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=xpPeM78AeyqXzMwrmF8QDTx6un/IOmdC2J/f9RaIfLg=;
 b=PovyH1yn6CXrPEB8yE8i6Rq7KANbmp7tfi2kcTCp1H73IAAf+83n1NFGWDqg4gqVeGsr9aufS
 P7DuOUkQd0PDv1BUaLL+/x4PnkP/yg+Cnzrn5gq9Lomp5wV/P2DcQuE
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=6800dc55 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ZOzjf2MOAAAA:8 a=COk6AnOGAAAA:8 a=7DCMZFnr-hN-Ju-LsH8A:9
 a=QEXdDO2ut3YA:10 a=1Mhi-5-LkjG4w5oc0yAU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: X5Cpp14XJ6JiT4u5RFYLsXdjNIPLMfKb
X-Proofpoint-ORIG-GUID: X5Cpp14XJ6JiT4u5RFYLsXdjNIPLMfKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=596 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170080
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 6/6] arm64: mm: Convert the opencoded field
 modify
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2694
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250417-field_modify-v3-6-6f7992aafcb7%40quicinc.com>

Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
- reg &= ~MASK;
- reg |= FIELD_PREP(MASK, val);
The semantic patch that makes this change is available
in scripts/coccinelle/misc/field_modify.cocci.

More information about semantic patching is available at
https://coccinelle.gitlabpages.inria.fr/website

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index b2ac06246327..4fbac8e74149 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -361,8 +361,7 @@ void cpu_do_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm)
 		ttbr0 |= FIELD_PREP(TTBR_ASID_MASK, asid);
 
 	/* Set ASID in TTBR1 since TCR.A1 is set */
-	ttbr1 &= ~TTBR_ASID_MASK;
-	ttbr1 |= FIELD_PREP(TTBR_ASID_MASK, asid);
+	FIELD_MODIFY(TTBR_ASID_MASK, &ttbr1, asid);
 
 	cpu_set_reserved_ttbr0_nosync();
 	write_sysreg(ttbr1, ttbr1_el1);

-- 
2.34.1

