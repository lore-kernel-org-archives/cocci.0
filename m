Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD82C8303D
	for <cocci@archiver.kernel.org>; Sat,  5 Jul 2025 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:to:cc:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=D0xSXwHIHKslGMCqKYomGWDSUYjDlcHuSehLtkzTcd8=;
  b=dB24OvbF1VtB+4ENIam9kDbswTVmock3DfGgPtM4hQK0EE0hYQxYmOaO
   T8jxNe8QP4206Zb+7J/8nkmRBWOtu0YAIgsFKbwkmd3oauurqyXGbZ4/0
   pJKAPBI1xZKxKuYqP7e0LDg0akWlGfZYFU9IoR4n4www5UhaSMPyv/Jja
   4=;
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
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230455989"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2025 15:35:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA41FE01A8; Sat,  5 Jul 2025 15:35:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AA6B4E0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 14:38:56 +0200 (CEST)
IronPort-SDR: 6863d6df_g1b/QgpOQ+p6O7FWBOTmUy9tsyHBFqOTqGIt7uf9IZLoyQU
 bpt6PQOuW/6QQm/eb+F9HWccjTyGHls/cxZz31w==
X-IPAS-Result: =?us-ascii?q?A0EBAABy1WNog4O03M1AGhoBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBPwUBAQEBCwGCQ4EAgQ0EC0kEGYQ4iBxfhlWCIYEWkDWKe?=
 =?us-ascii?q?YFVFIFpAg8BAwELAQFEDQQBAQMEhQCLdgIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABAQEBOQdJhXsNgmIBgSSBJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CCAVeAQEgFhEdAQE3ASwIAiYCSAIUAQ0FIoJgAYIoRgMFDAahc0NnK?=
 =?us-ascii?q?lkBgSBCiRIBAQF4gTKBAYIMAQEGgmjbIAMGgRsuAYhQAYFtg387CYJQgWMng?=
 =?us-ascii?q?iiBFYE7gTd2gVKCNFaDQoJpgRKCKoEqgS2CIzaCOIFtiBQdhicJP4ECHANZL?=
 =?us-ascii?q?AFVEw0KCwcFXlIzAyAKCwwLEhwVAhQdEg8EFjIdcwwoE4Zsg2ZGK0+EGg9pg?=
 =?us-ascii?q?RmDVBETbQ8GgR9cQAMLGA1IESw3Bg4bBj0BbgeRZYMqAXsTAStQgS1Tlj1Jj?=
 =?us-ascii?q?VdooQ4NhBiMHZYEhASmXi6YVyKCNok2gXmVVg0yhHUCBAIEBQIYgWg6gVxNI?=
 =?us-ascii?q?4M3EzwDFwIPjiEZg2eFE4oqAaxPNjUCATkCBwsBAQMJhkiGWi0FLoEdAQE?=
IronPort-PHdr: A9a23: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
 w==
IronPort-Data: A9a23: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
 9ViD7XSxKhIFayJ5ICr9A==
IronPort-HdrOrdr: A9a23:z3xGKKhClT/aH4I/qwzYGpGc8HBQX6Z13DAbv31ZSRFFG/Fxl6
 iV7Y0mPHjP+VMssRAb6LK90cy7K080mqQV3WB8B9mftWrdyQiVxeNZnO/fKlTbckWUm4Iz6U
 4KSchD4bPLfD5HZUWQ2njIL/8QhPLbtJ2yje3dz3BiJDsaDJ2JuGxCe3qmO3wzaQVYCZ8+DZ
 aGouhKt1ObCA4qR/X+K3UbU+3EvtHR0KjnbxkPGgI95GC1/EiVAcbBYmClN0AlIk5y6IZnyH
 PClQPh4KWlrrWU9j/wvlWjnKh+qZ/Z0d1EC9WLis8JbhPWqijtSrhAdtS5zUIISMfG0idfrP
 D85y46OcJ98nXQeXzwmwLk303M3Csn63r5jXOeixLY0LzErfYBerQx8L5xQ1/gwWomod1m16
 pPtljpyKZqMQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A5yfyLGgYpTmxq/u19U8oeLw0kjJuXFP64HPgHxG?=
 =?us-ascii?q?BJGNqRbSTGFG23Y9VjJ87?=
