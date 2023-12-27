Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1104DC46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=89N9lhXf0+V5TDws2RtrDi2eTRvFMJpvt+kjqpaCNIU=;
  b=gEaDVKrzPZjHpYnUXG/CFg+wc4CtmiUPEOl7azTnA7ICsfPfSLOgKFS5
   LJZYoDm0SeuzkMD/YJvPla/CY/JpJ0HT8Fhem1pEq7FVCUhiUcqi6d7G9
   kt16nmQsKSkQ8adlHZyKOMZEDVPF8iud2UQSn621abzUKUKFGMQqwZDOO
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144152473"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 18:28:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E518E0CCA; Wed, 27 Dec 2023 18:28:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 72E9DE004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 18:28:48 +0100 (CET)
IronPort-SDR: 658c5ecf_kLYkh2GBte7oX1LbFJ+YiuSg2QoZRKX5GPxZhrxo+nRv7/C
 lah7zkB4H/TB4gLOHWjS3SVx0Z2iFiwGhIG4WBQ==
X-IPAS-Result: =?us-ascii?q?A0FgAADEXYxlewMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4f1MyBAtIhFOPQYF1LQOEO4c1h0yKRYFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSCC4J0Aoc2Ah4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBJBgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCA?=
 =?us-ascii?q?QICASMdAQERJgEPCw4MAiYCAlYGARQBAYJ8gisBAw4jB646gTKBAYIKAQEGr?=
 =?us-ascii?q?1gfLCJWgWAJgRouAYgaAYkoeicPgVVEgTyDAz6EQ4NbgmiDZp0wWyIFQXAbA?=
 =?us-ascii?q?wcDfw8rBwQwGwcGCRQYFSMGUAQoIQkTEkCBX4FSCoEBPw8OEYI+KzY2GUiCW?=
 =?us-ascii?q?BUMNEp1ECoEFBeBDgRqGxIeNxEQFw0DCHQdAhEjPAMFAwQzChINCyEFVgNCB?=
 =?us-ascii?q?kkLAwIaBQMDBIEwBQ0aAhAaBgwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA2wfM?=
 =?us-ascii?q?gk8DwwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsoAywGOwISDAYGCV0mBw8JB?=
 =?us-ascii?q?CUDCAQDKykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUJCxsGPgInph9aKF+Uf?=
 =?us-ascii?q?x2DKAGPdJ5yNAeCNIFggWEMnysGEy+DbpM4DgaSVC6HUJBPIKhGgWoBMoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiCEK49HQDU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:g6cs1an/68CXDrAmZ1DhnUro5gygIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOWzzUPPzeZ2HyL9F+bI6w8xlVvcXVy9c3HgA5qyAxFltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayaj58B56r8ks1562o4mxA5TTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN0tAR8wOqkg2NxvCEUe8
 fw3NQBXQD+q0rfeLLKTEoGAh+wmK9T3epwSsDdswFk1D958GMqFGf+Vo4YFmmxYasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw9w/J/PpssjK7IApZiZjVd4bwVeGzeJsPhW+Gu
 Tr72VXTHURPXDCY4WHZoir31rCncTnAcIkVH7a53uV7hUWagG0VEhwfE1WhycRVkWa7XM9Db
 VMZ8GwioMDe6XBHUPG+UkO+p1q8nCQEUv4AF+0V9THX5IX9tlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOdCJmOPFIZ563unKxQ5eKRQowXk+iTgsYSZt3jUOiIQ0kw6JUdtpVqK45jEUJd0S6
 2HTxMTdr+xN5SLu60ld1Q2X695LjsWXJjPZHi2NAgqYAvpRPeZJnbCA51nB9upnJ42EVFSHt
 3Vss5HBtLtQVMzRxHTVGrRl8FSVCxCtb2C0bblHQMVJythR0yT/JN84DMxWfhY2bpleEdMXS
 BaL414AjHOsAJdaRfQrM9rqW5tCIVnIFNPjUeucddcmX3SCXF/vwc2aXmbJhzqFuBF0wckXY
 M7HGe7yVypyIfo8llKeGbxCuYLHMwhkngs/s7inl0v4uVdfDVbJIYo43KymNLpntfjd/1uJo
 76y9aKikn1ibQE3WQGPmaZ7ELzABSFT6Une+pIJJN2QaBFrAn8gAPL3yLYsMd4t1adMm+uCu
 jn3VkZEwRCtzTfKOCebWEBFMbnPZJdYqW5kHCoOOV3z5WMvT7zy54gidrw2X4Idyspd8dBOQ
 cM4JvqwWsZ0dmyf+hA2T4XMk4h5RRH62SOMJ3WEZRY8Tb5BRivI2ITWQSryxgYzDw6cl8g3k
 5u/3Cz1HLsBQAVDCp7NSfSNllmeg1kUqNhQbWDpfOZBXVrKy5d7DRDxgtscAdA+GT+ayhS0j
 w+pUAol/8/TqIoLwfz1rKGjrbbxNdBhH0BfTlLp3ZzvOQb0pmOckJJ9CsCWdjXgVUTxyqWoR
 cNR69reaPQnvlJ7g7BQIoZR75AVxoXQ/udB7wFeAn/0QUyhCepgLlm4zMB/jPBx6YEDizSme
 HCk24d8AqqICvPHAVRKBQsCb8a/7982tATWz8wIJBTd2Hcq0puBCV5fLjuduhx7dbFVCr4o8
 c0lmcwR6jG8tCYUD8a7vnhU2Vihfn0keIc7h64eG77u21YKyEkdQJnyCR3WwZCoavdQOBIUe
 huSiK7zhulf9HHjaFs2L2DGhsBGtKQNuTdL7V4MHEuIkdz7nc0K3AVd3DA0bwZNxDBV+rhXF
 k10EXZqNIOy/ztMr+pSbVCGQg1uKkWQxR3s9gEvimbccXiNakXMC28MYcC240ET9jNnTAhxp
 b235j7sbmf3QZvXwCA3ZE9Crs7jR/xX8inpupiuP+aBLqkATQvVuI2cTktWlEK/GuI0vlPNm
 sdy9uUpaaHbCz8Zk5dmN6akj4YvWDK2D00cZ8p+/ZE5P3DWIxCz/jmsF3qfWO1wI97yzEvpL
 PA2e+xuUUyl2TesvwIrI/cGA4VJkc4D4PsAfbLWJlA6jYaPkwoxsL/t8nnRuWx6ZfRvjsc3F
 a3JfR2gDGG7pCVZik3NnuZ+K0u6ZtgIPjP9+OWP9MQICJMxn+V+em4i0raPniu0MSk22zm2r
 Q/8d6vt4Og68rtVnqzoCbdmKzivDNHOCNSz7wG4tupRYeP1Mcvhsx0frn/lNV90OYQ9dstWl
 7PXlvLKx2LA4agLVl7Gl6m7F6Vm4du4WMxVOJnVKFhYhS6zZ9/+0SAc+myXKY17r/0F35OJH
 zCHUcqXccIZf/x/x3cPMihXLEs7OpTNN6zloXuwkuSIBh0jyjf4FdKA90LyTGRlZyQNaozfC
 Aj1hq6U3epmjr9wXT0KO/I3JKVDAg7TafNzPZm5/zyVFXKhjV6+q6Pv30hooy3CDn6fVt32+
 9TZTxz5bw6/o7zM0MofiYFpoxkLFzxotIHcpK7GFwJe0FhWzVLqLNjx9b0DDYxI1DP/3tf0a
 VkhqYfk5TrVBVx5ndfUubwPnTtzwsQRN92/KjFBE4a8dXKtHI3ZaFd+3n4I3pq1EwcPCMm4J
 NtY9nCY0t1dBH12bb5728FXStuLCh8XKrzkNKw9fwHP784iPIg3
