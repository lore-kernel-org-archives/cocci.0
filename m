Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6041AC369AB
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dbiIO3r1xFAtnDUD174p9j71UWbTGBeWLa/ZZ2MHI7s=;
  b=fu8KiIDGkkaNWEIAXDdvpl/tUQWw5MCiWG3A/mdDn5HU9+HKYAUnb6a4
   oqU1zwBoZAc4QbPcNVo6I++aAeH2uztVLQXdE9RQFPOmTelIYaBX0Syx6
   WL8mza4rzJpECD4f7Q1kykfFfJqTJrMLqb0Go6FXT4FTgp7KgPOc7/2nB
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.15,235,1739833200"; 
   d="scan'208";a="219234010"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EEFE3E0D3F; Thu, 24 Apr 2025 10:55:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59A86E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 15:06:11 +0200 (CEST)
IronPort-SDR: 6808e5c3_NMvLlIZd8AE5DCYdwWIUrtmDaDWgGoOUjVOkcIErfBEjaYG
 WwZiWf50KJsPXOajnfwLVvGLqfFgiq2A7EHrVMA==
X-IPAS-Result: =?us-ascii?q?A0HyAQBK5Qhog4O03M1AGh4BAQsSDECBSAuCRIIKBAtIH?=
 =?us-ascii?q?YQ4iHuGVYIkhDubVg8BAwELAQFEBAEBAwSFAAKLLQIeBwEEMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBOQdJhXsNgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CCGMBHwEBAQMSERUIAQE3AQ8LGAICJgICVgYOBwEBHoJgg?=
 =?us-ascii?q?mUDBaM7Q2cqWQGBIEKJEgEBAXiBMoEBggwBAQaCadscCYEbLohQAYFtg38bh?=
 =?us-ascii?q?FwngiiBPAuCeD6BUoZMgmmCMUVSVoIigWSEOIFVg0uCboQ0iGQJSXscA1ksA?=
 =?us-ascii?q?VUTFwsHBYEmQwOBDyNLBTAdgleFJYIRgVwDAyODE3QchGiEUi1Pgy+BE3BoB?=
 =?us-ascii?q?h1AAgELbT03CQsbBpcHiB6WFI4ZaKELDYQYoU4GEy+XWpJ9LphQo1YNhScCB?=
 =?us-ascii?q?AIEBQIYgX0kgVxNI4M3TwMXAg+OIRmDZ8FnNjU8AgcLAQEDCZAcLoEdAQE?=
IronPort-PHdr: A9a23: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
 57XjKL0MytP/5Tf+s5OX6Dp
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:kAW096oe5EYl7N+AM5Y0qdgaV5qAeYIsimQD101hICG8cqSj5q
 eTdYcgpGbJYVEqKQsdcLG7SdK9qBbnn6KdjrNxAV7PZniFhILsFvAb0WKA+V3d8k/FmNK1vJ
 0IG8MSZLLN5BpB/KDHCWKDYrMdKbe8gcSVbKvlvhRQpYIAUdAT0+8vYTzrbnGeEzM2eKYRJd
 6k/cxAqCOneXMLKuqGJlRtZZmym/T70Kv8ZxgIHhgm7xTLqwiJxvrVLzi0ty1uIA+m598ZgB
 z4uj28376ktf6jzB/ayivo9pxT3Pbs19NCAdbJps8eQw+c+zpAoL4RJcz2gBkF5NmEyFE2nM
 LKqxJIBbUN10/s