X-Talos-MUID: 9a23:zbKorgQJX2b+dzQSRXTCpQllGdtw5J2JFWdSqJ4f/MKgMDBJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120399937"
X-MGA-submission: =?us-ascii?q?MDHpj1ICE/IkH/ob+DbDMsy5uZIQxNcLf52118?=
 =?us-ascii?q?cdcRz1E6LTQzjwykcY4h9k41fr6GtH0SDuuNhfAcaBQu+qK/VyHMgEAn?=
 =?us-ascii?q?4UIf6ajdbZHvJgoq8wCACWGcgaQrLo9etWbcF1rbItCkfjaU4ye568lL?=
 =?us-ascii?q?2BeRuv91ReS9MDHk/ubSKRrQ=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:38:55 +0200
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619xE8R025936;
	Tue, 1 Jul 2025 12:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D0xSXwHIHKslGMCqKYomGW
	DSUYjDlcHuSehLtkzTcd8=; b=JaAjpfC8Z25Yaw7qsM5+8bRvQXaiiyTL27ckxX
	wjtumROwd/TYVcv37ZAK2fxWoqIejY8K9RxlVb89t7ZSkVR5VFbi9r8k+owC+fhv
	aElLOueRIoRXBlee/4hlrJ+ybALxfzpwXTqVW7uVyKVxtxEfD8PUcrslCCE7EMMH
	mwbtuq9D52NbfJWQlphEeMgiZtFMosJnxTj64xHpyG6rpBpgdxKSdMFyh3DodX5w
	Z4Ehta0e2v5PoNktviGlHNRmsg0sOAArrxFHhXEYIcGPhrka6d9qYEI8NvG3TKW5
	mx1XAF1PrWGpAML7g4POcBMcWawWv3jJKtv4Yofw0+4iKB/g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kd64p4uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 12:38:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561CcchC006483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 12:38:38 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 1 Jul 2025 05:38:34 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 1 Jul 2025 20:38:24 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250701-field_modify-v7-1-eacf13f215b4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMDWY2gC/2XOTQrCMBCG4atI1kby10zrynuISEwyOqCtthos0
 rsbdaG2y2/geZkH62JLsWPL2YO1MVFHTZ0HzGfMH1y9j5xC3kwJVQgrFUeKx7A9NYGw5wqkrtC
 CLkvJMjm3Een+zq03eR+ouzZt/64n+bp+QkbCfyhpLrhFqCrlHPodrC438lT7hW9O7JVK5ssnf
 ySTuYsGwQRnCmenvPjhyox4wSX3wYJUILSIZsrtL7cjbjNXQgREp0snRs8Pw/AEiIY1/WcBAAA
 =
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
        <Markus.Elfring@web.de>, Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751373513; l=4063;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=iQ35RxRMNQCWuVz6wds1TDAoTWkyLxSttohSUd9h/uw=;
 b=PJ4oIhaUHoma23HiPVd0lWXVogfovoMYZ7O6mYUHM1NF9N8vtT7r/NkoIBcsz/fhqchWHidRZ
 ADsLjFBjxmjBgoegKDUkjoc6PSGNJ7xucLDKfbGLga0p2AUFRvzW5kw
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Z+PsHGRA c=1 sm=1 tr=0 ts=6863d6d0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=05oQ047nAAAA:8 a=S47agHus8KO1I0bcMDsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=vNAg3JWiabyzeNEprMgK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3OSBTYWx0ZWRfX1OqJOzwSyxTt
 KJOHDEbQ9y0kYIQU8Vjc0CjD50f9XGch41WwBGvcw4ccB19toIz6sS7Lw0H7ImoN8TfRsIr4MHj
 GVO1Fqg12GvZZkndtbU/EWRvixOyuvvwO4CZy16lDo7YD/JeKnlqJA/8dn5u3IHNBcM2DQit1JA
 +qol2OCuAJc46cciR4RBx4SLC2kEOpiwjoEUjvpxuvKirl4Ctccfe+4HHVIf4DowR2dj/6kRvBC
 tDbz4eQO7G2dEusTUuMVMepYKfsi2Zy2PpakjbHTHfUyZ9G1yDBfjrB79ge1NSnbG4/odJfJSNc
 XHGO8MgDg5hdPheL+xgcbcXMsZSHIX2IidAFpdFZO+o8ZaPXeBOQFoxGWEXtM1aK4j77spKE+7S
 UtFd6Q/TldBskckU6zemMRx+oWendbVk0+25abYcAd/W2aFugOu25/YVG0L3PLNbN3U633L2
