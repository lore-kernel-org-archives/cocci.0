Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D35C369D7
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h9VplE0QC4aY1gR58x72U5ymrgJrPj0iCMqED0qOjtA=;
  b=QIAprutFPjd81vdG0vT7XR57roXjstcEJx4u+zbfNfU6OA10AfzFl/7K
   fm4LkqnVG7r24+ulvoVhQzK6n/iB/jKEhhi7WDhHb9zaQ0rML1Opg6ANJ
   FV7QqcG2uG8qkEs58QRksDlw7K76T3G1kdvA0EwGywb6s37Nh1I2A60mD
   I=;
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
   d="scan'208";a="219234028"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44D7EE0D44; Thu, 24 Apr 2025 10:55:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9AE08E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 15:16:10 +0200 (CEST)
IronPort-SDR: 6808e819_582ACUL0kq4/lvSZNbxCNuGhQXlDnH1da/d9Gfoyg72Aa+L
 IwqVrw4ZrUoGW6AGIcusgn86sYAJcmjoLKr5lmw==
X-IPAS-Result: =?us-ascii?q?A0FiAgCm5whoe4Oo3M1AGoEJgVOCRH2BDQQLSB2EOIh7h?=
 =?us-ascii?q?lWCJIQ7m1YPAQMBCwEBOQsEAQEDAwGFAAKLLQIeBwEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAUIOO4V7DYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIIYwEfAQEBAxIRF?=
 =?us-ascii?q?QgBATcBDwsYAgImAgJWBg4FAgEBHoJgAYJkAwUMoyVDZypZAYEgQokSAQEBe?=
 =?us-ascii?q?IEygQGCDAEBBoJp2xwDBoEbLohQAYFtg3+EdyeCKIEVJ4EUgW8+gVKGTIJpg?=
 =?us-ascii?q?0iCeIdxk1EJSXscA1ksAVUTFwsHBYEmQwOBDyNLBTAdgleFJYIRgVwDAyODE?=
 =?us-ascii?q?3QchGiEUi1Pgy+BE3BoBh1AAgELbT03CQsbBpcHgTmCMwGBDiyCA5NwgxcBj?=
 =?us-ascii?q?hlooQsNhBiMGZU1BhMvl1qSfZh+jgaVXoUmAgQCBAUCGIF9JIFcTSODN08DF?=
 =?us-ascii?q?wIPji0Wg16BPsAkNjUCOgIHCwEBAwmQHC6BHQEB?=
IronPort-PHdr: A9a23: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
 4YDRvlQU1lnTpsn
IronPort-Data: A9a23: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
 9ViD7XSxKhIFayJ5ICr9A==
IronPort-HdrOrdr: A9a23:pCqlSq0NpmM4aT7LArHUGgqjBBkkLtp133Aq2lEZdPRUGvbo8P
 xG785rrCMc7wxhIk3I+OrwQ5VoJEm3yXcb2+gs1NuZLWvbUS6TXflfBOjZowEIeReRygc178
 4JGMUTZ+EYT2IK6/oSizPIdurIruP3lJxAyd2urEuEzmpRGtNdB1ATMHfmLqQgfng6ObMJUK
 OG4MxJvjyhfmlSQPiaKxA+Lpn+juyOrYnhZxEeAR4h9U2pthOHrJDHMzXw5GZvb9toqY1ShV
 TtokjB/aOkvOi8yhjAk1XL55ATtdf9wttHHoihjcJ9EESetu9tXvUeKsi/lQFwmMuO70sni9
 7Fpn4bTrtO108=
X-Talos-CUID: =?us-ascii?q?9a23=3A6jauXmoQDGAz7B5iyhJSgUbmUe9+UlHblDTgGEC?=
 =?us-ascii?q?XJTZgeIOLdxix34oxxg=3D=3D?=
X-Talos-MUID: 9a23:9RV3EQsM2NtXy0voMM2nmz45OO5wxoeXUn8ptIsEp/i1bz5cNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="114985124"
X-MGA-submission: =?us-ascii?q?MDEh9gvMQdlgkOmPaNdtYIbXvoHZXEoTlF/NH4?=
 =?us-ascii?q?uRcL2CsFNy2dr8jegI9TAoW2t2QrdwdK9e0fXZHejmMivAeS2kVTkSTB?=
 =?us-ascii?q?tMikA1OJx3LzGOQbYba7zjHXWcwz0zhgR4GcK9tYg619pjL6/lOPPzmk?=
 =?us-ascii?q?m1uzKnpqNgwq18vTvvRiyF4A=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:16:08 +0200
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAbjfZ011429;
	Wed, 23 Apr 2025 13:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h9VplE0QC4aY1gR58x72U5ymrgJrPj0iCMqED0qOjtA=; b=epr/TzqLMbjdgAYb
	aqjECcYdB9xHMSlIJEnH+K2nZ9zREtawvRSPctcA4ZNZzuhSSZaWdUoV0GfwQ4Jr
	aqQfCmaeAca7jDw0/6FvtKZYappgVVgIyjImfMpGTpBdttd03vMHfQJR3jXxmoeO
	04vgxOTtGMP43qZNq5K2P8LDMu+KSiCXPMKKvC/JW/wkUqYJmDtYXe+kzxw3Pf4U
	4AJvywUUwVGcPdlJvxkKQSzIIBfKFfZWJroQdU2o8WeOhvSBQ/T7xtJXyfLpDaUp
	wZLpcpnMjS95LKl7uAmalekYmtRla7D78XVrGO9ThwghWxLB52FyXX9HwklWvv3c
	rlMosg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1j87e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:15:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53NDFkAl018230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 13:15:46 GMT
