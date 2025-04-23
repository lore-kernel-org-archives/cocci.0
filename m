Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E36C369D1
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Phbedu7xpyuH5nYJsAMb3poKKBwNLxsZinqwYSuHzUE=;
  b=qDOW3k8pmoUXy3RpC5YoMaXTIBc4G9Acc5pQHTPjUKPdRxTdHRCl9MA7
   /5pb7vNPVof1ykoInK38nqmDTMHbkMyRA9TXmL/FKZV38MhZMajV17v7S
   F/VZDxR6GusOBOx/plORKKmGDvJkkGLCwY8nfGSrlgaKaPnB2qGTSwUuD
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.15,235,1739833200"; 
   d="scan'208";a="219233968"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54A7AE0D1E; Thu, 24 Apr 2025 10:55:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 422C8E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 15:04:42 +0200 (CEST)
IronPort-SDR: 6808e569_3ssPWXbU5h95R/HIyhNnNoYnQZRC9Vgc1sTCY1TGQ5kjNRN
 FRZe4QNWx816X6yuG7TzrpHb0cHgtvABgrZE53A==
X-IPAS-Result: =?us-ascii?q?A0FMAADb4whog4O03M1AGhwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IFCBAEBCwGCQ32BDQQLSAMahDiIe4ZVgiEDhDuYA4FpgWoPAQMBCwEBNBAEA?=
 =?us-ascii?q?QEDAwGEOkYCiy0CHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBATkHSYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQIIBV4BAR4BAQEDEhEECwEFCAEBNwEPCxgCA?=
 =?us-ascii?q?iYCAlYGAQ0HAQEegmABgmQDBQyjGkNnKlkBgSBCiRIBAQF4fzOBAYIMAQEG3?=
 =?us-ascii?q?gUDBoEbLgGITwGBbYN/O4Q8J4IogRUngRSBbz6BUngXBBiBCYQYgmmCMUU+F?=
 =?us-ascii?q?FaBF4JvhDiEVUuCboF5ghF8iBIJSXscA1ksAVUTFwsHBYEmEDMDIAo0FB0CF?=
 =?us-ascii?q?A0QEg8EFgUwHYJXgjBPgiaCEXBsAwMjgxN0HIRohA5ELU+DL4EED3BoBh1AA?=
 =?us-ascii?q?gELbT03BgMLGwaXB4E5gUGCLYFNRiqTNoMYjwGLeJUTDYQYjBmVNQYTL4QDk?=
 =?us-ascii?q?1eSfS6YUCKCNosumwQCBAIEBQIYgX0kgVxNI4M3TwMXAg+OIRmDZ4E+g1WKK?=
 =?us-ascii?q?gGyLTY1AgEBAQssAgcBCgEBAwmQHC6BHQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vRALZTz6IRp5X29AIGr9Dg=
IronPort-HdrOrdr: A9a23:70ziO6hDZBYNIECLuoVvesCj4HBQXnEji2hC6mlwRA09TySZ//
 re+MjzpiWE7gr5P0tQ4+xoWZPwOk80kKQe3WB/B9aftWXdyRKVxcRZnPPfKl7bexEWlNQy6U
 4IScEXY7CdYmSSz/yKhzVQeOxQouVvnprY4Ns2g00dLj2D6MpbnnRE4lHxKDwLeOAQP+tFKL
 OsovNdoTyuYHIWadn+KEUkcoH41q/2vaOjWAUBARE/7gmIkHeP057VVzal/jp2aUI//V8FmV
 K15zDR1+GbqPe8xQbb12jPq65OkN+k59dfDMyIkIw4LT+EsHfZWG2kYcz9zUUIidDq0HwLl8
 TBuBApOq1ImgzsQl0=
X-Talos-CUID: 9a23:FGiqIGx84znzArQKf9JNBgUyMZokYlCBxUvVMm7gOHsxWqDIbV+5rfY=
X-Talos-MUID: 9a23:Mm6NZAryUGUGSZ+GRvAezwE8LMVZ6P2xMh1TssUNmPiFGHdyCijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219110653"
X-MGA-submission: =?us-ascii?q?MDE2cBn2dWU0sBrdyt+J7A+O/rlsYhFXKrvIxN?=
 =?us-ascii?q?gDVNlu7WTK7B5T8nWxceBrC9K+t6g/QoRNeVvTNnT/5u/QhFTDUO2/hk?=
 =?us-ascii?q?WJzpMwiG2pxyV526/dfn912VS9F853qPhKdW2SdaLnfVF0Rfb1REdMRl?=
 =?us-ascii?q?ZLI0THd1uhbJnEDKkT9H0rNQ=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:04:41 +0200
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAIXvJ017291;
	Wed, 23 Apr 2025 13:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Phbedu7xpyuH5nYJsAMb3poKKBwNLxsZinqwYSuHzUE=; b=iahpS7n/F/bDarVN
	E3ZgF4vG03KNPbYQZbzTR7ZVrZ6f7spf+ve30cp9n1a94p3PuxUqi00n3y8lRvvI
	wYeT6TdPvqFQw/elaCyTxG2NvtzNFHv0dqQYUQ7cXRZGTkObQ48IsB+uRVNE4BU5
	GUPowKohVHSJ7erHRx5C6yCDdCjFfHNgdduSisW+buhWeTd/EoBg05mc7CZMJYsQ
	3Nde65fRdfjE+0C300JVsYGeCqGquQfr7QNCB/k95lIugHLJLRhDTN7ddoVKHqwk
	LebYGTZAj84zWJHKJ88R133kfCjcQEZzKNEwLLZMQ8FhtEKfnz/1iN44XnnNHCKb
	QqIohw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3j5y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:04:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53ND4S04016458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:04:28 GMT
