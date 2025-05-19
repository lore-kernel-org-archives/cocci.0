Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B267C2D0CD
	for <cocci@archiver.kernel.org>; Wed, 21 May 2025 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PdV8uO80/mflHpZW6Zmyg39cv5SMy1ND2QAP2t8eHzY=;
  b=CoF/wUSJMTMs6TSSXNy/G2p+sCAWrdSkAvoMiQlhlaIZNPHfaYqAc3EN
   9y7AUdn6MMPF3szE9dHesbeVPzCCMxXBwbN1gmVKy2DIyQHEPq15y6d/q
   rdwqdlBKdZ//uBxT93/ywI1+mTuzXg0WEMXbduX+3f2LCdXoG3pM+Yshv
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223196920"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2025 15:51:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9BC37E0AF6; Wed, 21 May 2025 15:51:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 16028E0131
	for <cocci@sympa.inria.fr>; Mon, 19 May 2025 15:44:45 +0200 (CEST)
IronPort-SDR: 682b35cc_gxRoDHWkLjXM/+rTkdOe7SMh3ivKDT6rernC6d9BWNfIhH5
 0NebB5BM+nBs2jNTJAPCDNjwhlAlNt5IbpRfWEQ==
X-IPAS-Result: =?us-ascii?q?A0E7AAB4NCtog4O03M1AGh0BAQEBCQESAQUFAUCBQQYBC?=
 =?us-ascii?q?wGCQz8/gQ0EC0kdhDiIe4ZVgiSEO5gGgVWBfg8BAwELAQE9FAQBAQMEggyCL?=
 =?us-ascii?q?kYCi00CHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBATkHSYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAggFXgEBHgEBA?=
 =?us-ascii?q?QMSEQQLAQUIAQE3AQ8JAhgCAiYCAlYGAQ0HAQEegmABgiJKAwUMk36OKENnK?=
 =?us-ascii?q?lkBgSBCiRIBAQF4fzOBAYIMAQEG3gcDBoEbLgGITwGBbYN/O4Q8J4IogTyDA?=
 =?us-ascii?q?z6BUoEPAoU7gmmCL0RSjRqRfwlJexwDWSwBVRMXCwcFgSYQMwMgCjQUHQIUD?=
 =?us-ascii?q?RASDwQWBS0dgg2CLU+CHYIPcGwDAxYQgxNzHIRmhARGK0+DJIEDD2xlQYJ0Q?=
 =?us-ascii?q?AIBC209NwYDCxsGl32DZntGInaXc48DoQ0NhBiMGpU4BhMvl12Sfy6YUyKNZ?=
 =?us-ascii?q?ZVfGIUOAgQCBAUCGIFuATOBXE0jgzdPAxcCD44hGYNnjz0Bt202NTwCBwEKA?=
 =?us-ascii?q?QEDCZBYLoEdAQE?=
IronPort-PHdr: A9a23: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
 UtmTYnuomwz/fDvz0bP8pLFO2z2c99lv42Xgd4=
IronPort-Data: A9a23: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
 vSRD6ACOXm4
IronPort-HdrOrdr: A9a23:eUPL/6x2VNn3O+JCeN5oKrPwT71zdoMgy1knxilNoH1uGPBw+P
 rCoB1273PJYVUqM03I5+ruBEDoexq1yXcS2+cs1NyZPTUO1lHJEL1f
X-Talos-CUID: 9a23:cKRRuGGaAEVwiXsfqmJm+2AyP8t/XkTHyVz0fnekA3p0Fpm8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ArqEhZw1Ya1INXOT9YKIa2aUYrzUjuIuCJnsjr4o?=
 =?us-ascii?q?6qZffKQsuHxeGpwS5Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,300,1739833200"; 
   d="scan'208";a="222785333"
X-MGA-submission: =?us-ascii?q?MDHtGOP3BJp+WVeFQbWprqkhnRnQheGUBKZC5u?=
 =?us-ascii?q?cDXJVfm4uXdfrc6gFBtWOyx5kENnUbXpcvH6K4wkpxO8L932qdJhqyew?=
 =?us-ascii?q?J9828KS6m5xiW/cmnsFsDHb6m9gYXSO6/qx9SoaeHcnliooKhivQoL55?=
 =?us-ascii?q?KW6xGf78/LfP0mbnn2JpHVjw=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 15:44:44 +0200
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9IUfw028604;
	Mon, 19 May 2025 13:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdV8uO80/mflHpZW6Zmyg39cv5SMy1ND2QAP2t8eHzY=; b=prEs2AZG6sM1zEGe
	VlkKyMnGGYxkLQMT3wdOmMthss1lBfNyEtDD15+kpRauYm9ctxxE1rtGyBG7Fv0f
	7mJCkiJOnbNqwy/6kx5b3EJw/fdr4USRKjSBQQZQ0jHR3qMi+DE0bCsRrQ4toQWM
	XQpE8v6IZupkHpPDe9Et6SnwT6edFLhvkgEDwG+tYmfYg686FX3HielgtSb5ymMw
	H/6iWbGkmnrSAkUBtyDQyIUB5N69MUsS4VuPSWbwetCUd2aJT9KZy84qdFiXZdPk
	mqWtVNNGCrWJyKA02Gb/R93mSzgTlfhvNmEC0JXDbA8nvT4pFil22EVufRp+SY2P
	LCv/Dw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pju7cgmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 13:44:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54JDiVn1028686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 13:44:31 GMT
