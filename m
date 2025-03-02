Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F763C19F32
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VUq7jpm65I5PZBCnQ/Y5uKpTpvdmfTXVoJJzTUKDlL8=;
  b=hXAdU1+oUVZSLXBT5c/AMX/oHzOWH4PR7E5QcYdKYVFbYjTIymEilrve
   rpRwRUKZ7hKC7blxOMYl8T7VZdHsFyO4cK5OandRE8gsIAxHYMWTBKYEl
   dZ+P6SWT7MC4q5fLY748X4OV8SJZU3AOHAnId71nPehOOEv6rnbjPr6ce
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210735174"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 13:55:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02963E0261; Sun,  2 Mar 2025 13:55:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8016AE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 13:55:26 +0100 (CET)
IronPort-SDR: 67c4553d_jxjh8dKPvCvcnplCOUmr1Pk0xSkA4eggStSRjyWpPlPL0pS
 SJyTlt6vk2ESA32bG1arLkRffyX/fe32AvfFRQA==
X-IPAS-Result: =?us-ascii?q?A0EpEwAcVMRngAMP49RagQmBU4JEYnUzBAtIhFaPT4F0h?=
 =?us-ascii?q?GuHO4dTiHWBVoF+DwEDAQ1BAQIEAQEDBIIMgnQCixUCHgcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAkdEAgEDIx0BAREnDwsaAiYCAlYGARQBAYJ+gjABAzEHr?=
 =?us-ascii?q?zuBMoEBggwBAQbaXB8sIleBZQmBGi6FbIJjAYYmhDwnD4FVRIE8C4J4PoEZg?=
 =?us-ascii?q?yqDW4JpgjOEQGeaDo5XUnscA1ksAVUTFwsHBYEpSAMqNDEjgSMFNEE6ggtpS?=
 =?us-ascii?q?ToCDQI1gh4kWIIragQFgSqCN4RChEKFUoIRgV0DAxYPAYMfdxyDTIEthG0dQ?=
 =?us-ascii?q?AIBC209NwkLGwY9oi+FPR6DGMVlNAeCOIFmgWMMn14GEy+DcAGTVA4Gkn2Yf?=
 =?us-ascii?q?SKpD4FtATOBXDMaJIM2TwMZD5JOyCVCNTwCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23:evA4vRfXswehTGvgq1PVFnemlGM+xNTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASTG92DoKIV0LuempujcFJDyK7CikxKSIZLWR4BhJdetC0bK+nBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizewb61+I
 A+qoQnNucUbgo9vJ6g1xxDUvnZGZuNayH9nKl6Ugxvy/MC88oJ9/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07QzWi7
 6NsSB/1lCcKMiMy/W/LhsBsiq9QvQmsrAJjzYHKfI6VNeJ+fqLDctMcWWpBRdtaWyhYDo+hc
 4cDE+8NMOBFpIf/ulQOtwOzCwqiCuzgxDBGm2H43aM63esjDQ7I0xctH84XsHnOsNn5KLkeX
 OKzwaLVzTvDdfRW2TLl5YbPaB8hu/KMXa9rccHMxkcvEw3Fjk+RqYzjMDOey+MAvW+B4Op6V
 uKvlnUnpxt+rDiryMcskIjJhoQayl3f+yR23p06KcelR0FleNOpFoZbuC6GOYVsWMwiX31ot
 zggyr0AoZO2fTYHxYg7yxPbdfGKcZWE7B3hWeuSPDt1hnFodK+/ihqu/kas1u3yWMm63VpXs
 yZIk9fCuH4D2RLd6MWKVPlw80G80jiMzwDe8v9ILV0qmabBNZIt3Lw9moAOvUnDBCP7ll36g
 auZe0k+9OWk9v7rb7f6qpOGOYJ4lgfzObkwl8y7HOQ4KRQOUHaB+eqh1b3i/FP2Ta1WgvAwj
 6LXqorVJd4Bqa68GwJV0pgs6xK4Dzq+1dQYmmQHLE5fdBOJkYfmIEvCL+3mAvunglSslilkx
 +zeM7H/H5nBMGLPnKn/cbt/8UJQ1Qo+wcpR6p5MD7EOOvPzWkv/tNzCCR85NhS5zeH9B9Vn1
 YMeRHmPDrWWPqPWv1+I/OMvI++DZIIOtjfyNeMq6+TzgnAngVMde7Km0oMNaH+kBvRmP1mZY
 X30j9scCWsKpBYxTPT2iF2eVj5ef2q9X6Ug6T4nCYKrFpzDR4CogLyZxii3BJxWZmZcClCNC
 3jkbYuEW+1fIB6Vd+ZlgycfXPCbTJQs0wOxuQ71g+5uKvvP4SQwr5X42d5n+ODSmlcz8mowR
 8+a2GqMZ2ByhGIBATEsj45lpkko716Z0rVjy9FcG8ZS4fwBBiIzL53B1KpXD97oWwTOVsiEQ
 hCqT4P1UnkKUtstzopWMA5GENK4g0WGhnLya1d0v7mCBZhvt7nZw2C0PMFljXDPyKgmiVAiB
 MpJL2yvwKBlpEDIH4CctUKfmu6xcLgEmjbX/TKmxHCNoVoefQp+S6TDUlgAa0GQodmqrljaQ
 eqWAK88ehBE1dbEL6JLbtPzilATYf75O8nFJU+1lX2xAxmg2b6GKobnKC0GxCuILk8CnkgI+
 GqecwgzAiD0u2XFEDlnDk7ieWvp9vRi7my2RAk4wmlmdmVH0Ly4sl4QjP2YELYI264c/Twms
 3NyFUq82NTfD5yBoRBgdeNSe4F15lAPzm/fuwFnW/7oZ6l/ml4TdRh2tELyxl12DItHi80js
 HItykJ7N6uZ1FpLcz7Q04r3P/XbLWz7/RbnbKCzuBmW9d+M+boUrtk8pU/iug6BCUcotXlqk
 pFU33aa+pTWHV8KS5uiGk0z9hV8u/TbenxnvtmSjyczd/Dp9GSRvrBhTPEowRuhYdpFZaaNF
 QupVtYfG9DrM+sy3V6gchMDOulWsq8yJcKvMfWci8vJdK5tmiyriWNf7cVzyEWJomBZQ/TLw
 o1D7vWWxAqBWB/jgV3nvs29yuUmLXkCW3GyzyTpHtsbQ6RofpsQT0qqLde2wNpWmJPnHXJVv
 g3GZRtOyIqifhycaEb41Atb2BEMoHCpriC/yiR9jzAjqqf3MDXm++35b1JHP2dKQDInllLwO
 c2viMhcWkG0bg8vnR/j5EDgxqEdqr4tZ2XURE5JeWDxIQQAGuOVv6CBftUJxZcmqyRRX8yjb
 FrcRrO1rxYB0izlFndT33hhLmvs4M+m2UUnzjnVJW07tHfDfMBs2RrTgb6UDeVc2DYLXmgwi
 DXaAES9I8j8+NyVk5nZteXtH2mlV5BVbWzq1dba7XH9vzc1R0Ti2avg/7+vWRI32iL6ydRwA
 CDBrRKnJ5Luy7z/KuV/OE9hGF777cN+XIB4iIo5wp8Kih14zt2Y+2QKlWDrPJBVw6X7OTAoT
 CQI3sWTzQzrwkxlIVqWyoi/WnjXka4DL5GqJ3gb3C4w9ZUALa6O76Ff2wZxrEC5qw35fvV32
 DsQg6hLijZSk6QCvwwjyT+YC7YZEBxDPCDioB+P6si3sKRdYGv8Oaj1zkd1msqtSa2TugwJE
 misYY8sRGUji6c3eEKJynD47ZvoPcXdfc5G/APBiA/O1qBcepc2i+ZMmidtf27w9XR3zukmk
 Vl+05ago4GdJyNy8aj/DhM9VHW9bpEW/SzxyKxZg8Cd0sawE58nFjhDVcntSu+0VTkJv+njN
 EDXGTsw8zGQHr+6f0fX4RVjqG/TVpuwPHaNPD9AxNNuHV+WI0kXlgkQWH9ScocRMAesyYShd
 U544mtU/Vvksl5XzfouMRDjU2DZrQPuazEuSZHZIgAEpgdFr1zYN8CT9IcRV2lR44GhoQqRK
 2eaexUADGcHXVaBDkziOb/m7MfJ8uyRDO6zZ/XUZrDGpetbXvaOjZWht+kuty6LLdmKN2J+A
 ucT301eQTZmFs6flzhOAy0bmiTRbtKK8Rex/ioky6L3uP/vWQ/p+c6OE+4IaI8poUrpx/7ec
 bXD4UQxYSxV3Z4N23LSnb0W3VpJzjprayHoCrMY8yjEUKPXnKZTSR8dcSJ6csVSvMdelkFAP
 9DWjtTt2/t2lPkwXh1gXEbih9rvSMgEOWC7O3vYCUzNOLnMdlipi4nnJLixT7FdlrAerxqrp
 TOSCFPuJByGkCT1EQ+iO6dAgWvIWX4W8JH4eRFrB2/5SdvgYRDuK957gwo9xrgsj2/LP2oRW
 dCTW1xApPuc4HEB6h2eM2lG82YjMuSO3SqUvbGwwnM+rvZhRCh5xboy3Q==
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:XgVNSqmhkRpuWRina6VJvyk+jgzpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:v1LLim94pv1O7CswYfSVv2AqPvo4XnP/8GvNJB+xVWFIdbOtUnbFrQ==
X-Talos-MUID: 9a23:m2FBRARmSBGx5gPpRXTHgypsaNp6z52UGUEqldYJ5pfcFgBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="110424846"
X-MGA-submission: =?us-ascii?q?MDGhPGc3/wJGTjBoIyCpN3Wwvl3Dsns64yURpK?=
 =?us-ascii?q?pLB7LHQzzvCq0tmlDwVnM5fZvRoCdyULB4ZW/kax1kO3013w52IlZUzw?=
 =?us-ascii?q?KJT/G4wO4lozzK9cKcpCCbdGvbqyDoIaFIr63hFf52DqfiBJmt6Np7J6?=
 =?us-ascii?q?m/d8uGItoer1pvRc+xQDz23g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 13:55:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740920124; x=1741524924; i=markus.elfring@web.de;
	bh=VUq7jpm65I5PZBCnQ/Y5uKpTpvdmfTXVoJJzTUKDlL8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aV/Eq7cs2f6dbKs3FEnR1l9obxE3mzq4B3kJ91NJcvgEqK9yPTpvO/wMGc1M+yaN
	 CerRBuN1BhFtxNntKd5y0S9nbzKO/eNWu7kbSgqP8SutWf4l2P9soaLtIeBdgGZ1t
	 04nm95B73bkcoFsiNI9o5C7JL3pj5rUDvq0M95YpEG59vveHjmIz+IbT8+WWoeOgS
	 /uE/+Orl+JT+A5XaxXuBZMJwIUY4VCJeGj61qtUpd/29PPLnx+6Vpgn4Sxyi5QlzQ
	 ugBmYH4jLMJ2ZLlYrwdJUVqWgHyaVCc5d6akuGSWPeeZ/qS/KQbroSD1jFKVWdJcq
	 3JW0Ez/VeINg749zAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Epo-1tBDAp41nk-00zL1k; Sun, 02
 Mar 2025 13:55:23 +0100