X-Proofpoint-GUID: tO_1oIxOmqPMp9vNYDv0s4FdLkUaFSSS
X-Proofpoint-ORIG-GUID: tO_1oIxOmqPMp9vNYDv0s4FdLkUaFSSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010079
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v7] coccinelle: misc: Add field_modify script
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2853
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/20250701-field_modify-v7-1-eacf13f215b4%40quicinc.com>

Find and suggest conversions of opencoded field modify patterns with
the wrapper FIELD_MODIFY() API defined in include/linux/bitfield.h
for catching the possible parameter type error in the compile time.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
macros. It is functionally similar as xxx_replace_bits(), but adds
the compile time checking to catch incorrect parameter type errors.

This series also converts the four instances of opencoded FIELD_MODIFY()
that are found in the core kernel files, to instead use the new
FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
the script field_modify.cocci.

The changes are validated on IPQ9574 SoC which uses ARM64 architecture.
---
Changes in v7:
- Use a formatted string literal as the function parameter for the
  report mode.
- Link to v6: https://lore.kernel.org/r/20250626-field_modify-v6-1-200dffa38a07@quicinc.com

Changes in v6:
- Adopt the suggested code variant for the org mode.
- Link to v5: https://lore.kernel.org/r/20250624-field_modify-v5-1-cd67127030e4@quicinc.com

Changes in v5:
- Remove ARM64 patches based on the discussion in v3 and v4 versions of
  this series.
- Simplify the condition selections in coccinelle script.
- Link to v4: https://lore.kernel.org/r/20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com

Changes in v4:
- Add org, report and context mode for coccinelle script.
- Fix other comments on coccinelle script patch.
- Remove the FIELD_MODIFY patch as it is merged.
- Link to v3: https://lore.kernel.org/r/20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com

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
 scripts/coccinelle/misc/field_modify.cocci | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/scripts/coccinelle/misc/field_modify.cocci b/scripts/coccinelle/misc/field_modify.cocci
new file mode 100644
index 000000000000..3ed3739fdf10
--- /dev/null
+++ b/scripts/coccinelle/misc/field_modify.cocci
@@ -0,0 +1,59 @@
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
+@depends on context@
+identifier reg, val;
+constant mask;
+symbol FIELD_PREP;
+@@
+
+*reg &= ~mask;
+*reg |= FIELD_PREP(mask, val);
+
+@depends on patch@
+identifier reg, val;
+constant mask;
+symbol FIELD_PREP, FIELD_MODIFY;
+@@
+
+-reg &= ~mask;
+-reg |= FIELD_PREP(mask, val);
++FIELD_MODIFY(mask, &reg, val);
+
+@r depends on org || report@
+identifier reg, val;
+constant mask;
+symbol FIELD_PREP;
+position p;
+@@
+
+reg &= ~mask;
+reg |= FIELD_PREP@p(mask, val);
+
+@script:python depends on report@
+p << r.p;
+x << r.reg;
+@@
+
+coccilib.report.print_report(p[0], f"WARNING: Consider using FIELD_MODIFY helper on {x}")
+
+@script:python depends on org@
+p << r.p;
+x << r.reg;
+@@
+
+msg = f"WARNING: Consider using FIELD_MODIFY helper on {x}"
+coccilib.org.print_todo(p[0], msg.replace("[","@(").replace("]",")"))

---
base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78
change-id: 20250612-field_modify-27139f673881

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>

