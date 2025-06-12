Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A87FC7114C
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AtRFh0Ey70hl6l/1Ltvy8lBRLOlLz+gnmfGfYWjxjc8=;
  b=pOLCCAhr0nfjKVAnigMw47GQPvaLkS0+JKEZ58TaNZtBcJ5RFhbSpyfq
   RYfGBEaapPM1t6iq6elhTAxB//yGLEW7TbT19C1HW5z96VmlHHkl1ujE8
   n3FeWjW5LqUH4WmarKPReVGK72u3rqkyPV3lXIRFfuSoNFowUY11BoA3T
   E=;
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
   d="scan'208";a="226896298"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 054F4E0DA9; Thu, 12 Jun 2025 15:49:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11EDFE0157
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 15:46:44 +0200 (CEST)
IronPort-SDR: 684ada43_0ed+gaZHtNty5jWfa9vnQRQLw92aRU5xTSf4pMAhlzRJenm
 lfLaJ+WXjzoCdZS1BMzWp+3AHTGny2gxOefTBuw==
X-IPAS-Result: =?us-ascii?q?A0EGAADl2Upoe4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgT8GAQEBCwGCQ4EAgQ0EC0kdhDiIHF+GVZ5lgVWBfQIPAQMBCwEBN?=
 =?us-ascii?q?xoEAQEDBIUAAotnAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBQg47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CCDkqAQEeAgEDE?=
 =?us-ascii?q?hEdAQE3AQ8lAiYCAkYQBgENBSKCYAGCKEYDBaMoQ2cqWQGBIEKJEgEBAXiBM?=
 =?us-ascii?q?oEBggwBAQaCaNsgCYEbLgGITwGBbYN/O4Q8J4IogRWDaIFShkyCaYMqFIJLh?=
 =?us-ascii?q?1SWfwk/gQIcA1ksAVUTDQoLBwVeUjMDIAoLDAsSHBUCFB0SDwQWMh2CDYItT?=
 =?us-ascii?q?4IdghJwihiESStPhCUPbYEmg2ERE3IPBkdAAwsYDUgRLDcGDhsGPQFuB5gJg?=
 =?us-ascii?q?28BgQ4rmQ5JjVNooQ4NhBiMHZYDhVulBpkEIo1lmwYCBAIEBQIYgWg6gVxNI?=
 =?us-ascii?q?4M3CUYDFwIPjiGEAIE+jX8BqCY2NTwCBwsBAQMJkC8ugR0BAQ?=
IronPort-PHdr: A9a23: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
 8IH6cFTRvFENWnBMMbsLbgOjx4q4VazTGg=
IronPort-Data: A9a23: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
 vSRD6ACOXm4
IronPort-HdrOrdr: A9a23:8sBO3qhlAPogUf1S3s70wZsz5HBQX5913DAbv31ZSRFFG/Fxl6
 iV7YwmPHjP+VMssRAb6LK90cy7K080mqQV3WB8B9mftUzdyQ2VxeJZnOjfKl/baknDH4dmvM
 8KHsQQNDSzNykcsS+Q2mmF+rgbsaC6GCPCv5as8587JjsaFJ1I3kNVBhmWF0tuSBIDJ5Yofa
 Dsm/Zvln6MdWsaa8KjCmJAZejMoNXXiInrCCR2fSLPkDP+9g9Av4SKbySw71MmSDVIzq4l8W
 /Z1yLExojLiYDI9jbsk1bJ6ZJYgd3gzcYGIvetpIw6FhXA4zzYEbiIfdW5zUcIidDq0U0tlt
 bUpRcmIoBI8nvUOky4vBPs3hOl/DElgkWSuWNwRUGT0L2MeBsKT/JqpYVFfgDf409IhqAD7J
 52
X-Talos-CUID: =?us-ascii?q?9a23=3AQeluzmuQlXMmNrr/Ib5dUUyN6ItiY3LflXjNJnO?=
 =?us-ascii?q?JFFZjFuy1anW55ZJ7xp8=3D?=
