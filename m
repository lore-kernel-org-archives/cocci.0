Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F021EC4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=c9unVzyVLiaRYR7Ti2BSnj+UnsnjevNc5F8cUNGHqxM=;
  b=W2j+VLhKUYn8bBZ/fzQr/zX5Yw1UTrCRlz6NF3KJdV4JhUnoyajiNs5i
   D3lcw1hWAoml4ch+fft0kTlCz3oLpTSaN5QJethirdayIf774OOs4Hjp3
   Rxk+Prj3u0k4gJr6Kjc9Gi0UWDYXvtgjrjb79QrCCzPSGhoifhjPgp1Ja
   A=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145885469"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 14:33:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB62CE0CCE; Wed, 10 Jan 2024 14:33:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D6E8EE004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 14:33:15 +0100 (CET)
IronPort-SDR: 659e9c9b_6gi/6jvmPCLzDwTuh3Q0cecvwzrHMNeBwB4lczB484k1map
 b0jDVtW1ArqM/+bsKybiHuxLPxXqHkSufp3BRYA==
X-IPAS-Result: =?us-ascii?q?A0FLAADNm55l/wQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4B3VWMgQLSIRTkTYtA4Q7l3CBVoFAFigPAQMBDTQNAQIEAQEDA?=
 =?us-ascii?q?wGEfwKHPQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?oEGE4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQECDQczQgEEASMEGQEBESYBBAsLGgImAgJWBgESAgEBgnwBg?=
 =?us-ascii?q?ioBAw4jBw0GtUl/M4EBggoBAQaBRQIMAkOtQB8sIlaBYAMGgRouAYgaAYVng?=
 =?us-ascii?q?0F6Jw+BVUSBPAuCeD6CYQOBX4NbgmiCGoNCg2+FJYcOUn8dA4EFBFwPGw8eN?=
 =?us-ascii?q?xEQBQ4NAwhuHQIxPAMFAwQyChwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGD?=
 =?us-ascii?q?CYDAxJJAhAUAzsDAwYDCjEDMFVCDFADZR8YGgk8CwQMGgIbHg0nIwIsQgMRB?=
 =?us-ascii?q?RACFgMkFgQ0EQkLJgMqBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUB?=
 =?us-ascii?q?wsHe4EXAxkrHUACAQttPTUGAwsbBj0ClSoBgjk4Bj4DOgJGFxeUP7IYNAeCN?=
 =?us-ascii?q?IFggWEMihiVEwYTL4QBkyUOBjGSIy6HUJBPIItUgXaafIFqBjCBRgwHMxokg?=
 =?us-ascii?q?zZPAxkPjiCEKzdUg1aKZkA1AjkCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 3PgLpvnII5VOoCpgiRf
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kFsxM62FxSiLTTQHtaRwGwqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:hs/XzW88quoigG0MXFyVv3UYF8k3cXj89VT3PRGnF2xzepbORVDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A30n5IQyOWDf1SpjxwNuKsPYm80WaqK2QF2I0qog?=
 =?us-ascii?q?tgpSjPBR5Og+WkRaFcpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145885422"
X-MGA-submission: =?us-ascii?q?MDFz3yGzPU0TO/pj4tCIbAzkCn1iP6eOrjy6PQ?=
 =?us-ascii?q?2biSqIx2kNhwFn/zV6DaxsXF+cYcX1W9qEbMbsbazUZiqD/zlhYUvxD0?=
 =?us-ascii?q?FP8LvfAdMxT71G3mazHguckQajY/8sDwrCN0ILJKZ5RJVNFHt28zC72v?=
 =?us-ascii?q?giQeTlQFBBUc7CXdXlPFOJiQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 14:33:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704893585; x=1705498385; i=markus.elfring@web.de;
	bh=RnhFZzqFP21H6mHBzHvMIpfQtdiPSMkVFOutsyi3vUM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=tbVn4XmOugNswqCvTt0ISjOo2W+60xRWRLtnchnRwH8A/s1x8r6RJtOGXveiQW1G
	 IzOeMNJFFyOwtmKVJN5PokuAhzeMnPC1s0cRzY3flGZGKWOcMr/YsgwAAUzhCZakS
	 KzQhodSsA2viM9QLkwtxNY463HNnP4txpSoatwhrSyXG8eCOfrUiBdwH+SvLCqKxw
	 5N16pAEiQmmxDwr/RBfRV6Jhgd7eVm2oJ5XC7T9GA5lKNwxbwGY4A4JNik3CS0VNO
	 gIp7OARbSONnVlt/zsUeCB+quNRuvXXanPX/0Y9k9a+Yb24cjfNRdIbCLT+1/3UTc
	 RyH/peKebc3EE17gyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1qi9bj1BMU-00fRcl; Wed, 10
 Jan 2024 14:33:05 +0100
