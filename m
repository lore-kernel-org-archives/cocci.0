Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04056C71136
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4UZaUurOrt1AA6JlidBnCXvptFMXwOUkDYNh/JmFBZE=;
  b=E51vp2NA1ljEvOliFRjZMDPbS1wRLZsinpOSDHjzB3ZGln2uYdWrti2h
   Rlv95Jj846DD83GF5uf8Yc9vGnwmUnfM8O2A/Edh93VIN5cOdWFIWDn70
   3tp76HnGt9qegdZxRofMU56lSPLNs3alQwmDxWGwMWaF0qAawIOe4oU/d
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
   d="scan'208";a="226896278"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B341CE0DA8; Thu, 12 Jun 2025 15:49:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E0CDE0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 15:46:41 +0200 (CEST)
IronPort-SDR: 684ada41_GihkOGvLQomztawZEkh4CAIK7CQjyuxMGJrEH79+R5NlKif
 qnFjWs2GSPnMAT6alHigNQuK+Qvakcf1nEKSNxA==
X-IPAS-Result: =?us-ascii?q?A0EKAABg2Upoe4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgUAFAQEBCwGCQ4EAgQ0EC0kdhDiIe4ZVnmWBVYF9Ag8BAwELAQE3G?=
 =?us-ascii?q?gQBAQMEhQACi2cCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQFCDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQIIOSoBAR4CAQMSE?=
 =?us-ascii?q?R0BATcBDyUCJgICRhAGAQ0FIoJgAYIoRgMFoyZDZypZAYEgQokSAQEBeIEyg?=
 =?us-ascii?q?QGCDAEBBoJo2yAJgRsuAYhPAYFtg387hDwngiiBFYE7gi2BUoZMgmmDKhSCS?=
 =?us-ascii?q?4dUln8JP4ECHANZLAFVEw0KCwcFXlIzAyAKCwwLEhwVAhQdEg8EFjIdgg2CL?=
 =?us-ascii?q?U+CHYIScIoYhEkrT4QlD22BJoNhERNyDwZHQAMLGA1IESw3Bg4bBj0BbgeYC?=
 =?us-ascii?q?YNvAYEOK5kOSY1TaKEODYQYjB2WA4VbpQaZBCKNZZsGAgQCBAUCGIFqATeBX?=
 =?us-ascii?q?E0jgzcJRgMXAg+OIQwWg16BPo1/AagmNjU8AgcLAQEDCZAvLoEdAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:MoxKUKt5sj/XtYQ3N0KsCYBe7skCM4Mji2hC6mlwRA09TySZ//
 re5MjzsiWE7Qr5OUtQ++xoXZPrfZqyz/9ICOUqU4tKGTOW3ldAT7sSjrcKoQeQfxEWn9Q1vc
 wMH8dD4Z/LfD9HZK3BgDVQfexQueVuc8uT9JLjJyAHd3AUV4hQqyp0FQqfFFR7X01lCYpRLu
 vg2uN34xetZngTaN22HT0+X+bFr8DWj56OW299O/de0nj0sdr+0s+HLzGomi4EVTVB2LEj9n
 WAvTDYy8yYwoKG4y6Z7nTU6ZtOntvn159kP+yjzuYoChiEsHfbWGxGM4fyywwdkaWX81Atn8
 DLoxA8e/5r43eUU22pqRvpwU3N1zxG0Q6T9bZduwqT0LjEbQN/M+Bggp9UaRzQ7iMbza9B7J
 4=
X-Talos-CUID: =?us-ascii?q?9a23=3AuP+Jd2o5+wOWVlAl/zqyXlzmUcMDamzelFPKGhS?=
 =?us-ascii?q?xSj5sa4fOY3Ou85oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ARZibTQ8/vSFVfK7g58D4+mmQf5xPsqGpFnBTrbw?=
 =?us-ascii?q?fsOOdJzZaZQWChR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226895311"