Received: from [10.253.74.233] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 06:04:22 -0700
Message-ID: <0ee48e2f-58db-49b0-b651-dcc0e517465e@quicinc.com>
Date: Wed, 23 Apr 2025 21:04:19 +0800
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
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <a1be0efc-a4c9-461d-a01a-8fb830b2c68d@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d1C-_VtA2se0ltPj1-LpCYtqKYl_3Kko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5MSBTYWx0ZWRfX2HoPaNVS9Rs7 skvMbPo1O3/lDaMF3Rx3zRJoaEiSWBgzeVDMxsZJJO2e9jxt8qfRvlI5KD8g0tcaAR5W59oIxT+ HbBNVqMHeINLSNyJEZrhMSINbaakgbrmZ0ZiDWmSNbyHPI+R2LL38UK371n8IX1nZ6zOg0ZrD+I
 qh7h1Y/9oTycKb5NEkF7+MN42ZHOBl0ZLWDEXlfTm4PK2nG48KB76GjHDlzt4mph4wRmXS4D5+4 DNajvL7sbg8WYHwyZ/Eo3L8lzNDzj2dMZFcnpW+ZPWPJ15WlnizmFQKiI1TItPgf57CKGuKUy/5 JP1wSn2OXVEeDpkISxi9dbaxR9IVqixTVflxlExmCrIw93KqGsirZTE/jH8XwEkdbxTJcT9YjLR
 Fs4Cq/DHFYwvzw6HgDHY4XwnEp7yE8FJZj912d+vyIMPObrHmV3lzNcAIIouzKAnJlaIxQKN
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=6808e55d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=ZOzjf2MOAAAA:8 a=Tm5InjWKXzpK7Ii0gWsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1Mhi-5-LkjG4w5oc0yAU:22
X-Proofpoint-GUID: d1C-_VtA2se0ltPj1-LpCYtqKYl_3Kko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230091
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 2/6] coccinelle: misc: Add field_modify
 script
Reply-To: Jie Luo <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2710
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/0ee48e2f-58db-49b0-b651-dcc0e517465e%40quicinc.com>



On 4/23/2025 7:01 PM, Markus Elfring wrote:
>> This script finds and suggests conversions of opencoded field
>> modify patterns with the wrapper FIELD_MODIFY() API defined in
>> include/linux/bitfield.h for better readability.
> 
> See also:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15-rc3#n94

OK, I will update the commit message with the imperative mood.

> 
> 
> …
>> +++ b/scripts/coccinelle/misc/field_modify.cocci
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +///
> 
> I suggest to omit a blank comment line here.

OK.

> 
> 
>> +/// Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> 
> Replace?

I will correct it.

> 
> 
> …
>> +// Copyright (C) 2025 Qualcomm Innovation Center, Inc.
> 
> Copyright: ?

I will fix it.

> 
> 
>> +// URL: https://coccinelle.gitlabpages.inria.fr/website
> 
> I suggest to omit such information here.

OK.

> 
> 
> …
>> +virtual patch
> 
> How do you think about to support additional operation modes?

Sure, I will update the patch to support other operation modes.

> 
> 
> …
>> +- reg &= ~mask;
>> +- reg |= FIELD_PREP(mask, val);
>> ++ FIELD_MODIFY(mask, &reg, val);
> 
> Would you like to integrate the following SmPL code variant?
> 
> -reg &= ~mask;
> -reg |= FIELD_PREP
> +       FIELD_MODIFY
>                    (mask,
> +                  &reg,
>                     val
>                    );
> 
> 
> Regards,
> Markus
> 

With this code variant, there is no space prior to &reg, here is the
example code changes generated by the SmPL code as below, is this
expected?

Thanks for the review comments.

--- a/drivers/phy/starfive/phy-jh7110-dphy-tx.c
+++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
@@ -244,8 +244,7 @@ static int stf_dphy_configure(struct phy
         i = stf_dphy_get_config_index(bitrate);

         tmp = readl(dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
-       tmp &= ~STF_DPHY_REFCLK_IN_SEL;
-       tmp |= FIELD_PREP(STF_DPHY_REFCLK_IN_SEL, STF_DPHY_REFCLK_12M);
+       FIELD_MODIFY(STF_DPHY_REFCLK_IN_SEL,&tmp, STF_DPHY_REFCLK_12M);
         writel(tmp, dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));