X-Talos-MUID: 9a23:+RCJkAlQ7LkRYEWdEkqNdnpvb/piz/WFD3wVlKsMoZO4LwErMju02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="118901672"
X-MGA-submission: =?us-ascii?q?MDHTDCf/uGnwTFav6BirAA2SMPXXt53WI5yTs6?=
 =?us-ascii?q?44CPOXfx6Jtc3X5Jfp0MhdzmZpE2TANYaza41x/q7LxHk/l6vtTUqVKV?=
 =?us-ascii?q?yimyGW8ofTRvEfI/MsrXGx+osIvhDr6cXI8bJIoVVcb+QFWzypidEj52?=
 =?us-ascii?q?oDiJgB7OIxXgxS2hk5e4vm2A=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:46:43 +0200
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7klnb019621;
	Thu, 12 Jun 2025 13:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AtRFh0Ey70hl6l/1Ltvy8lBRLOlLz+gnmfGfYWjxjc8=; b=dZoZFanLuvbFrqGn
	nlshuUO+Fjc9ySmmkn4wfLXL//mXLFOQGubK39WKbEBheMRSur7xC1Wrnh18YAbX
	jUT4nA74pv5r641DAUfnKLy/w7aiVqKDvbxGbAYmOX69MVi/p7y+eZ/ZkIBW7A2i
	TgRlylq+5SENpBxkMxXtggorGcsRk2QS6bv3CNh9W3lA8vL0fK2xKL1uSlRG3A+1
	OSeFGA3nj+PweML5fB1gMny7BkUtaPDsRH1Cx6Y1voq6EXK3U2a253yEBd5ulhR2
	dR7c5bLq8YsJ2fDJVy5UwsCoXB2gdfSDENHPdijXI/+RoYQbY1qhtMf1tnQ5yqx0
	9cI+0w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474eqcrq9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CDkVpr030855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:31 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 06:46:27 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 12 Jun 2025 21:46:10 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-field_modify-v4-3-ae4f74da45a6@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749735973; l=1055;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=RQ6JRVRsPYGnPD/Etf5zFYsGdfK+yVXW3fMdn2fe+PA=;
 b=py8dXdWMApFsDGHzCOE0AYnCD+LUzkA/muQQlvUJ+EaQlNIZoez3TpPULkEfohxYbuOBf3qty
 kFUx4wH1c0kBVGx9VaRbm5yEKsI3AMjifEQNFYsElAby9wDyim1cdlI
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNiBTYWx0ZWRfX3X8eZjf1IM2j
 +i7Jxhwn+k2R6uhBlqGl8860OQv4nlDvTaw0oOnlXb80b7zuU+hK5LwZwR7ZBywcr8ug4WcvfVf
 nUyTXYxvj7xt8Adffx6reBcpOFmEgJ+o40utzrPH+ktVDwDLXZ5Djo3gW8egwP+GQD70RyruSmS
 AsJMirRy5tt7xUDNfplcPwM8vQMdk1dmMpPYJl6PDGbl8Uojy1ph2SR53+a2u+plsQOrgvB3fO2
 hTVBu8abzTdGcbHHyw+o0S87Kg0NUpdQ995jrJ8aCCCNzd3aI6lVm4Oyti/ugUQLe2KZPHPchkt
 0J6gkWHJOIRC6JUBpdd7BPjn69bgKxlGF6SgwyHzDMdiFjHGF5DVUlEeNfjUipt7DLI4n7aDLXW
 DSatKW8VGAKBortwJ25DJjZMKg3+PqRN38O/+kT8TVzUP39iugvYJ4/sAUMaGwvFzuloftj2
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=684ada38 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=YgwN3AOMAAAA:8
 a=COk6AnOGAAAA:8 a=SCSGtF1BeqTgPpDbPWsA:9 a=QEXdDO2ut3YA:10
 a=ztR1XV6QG-NWxUt1dNgd:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hWeRRxSRKAV1XyHXXPfUuaQiuUBA0QZT
X-Proofpoint-ORIG-GUID: hWeRRxSRKAV1XyHXXPfUuaQiuUBA0QZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=434
 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120106
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v4 3/5] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2777
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250612-field_modify-v4-3-ae4f74da45a6%40quicinc.com>

Replace below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
- reg &= ~MASK;
- reg |= FIELD_PREP(MASK, val);
The semantic patch that makes this change is available
in scripts/coccinelle/misc/field_modify.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index dee1a406b0c2..c1dbea320131 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -37,8 +37,7 @@ enum pkvm_page_state {
 static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
 						 enum pkvm_page_state state)
 {
-	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
-	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
+	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
 	return prot;
 }
 

-- 
2.34.1

