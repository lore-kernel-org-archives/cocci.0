Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845BFCCF9E0
	for <cocci@archiver.kernel.org>; Mon, 27 Oct 2025 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:message-id:date:mime-version:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JV5F2mfcXjbp0Yn0zNkEW2lY+742MXru0QGn/jvHbOo=;
  b=YGrkinTgNsUN+Eh3aCvW3oh4nQZPLzYMHBPTIMfmlswdgBIeIMRfLg4d
   PwgKuBTrzYghL8jx4nDOf4zmgnJBSO1E0aRdwWxBo0t45iO3vb1vNxIOo
   rHEGFOGEv+gnH27TZwO/seRn5O25XDrjHBW+8BKazLsxDKcp6SkcWsV0t
   A=;
X-CSE-ConnectionGUID: 3OV/PWOhRTyxAkIcc+FaMQ==
X-CSE-MsgGUID: KHh2dHunQySCZhPprWp5gQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@qualcomm.com
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="246269340"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2025 10:40:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C7669E0B0D; Mon, 27 Oct 2025 10:40:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 184CDE0171
	for <cocci@sympa.inria.fr>; Mon, 27 Oct 2025 03:41:48 +0100 (CET)
X-CSE-ConnectionGUID: KmODrfs0T0ifW0uZSHCfKQ==
X-CSE-MsgGUID: dA0gziP/SyGI30mqcgQCCg==
IronPort-SDR: 68fedbeb_9+As+RongWbl9GGWhtU0+KrdNBBOs4v39VofcOq3hISx5CN
 7Sjy7C4EQCwIbUV9GXZ6kDJ9PT4SPOL6wTe9Pcg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GQBQAP2/5oe4O03M1AGoEJhBCCEwQLSYRViHuGV4IhA?=
 =?us-ascii?q?4Q7mAqDFT0CDwEDAQsBAVEEAQEDBIUAAoxOAh4HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQFCDjuGTw2CYoElXkgBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEUAg1eAR8BAQEDEhEPAQUIAQE3AQ8JAhgCAiYCAjMBB?=
 =?us-ascii?q?QEcBgESAgEBHoJggipKAgGTY44pQ1USKkkQATFvQokSAQEBeIEygQGCDAEBB?=
 =?us-ascii?q?twlgWQJFIEILoVtgmQBhWw7hD0nD4FVRIEVJ4MDPoFSgjiEFIJHIoImgQ6GJ?=
 =?us-ascii?q?4J2iDMGhklSeBwDWSwBVRMXCwcFgSAQMwMqNC0jSwUtHXMMKBIQHxAIEWBUQ?=
 =?us-ascii?q?INJGwZoDwaBEhlJAgICBQJCOoFoBQEcBh8SAgMBAgI6Vw2BdwICBIIbfoIjD?=
 =?us-ascii?q?4gFAgELbT03BgMLGwY9k32CRi0GAXsTAYErgRMMHqNCgh6LepNZgQo0B4Qfg?=
 =?us-ascii?q?V4GDJ9sBhMvhASNE4Y7FJMFmQYio3+EdQIKBwcRJIFbI4FcMxojgzdPAxkPk?=
 =?us-ascii?q?iHGPTc0PAIHAQoBAQMJkWo0gUsBAQ?=
IronPort-PHdr: A9a23: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
 oE6bkOQXEcqyf2aEBFbbaL/
IronPort-Data: A9a23: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
 4QqbTgsfXxXgnId3Sqtl7C51f3ZUP7SI+0UUBqy
IronPort-HdrOrdr: A9a23:+wWp9Ki8n3jKkpRVM5kpdiIP0nBQX5h13DAbv31ZSRFFG/FwWf
 re48jzpiWE+Qr5P0tQ6+xoWZPwMk80kKQe3WB/B8bbYOCLghrOEGgm1/qT/9SCIVyEygc+79
 YYT0EWMrSZZjUX/KLHCUuDYqgdKbK8gd2VbInlvgtQpE1RGttdB4QTMHftLmRGACZBHoQwD5
 eR645qoDC6aW0LYsnTPBc4dtmGidmOupyOW3477t0ciTVmTwnG1Fa/fiLouCv2nwk/o4sKwC
 z9iAr+6byks/anjjHh90K71eUjpPLRjuJZAsqCk84ULSiprD2JSsBOZ52u1QpF1d1Gzj4R4Z
 HxiiZlBt907XzJeGGzvF/WwgHllBsj9nfjzEXdrXzoyPaJMg7Sz/AxzL6xuyGpiDtEgO1B
