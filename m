Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96BDC61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X8GgE2nPNPiJlYy8ohdXyvSbBqN//6odlSN5nqekQ1s=;
  b=CM/ImxUFlW+osRkGruPlwIH8dtvohdiIv3Bz8oWqNWAUgi1sGtaRt1+o
   NSMmL6ynmrEeZTD6U2R90JMYDySvVIU8DeWl5iHFKttdJhWH6xVwZxtZJ
   1qnpDk8N1Ml7YzWGTuM+kA3I4tV1ikcdGqPeW2c5HRA117fQU+2UvQYlX
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
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226896342"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 913B8E0DCF; Thu, 12 Jun 2025 15:49:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7621FE0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 15:46:56 +0200 (CEST)
IronPort-SDR: 684ada50_G+LATGJ7SbPYXBZ8uoSY3A7ngs7J/aciEHSEjbYDuOpk5/Y
 Te+figNquNpOaByFslcB4vhnCQ7meRz2QQwUFUw==
X-IPAS-Result: =?us-ascii?q?A0EGAABg2Upoe4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgT8GAQEBCwGCQ4EAgQ0EC0kdhDiIHF+GVZ5lgVWBfQIPAQMBCwEBN?=
 =?us-ascii?q?xoEAQEDBIUAAotnAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBQg47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CCDkqAQEeAgEDE?=
 =?us-ascii?q?hEdAQE3AQ8lAiYCAkYQBgENBSKCYAGCKEYDBaMmQ2cqWQGBIEKJEgEBAXiBM?=
 =?us-ascii?q?oEBggwBAQaCaNsgCYEbLgGITwGBbYN/O4Q8J4IogRWDaIFShkyCaYMqFIJLh?=
 =?us-ascii?q?1SWfwk/gQIcA1ksAVUTDQoLBwVeUjMDIAoLDAsSHBUCFB0SDwQWMh2CDYItT?=
 =?us-ascii?q?4IdghJwihiESStPhCUPbYEmg2ERE3IPBkdAAwsYDUgRLDcGDhsGPQFuB5gJg?=
 =?us-ascii?q?28BgQ4rmQ5JjVNooQ4NhBiMHZYDhVulBpkEIo1lmwYCBAIEBQIYgWg6gVxNI?=
 =?us-ascii?q?4M3CUYDFwIPjiEMFoNegT6NfwGoJjY1PAIHCwEBAwmQLy6BHQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:xcR6WqmW2beCpf0QiwnZK+yomHfpDfIh3DAbv31ZSRFFG/Fw8P
 re/8jztCWVtN9/YhsdcLy7VZVoIkm8yXcW2+Ys1N6ZNWGMhILCFu9fBP7Zslnd8lrFh4lgPM
 lbH5SWcOeAaGSS2vyKgjWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3AWb01+2rqaFac2H3YPIzNVK7mUfkCY2fN9U7IGH2?=
 =?us-ascii?q?9WGtod7/EdVLP8Zoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AwRbv1Q0LRbSqS8QoAWQW0gq0gDUj2IeMVlILur4?=
 =?us-ascii?q?/tcytLRZ+JxGt0C+Oa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226895379"
X-MGA-submission: =?us-ascii?q?MDEpTuydR4/a/hitx/L+wBtr3vExIRVezGXlqh?=
 =?us-ascii?q?iiQocWvlwNJhJHVmXjCDPa0gbbE8R9IESjTW/S4w55UV/hdQwJD5kFdr?=
 =?us-ascii?q?/T1Ijk7WQQLQKhWJiSk4T8BuWKP20KEiz3KBt4NTwQN/79/fzAt7H5AC?=
 =?us-ascii?q?A5bXNC9NIHQZGGFN85ZLRf5w=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:46:55 +0200
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7t2tK029227;
	Thu, 12 Jun 2025 13:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X8GgE2nPNPiJlYy8ohdXyvSbBqN//6odlSN5nqekQ1s=; b=DI+vGVfG2tsbpW7e
	c1Maclxn21evjKUoE3EtsxjIF7+zgCBH47M4CinLcXu8VQr22xo+yf2Wux3QoEV0
	PuOh4zglhd8v6+gZ6j+eJyw3g8EpKQMHW76MJsHSAL5QWT23Th7NLgjV8QzHiAe2
	yA0vhzTcdFFWV2IjlzEhrrZVpfBzUVGF2LcQBo8VrP2cRUuRv4pbdwC5AvSYpF3Z
	M43OXs801E/IQFFiI/THPmZH1LjyFjlhM4peUhT6DJMmq5Ad+Eq3gTr7Knbymh61
	2xXMZGkCHWECPt/imV0Cg56uCXci6Smtuzeo1matngyeEklowkVtzHuhmyf3cDHw
	o+ngbw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn6gq38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CDkfF2008186
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 13:46:41 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 06:46:36 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 12 Jun 2025 21:46:12 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-field_modify-v4-5-ae4f74da45a6@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749735973; l=1011;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=W/ahaZ49s/QUKZlkADLnL22LdnI5S7Mvd9H7G4IoQdc=;
 b=hel6wCcdA56WnGWVTAMEcD0oSXQ+ePCdhntzG9esVw3qUoy/BSILo7hV+c3qvZLRv3e5XgxZl
 XtsGVslBdZJDopMC5XZYgzgtQ76pihmggA6fVfcaWuuBKEtb5v/FH1y
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNiBTYWx0ZWRfX8f2PlBQBhUyc
 jA6I1zp59iHWJ18qmXDABq2XSM+kvLWUmj1aDU76cEj4pD7xCFcRf1iF2DpkjUqXLKUEoEjUQCy
 7am7u0lIVsVQtqT5aqZbmdkyAkZlu1gPg90JKYqgOPsl0bBZSN9FZTElSOT5/vjCwX4fGXf/yDn
 /MKPQrhqU2QMJXsSFFX9kbzoQAMCWUDaxFK7O9c05mvMWoA6gknd+7rwR/DbpSo2a8MstYioH8N
 BPq1KzuUd4CdbjXEK8TmsamjxVbyf4ZKl3iaUyVucfmsycKyeT6+oVsq5QD/2nzSu0EgoLzdE4G
 wsoTuYUHlTriip12hTyXDz9bHu80JR5H83mziMPPFoTGyh0BlzpYqXh2wdLMj/PJbREk+RmDSLX
 aUy0NchoVJaX7E5KQVRPrYvpAqAId6/TQWcCGkUbJBeEbUdCP0iGMPHim+qdnDTqXr0ZASGg
X-Proofpoint-GUID: 8bi3BmivY8GHEm5ykXFVLbLnIhfr2nai
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=684ada41 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=YgwN3AOMAAAA:8
 a=COk6AnOGAAAA:8 a=eT1jO_uuukyntfU6EpwA:9 a=QEXdDO2ut3YA:10
 a=ztR1XV6QG-NWxUt1dNgd:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8bi3BmivY8GHEm5ykXFVLbLnIhfr2nai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=621 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120106
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v4 5/5] arm64: mm: Convert the opencoded field
 modify
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2778
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250612-field_modify-v4-5-ae4f74da45a6%40quicinc.com>

Replace below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
- reg &= ~MASK;
- reg |= FIELD_PREP(MASK, val);
The semantic patch that makes this change is available
in scripts/coccinelle/misc/field_modify.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

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

