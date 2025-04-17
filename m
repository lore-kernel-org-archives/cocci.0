Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FFBC369D3
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LRMHmsRiXieBj8psfApOLY0gCKvwS9nBg3+ZVQMAHlQ=;
  b=CKNRZg4J4gTdUV90Qc4PnwdHjc4S8376aiwR094nc2f/LBGvr8G7mcnR
   OmBOnnXiRxs/tFiGguo9s0ofXRufyNxeu+YfvqyTVwWWBjOUAhNDLTSi0
   fxO7drRNH8lOpFCHNm3pPIOIAwZBhZvFJtUKOtIfchMRAkyLpR2qBF5E4
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
   d="scan'208";a="219055798"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13A61E0261; Wed, 23 Apr 2025 10:51:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9E4DDE007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 12:47:39 +0200 (CEST)
IronPort-SDR: 6800dc4c_eqORdLG7frjwRxlCCARZm/C/NAI4dm7yCOEkxw/fIROluge
 XSKr+X6AjVB0UPw0pjXhSlIXm9RtRx+aY2Kk4Pg==
X-IPAS-Result: =?us-ascii?q?A0EFAAA52wBog4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgT8GAQEBCwGCQ32BDQQLSAQZhDiIHF+GVZ5hgVWBfg8BAwELAQE7C?=
 =?us-ascii?q?QQBAQMEhQCLLQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBOQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAggFXgEBIBYRH?=
 =?us-ascii?q?QEBNwEsCAImAkgCFAENBSKCYAGCZAMFDKRjQ2cqWQGBIEKJEgEBAXiBMoEBg?=
 =?us-ascii?q?gwBAQaCaNsdAwaBGy4BiE8BgW2DfzuEPCeCKIZPgwqDQoJpgRSCNIMtgSWCf?=
 =?us-ascii?q?oQ/hFpXgm6BeyuDYIchCT+BBRwDWSwBVRMNCgsHBWRVMwMgCgsMCxIcFQIUH?=
 =?us-ascii?q?Q8GDwQWNR2BeoNygjBPgjeCEXCKJ4RULU+EOQ9xHUADCxgNSBEsNwYOGwY9A?=
 =?us-ascii?q?W4Hl0CEFwGBDytQggCWO0mNUGihCw2EGIwZlX2EA6ZULphQIoI2iTWBeZVQD?=
 =?us-ascii?q?YUnAgQCBAUCGIFnOoFcTSODNxM8AxcCD44hGYNhhROKKgG3OTY1AgE5AgcLA?=
 =?us-ascii?q?QEDCYZIiSItBS6BHQEB?=
IronPort-PHdr: A9a23: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
 IUK5YIKGZz+iSkwyO/+Mb8OyBMmog/sIQfdZMk=
IronPort-Data: A9a23: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
 vSRD6ACOXm4
IronPort-HdrOrdr: A9a23:NBfN/6/0/3axiROdOPNuk+DsI+orL9Y04lQ7vn2ZESYlF/Bxl6
 iV8cjzpiWE7Ar5OUtQ4OxoV5PgfZqxz/VICMwqTNWftWrdyROVxeNZjbcKqgeIcxEWtNQttp
 uIGJITNDSENzZHZLHBjzVQfexL/DDNytHOuQ6X9QYKcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3AU3EY1Wq5R5ho8ysb8hamM/3mUcl7QHvS1Cr8GFS?=
 =?us-ascii?q?bUWFnduecRm7TqLwxxg=3D=3D?=
