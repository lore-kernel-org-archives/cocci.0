Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF4DC71143
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3fXWGiDGcxviW1fGNoR2ruND6LCNBMbPtWe2+G2nYOo=;
  b=JEuDlfk6kS3u5Zjv6nB9MZWgvRpSZLjboyisQu64mqaVz1NE4GRQdNw8
   oS4TIxn9j9BuN5wDq/jHyJXoGXNSuYrrvUA5SV6RpFfQe3yJ61gxZMu/u
   Hnr545Uy+AjqoU89JLbTtM2KPqp0Y79Vt8BAtjtDCxgtVVSj/YQkd4huP
   0=;
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
   d="scan'208";a="226895885"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 349FFE02E4; Thu, 12 Jun 2025 15:49:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B9CE9E0131
	for <cocci@sympa.inria.fr>; Fri,  6 Jun 2025 07:33:53 +0200 (CEST)
IronPort-SDR: 68427dc1_OGpeHg8CxhfueULLy5I63Jb7uZRUYPfeWv/7Y2E+ZwRzQs6
 rrgpKeh5y6xO+4MooyeQXPsyp+sn2/jjp4KFWfw==
X-IPAS-Result: =?us-ascii?q?A0HRAQA2fEJog4O03M1AGh4BAQsSDECBSAuCRIINBAtJH?=
 =?us-ascii?q?YQ4iHuGVYIhA4Q7mVuBfQIPAQMBCwEBUQQBAQMEhQACi2ICHgcBBDIHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBATkHSYV7DYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAghjAR8BAQEDEhEPAQUIAQE3AQ8JAhgCAiYCAlYGA?=
 =?us-ascii?q?Q0FAgEBHoJggilGAwWRTI4oQ2cqWQGBIEKJEgEBAXiBMoEBggwBAQbeBwmBG?=
 =?us-ascii?q?y6IUAGBbYN/hHcngiiBFScLgng+gVKCOIQUgkcigz6BQIhNgwiFHI5FCUl4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIBAzAyo0MSNLBS0dgg2CLU+CHR+Bc3BsAwMWDwGEAhyEY?=
 =?us-ascii?q?oQDRitPgyKBAw9tZUGDXxENBnQnQAIBC209NwYDCxsGmR2DPC0GAXsTAYJKH?=
 =?us-ascii?q?qM3gh2fUIE+DYQYoVgGEy+EBJNbkwKZBCKCNqFAhHUCBAIEBQIYgW8FLoFcM?=
 =?us-ascii?q?xojgzdPAxcCD44hGYNnt0I2NTwCBwEKAQEDCZAXNC6BHQEB?=
IronPort-PHdr: A9a23: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
 vEekxZ/auUr/3Hn5FJlfzL3
IronPort-Data: A9a23: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
 9VsD7UD6Jy5FX1s
IronPort-HdrOrdr: A9a23:DIvMXq3fU47jJ2Pg2fL/TwqjBBkkLtp133Aq2lEZdPRUGvbo8/
 xG785rsyMc7wxhIk3I+OrwQ5VoJEm3yXcb2+gs1NuZLXDbUS6TXflfBOjZowEIeReRygc178
 4JGMUTZ+EYT2IK6voSizPIcerIruP3lZxAyd2urEuEzmpRGtNdB1ATMHfmLqQgfng6ObMJUK
 OG4MxJvjyhfmlSQPiaKxA+Lpn+juyOrYnhZxEeAR4h9U2pthOHrJDHMzXw5GZsb9toqY1ShV
 TtokjB/aOkvOi8yhjAk1XL55ATtdf9wttHHoihjcJ9EESdtu9tXvUeKsi/lQFwmMuO70sni9
 7Fpn4bTrtO108=
X-Talos-CUID: =?us-ascii?q?9a23=3As8a4AGiE0bIOXCOY68cRjAAGMTJufkXAlGv5Dle?=
 =?us-ascii?q?DLWdwVriPZW6x+4x/jJ87?=
X-Talos-MUID: 9a23:xA9smwX+g9OGFf/q/Dzc3AxIKp5p2py3M0ZOyZ8mmfGaBDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="225577116"
X-MGA-submission: =?us-ascii?q?MDFnvIXaJ6LCaDSEiDJiBb69Jn4S0Ndzq5kv1G?=
 =?us-ascii?q?jIfPUfrdcZD3h82y7rv2k36ysqZAzXZOoFZiFbsgxH0vxwBBAGGCnmup?=
 =?us-ascii?q?PZwjwBwpEC921rF5XAZQcZaOf4VW/866VtCzgbbWLs2f0L0sFX3tPGhZ?=
 =?us-ascii?q?oubnE+gLzymgj88ukloGqm8Q=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 07:33:53 +0200
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555H44dg000905;
	Fri, 6 Jun 2025 05:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3fXWGiDGcxviW1fGNoR2ruND6LCNBMbPtWe2+G2nYOo=; b=GfAPyq0kYu2RL4oW
	xjCLyhCE4D7Wh3PbVBc0I4prWGdAwD6Kc1eNfA40rfwQNkWGinfeAWHik5fcGtu/
	oFKIOZjRx0bIW2M0+gmG7bCJ3r9Um715VBQsPe3zNyw+Njxpvs7K0k2guiwdpjSZ
	OnFLym7wiL9Up+3PFN3zGF6/DscK4QdBtfRAjH44Uwhiorfm7zN/qJqx378sY4Fg
	cuAjHUn1jorHkSAhL5wjauaY84Wo0PZIE0TyKUMnkVVuu1D/9aswdFET5mGVBptn
	v1ctJwgB8CLwxTVEzZXnHIYZkYIdleTJm4EjEJ8qnLkdUeIBhZJGmHsoQT2J8HAZ
	gKdeMw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8qbjyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 05:33:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5565XhtK027289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Jun 2025 05:33:43 GMT
