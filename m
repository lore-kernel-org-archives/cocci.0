Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6763CCD5BA0
	for <cocci@archiver.kernel.org>; Thu, 13 Nov 2025 08:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XXmhNVJ3hoJG6pe/vOtNZg2Q+Bbm2uaXXHuBILr0mY0=;
  b=YVBHfp7EedL6/Q6Xt2cF7b2HRjFYhamseCNwdkk3k93p68Z3+ans9cml
   6wX6x18b94PF2SzSutxG+FiPOP4ZVITGk4OC8tQPaeaN2Rkbi0nAXzIJU
   QwMWx1F0jqmaMxq1qzI+U0ubKOo78trKwn69C49ixWsrwkmtLIPoBvEUv
   0=;
X-CSE-ConnectionGUID: /PBoZluwT16zFOv/PMT0pA==
X-CSE-MsgGUID: HqbLI23JSua2laLpY8GvSg==
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
X-IronPort-AV: E=Sophos;i="6.19,301,1754949600"; 
   d="scan'208";a="248903626"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2025 09:42:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD534E0BE9; Thu, 13 Nov 2025 09:42:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9974EE0171
	for <cocci@sympa.inria.fr>; Wed,  5 Nov 2025 02:54:26 +0100 (CET)
X-CSE-ConnectionGUID: eQnZ1nDjRoqC3VqzgZ55VA==
X-CSE-MsgGUID: 9omu9vSdS167OI86jTGDZw==
IronPort-SDR: 690aae44_+XhxLiiEPxYsK9Y7sdnGkytUU7JBAk1PtVzRVBooWVWaPGA
 n3fit7f2Fa5+/i/Y7BHyjd0Oi/GuPoLQOoqjCgQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EhAwDFrQppe4O03M1AGoEJhBCCEwQLSYRViHuGV4IhA?=
 =?us-ascii?q?5xFgxU9Ag8BAwELAQFRBAEBAwSFAAKMWAIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBQkmGTw2CYoElXkgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEUAg1eAR8BAQEDEhEPAQUIAQE3AQ8JAhgCAiYCAjMBBQEcB?=
 =?us-ascii?q?gESAgEBHoJggiMBBkoCAZcYjilDVRIqSRABMW9CiRIBAQF4gTKBAYIMAQEGg?=
 =?us-ascii?q?mnZPIFkCRSBCC6FboJlAYVuO4Q9Jw+BVUSBFScOgnU+gVKCOIQUgkcigiaBD?=
 =?us-ascii?q?oYngnSIDwaHZlJ4HANZLAFVExcLBwWBIBAzAyo0LSNLBS0dcAwoEhAfEAgRY?=
 =?us-ascii?q?FRAg0kbBmgPBoESGUkCAgIFAkA6gWgFARwGHxICAwECAjpXDYF3AgIEghl+g?=
 =?us-ascii?q?g8PiXQCAQttPTcGAwsbQ5RdgkgtBgF7EwGBK4ETDB6jQoIei3qTWYEKNAeEH?=
 =?us-ascii?q?4FeBgyfbAYTL4QEjROGOxSTBZkGIqN/hHUCCgcHESSBWyOBXDMaI4M3TwMZD?=
 =?us-ascii?q?5Ihy3E3NDwCBwEKAQEDCZFqNIFLAQE?=
IronPort-PHdr: A9a23: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
 MJleE2RBRlH8Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:t7Jqgqlo5wsevXx0Rn51rfl2B0DpDfNhimdD5ihNYBxZY6Wkfg
 6V7YsmPGzP+UcssRYb6KK90ci7MADhHPtOi+Ys1NiZLXDbUQeTXfxfBM7Zsk3d8k7Fh5ZgPM
 VbAs5D4bTLZDAQ4KqKhzVQUexQvuVvm5rY/9s2oU0dMT2CJ5sQlDuQiW2gYzlLbTgDKpwjCp
 KG68ZL4xamc28Gd9m2CxA+PtTrlpnkkNbJb3c9dn0aAcq17Q9AKoSVL/FV5GZ6bxp/hY4492
 7Ligr44bjmnc2a53bnphnuxqUTocDmzNRbAsyKl4wyERXDziiVRKkJYcz0gNgSyNvfoGoCoZ
 30uBEnMN1063TNOlutqR+o9gX82DYq8TvPzlXwuwqXnSU8fkNyNyOJv/M6A3/k13Y=