IronPort-HdrOrdr: A9a23:W87oe6H814d3UsHnpLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:AbMO0W3Szb47YY6sfuWtmrxfWc17dHr59FXqO0acWWJpZ6ClE3G/0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3ABkZgRA8/HSZYghlzqmJ7cn+Qf55I2+PyLW8wqKh?=
 =?us-ascii?q?Y4dKtKzMoBhGspiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75418392"
X-MGA-submission: =?us-ascii?q?MDEZPiilJVleFiqZVHtP9iKJ0xBOWW8L/c9VQX?=
 =?us-ascii?q?DnobrtKmXs0wUfwS3w8lyz9Ca1NKfpZLiogb3+mc5pU5FIoifj9xEyIS?=
 =?us-ascii?q?kVLGzk3CrcLgNDkVJBiQk4s1bDiYuuWjaWExfdHPFh4jEVCfjdu4NYIw?=
 =?us-ascii?q?3CogFrnW8Rd28/wDXij2K5Rw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 18:28:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703698110; x=1704302910; i=markus.elfring@web.de;
	bh=hrGMV7DS1Hq9z/Sx/zgTn8G7c+CCmRc26CbqvNt/lTY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=u18bTJEcOAvYsxLq2lWLLpNPETzZtg5KKMv+5oPocaSc6yRIXH4aN75ZdeEoC2kz
	 /A77l9JH7Dzu9Bij1azXZBQ3QhcVoIXbVr5ZzD6EZVaKgIKePcNboM9JBRAbNW8wo
	 OrIm+TfWhtxy4YDmyx1sjJSQyhZ2LjJx9h9T87VyKDssasmDRWAg32/5ezt4pLxiF
	 q+HX2KCT4GXxnSi7MZg4c1B8zTRkMgcG//XsrbGfm8jQJkh4I0Cyez1GpoTWyrKPr
	 l5z6tsae39HqVj9n4VUIoOaQvyU5c7BhlLZoZdGOqJ0iwyZXIjxOTh2m2IAM29wvy
	 5J/j3eUDOMRTqcEvnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWoe-1rXrfC2Un2-00KL1N; Wed, 27
 Dec 2023 18:28:30 +0100