X-MGA-submission: =?us-ascii?q?MDH10ExF4mxr4IWagt3oXgnreulVt1gvBS8bCj?=
 =?us-ascii?q?bIZkVAiudJh6GiKQVm6IkvlIdWiJ0nV3xjb+pMtOAHz4KV9g3Ss6bQjQ?=
 =?us-ascii?q?HiqvihNBagFluci2PYMIcnXLyJtWMwrwNTzehgfHIRDKlfrjNeWS5rJu?=
 =?us-ascii?q?icyTnLYnsENAUy7WMHOY8w8A=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:46:40 +0200
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7qdJV026026;
	Thu, 12 Jun 2025 13:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4UZaUurOrt1AA6JlidBnCXvptFMXwOUkDYNh/JmFBZE=; b=Qpayt6fDpRwqs5IN
	QfrYHcEju6B6ZpFnGfEsdHYk+XBSoB5zqvMPDR4vuk0zL0JPGQDnnrhgzD9X1V/Y
	9/H9SxGRc1n7ZoqBbnTMtP0F/ZPYgTxvooOLZC5gYSqj+4LjS4+R3evBS95W2s5z
	DdiJdN4L794EKFG8kSMcn00O8/kPFu99CihdpWpQMjdd6nVrya3DGmAIJuC62P/l
	Hvj27wsIDiJGzyQiOJBNuYnJi8bcJrtLR7LUw75uaL5fL2X0IM22389QTeEQC6tO
	pefzhazr/K/uK+nbETJBM/Qv1SdY3/ukciN53pY1GQ5DsrZX5qv3yfVPDXUS0h0E
	niSDmg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2ybhed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CDkRnp007216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:27 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 06:46:22 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 12 Jun 2025 21:46:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-field_modify-v4-2-ae4f74da45a6@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749735973; l=1049;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=0hd3Xbu/1BPf0k75pV/Vg9Nmx0tY6XisEeYKWmsaInw=;
 b=MN4Ir/SPSOB8/z6pPsHFnzrQnIsWWBsWdoSc5igPk/5BO651bKFmoL5zTSlDlLiUdAHPXXMZ4
 vBPoLggVWK2BomicbhBfkt28p+7RgruSjgaOkwBcL+/lr/vvTfsC/ws
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNSBTYWx0ZWRfX9OVNPTYq5/fQ
 WkpnNqIAs8aif9RKa9JaAhPX7mhCVvZyQfYblBUBsXEvEiBmm0Y4pVP4QVhFbA5f4dnHWGAlCsG
 nOI13mR4wpofG1paHE2y3nxUMaxRzwkLWaa+Tqdevj15kyNM6+hJ5TOtAAEENnECtfQo0NJ6Uh3
 nTNnZeqwoxGzxTj/ypH3HQIiZzL+e92xKt8/RdjYoT90CFjzc28+jupqJD4DJyTMaki5De4cUd9
 yyNJdF6y1Gb6m4u1ydXUECHgKtAb7ZX0UIwxoUSaWfNQmbiSM4Bup5FiU4TnPlnikG2kZTzr7BS
 gNSRa2CfRaCHeJE+7Nba2eckEYS1mJ5ZtHZfNa5p2uwor/p9uxEuufCjjRLGPjpCfNVza6ix3gp
 0OZ06PXEKdGLydTLwngKtFf5ttjmyvqCackEh2I/mR5fQ+RwLrK4WzFp7UxB0YzxntXY+jda
X-Proofpoint-GUID: 95-X0mNwDG0cKiO8OxADInFGJISH4C46
X-Proofpoint-ORIG-GUID: 95-X0mNwDG0cKiO8OxADInFGJISH4C46
X-Authority-Analysis: v=2.4 cv=f+BIBPyM c=1 sm=1 tr=0 ts=684ada34 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=YgwN3AOMAAAA:8
 a=COk6AnOGAAAA:8 a=C2vL1j-_i977Atbg1qQA:9 a=QEXdDO2ut3YA:10
 a=ztR1XV6QG-NWxUt1dNgd:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxlogscore=579 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120105
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v4 2/5] arm64: tlb: Convert the opencoded field
 modify
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2776
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250612-field_modify-v4-2-ae4f74da45a6%40quicinc.com>

Replace below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
- reg &= ~MASK;
- reg |= FIELD_PREP(MASK, val);
The semantic patch that makes this change is available
in scripts/coccinelle/misc/field_modify.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/include/asm/tlbflush.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index aa9efee17277..cdcee05bdf6d 100644
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