Received: from [10.253.74.233] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 06:15:40 -0700
Message-ID: <2b7ca78e-18f8-41bf-979d-8d502f6f8fe1@quicinc.com>
Date: Wed, 23 Apr 2025 21:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Luo <quic_luoj@quicinc.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Yury Norov <yury.norov@gmail.com>,
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
        Zenghui Yu <yuzenghui@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cocci@inria.fr>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.linux.dev>, <andrew@lunn.ch>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-3-6f7992aafcb7@quicinc.com>
 <aAFEOr_PnZRH2ocR@shell.armlinux.org.uk>
Content-Language: en-US
In-Reply-To: <aAFEOr_PnZRH2ocR@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zr3M8IAXwgtXp3BYAbPXMxX0KvqkQhtU
X-Proofpoint-ORIG-GUID: Zr3M8IAXwgtXp3BYAbPXMxX0KvqkQhtU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5MiBTYWx0ZWRfX7P6/H5f+henI G7IlHjHppUVsUsuEJVmbat7/+Zqx6yiHfDal02OxGIrVvJzemA80dkzmPAEpN5koc02+DO9qDm9 CPrvZqBIocUsJn0VAYfPnk0B+cbFcC/TTx7ajmDiSGX7ymx7H3LtkYPCpGeHGf99yRxo2Yinjf3
 g0c5dPQVZ9SdtSkS227NT/HjMd7vLRRJhl2ne6IbwkrFzybAAa6VLlX+1nW5JoxtYXm6SXoFpd3 VrwGom//9wcah4zQg1ivFK+uU65qUT6ig+HupDy3rwuIo8I3Dd0PDs++zGxu5vSbqvIBihGgIJu rGQ2CYXbxvS09+FkthDdldqx6yDsJ6CM3xdnahX1mjayKJvBzTUq2NxLmJgBagdDnSdCs5EXlbL
 6h0D1rqU2X/CHzQ2o/UAuFgE4/GR/q2EFz55YGzXof4R9QvjoWgDXUQdVlie2gnV7hLLzsJ7
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=6808e802 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=ZOzjf2MOAAAA:8 a=COk6AnOGAAAA:8 a=8k5bqqvh19RxIrhT-ooA:9
 a=QEXdDO2ut3YA:10 a=1Mhi-5-LkjG4w5oc0yAU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=867 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230092
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 3/6] arm64: tlb: Convert the opencoded field
 modify
Reply-To: Jie Luo <quic_luoj@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2712
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/2b7ca78e-18f8-41bf-979d-8d502f6f8fe1%40quicinc.com>



On 4/18/2025 2:11 AM, Russell King (Oracle) wrote:
> On Thu, Apr 17, 2025 at 06:47:10PM +0800, Luo Jie wrote:
>> Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
>> - reg &= ~MASK;
>> - reg |= FIELD_PREP(MASK, val);
>> The semantic patch that makes this change is available
>> in scripts/coccinelle/misc/field_modify.cocci.
>>
>> More information about semantic patching is available at
>> https://coccinelle.gitlabpages.inria.fr/website
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   arch/arm64/include/asm/tlbflush.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index eba1a98657f1..0d250ef4161c 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -112,8 +112,7 @@ static inline unsigned long get_trans_granule(void)
>>   	    level >= 0 && level <= 3) {					\
>>   		u64 ttl = level & 3;					\
>>   		ttl |= get_trans_granule() << 2;			\
>> -		arg &= ~TLBI_TTL_MASK;					\
>> -		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
>> +		FIELD_MODIFY(TLBI_TTL_MASK, &arg, ttl);			\
> 
> This could equally be:
> 		arg = u64_replace_bits(arg, ttl, TLBI_TTL_MASK);
> 
> which already exists, so doesn't require a new macro to be introduced.
> 
Looks like the new macro FIELD_MODIFY() is accepted by Yury, maybe we
can keep to use FIELD_MODIFY() with this change for better readability?