X-Talos-CUID: 9a23:N0b8U268mxYcNv0NT9ss10szNtoraSXhlHbeHBelO11JY7O2cArF
X-Talos-MUID: 9a23:5BEvUAURzmDC3ifq/DPF3D5wNf8v2LWBKRtVlIwNtPCvHiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="129171760"
X-MGA-submission: =?us-ascii?q?MDGvH6LrWG1iJhBQw8IOm9NBiHuJt3NqOYS3sh?=
 =?us-ascii?q?xfKo6DCReAEkflJ1lgQ36RDZ0QPL59MPb1g9XIlYEjTHlCLuHik7MVnd?=
 =?us-ascii?q?blsIsqhv6WMPJEw6jmmlDSg6Gufw9wE8gkvsGAcdErXxdguHboxVfWtS?=
 =?us-ascii?q?QMhlvrjF82vleGHR8C35gaAQ=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 03:41:47 +0100
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QNGZBr1011806
	for <cocci@inria.fr>; Mon, 27 Oct 2025 02:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JV5F2mfcXjbp0Yn0zNkEW2lY+742MXru0QGn/jvHbOo=; b=Bg6xkrgkAkMijxGM
	Sh7izWP93gHnZkwct7lHnjjYh7wWsRujrd5iZoPQbDiooSfdUBUuWdp+kEiQiLis
	3XsqlOlbF4t7Ozp1txnRX2Dobu/mK8s++PKYAYNzSCfPzFqkiiXaRBQVTnGTShH8
	OJIgPeR17U2yQFjXbWRJcBOfkiaOI2oXNQvXNoUPs40Lhr5NcKZcYfgnTUX9iYRI
	fz09g6JKO/MumbC1vhVqP6z3N8b4fsm3pcZ0LTDfkAlJTm4rriL+VqvETBJo22Km
	pHMwLdSt8ZT4SG8RjRqbpHttEg3s6Wxaie93ZW1QLOMozOvp7c6GjQGsqsA+1YAy
	8XZgvQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4waysu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <cocci@inria.fr>; Mon, 27 Oct 2025 02:41:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bdd0479a9so4179592a91.2
        for <cocci@inria.fr>; Sun, 26 Oct 2025 19:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761532903; x=1762137703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV5F2mfcXjbp0Yn0zNkEW2lY+742MXru0QGn/jvHbOo=;
        b=QiXrsp0tT+sFgd4rIysj9qyB1NOHNM9Aweo6DPxrr87RBuEgBjHBOyGlc6PF0CCPMn
         Ae87WYhuXGEZWrII/C+4jXqxezVQrUDiMTSzaZzss3Z4hApAQ3J8DkN6LK0iEyos6p+w
         S3DeT9HH1nBTyhqfPWD50rgoIJ51SGxXYNUILTXrL2rDcbG7WM7eJv4Ng01IqJDJl6je
         bi1FuF9EefuvBT3YA9ZapmwcEbDUN4k8C4YoGtPmZSOe3iV2ls+wZB92hLVQx8zKDNoW
         3bsvq51Lb4WYg2qdcsxBDihmiCeacJrH5WbQWLVXSbbsuojJWi8sJCrhOKcvOy+gH6yL
         bE+w==
X-Forwarded-Encrypted: i=1; AJvYcCX6qhpkcCpeb4Bf4iYDkm+c5rYn23/v6ns57EEAsjcZbVlQ8HzcrwiMoh6p46rm2y/g2Pin/w==@inria.fr
X-Gm-Message-State: AOJu0YzR4qLhBo6UC8c7g8Nw2JJfiaz3l7UC6GYSubbRnYt3ja8Xmd65
	iaRomLO86TPFZ2d9Gy2CTGgjQ430zcuA5zFai/H/mxjtMdew71p6YwRgQ9jBr+gRHQryR1b+ind
	mhifE7eOsOM1TZQ6oZAC/QTgmdbX0JWw/uglLdQHNTTU08Hnp
X-Gm-Gg: ASbGncunSJxUr2vIigwL1WLy7RPPidFVraQwIdNz8nQvkyqxC3qCNLMC/CzQAKVWuim
	UTYfV30j0A4mf52w9+BBBWEjfb5FhyDxN3stzNkn4adtkynJtpeCdnG22nTBMoVmdwHt+GoCD7G
	IU+y8FBcHsw5lY3/ZAqEHA/hwbxmpYORS2hgows2q2cCTUFBVoCfy1FG94F+qsl4yckuDkdBYx3
	SBB7MzfmLwI4xy3WlgzTWjmt9zUxY4anpyr+PkTghoP9RJ/06OP7Z85LDjdfu8SdulzUOWIv6e1
	hIsiLjrn9hyDnkG/WJuMAr4nPmZ2HQf6wXrmtA7VCZBR3WUKhUuGwyo4np/3BagS106GqpbU5+m
	JkGcv8OrPiif+U5lXbJ0LdMrHalqlLLlKuoH/f/PS2jLm0aLIN6k/Vg==
