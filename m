Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2A1C369DC
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2vUtnJERmDPMRwfb9WPRiqeU5l4lGHI2IYPwOWBEt0Q=;
  b=KGtUy5M/JkAaa0imG7fllmbMe08QaEpWLiOw6zhnN1TVLMgY6pZdVuX1
   aTGzYh7nHSVjh93GQfnmNyoKrDgm6S6vtKYXqD17QdbFtgLdLkYs3QxJ8
   /8cKmbe9ijN8WvsdLiVhuF8FVVcy2gB8dvApuXEt+dZ5kYmyR4yjwlaGG
   w=;
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
   d="scan'208";a="219055977"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6792E0D67; Wed, 23 Apr 2025 10:51:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 36930E007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 12:47:57 +0200 (CEST)
IronPort-SDR: 6800dc5e_NMgix+lFDrxPibh6d7zAx5opQhob0rzmjys1uimVQnGAd1o
 qMkMPNyyJ4AIqmoLCbkvyYRat48XlRyLindmfpg==
X-IPAS-Result: =?us-ascii?q?A0EFAAA52wBog4Oo3M1AGhsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgT8GAQEBCwGCQ32BDQQLSB2EOIgcX4ZVnmGBVYF+DwEDAQsBATkLB?=
 =?us-ascii?q?AEBAwMBhQACiysCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBATkHDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQECCGMBAR4CAQMSEQQZAQE3AQ8lAiYCAkYQB?=
 =?us-ascii?q?gENBSKCYAGCZAMFDKRjQ2cqWQGBIEKJEgEBAXh/M4EBggwBAQaCaNsdAwaBG?=
 =?us-ascii?q?y4BiE8BgW2DfzuEPCeCKIEVgTuCLYFShkyCaYM0FIVdiAeTcQk/gQUcA1ksA?=
 =?us-ascii?q?VUTDQoLBwVkVTMDIAoLDAsSHBUCFB0PBg8EFjUdgXqDcoIwT4I3ghFwiieEV?=
 =?us-ascii?q?C1PhDkPcR1AAwsYDUgRLDcGDhsGPQFuB5dAgWeCMAGBDiyVc4MYSY1QaKELD?=
 =?us-ascii?q?YQYjBmVfapXmH4ijWSbBAIEAgQFAhiBZzqBXE0jgzdPAxcCD44hDA0Jg1iBP?=
 =?us-ascii?q?o1/Abc5NjUCOgIHCwEBAwmQHC6BHQEB?=
IronPort-PHdr: A9a23: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
 g==
