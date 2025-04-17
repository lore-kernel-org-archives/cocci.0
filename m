Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BD9C369D9
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fl2qado12sJSasEZ85EejccDkasGJOzdpdf5GWKzGqc=;
  b=kvMEjU5VNyEsoXTGgehYNo+BteUXxYUUwgE4xh/NsygbGlBKkhMnub56
   C+AzTUOQRIeDh6vSCWhCZj76UKaFxu3VHcNbfCKtR8SFfdKNY+Ti2hYdR
   EcRSVgESyUye8dDPumAPH0ePPygGlTGvHOejFGsUOjyCwroUoOyjXi+Af
   U=;
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
   d="scan'208";a="219055911"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 519CEE0D3E; Wed, 23 Apr 2025 10:51:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 65044E007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 12:47:55 +0200 (CEST)
IronPort-SDR: 6800dc5c_a24p119BYUaD61JuCfqWJe6Ms5F/P6vtICt5C0JzlkfFpET
 BCOZ6pqZkC/7NA+nEqBb0rK8TDm6Yn/Z0p2r3Vg==
X-IPAS-Result: =?us-ascii?q?A0EIAAA52wBog4O03M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgUAFAQEBCwGCQ32BDQQLSB2EOIh7hlWeYYFVgX4PAQMBCwEBOQsEA?=
 =?us-ascii?q?QEDAwGFAAKLKwIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBOQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQIIYwEBHgIBAxIRHQEBNwEPJQImAgJGEAYBD?=
 =?us-ascii?q?QUigmABgmQDBQykY0NnKlkBgSBCiRIBAQF4gTKBAYIMAQEGgmjbHQMGgRsuA?=
 =?us-ascii?q?YhPAYFtg387hDwngiiBFYNogVKGTIJpgzQUhV2IB5NxCT+BBRwDWSwBVRMNC?=
 =?us-ascii?q?gsHBWRVMwMgCgsMCxIcFQIUHQ8GDwQWNR2BeoNygjBPgjeCEXCKJ4RULU+EO?=
 =?us-ascii?q?Q9xHUADCxgNSBEsNwYOGwY9AW4Hl0CBZ4IwAYEOLJVzgxhJjVBooQsNhBiMG?=
 =?us-ascii?q?ZV9qleYfiKNZJsEAgQCBAUCGIFoATiBXE0jgzdPAxcCD44hGYNhgT6NfwG3O?=
 =?us-ascii?q?TY1AjoCBwsBAQMJkBwugR0BAQ?=
IronPort-PHdr: A9a23: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
 +wx
IronPort-Data: A9a23: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
 vRAI5TzOahdFH1s5Q==
IronPort-HdrOrdr: A9a23:3PDbMq1j/qnOif76KSNPxAqjBJ8kLtp133Aq2lEZdPVwSL3/qy
 nIpoVj6faUskd0ZJhOo7+90cW7IE80lqQFhrX5X43NYOCOggLBR+wP0WKI+UyCJ8SRzI5gPO
 tbAspDIey1LXxCyeDg4Ae5FL8bsby62ZHtod33i01MdGhRAZ2Jg2pCe36mLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3Avwg0XmoUGXJYXT6o+DVjMYbmUYMJUHD61kjIH1K?=
 =?us-ascii?q?HBktrRrvPb3vP1Kwxxg=3D=3D?=
X-Talos-MUID: 9a23:NSK99Avcw+8gQ7okX82npXZsLMB326aUDho31ocmoNWEPjVZEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="218296334"
X-MGA-submission: =?us-ascii?q?MDEFYFOIOtCzVjXNpniPHgUhhw0Qn15WgndL5V?=
 =?us-ascii?q?l++qUtxNtnTP14nsSWztIiZ2SmQQJ+zPTYX6znMRceA3urRvHahIvO+u?=
 =?us-ascii?q?ohZ+qdSPsDCkBzrgEYeEGuI+YzIwgf7EMpWFmTB1vxQhwemf2/yMfyXy?=
 =?us-ascii?q?xQrRFSnP5FKLFvhiVumZLZnw=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:47:55 +0200
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l3CY022761;
	Thu, 17 Apr 2025 10:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fl2qado12sJSasEZ85EejccDkasGJOzdpdf5GWKzGqc=; b=cplR2MAFgNtv3jkf
	m+BRgiGkeT9kLkC1/OH+hhbQKyLBSzNrn1MhJdBy+nxwG2iwbYCCKRpAO4hnIChy
	JDqapvRlSx7n7zRMn7R3XpNfi9rqPyl99jxj7t3+fWo/+aDsYApOMVLQptPohpJU
	hqhf2V1SQKKemmR8heOEpRj4eCJwBbGif+/YYOduQZBqtnuURg2tqntSmmTsX694
	eUij9Fo2ZHzG46/MR0L1VJqV/JHxlwD/DNz9hLd+GEzvytwlbQhS5FjaRN1YdO4f
	B/YN5o9cGmb86vURCxL6GqTuaty60SnOwqxk+0H/fBDNV0q0otTroBX1oFxu0ZSZ
	4nTTbA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9ek0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HAleh0018259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:40 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 03:47:35 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 17 Apr 2025 18:47:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744886837; l=1077;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=cvVlxw6voFepum5B3j7VuYklAnJvwlbit3ZxBrFCeuY=;
 b=GTL0dCoHat+xXHUQb1fat8JsWpoJ4Y5akSpsWuWFztDiVKGbhBiItuLWg0KHJfcY3W7NleQZM
 qh+d+klpWIfDh0G12O8Y+QNqzV0cvncGSj5hNd48sXgS2CAjsQzaQyL
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5C9jqgUTuZmSpnBBeYGCWvUM3h1fRkyj
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=6800dc4d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ZOzjf2MOAAAA:8 a=COk6AnOGAAAA:8 a=SCSGtF1BeqTgPpDbPWsA:9
 a=QEXdDO2ut3YA:10 a=1Mhi-5-LkjG4w5oc0yAU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5C9jqgUTuZmSpnBBeYGCWvUM3h1fRkyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=421
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170080
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2692
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250417-field_modify-v3-4-6f7992aafcb7%40quicinc.com>

Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
- reg &= ~MASK;
- reg |= FIELD_PREP(MASK, val);
The semantic patch that makes this change is available
in scripts/coccinelle/misc/field_modify.cocci.

More information about semantic patching is available at
https://coccinelle.gitlabpages.inria.fr/website

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 34233d586060..b2af748964d0 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -30,8 +30,7 @@ enum pkvm_page_state {
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