Received: from [10.239.133.242] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 22:33:41 -0700
Message-ID: <10e5207e-353e-4648-8e8d-6ee38d14907f@quicinc.com>
Date: Fri, 6 Jun 2025 13:33:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall
	<Julia.Lawall@inria.fr>, <cocci@inria.fr>
CC: <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <quic_jinlmao@quicinc.com>
References: <20250605044405.2057511-1-quic_songchai@quicinc.com>
 <e8221cc5-cf5b-49f8-871d-e49d6621fc6e@imag.fr>
Content-Language: en-US
From: Songwei Chai <quic_songchai@quicinc.com>
In-Reply-To: <e8221cc5-cf5b-49f8-871d-e49d6621fc6e@imag.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kv9s_mcjB24Xqulvs4uzK8jhNFLf81Nx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA1MCBTYWx0ZWRfX2FtfBsIFWyYO
 WHvTaOcQGmaSc5W53cvx5lzDd8WoSiMQH/8P/EhZPD+dAQaM7h4IexaPmyKv7h81LfK4m/cP3jV
 W7XuKcIw5Go2Vwp1YE3KPraDSN5WaMz63XNZPoc8PlM5W7UQ0wVZnOiVf2GCVK4nwnDciiOfEXA
 Dxtnbum+4jk2x376z1NOnQRf/XlAwOLMSSme8PICuy1X1fXR9mtFP6OETAYJprikclxyskY1FpC
 cF9/rzOQG5zr0Uh8+FlgRTF7bZG+g69O+eqV/Y/yL5Gy2xczvKubRg893Szle3FH4+WNuVMaBL5
 KKE9z2I1w6gN2zB0iY5N46dAKKLFP092QOISMiwVoFiBjqzFEzRX9G6wH3rIL7Gr05VVo0CeUkx
 nEH8c0H21sfL3s/4lu8zeYq2FJChEcQe+PhTbP28Aifk05eSmjS1BasRDwykrDf3kCWaF5zs
X-Proofpoint-ORIG-GUID: Kv9s_mcjB24Xqulvs4uzK8jhNFLf81Nx
X-Authority-Analysis: v=2.4 cv=PrmTbxM3 c=1 sm=1 tr=0 ts=68427dbd cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=sPnlxz4oxlKK5PFXHyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060050
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v1] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Songwei Chai <quic_songchai@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2766
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/10e5207e-353e-4648-8e8d-6ee38d14907f%40quicinc.com>


On 6/6/2025 1:43 AM, Nicolas Palix wrote:
> Hi Songwei,
>
> Le 05/06/2025 à 06:44, Songwei Chai a écrit :
>> Enhance the coccicheck script to filter *.cocci files based on the
>> specified MODE (e.g., report, patch). This ensures that only compatible
>> semantic patch files are executed, preventing errors such as:
>>
>>      "virtual rule report not supported"
>>
>> This error occurs when a .cocci file does not define a 'virtual <MODE>'
>> rule, yet is executed in that mode.
>
> I am fine with the idea even if the orignal idea was to be exhaustive 
> in the implementation of the mode in each SP.
>
> However, silently discarding the patch is maybe not what one would 
> expect as the considered SP will vary according to the mode.
>
> Hence, could I suggest to add an else branch reporting a warning at 
> least ?
>
> Regards,
Sure, will update patch with else branch reporting a warning.
>
>>
>> For example:
>>
>>      make coccicheck M=drivers/hwtracing/coresight/ MODE=report
>>
>> In this case, running "secs_to_jiffies.cocci" would trigger the error
>> because it lacks support for 'report' mode. With this change, such files
>> are skipped automatically, improving robustness and developer 
>> experience.
>>
>> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
>> ---
>>   scripts/coccicheck | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index 0e6bc5a10320..18a69edcea66 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -270,7 +270,9 @@ fi
>>     if [ "$COCCI" = "" ] ; then
>>       for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' 
>> -type f | sort`; do
>> -    coccinelle $f
>> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
>> +            coccinelle $f
>> +        fi
>>       done
>>   else
>>       coccinelle $COCCI
>>
>