Message-ID: <1df4916d-421c-4c87-8503-5a36934d03d8@web.de>
Date: Wed, 10 Jan 2024 14:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
 <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
 <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
 <d912872a-e70a-4e5d-aabe-26f289507f44@web.de>
 <CAOQ4uxjsuYy8BzgaHXaNa-S0+HZ_P-Fb1UEgOkbrdxQPz0Y6rQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAOQ4uxjsuYy8BzgaHXaNa-S0+HZ_P-Fb1UEgOkbrdxQPz0Y6rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sR4rQTtSYytVnVBdP1/d3E7GPPa8HOhhDRPvzDXFi2UK8060jYO
 GQBshFtoDKifWRZ0Qiuh5mQ6tecfzLFlcTqy4suRtfHRN6viFEmam9deD1FfL9Ej5F0xeuE
 1T93FEy1dZ0dtC063PuBRiQz0HYzLlCMXF/HJGASl1mHFx6eatO7jOBT28ZN1CSGpBmwKpy
 oy4Zfv7FNkOu/SpM5GEog==
UI-OutboundReport: notjunk:1;M01:P0:JzdfnNQ9PNY=;gDs/TB4KQUmIb+ze3lX1auKhdX+
 N88AI0I1T4TkJzYA4iyoFH+lVoBMMNu6rUf7zYNA2nHOzzndPPbinArvGXXHK9aR567BXDHCW
 u80pXGeaXVdsa4E/U3xH47t8SPlyH7/FjK6Y1rJq6RYFB2htKOTIduup0+rPWcBYvX4c0VwzI
 fn8EZonv3LElpZvPeZhJgFVYSoc3eoJWagJCmjxDMjfooPwxD+VYj2/76YvIYE0VwHCi11EbC
 OBO6PO04ZGqCcLp9Ffzg1WqidpMfdFeRu52kyJoMK8bDBVQkwJETILvMCR8BVf+s8nvn8Sjhd
 lqF2f3itCv53S6QocxiR9HyIR5eQQKuoU3bRgUOzyoPA4qIVn2wJn/zh7PY1pL9ilMe01lB9q
 QoH1620eNuzyFXR7KNFog42gD7RbPdr4N8R7o7DZfp79KMkfWPxQzFDMZ/CGjhtjiweCOGXO/
 A4kiuIymlowJ/ELxdXsidPRwXKrS+rGR4OT8/IW4D7d6Iaa7UnItDCXGBP4mhXHOJn6+y7cXF
 m+A43DTuF8eM5v0bNSJsZvMFrjioyco2HXLFGPccFIB5frxByMO8pm46XUgY9A4gw4dF7DWHe
 JvaEe0ISboEAxSPHTPzJe1cVWzBmOpveR9UlGVAY+KTD8JWeJfmgSR1xvesIEy79aJdB9thBc
 EMcS0nva+5ep3GB27xHw0FKXrjqiMsSIwAhUA+n60EdIsjU8XX78xp94LIo4KOyuNRazbxH7o
 ZmZc+esTVgBHg7we9ShBrknbskcEbUxfi3SRSqy69JG4+IEaz1NuFMHhfrUm01WkBmEja6vOl
 WweYw4Dx+J76D36QNpWDDLhB8qMs07Cx5SD+D1fnURyiBMQS4L30bNimAw7GCfiFIdsL0+ixa
 C0ie1LUvaIrhSEa4XRkeWGBseWL6b/8RsowFL23KjkBsq0TBRuabomZcs4fgw31wso63HFH7M
 FCv8YsFP5Cd2nF1wHK5WzQEm6uA=
Subject: Re: [cocci] [0/4] overlayfs: Adjustments for ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1453
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/1df4916d-421c-4c87-8503-5a36934d03d8%40web.de>

>>>> See also:
>>>> https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@we=
b.de/
>>>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html
>>>
>>> I will queue cleanup patches 1-2,
>>
>> Thanks for this positive feedback.
>
> Sorry, these patches do not apply to master branch and patch 1
> is no longer correct in master branch and the new mount api changes.

Do you want that I adapt the linked development ideas to the current situa=
tion
a bit more?


>>>                                   but I do not like patches 3/4 and 4/=
4.
>>> I do not think that they make the code better to read or maintain.
>>
>> I would appreciate if the details for such change reluctance can be cla=
rified better.
>
> patch 3:
> I much rather a single error handling label that takes care of
> all the cleanups - it is harder to make mistakes and jump to
> the wrong label when adding new error conditions.

There are different coding style preferences involved.

See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es


> patch 4:
> Overlayfs uses this coding style all over the place
>
>   err =3D -ENOMEM;
>   ofs->creator_cred =3D cred =3D prepare_creds();
>   if (!cred)
>       goto out_free_ofs;
>
> I don't see the benefit in making err =3D -ENOMEM conditional.
> I don't see the style after your patch as clearly better than before.

Can it be nicer to set error codes only in exceptional data processing sit=
uations?

Regards,
Markus