X-Talos-CUID: =?us-ascii?q?9a23=3Atbmv6Wh5b3aVdNzWVYoCifamWDJuf0Tb/i7WD02?=
 =?us-ascii?q?CDn9CE4OMW1Cipf5aup87?=
X-Talos-MUID: 9a23:MUZ+4gpAOrbyX7zzWPcez2BlMdo5/Z+iMxlTzrIn65eGCQNcCSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,280,1754949600"; 
   d="scan'208";a="129999309"
X-MGA-submission: =?us-ascii?q?MDERfLqkfK5wv5Q4BlcQwhvkYenrCDTpkguPRi?=
 =?us-ascii?q?To783sAfZrS35Qyn0KUrtAuy15bPV0vd2fctpr4MLhjvlyDIP+oIb9YZ?=
 =?us-ascii?q?+8FT5TFTUbPz4bzlip7Sb6hp6pFMLHlPYfwbuGWCPFMYmdaB/XC9QIl/?=
 =?us-ascii?q?PswGUXfqINc7km0p0m7suKrA=3D=3D?=
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:54:10 +0100
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KgMmj3043711
	for <cocci@inria.fr>; Wed, 5 Nov 2025 01:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXmhNVJ3hoJG6pe/vOtNZg2Q+Bbm2uaXXHuBILr0mY0=; b=hUd3ZVyMwN1XBkDq
	RNjpZHU2/jYeih+0Vy5RMw+78f7w4UPnHluulORvPzCGYHCMEqbEhx742VW1vgil
	N5ZwEX6tQehuNbgMBrT0VYwkF5N91Ze1HQm0SEuQweZgwWNIzaUTrvTe183F0lZo
	gnOevR/n/jk1siJ9Rx8YlhnYGsdI38/1CqTi1HsM8+TQVR5sabkBdK8jKUTmAude
	pyM5QH51u7h0Wxngt4oAmwZwnYFa47X9ELJwr5H1Z+3LURHqwl9zbMF0ruy3R54N
	KnmrcWK+ZiqGAwgPHEltFE7Bd0BsClDzF47yJfMWL6XdicXfhKt+WRjxAluTbA2Z
	iG+g+A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a78equsyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <cocci@inria.fr>; Wed, 05 Nov 2025 01:54:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340c0604e3dso3493876a91.2
        for <cocci@inria.fr>; Tue, 04 Nov 2025 17:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762307642; x=1762912442; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXmhNVJ3hoJG6pe/vOtNZg2Q+Bbm2uaXXHuBILr0mY0=;
        b=KNk1WWOloHFvDnXH2m1M4MDHYIwfmssA+HMK+X9yPLj+/SNUsRxwzyZgPjJaoOCLGl
         z49IwGcLT32rzpCzbD8RchpBlDM+pVMWA4nlcxpzALHakbhTMT2DIWGSgNtgY2wVbAgx
         HQIX4pXKdxqryqsagfhMmBSdeG6mL8Q1F8GGWKsSDGgi53r83K78yzJt8UQ38tOBDvF8
         EAT1p9sqCzvyM2OVSOGz+w1npdS3LYBponLzBz8JxnZI2GkuLs9j5/EyFAJECpTvMJgy
         1ywwuCW+RdYt/LeCMtu/dgYxXSoOfjKIWJkBmKqv/v3YqYHuQ3v8EUAs6MQO72J3Srnv
         FobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307642; x=1762912442;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXmhNVJ3hoJG6pe/vOtNZg2Q+Bbm2uaXXHuBILr0mY0=;
        b=Y58MFPH2ZMpFCZc6ZP0Q4xwZ5tM7EhD9h4wpNy6F5E4mD5QZFa+H8GU4gCpxgik0Y/
         WilcqaR6TcU3KctS7B1PLqUcRcfmzHCmo0WG1+2/UL/JkgxJF4G0My0sUiUt35JIiRhP
         3X/hPb/O+Wfx+D939QlIX0xE/i9hcFmsVn15L4EUwDG0N952rAh9opeVoD2Rhn2aA9qp
         Rt0aOy8NcGs6j2+Zh6yKV2LTzN4sS4er62b779dbYhOSns0ZryiXR7Pgvhi3qgbvaQSr
         MyjofrCoADOSdhQucEDPaLyLzGaP/qHhkQ73FfyF7GtR14LGzx9yU9o/Xva4LwfIbN3t
         cOgg==