X-Received: by 2002:a17:90a:c110:b0:33b:c5f6:40ef with SMTP id 98e67ed59e1d1-33fd66b4246mr11005022a91.24.1761532903344;
        Sun, 26 Oct 2025 19:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2qj7rWVn7xtVSSroR9gqFj9StePj4mrbtd+kLAo1n4y5CO9Fe7FI7xL/9TweMaOP55jU5Lw==
X-Received: by 2002:a17:90a:c110:b0:33b:c5f6:40ef with SMTP id 98e67ed59e1d1-33fd66b4246mr11005001a91.24.1761532902827;
        Sun, 26 Oct 2025 19:41:42 -0700 (PDT)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d2767sm6622083a91.6.2025.10.26.19.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 19:41:42 -0700 (PDT)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
X-Google-Original-From: Songwei Chai <quic_songchai@quicinc.com>
Message-ID: <d2fd354a-e3a9-491f-b5cc-86040b037ebe@quicinc.com>
Date: Mon, 27 Oct 2025 10:39:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        jinlong.mao@oss.qualcomm.com
References: <20250606060936.2756980-1-quic_songchai@quicinc.com>
 <54b6e30f-a194-4f5f-9df4-5df0d3d4d738@imag.fr>
Content-Language: en-US
In-Reply-To: <54b6e30f-a194-4f5f-9df4-5df0d3d4d738@imag.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wjtkeUATZWX5_t5cMCaaNQCBSjy1bbYD
X-Proofpoint-GUID: wjtkeUATZWX5_t5cMCaaNQCBSjy1bbYD
X-Authority-Analysis: v=2.4 cv=NobcssdJ c=1 sm=1 tr=0 ts=68fedbe8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=sPnlxz4oxlKK5PFXHyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAyMyBTYWx0ZWRfX8u6FKBMfJnRV
 OqHOM4OAkzOWZ5MuleT7iBGh1hbG73lX2PRtddlNnylj7jm6TUnCI6oBYu4Q8ynQZTCZ2KG9thK
 O9Oa8PcXy6Le3EJd97O7gHAvT1tZpK21f6n/n5qyNCgWXlUCca4nDY9/e+yDaWoAoiHmh74uJdg
 Zd+hI5esv0xviF01qjiU0kMI8P46ZFAUWzj8/BGq678e4LSNwRiE8dKSWcQBNacazCF3OxKdDss
 0J6uxkCtBL1oMpB+h8AaS6p4vaa1GKB0jD3ClymU8TVtA8hkEJWe7BS8IHQSYDdsQLABKZDz98p
 oQ9AiIEEZIwKN8xAXXB1sGyTB452Ol4PdGc9W7qCEm5dzIieWe1gy4NgP649tJEfFrSGu7FEysY
 5x0XXwgp8d5GZUNrwpqJWFBySPaEEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270023
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Songwei Chai <songwei.chai@oss.qualcomm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3100
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/d2fd354a-e3a9-491f-b5cc-86040b037ebe%40quicinc.com>

Hi Nicolas/Julia,

Noticed this patch has stalled after being ACKed.

Could you please help review it and assist in pushing it forward for 
merging?

Thanks.

On 6/6/2025 3:26 PM, Nicolas Palix wrote:
> Le 06/06/2025 à 08:09, Songwei Chai a écrit :
>> Enhance the coccicheck script to filter *.cocci files based on the
>> specified MODE (e.g., report, patch). This ensures that only compatible
>> semantic patch files are executed, preventing errors such as:
>>
>>      "virtual rule report not supported"
>>
>> This error occurs when a .cocci file does not define a 'virtual <MODE>'
>> rule, yet is executed in that mode.
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
> Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
>> ---
>>   scripts/coccicheck | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index 0e6bc5a10320..89d591af5f3e 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -270,7 +270,11 @@ fi
>>     if [ "$COCCI" = "" ] ; then
>>       for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' 
>> -type f | sort`; do
>> -    coccinelle $f
>> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
>> +                coccinelle $f
>> +        else
>> +                echo "warning: Skipping $f as it does not match mode 
>> '$MODE'"
>> +        fi
>>       done
>>   else
>>       coccinelle $COCCI
>>
>