IronPort-Data: A9a23:KRnlTqrHyoO+CRi8H/GxMO8ZzOBeBmKwYRIvgKrLsJaIsI4StFCzt
 garIBnSbv7YYWLyL9glb4mx90sF7J/VztFnTQNtqSA8QykR9+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsv/rRC9H5qyo5WtE5wNmOZingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kfF4Yi189tLV0Q3
 vw9DDZXbBS/3vCflefTpulE3qzPLeHuLNsW/yk4lmjVA65/B4jbQ6LR+dJUmjw3g6iiH96EP
 5dfM2A3Kk2eM1sWYQ5/5JEWxI9EglHmbjxTn1aIoqgf+nXSxw132/7mN9+9ltmiH5wFxBfG/
 T6cl4j/KigKKvut+zOhyFmt2cWIsR7FRKEyHYTto5aGh3XInDBLVEJLPbehmtG9g1G3X9Z3O
 U0R8DAn66k07k2iCNfnNzWzp3WPvzYHSt9IGqs77huMw+za+W6k6nMsSy4ZYZl+7JRvSTJyj
 xmRh9PuHiBivPueTnf1GqqoQS2aEAIeF0IrfwM4EyAFxv3l+oM3skvdZ4M2eEKqteHdFTb1y
 jGMiSExgbQPkMIGv5lXG3iX3lpAQbCZEmYIChXrY46z0u9uiGeYi2GA7EiD5LMYdN3AQlfZ5
 T4cg8iZ9/wDAdeGkynlrAQx8FOBuK3t3N702A8H83wdG9KFpiPLkWd4vWwWGauRGpxYEQIFm
 WeK0e+r2LddPWGxcYh8aJ+rBsIhwMDITIu5CqCOPoEfPcErLmdrGR2Cg2bAgwgBd2B8zckC1
 WuzKJzE4YsyUvk3kGLeqxk1i+ZzmnFWKZzvqWDTlE77iebBORZ5uJ8dKlyJYPg+7aWY6ATT+
 JA3Cid540U3bQEKWQGOqdR7BQlScxATXMmqw+QJLbTrClQ9Rwkc5wr5mupJl3pNxP0Nzr+gE
 7DUchMw9WcTclWcc1TbMy48MOi0NXu9xFpiVRER0Z+T8yBLSe6SAG03LfPbpJF+rLQ9n81nB
 eIIYduBCflpQzHKsWZVJ5rkoYAoMFzhiQuSNmD3KHIybrxxdTzvo9XERwrI8DVRLyyVscBln
 aas+DmGSrU+RiNjLv3sVtSR832Ls0MwpsdOTmrTA9wKeEzT4IlgcCPwqfksIvAzExbIxxrE9
 gPPXTI3iPXoj6Yn1ebzgIWogpqiM8F5FBF8R1vk1KuHb3jG32u8wL1vVPSDUiDdWVjVpoSjR
 7Rx5NPtPMIXmG1lt9JHLI9q6qYlvf39iqR/zA85OFnqNnOAFaJHDl+K+eJtp5997OZVliXuU
 33e5+QAH6uCPf3UNWI4JS0nS7+m/u4VkDyD1sYFChz2ywEv9YXWTHgIGQeHjRFcC75HMIkF5
 +MFk+xO4iydjisaCPq3vhp2xU+tcENZC74Gs6sECrDFkgAok1FOQaLNAx/Mva2gVY9+DVkIE
 BS12oz5mLVu9mjTeSESFF/M/9Znq7YghRRo9GIGdnO1wofrp/lvxxBA0yUFfiIMxDV97u9DE
 GxKNUp0GKawwwlVlPVzB2CBJgUQKyCaq2rQykQInlL3V0OHdHLAB0xjNPev/HI2yXN9fD9a9
 4Gm0Fe/VSvbbZzz1HFqWGpOif/qffpu/CLsxeGlGMWkGcEhQDzH26WBW0sBmyHFM+gQ2nLVl
 LJPx/lhT5H7OQo7gbwJO6PD2Zs+EBm7dXF/G9d/96Y3LETgUTCV2wnWDXuue8lIdsf4wWXhB
 +NAfstwBgmDjgCQpTUmBIkJEb9+vNgtwPEgIrrLB2o3g4GznwpTkqD713bB3TcwYtBUj8wCB
 JvbdGuCHkyulHJkoTLxg/ceCFWoQ+svRVPa5/+0wtUrBphYkeBLcGMO6JWWkUiREjNa+0Ozg
 FueSY7Ql/dv2KZ9rbvKS69jPTi5Gfn3deaP8T2wjehwUMPyAZ/wkD0R+3baPFVwHLoOWt5Iu
 6yHn/zp0Wjk4rsncWDrtKOQNqtO5M6CYvJmaMbqHWgHnyHYAM7IyDkA8lCeNpZmvo585M6mZ
 g3gc+q2V4cfdOl8zU1vSRp1MkgiGZWsS5z/tAWBr/ioIToM4zztdd+I2yfgUjBGS3UuJZb7N
 D7Rh9+vwdJp9KJ3Gx4OAqBdMa9SeVPMd/MvSIzsiGO+EGKtv1Klv4ninzoG7RXgKCGNMOT+0
 KL/ainOTjaAk4CW84gBqK13hAMdM1hli+ppfk49xc9/uwrnMEE4d9YiIbc0IbAKtBft1aPIR
 iDHN0ojLiTfYQ5qUzvB5PbbYwPOIdBWZ/nYIGUl8XrBPm3yTMmFDaB6/yht32Zud3GxhKu7I
 NUZ4TvrMgL33phtQv0J6+emhft8gMnX3W8M5Vu3hvma78zy2lnW/CcJ8MtxuS37/wXlkVWTL
 C1tHTsdTE/jEAjpCcZnYGJYFFcSuzaHI/DEq8uQ6I63hmlZ5LQoJD7D1yXby6ACZ8UML/gFQ
 nafq66l/TWNwnJK0Uc2k4tBvEK3YM5n2uCjMa7oRAsZ2aq37wzL+i/EcTUnFKkfxeKUL78Re
 vRALZTz6IRp5X29AIGr9Dg=
IronPort-HdrOrdr: A9a23:IG+LoK14aWJUytkgikk57wqjBIYkLtp133Aq2lEZdPUMSL38qy
 iv9M536faGskd0ZJhAo6H4BEDuexLhHPJOirX5eI3SPjUO21HYVL2Kj7GD/9SIIUSXygce79
 YCT0EUMrHN5C1B4/oSlzPWLz9P+rO6GeuT9IDjJj9WPGdXV50=