X-Forwarded-Encrypted: i=1; AJvYcCVl2u0fJNTDrgBeA7KdMHOTuhbepcZkAE4qF3dSGer5pdIcStY+mSbahL1rroAgbRPN7aBF+g==@inria.fr
X-Gm-Message-State: AOJu0YzzySqsrtyOcJPNYAY50jeGxJlLaCHiRdadi4NMNatsaL+MxFp6
	S/l+sOHwYphAPXNXw2yxSfEsiWYeEWftn7JnANVQZQKh6Vpdn1KqV4CHiSgOef9q5qUdjY/6Zwz
	WSzB1rzNq0h2Q/BqqfDNx7ndeliyiNRnp+KYbQMdIvJTVhA9i
X-Gm-Gg: ASbGncvrKsSS1OHgaVm+d4Y1oaj/PTKqRTIcgB4ukVF/2B9e+2KZes8B0OX3g3BT5Ts
	IzdW7bFdy4ofGIrYfjyxbfkycH+MSmOxcajRjvtzYqb8AhHgOXGp+sm9rXlo7K90UYtyOGcX1JV
	jrq+g97QlXfc1HBQIAAv71HZgEeEBNnqwTm5WQ0NFxQJgK6ZsuwJ3uzI7hRuKti4x93rUT0Ir3Z
	auDmqftHT2QMJm5SiIATWIe4kqI5dn11ca8H1O0qjZ70LXWFt4xmEuLEctysfrBXbi9eX/CRQSQ
	OiBaDfUJGuUjcyiCFxvytKOLeOsFLZR5DcRL7Xmg5WyW9nauGLS6HK7XdFG9TSaC/i2ycl7iY81
	L1GwrZjmvhSQyNxvyVSiJOtmJ4+FqazE5wRCQqnWYBUtZNAmTlIddRAaOimYggGPUdgc/6g==
X-Received: by 2002:a17:90b:4e83:b0:33d:ad49:16da with SMTP id 98e67ed59e1d1-341a6de76a3mr1454708a91.31.1762307641941;
        Tue, 04 Nov 2025 17:54:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA/bg0wXqruJ/4EMP1KV3HXVtGWNjBWM/YLfvsxYb2Nat5WHW/87S3quP7HRJbxdTtN2aw6A==
X-Received: by 2002:a17:90b:4e83:b0:33d:ad49:16da with SMTP id 98e67ed59e1d1-341a6de76a3mr1454689a91.31.1762307641362;
        Tue, 04 Nov 2025 17:54:01 -0800 (PST)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a699c98dsm948828a91.17.2025.11.04.17.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 17:54:00 -0800 (PST)
Message-ID: <88daba74-f005-4be7-be3b-627ccd424276@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 09:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        jinlong.mao@oss.qualcomm.com
References: <20250606060936.2756980-1-quic_songchai@quicinc.com>
 <54b6e30f-a194-4f5f-9df4-5df0d3d4d738@imag.fr>
 <d2fd354a-e3a9-491f-b5cc-86040b037ebe@quicinc.com>