X-Talos-CUID: 9a23:YxhWjG4G06OBvp8lN9ss2xMJHMEXQ0bn1ljIDG2hIH10bp6+RgrF
X-Talos-MUID: 9a23:5VpXeAit0+dRct8bH6P4jsMpK/lz2PueEGk2mJgklNKNLTViYg28k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219111034"
X-MGA-submission: =?us-ascii?q?MDHCwljbezOSZ+t6sIaPOVwOSG8uWbJwJLforR?=
 =?us-ascii?q?p9WWipIVYpRcPy3hOOCwCl2AG9Argp1/5ag4SSuntlOx82Qt16+ASEaG?=
 =?us-ascii?q?cxtu0XuOiffq0Gd6SCAc+7E3YEBeyc5lJl2RjGYMMIYIwzRYBpf0tGDC?=
 =?us-ascii?q?euxnlV86dmrJtLa/PRu1lYaA=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:06:10 +0200
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAbfrI003028;
	Wed, 23 Apr 2025 13:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dbiIO3r1xFAtnDUD174p9j71UWbTGBeWLa/ZZ2MHI7s=; b=EGU1V1RoPpwTV0Dk
	HtZuXkiX6YSS+gkHqMVgolOvgdsC77YqlkSZRSFMt2SznYLQ6/3DjUf1HAuK90bL
	ghxCtT1U82C4Aj17XPCcka0NbFrM3sVBfsqO25GTNy9p7OxVQ31KuOQ6NJElm+Kg
	0HBuwiWU/9Y/We/WCijRC8/6VJkw53orwUz3ID8JKeCT0cUpH5VOvg/Ed7+8Scej
	FGXtqp0BmVycauebqUquqWHYiY0Hu6scLD2utCGX6ZHsC6wOmjpGLixYrPl+3s3m
	KlOp49MS7EBxFjWaJBRgljOVaUlvAqaxzmHto1kFLQuVbLEmMUEnNF2UWQ2RUe8e
	NNp7/w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jgy26fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:05:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53ND5tvn030684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:05:55 GMT
Received: from [10.253.74.233] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 06:05:50 -0700
Message-ID: <968d21dc-437e-4909-bca8-fac4402f515d@quicinc.com>
Date: Wed, 23 Apr 2025 21:05:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Luo <quic_luoj@quicinc.com>
To: Yury Norov <yury.norov@gmail.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall
	<Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Joey Gouly
	<joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu
	<yuzenghui@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cocci@inria.fr>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.linux.dev>, <andrew@lunn.ch>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-1-6f7992aafcb7@quicinc.com> <aAKH37xa1brIAXfs@yury>
Content-Language: en-US
In-Reply-To: <aAKH37xa1brIAXfs@yury>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5MSBTYWx0ZWRfX4TP2GyrZl2bD j6o5xqwG5uolOPgkZM7X1CKnS3GuJhM7tmWZix521YhiWNBerHYtIC/RZvjJiA++wdsHc6KXOGt feGfqf4d6AripWWplDXnKv7Oypre9uFe4B6+sMxjpyPEJl2LijTok5gAwh2Det6EPBt3J2sdRQ8
 Zc8IjH8SKi/vzkFTVXm3+VeegMXCT3hBOwUKIbP2Md5+fKa9ILG31larC7qKAC2cfmKmRiiBPn9 DQgTD61eDfJQwnBWaWcnY5bsTWG8thxvLzKduoFuysR+TcbBDSJ8UC0pU8vg5utqoo6D8kE6UIn svdbAbkln7Bg5GnhWhlR4/HuSqTNcfi7ZZGVV5mexmUnPlV8Bj+HSg1lcTjU9bXj+Lx1mQ3AgjG
 UWl+1TbHzvTDaHFvaAZyVaYBtDl7P3lK5bCmdPezLva7IedogMgr39gBX9hg71Hb9AO4au6u
X-Proofpoint-GUID: R4LFE6L8_KJPKtN4i2COLAGKmLFNWmG9
X-Proofpoint-ORIG-GUID: R4LFE6L8_KJPKtN4i2COLAGKmLFNWmG9
X-Authority-Analysis: v=2.4 cv=M5VNKzws c=1 sm=1 tr=0 ts=6808e5b4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=UqDml5D6FPZDCTgpU1gA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=928 malwarescore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230091
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 1/6] bitfield: Add FIELD_MODIFY() helper
Reply-To: Jie Luo <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2711
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/968d21dc-437e-4909-bca8-fac4402f515d%40quicinc.com>



On 4/19/2025 1:11 AM, Yury Norov wrote:
>> Add a helper for replacing the contents of bitfield in memory
>> with the specified value.
>>
>> Even though a helper xxx_replace_bits() is available, it is not
>> well documented, and only reports errors at the run time, which
>> will not be helpful to catch possible overflow errors due to
>> incorrect parameter types used.
>>
>> Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
>> macros. It is functionally similar as xxx_replace_bits(), and in
>> addition adds the compile time type checking.
> This paragraph duplicates the above. I'll drop it and take this
> patch to bitmap-for-next. Regarding the rest of the series - it's up
> to ARM64 and Cocci maintainers if they want them or not.
> 
> Thanks for the work!
> 
> Thanks,
> Yury

OK, thanks.