X-Talos-CUID: 9a23:lOTLaW8GwLT6EKOyhsmVv2c+EfoIW2fx8Cn7I2qcDzxrTIHMW3bFrQ==
X-Talos-MUID: 9a23:7v01KQYekWzc8OBTji/yowNQPeNSyKXxIgchrKsamOmNDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="218296342"
X-MGA-submission: =?us-ascii?q?MDEnB5+UTa6pDjxkN3kMHL8wVBW+UMcSFPnO9C?=
 =?us-ascii?q?9Mv9VFXzT9cmsVNmj+CMPC4KvhesLOIVLqYffZP5C9KjLfrMSgr+mnwN?=
 =?us-ascii?q?whqmvYOGZEl8SrJhLo1grmsDuNwZDYMHtpYApu1MJu3OAcpO7uzua8oX?=
 =?us-ascii?q?A1Vx1MeJ1PPG6Sl0L2vag+7g=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 12:47:56 +0200
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l4b0009289;
	Thu, 17 Apr 2025 10:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2vUtnJERmDPMRwfb9WPRiqeU5l4lGHI2IYPwOWBEt0Q=; b=FQMLOvU6JaUT+O2F
	Cpxl96N85uMFfEvZs8UsynDIb1V5Lwjftw3Oc2ZQSU/OvMaSc0mkzRxJ75t6lV5K
	uDjRksZzL4zkVR+/HgPTzahrAUDP9ejSfwIYjF+WLYy/opS2litjlIWpd/FTDkI1
	7on2leP6WzcuaHHKipzObOVP10k2s8Zkt7wuYYjH9IqfHjLL5uidf2+5hQB/JGgV
	xcydMZe9+ItMzlPDyKzjUHO+syMnohg+jTewlU7gcWOX333uWtpAxKnyfH9nibkY
	Z5IUvy74PLqVIAxYHk5w0j/C5PhYpsa+VUDKAPXKALKkW5pSU+Q3Tx6FinR/4Mqb
	wLg3Nw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvbuw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HAliWc013807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:47:44 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 03:47:40 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 17 Apr 2025 18:47:12 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250417-field_modify-v3-5-6f7992aafcb7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744886837; l=1186;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=BTrhh55yMb7cCbPZyADxkhifxyh70Jy6fVzDF7gg+Go=;
 b=1gr9ETSiHP3k6QWOSYu135b7vjV0vFrWM2/Ustgl5P5f0ECA/OXVDu3t5wuXJO6lJzCe0zJcQ
 LsIs71XfDeWDAb3/qKUu5c5biObRUw18F/vqMqTSj7RNady0wTT17pv
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g1EP1rhd-Txj9pSSyCiq3labrXcTMZHR
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=6800dc51 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ZOzjf2MOAAAA:8 a=COk6AnOGAAAA:8 a=UT3M8-a78LFy_Dz9DhAA:9
 a=QEXdDO2ut3YA:10 a=1Mhi-5-LkjG4w5oc0yAU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: g1EP1rhd-Txj9pSSyCiq3labrXcTMZHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=719
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170080
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3 5/6] arm64: kvm: Convert the opencoded field
 modify
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2693
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250417-field_modify-v3-5-6f7992aafcb7%40quicinc.com>

Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
- reg &= ~MASK;
- reg |= FIELD_PREP(MASK, val);
The semantic patch that makes this change is available
in scripts/coccinelle/misc/field_modify.cocci.

More information about semantic patching is available at
https://coccinelle.gitlabpages.inria.fr/website

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index ae4c0593d114..946db5b3500f 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -123,10 +123,8 @@ static void vgic_mmio_write_v3_misc(struct kvm_vcpu *vcpu,
 			val &= ~GICD_CTLR_nASSGIreq;
 
 		/* Dist stays enabled? nASSGIreq is RO */
-		if (was_enabled && dist->enabled) {
-			val &= ~GICD_CTLR_nASSGIreq;
-			val |= FIELD_PREP(GICD_CTLR_nASSGIreq, is_hwsgi);
-		}
+		if (was_enabled && dist->enabled)
+			FIELD_MODIFY(GICD_CTLR_nASSGIreq, &val, is_hwsgi);
 
 		/* Switching HW SGIs? */
 		dist->nassgireq = val & GICD_CTLR_nASSGIreq;

-- 
2.34.1