Message-ID: <017f212f-fb55-42ca-bc1c-7f2522194a9f@web.de>
Date: Wed, 27 Dec 2023 18:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <2aa6bd31-f3d8-41ac-abf1-9ec7cf7e064b@web.de>
 <ZYxXTVpLfI-mgxF4@smile.fi.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZYxXTVpLfI-mgxF4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V9bNz1Vq4gc/izWZjmMc6xV8NhQ1cp41dBgf3I03DmYlY+8jTNt
 X192lV3pIcnPwQbGPj2wre8044olcROF4pPcdNDRfwlDjgHf3K1j79LPHSmcGez3eS3dMGR
 uFq/pFapverKkfXx0gTbHMdfVynoxGUlsl7xsLXH7/iQSKuPJIIQbEw5b+QqahJN8YLpC5F
 gnHx15GAazW62NiqY25IA==
UI-OutboundReport: notjunk:1;M01:P0:ReUDYDxLwuE=;pQgvrz6qztCFdyc/FQRg/Nk1gqt
 Vcj1nqZWWIYul35Q8rzZYlLrCemvCGgZER4teElf803vFXfeyFp410ZuyNUZnKMoD6a0IaNMl
 VxjwpoJB8LWYeHuGZ1TXf1Ik1BsET0C54sT+23Xbx6gSO/iWcpPAv9EsdtLnCCfgQ3M8ZhRjZ
 6qdCN34hBlbTjPINFupc9J7zdM9EhH7b8CI+J5S8vGFUEcf/68hWmZQNoXpPX2CIlkgx0wcMl
 7ib4QIvoj00nMkT6ag164VQK/idITxIybYGYYUrRpODiS0sxVGMKZJbsvvc8ZTPJYvLtSjHdd
 fziTLfGdoC7BbZLx+RlHjDTSldF/ZNhPSkxB0obRyCAvZJg6r43PXDDt5q/mH7JRXZrHzLqw7
 jrmM0WqBsxxB8vCDjgZ/NVr8C0kQtiyWTimVycjot+3Ldcn8KlSNUJFopnNGn1jWrmIt66sNx
 coIfA0/E3HgzLR2Xr/vZdZ53gyMmm62bHUQedstSGGgiNBRrB9Pt3D969jkjLTFRjR8WVB16Z
 nLsMemmFK8NckbjtSr10ovnaVYvCvR/7q8nG31cRJYyayGTcx6qLAFiuCK4ronXs7RtNm6vLm
 uk7rJxeOcuwtTSJn06fko8+Hviha7rIWkDVdXLlIIPYlushrsH+Bhl8wOSqCYnRsGTHhrJo01
 CktMUBmjYLNq4NPTahjFFTFqTw5MCiQKIVNugIe2EacZEhbNBvtfKXU3+HVBEqNwKmHjRQkE8
 HVTp5HjOqwxCKY6vLSwDVMtWJ3IxAIgFcTh9XEfh7jfSEmvtleNWpqAYe0efPs88Vy6kZ9mw6
 Ree21vZugeZOS62MtL6K8H2OAuwbaKZSpV751jlP1L+rWmpbM6j3uUBVIvf8SrDMTgFquLrIH
 5a0pzAoR+9dXmeUSoHKhzL+dbDgvS/aSjwYmPpQyd4kkml3cOo94M2kHMVh9mXAQBFj0mC5mt
 zorgMw==
Subject: Re: [cocci] mmc: mmc_spi: Adjust error handling in mmc_spi_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1422
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/017f212f-fb55-42ca-bc1c-7f2522194a9f%40web.de>

>> The kfree() function was called in one case by
>> the mmc_spi_probe() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>
>> * Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=
=80=9D failed
>>   at the beginning.
>>
>> * Move an error code assignment into an if branch.
>
> How is this one better?

I suggest to avoid a bit of redundant data processing also at this source =
code place.

Regards,
Markus
