Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EDC369D3
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dTr8jPcJDG1ssEC02tHjuO+8nyj5jMrX7M1nMqoPipQ=;
  b=eljM0ay/0vyDNex2bR1rk3lMyfziYCmSOPhqeaMf2qBHOJ/DiZq/SywM
   fbJn6IciiPqF1n7RKUhHBeDvygxpTy+EjakWVHnnkv5fVldrAzLtatSsg
   HfXhNIlfm8eTR8myIdCV5r5XElLtGaSYK2oCDM9KZS3Q9et7mU2f2jXiF
   M=;
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
   d="scan'208";a="219056049"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35A8CE0D75; Wed, 23 Apr 2025 10:51:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 15893E007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 12:48:49 +0200 (CEST)
IronPort-SDR: 6800dc90_g3EmXj/I2Ddm7M8hQgHpqZMHGTGmH44O3Az7RDr4kefSu7x
 oBxR82lMTXQxRX7s98LXtLMUW8QL/PYXs73uZ7Q==
X-IPAS-Result: =?us-ascii?q?A0ELAACz2wBog4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgUEEAQEBCwGCQ32BDQQLSB2EOIh7hlWeYYFVgX4PAQMBCwEBOQsEA?=
 =?us-ascii?q?QEDAwGFAAKLKwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBOQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQIIYwEBHgIBAxIRHQEBNwEPJQImAgJGEAYBD?=
 =?us-ascii?q?QUigmABgmQDBQykbENnKlkBgSBCiRIBAQF4gTKBAYIMAQEGgmjbHAMGgRsuA?=
 =?us-ascii?q?YhPAYFtg387hDwngiiBFYE7gi2BUoZMgmmDNBSFXYgHk3EJP4EFHANZLAFVE?=
 =?us-ascii?q?w0KCwcFZFUzAyAKCwwLEhwVAhQdDwYPBBY1HYF6g3KCME+CN4IRcIonhFQtT?=
 =?us-ascii?q?4Q5D3EdQAMLGA1IESw3Bg4bBj0BbgeXQIFngjABgQ4slXODGEmNUGihCw2EG?=
 =?us-ascii?q?IwZlX2qV5h+Io1kmwQCBAIEBQIYgW4BMoFcTSODN08DFwIPjiEMDQmDWIE+j?=
 =?us-ascii?q?X8BtzI2NQI6AgcLAQEDCZAcLoEdAQE?=
IronPort-PHdr: A9a23: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
 7k=
IronPort-Data: A9a23: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
 tVh3pTmOHm4FQ==
IronPort-HdrOrdr: A9a23:dCq/b63Gj2pWK0HhFyaA5AqjBBAkLtp133Aq2lEZdPRUGvbo7/
 xG+85rsCMc6QxhOk3I/OrrBEDuexLhHPJOj7X5eI3SOjUO21HYT72Kj7GSpwEIcheWnoUxuc
 hdmupFebrN5DNB7foSjjPIaurJQ7K8gdOVbbC09QYTcShaL4xt8At9DB+WCQlVSBkuP+tFKL
 OsoudKuDakf20adYCABncDV/XevNGjruOdXfd/PW9d1ODYt0LV1JfKVyGC2BEQSjVOxqpn31
 TkvmXCl9eemsD+8wTb0WDL6ZRQhZ/G8ftsQOKxquV9EESdtu6PDL4RL4FqeApF0ZDb1H8a1O
 HngxA8M99143a5RBDKnSfQ
X-Talos-CUID: 9a23:2CTk4Gza3txWiKkvJiMoBgUaF+ckU13HzUvLABaRAGs1d5qTSUePrfY=
X-Talos-MUID: 9a23:i1DmzAkTPQLmkZF0d1IWdnozBch5wJz+M3oniMk3pvaOGSZpYTu02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="114510298"
X-MGA-submission: =?us-ascii?q?MDGRzhv2NX7gfFT5hQ3lA5i5OrV2Sr7pMthykU?=
 =?us-ascii?q?4Get3wN0g1R7DX8p3aeHz6LWCcS8hrmhjeNcchAJGu/3n6GF64i0WlbE?=
 =?us-ascii?q?RDYfyyoV10TQOvy07pwjEeQxCkEc9iGvwFciAz9ux0xInJ1KVvu2i7gq?=
 =?us-ascii?q?1Yb/G7SDoUc5vd9izz8F5y9Q=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:48:47 +0200
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l5Ml009309;
	Thu, 17 Apr 2025 10:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dTr8jPcJDG1ssEC02tHjuO+8nyj5jMrX7M1nMqoPipQ=; b=dmx5oJ6JtpYkEYa/
	L0Vyz/KnttUzx2cqqWQYLeTWaUVL4XmR58nnaXOAePWW/gdcYyg6h3EUnPCmjkBv
	R7s6G1p3W9uZuCobNfASQi2UgwC686Ds9UK1bpo2iffENDzgTH7U88JppoWaQy2j
	XtF/S64aYGs1bf2wOGjlw6kcP8M1o8Wpt2UtE/etIJDBhGYDoid9GXAC8itkgk2e
	cPjaCNM1MbsmZ5wDkoogdYJWQcBJi6F8bQEPDDH8plelucItKSZuw02n0Mc14DDf
	CcILIbR5SjsRr/BHFie+zFcb9xTc6n5DcLXKN3kwklyvPE6aRDX5CaZEWq60DP75
	LGg5fw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvbuw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HAlZHQ011208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:35 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 03:47:31 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 17 Apr 2025 18:47:10 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-field_modify-v3-3-6f7992aafcb7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744886837; l=1071;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=gqGzOX65dgUloUXBiDM2uUofMMrXchcJwN/9t+iSb7k=;
 b=sxhXTdsE+Z/QAYZZpILNncmv9BD3WHP8C30/OyBTr9mtTkJJhDV22A9VJlIMxz87/nnKD69Ta
 SFmrL05AyupA38N88nqL6ZzChWDnb8DsQhi7Z9hD9tVAMrP2JnglnZT
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AtLGZHnrWsYSQEjPsUo0tJffbaXJLcWr
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=6800dc48 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ZOzjf2MOAAAA:8 a=COk6AnOGAAAA:8 a=C2vL1j-_i977Atbg1qQA:9
 a=QEXdDO2ut3YA:10 a=1Mhi-5-LkjG4w5oc0yAU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AtLGZHnrWsYSQEjPsUo0tJffbaXJLcWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=542
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170080
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 3/6] arm64: tlb: Convert the opencoded field
 modify
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2695
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250417-field_modify-v3-3-6f7992aafcb7%40quicinc.com>

Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
- reg &= ~MASK;
- reg |= FIELD_PREP(MASK, val);
The semantic patch that makes this change is available
in scripts/coccinelle/misc/field_modify.cocci.

More information about semantic patching is available at
https://coccinelle.gitlabpages.inria.fr/website

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/include/asm/tlbflush.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index eba1a98657f1..0d250ef4161c 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -112,8 +112,7 @@ static inline unsigned long get_trans_granule(void)
 	    level >= 0 && level <= 3) {					\
 		u64 ttl = level & 3;					\
 		ttl |= get_trans_granule() << 2;			\
-		arg &= ~TLBI_TTL_MASK;					\
-		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
+		FIELD_MODIFY(TLBI_TTL_MASK, &arg, ttl);			\
 	}								\
 									\
 	__tlbi(op, arg);						\

-- 
2.34.1