Content-Language: en-US
In-Reply-To: <d2fd354a-e3a9-491f-b5cc-86040b037ebe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxMCBTYWx0ZWRfX0kGEiQ2X3HVz
 0Sqm9713NedXAqOry7Ixiu6nenGDudbSOXwV5aCvai0zqIe0TOTjrp5yDpIv8lxvZpeu4mphMIp
 3qV0xlTroVCOb1Neec6vMnR8U3F8JRrVuNgxhpBm2q5tTn7i+83npmtsPxEYhcIBkN5WncPW8a0
 W0awxl9sCmXupQSQ5VnOdXcrSrK/FFmcDRW31zWh27Q+D7+Whmh9CEUKxle5OvARYEuvK+ah2go
 0foLU31yDhQzkdwWMrtHThBQjBJVXg7es2rSFA84R9OVW3j1SK/kTxOixW6+HSS25C3vMx2rt51
 +CZlWwQqe47MBJcWLwpQGFpqjFzPsQRWZLK2MPZ7D0Lk8c7Z3UpjAVQ3yVapUPzBptlvOvsgmVg
 UpiFR3aPB6WRy6ibpfURpX9p23WSgw==
X-Authority-Analysis: v=2.4 cv=fofRpV4f c=1 sm=1 tr=0 ts=690aae3b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=rWyacSYSx-f4FmYYJUoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2W5s2ErKY4Q6FtUZNd6oKiP1HJmh-hOQ
X-Proofpoint-GUID: 2W5s2ErKY4Q6FtUZNd6oKiP1HJmh-hOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050010
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] scripts: coccicheck: filter *.cocci files by
 MODE
Reply-To: Songwei Chai <songwei.chai@oss.qualcomm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3173
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/88daba74-f005-4be7-be3b-627ccd424276%40oss.qualcomm.com>

Gentle Reminder.

On 10/27/2025 10:39 AM, Songwei Chai wrote:
> Hi Nicolas/Julia,
>
> Noticed this patch has stalled after being ACKed.
>
> Could you please help review it and assist in pushing it forward for 
> merging?
>
> Thanks.
>
> On 6/6/2025 3:26 PM, Nicolas Palix wrote:
>> Le 06/06/2025 à 08:09, Songwei Chai a écrit :
>>> Enhance the coccicheck script to filter *.cocci files based on the
>>> specified MODE (e.g., report, patch). This ensures that only compatible
>>> semantic patch files are executed, preventing errors such as:
>>>
>>>      "virtual rule report not supported"
>>>
>>> This error occurs when a .cocci file does not define a 'virtual <MODE>'
>>> rule, yet is executed in that mode.
>>>
>>> For example:
>>>
>>>      make coccicheck M=drivers/hwtracing/coresight/ MODE=report
>>>
>>> In this case, running "secs_to_jiffies.cocci" would trigger the error
>>> because it lacks support for 'report' mode. With this change, such 
>>> files
>>> are skipped automatically, improving robustness and developer
>>> experience.
>>>
>>> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
>> Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
>>> ---
>>>   scripts/coccicheck | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>>> index 0e6bc5a10320..89d591af5f3e 100755
>>> --- a/scripts/coccicheck
>>> +++ b/scripts/coccicheck
>>> @@ -270,7 +270,11 @@ fi
>>>     if [ "$COCCI" = "" ] ; then
>>>       for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' 
>>> -type f | sort`; do
>>> -    coccinelle $f
>>> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
>>> +                coccinelle $f
>>> +        else
>>> +                echo "warning: Skipping $f as it does not match 
>>> mode '$MODE'"
>>> +        fi
>>>       done
>>>   else
>>>       coccinelle $COCCI
>>>
>>