Message-ID: <694f45e9-5537-48cd-9650-a73e9db1b7b2@web.de>
Date: Sun, 2 Mar 2025 13:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, cocci@inria.fr
References: <Z7zjkyOeoPNYeOR3@blossom>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Z7zjkyOeoPNYeOR3@blossom>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PBbY0sgGc3F8JejkOsYz7MQH6GlFR9tnjoahyIHhaEQQ7GQBqrm
 QxX52+u7Wt/j7C3xZc4VrodA+xPef9JQmrEbaOewkA3QwuS4oyRwKjbWtTSNEAAk5I4iuNW
 v9RCksmm9+DvmoFQ8rZn13F6n+E9Q+MTj8rzaEZrA3rnitm4eLZeesqOHN8iqu7M6aWaV6W
 tT76sz34WVh6nS2HrYw2Q==
UI-OutboundReport: notjunk:1;M01:P0:JBtWakaQVQM=;CMeVPjjwLLRxIkIurR+aAzMk/2Q
 F8+FF+e8BUZFIcuKetDidTtbnMDaRASUP8jcBT314hpcHJcUZdVZ3bnM4npUvSh16uey6bUcw
 q4bX6gV3ALiDRmmMKxaYwhtN1A4Wj9dD1RRzafmMylVitwtgFyN5I9M2rbxHaN4Te8CoitsuQ
 0QF96YV0475SHD2scK00xURQqEz9V4YiNpLomhjCjkMS/q1zMbre4LmBwktI5Al9q+64u8JiI
 VfB22570gwLNI29dX6XcGVLfe6QZ3bpCyZzi2vr10q1y1SAg8WvUWdfOBPQ6avp7d+QE5ZGFZ
 YGNw9ZfbxhhbPVR+bpiV8LmnG/0v5s+Ay8uVcmYFKirCn/g7Gy5ANtl0V+SbEVrXkJ3og6gEQ
 GjWh2iBh/LqyKEJJQRQvPBwGm26RBgmWrKeB7cwzR46bZVs+dhP4FF/1AbKUyrPC7AfXE/qDK
 demOirFUSkH5R9ZOGlRaCDoDRPasazzpbP+7ISKGp5I0PSoJE/RxyaR7PY/cTtwrBgxUkP3kj
 54RoFr6GD4OBBpBuAqYG76T6VGKN1V5fUVQZbbz71CPSP2gTyV6vPso9vJQF1PDAEhVEs7/yE
 nYGLKR1T4MQW+9e6ddx08M7mBLuEEDrtfB2fiFhTTXvSsibjZXwqBVCrd4BJ+Zg6V7Y2jt9ob
 Fuj8R6+bg/lukGxfgwww1dTc8NEMWcdTDANbwyd00Eke/VYUaeYoNG9cz4gRsE+bXlw4yrSq2
 HRFRnbJ5v9xtS8AagGaqq4rWhVLfVxR6rMFz0zSLToR8Yiz2U/yYmjMpb855NTwl9g52wW39/
 aI7xmh531Zm6oLBhBPDE1fpXmVfcKUZ1uMrLZJQeKbx3OXfFj029cwbxdHHazHDn3/TFZGNzN
 H5AZpItWlYmgQ1VAWVjMyCsjCyWnsI7PGimltnzVFFT0CNvefWHlGqtT31siuHYeB2/D7PVB5
 Xm098YMvBSrWl262zUzd7tVkoWvB+rc81o5cKwhxzcA45I5Dx8UeB6jcTukIus0LMe6xbaL1r
 QeYXwzofMUoruB4nfr0cRacRu7+03d4Y6KuG1eXY8m60MJ+Gmm9nWY6OkZ29F0RsFYWZYJs2n
 qfrIF2nEFdjxFW9IG0T8gX2jspkuLd+Rw4FZjR1NMOSDmGLNzPoXPU4vim9iwwa0kfS3Nzc+j
 rAv2BUw81PVf/QvEvoKSrsOFhtXPf3brHKOT3qbrhuMtxyA0HrDqXlFpBqu+lpg1286qy1nRk
 ZTnLHiNOmjQxLSuG1Sy547JaT5hDR42uNab/f0ST9dMP17hvY1qftb3u7gnt0tuYgpv2mfQ7q
 GQYncJSsEUR3MlMJ9Yr9znzLhwmHJBNdC4/+Rn45GtkgkAR1s3O0W/HyyCvOvDAv6BTucbs+n
 y4O0JVxZoDPRDVsbo8oDGy19L49QTNmK0y5a4RGPx+DZEun9/MkTpjWt/4Oj19MHJ7pOk81Wo
 eBQpBsRLCANSrttvhN9fUDO7cSvM=
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2466
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/694f45e9-5537-48cd-9650-a73e9db1b7b2%40web.de>

=E2=80=A6
> However, putting it together...
>
>     -lhs =3D rhs;
>     +lhs |=3D myfunc(rhs);
>
> ...fails with a parse error
=E2=80=A6

Does another transformation approach (like the following) work better toge=
ther
also with the Coccinelle software versions which you tried out so far?


@adjustment@
expression lhs, rhs;
@@
 lhs
- =3D
+ |=3D myfunc(
 rhs
+          )
 ;


Regards,
Markus