Received: from [10.253.10.117] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 May
 2025 06:44:23 -0700
Message-ID: <1e3ba498-2bfb-4cab-ba13-5ab2c5b03ef9@quicinc.com>
Date: Mon, 19 May 2025 21:44:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        "Julia
 Lawall" <Julia.Lawall@inria.fr>, Marc Zyngier <maz@kernel.org>,
        Nicolas Palix
	<nicolas.palix@imag.fr>,
        Oliver Upton <oliver.upton@linux.dev>,
        "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>,
        Suzuki Poulouse
	<suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Yury Norov
	<yury.norov@gmail.com>,
        Zenghui Yu <yuzenghui@huawei.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "Kiran
 Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
        Lei Wei <quic_leiwei@quicinc.com>, Pavithra R <quic_pavir@quicinc.com>,
        Suruchi Agarwal
	<quic_suruchia@quicinc.com>,
        <quic_linchen@quicinc.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-2-6f7992aafcb7@quicinc.com>
 <a1be0efc-a4c9-461d-a01a-8fb830b2c68d@web.de>
 <0ee48e2f-58db-49b0-b651-dcc0e517465e@quicinc.com>
 <43712874-6f1d-435c-98b2-30ac44d25309@web.de>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <43712874-6f1d-435c-98b2-30ac44d25309@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=XKEwSRhE c=1 sm=1 tr=0 ts=682b35c0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8
 a=c3S3xlzBOW1yjAwqZsgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DDx5Kpyrf6pBeNUIV-O76BAavKioXic-
X-Proofpoint-GUID: DDx5Kpyrf6pBeNUIV-O76BAavKioXic-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyNyBTYWx0ZWRfX8LBxompbvgoH
 3i7uWyfrxx5T3Tfgsvy7ubiVJ6v1qhIGwf4jf/Xj3Xy1N8bv6dH9EU/v4+YK8hk3EOZKpGwsXpO
 zKPXnFqYrqWOXyiJzvXGm6Lg+ocGxkUpkTDXJZ/O5AXvVsS8FpVHPcnvp90SgtTIkcdhMEupjQ2
 uOj/n9xXrmiGEGLnLbuK3/1L9NHPSOpmoaK3yrzHw6a5A4PoIXXRCzpq8QAa9ZmTuW4GdgZaAci
 EHCwTjF+Lk7iDIzSmtS2qgKhzHtqhTC9bWvgCDe3sDRnz3V+dDqppGyupxR8VK2WXx2IejHyv8w
 JFBhRBjRDa880TK7422aleYlIMa6BgheyGcrQ8t5EswA8UqaJ1amugbbjV7lOzAkyz96FklOAvx
 XIva8OfJHDHpw248ZP7AXaRVN54826XqkLx8ayhxETvYMM/RYgIieue2XoBPYKPK+9fivQ+l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190127
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 2/6] coccinelle: misc: Add field_modify
 script
Reply-To: Luo Jie <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2747
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/1e3ba498-2bfb-4cab-ba13-5ab2c5b03ef9%40quicinc.com>



On 4/24/2025 12:35 AM, Markus Elfring wrote:
> …
>>> -reg &= ~mask;
>>> -reg |= FIELD_PREP
>>> +       FIELD_MODIFY
>>>                     (mask,
>>> +                  &reg,
>>>                      val
>>>                     );
> …
>> With this code variant, there is no space prior to &reg, here is the
>> example code changes generated by the SmPL code as below, is this expected?
> …
>> +++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
>> @@ -244,8 +244,7 @@ static int stf_dphy_configure(struct phy
>>          i = stf_dphy_get_config_index(bitrate);
>>
>>          tmp = readl(dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
>> -       tmp &= ~STF_DPHY_REFCLK_IN_SEL;
>> -       tmp |= FIELD_PREP(STF_DPHY_REFCLK_IN_SEL, STF_DPHY_REFCLK_12M);
>> +       FIELD_MODIFY(STF_DPHY_REFCLK_IN_SEL,&tmp, STF_DPHY_REFCLK_12M);
>>          writel(tmp, dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
> 
> The Coccinelle software is still evolving somehow.
> Thus your test result can trigger further development considerations.
> I hope that clarifications and corresponding improvements can be achieved
> also according to such source code layout concerns.
> 
> Regards,
> Markus

OK, understand. I will keep the original patch as below for now, as we
need to ensure the script generates code with the expected style.
+- reg &= ~mask;
+- reg |= FIELD_PREP(mask, val);
++ FIELD_MODIFY(mask, &reg, val);

In addition, below case is filed to request this improvement on the
coccinelle project.
https://github.com/coccinelle/coccinelle/issues/397

Thanks.