X-Talos-MUID: 9a23:F9q4kAaJEYitCOBThzTylXYyE+tU44uTLhoX1rIGmZKkKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="218296302"
X-MGA-submission: =?us-ascii?q?MDG+RZfMQ54/WHRFavqiTo9v9UXE6UB1d4ZYtb?=
 =?us-ascii?q?4Y1O/dYY2nh0rZTdw07JzveFsT6W+jMiZ08BPyFOtgTl4IWeufArNCFQ?=
 =?us-ascii?q?he5iEidaXLCPQwKs7IHO9TjCvaghTm1+Ss6PGrbxI4XmaRGsqrh1xEIL?=
 =?us-ascii?q?Vxx2E2QWRlNKmiVZPigccS4Q=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:47:39 +0200
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l7QW003036;
	Thu, 17 Apr 2025 10:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LRMHmsRiXieBj8psfApOLY
	0gCKvwS9nBg3+ZVQMAHlQ=; b=JRdC/+Ito+q1oHGhzzSVYYd8uvr0eiRG7HqYhu
	RkXq1ET6mbVzecWa30fNAS03efvXsIsjc9VX4odMxk1PJgIrKJMPv0JejYk3Z+Nl
	vTmnqgzfZ3je6kS1l0pINMfvfhOiwAeVJoqNeJg3iBKd0J2oQDRhNGE9u8LcdOBf
	BmSSIBdIzq0+4vcHsnsIe3rp3M4JPhGhpVsqFKNJ7kz3eGX7vVZIEMu0+E0xJ7J+
	Q3bkfCY1M0vD9IAM3V0DyHlOlE6YpkLoDItLgeKfwgn2gU9lOvr2LuqQCwCAS00C
	Glz5JtL2DBxFLKR3MjBlSb+HbxpZB2gA8U9j96r4kYGaMKAg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk6fm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HAlMZp013519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:22 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 03:47:17 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 17 Apr 2025 18:47:07 +0800
Message-ID: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACvcAGgC/x2MwQ6DIBAFf8XsuTSCYKCn/kdjGoGlblLFQmtqj
 P9e6nHey8wGGRNhhku1QcKFMsWpQHOqwA399EBGvjCIWqhacs4C4dPfx+gprEw3VmlvjSkvFGV
 OGOh75G5d4YHyO6b1qC/8v4JXAdHolnHlWiZlj8zW2jIt0HApFRohrq8POZrc2cURun3ff+MRm
 DKnAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744886837; l=2029;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=sNPOlKWxoa2d3Xd6pXHYvrfVZgt6hORR+j95PnalnKo=;
 b=BHLO3JJmTWuhCBY6yr0kCXOSkZrQy9MK+KEJ1RAfExjyoxi7m7VCsE4uEpkPi53uqWpWVhD3v
 5WdVAxpbsIxCWjcCqsroD9l/TllAID7lBKVr2cQoznmU2MXZ/n8MGbP
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=6800dc3a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=cHbbWd92-npjkAukGjkA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -f_gB-2QlCjIYT6UaquToRoAO_Mpl07q
X-Proofpoint-ORIG-GUID: -f_gB-2QlCjIYT6UaquToRoAO_Mpl07q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170080
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2689
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250417-field_modify-v3-0-6f7992aafcb7%40quicinc.com>

Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
macros. It is functionally similar as xxx_replace_bits(), but adds
the compile time checking to catch incorrect parameter type errors.

This series also converts the four instances of opencoded FIELD_MODIFY()
that are found in the core kernel files, to instead use the new
FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
the script field_modify.cocci.

The changes are validated on IPQ9574 SoC which uses ARM64 architecture.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
Changes in v3:
- Correct the order of header files included.
- Add the Coccinelle script field_modify.cocci..
- Convert the opencoded FIELD_MODIFY() variants inside arm64 directory,
  identified by field_modify.cocci.
- Link to v2: https://lore.kernel.org/all/20250410131048.2054791-1-quic_luoj@quicinc.com/

Changes in v2:
- Update the documented example for FIELD_MODIFY().
- Improve the commit message to describe the need for the change.
- Link to v1: https://lore.kernel.org/all/20250318071526.1836194-1-quic_luoj@quicinc.com/

---
Luo Jie (6):
      bitfield: Add FIELD_MODIFY() helper
      coccinelle: misc: Add field_modify script
      arm64: tlb: Convert the opencoded field modify
      arm64: nvhe: Convert the opencoded field modify
      arm64: kvm: Convert the opencoded field modify
      arm64: mm: Convert the opencoded field modify

 arch/arm64/include/asm/tlbflush.h          |  3 +--
 arch/arm64/kvm/hyp/include/nvhe/memory.h   |  3 +--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c         |  6 ++----
 arch/arm64/mm/context.c                    |  3 +--
 include/linux/bitfield.h                   | 21 +++++++++++++++++++--
 scripts/coccinelle/misc/field_modify.cocci | 24 ++++++++++++++++++++++++
 6 files changed, 48 insertions(+), 12 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250411-field_modify-83b58db99025

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>

