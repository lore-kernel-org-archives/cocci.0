Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D33EC433F5
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 12:50:42 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D185613A6
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 12:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D185613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2374021"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2021 13:50:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 41680E006B; Sun,  7 Nov 2021 13:50:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F5F4E004C
	for <cocci@sympa.inria.fr>; Sun,  7 Nov 2021 13:50:34 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AcMzDsRUERXU3lCUn/Qsbv+n1J8nV8KzTUjF92vM?=
 =?us-ascii?q?cY1JmTK2v8tzYMVDF4r011RmVB9yds6MP0rKP++C4ACpcu87H6ChDOLV3FDY9w?=
 =?us-ascii?q?f0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV?=
 =?us-ascii?q?6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRvMusUMnYdvLqk9xgbVrndVZ?=
 =?us-ascii?q?u9awX9kKU+Jkxvz+Mu84IRv/zhMt/4k6sVNTbj0c6MkQLJCET8oKXo15MrltRn?=
 =?us-ascii?q?CSQuA+H4RWXgInxRLHgbI8gj0Uo/+vSXmuOV93jKaPdDtQrAvRTui9aZrRwT2h?=
 =?us-ascii?q?yoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7WcMgETmRdQMleSy1BApu?=
 =?us-ascii?q?9b4QRCeoBIf1YpJT5q1cXsBeyGRWgCObpxzRVhHH5wLc63vwiHw/I0wMvEc8Av?=
 =?us-ascii?q?mrarNv1NqgdTe+7wbLUzTXadf5axSvx5YbKfx0nvPqCXahwcc3UyUQ3EA3KlE+?=
 =?us-ascii?q?QqY/4PzOOy+8DvGyb7+R6VeKujW4npBx6rz+oyMg2kInJhZ8Vykve+St2xIY1K?=
 =?us-ascii?q?8e4SE99Yd6rC5ZRuT+VOJBsTsw/XW5loSA3waAJtpCnZiYF0ognxwLBZPyddYi?=
 =?us-ascii?q?F+g7vWfuRLztmmn5oeayzihSv/UWkxeDwSMi53VdKoCRFjtTBqnIA2gDN5sSbV?=
 =?us-ascii?q?PZw+kmv1DeA2g3R9+1JP104m6rdJpU8zLAwkZ8Tvl7CHi/wgEj2jamWdl8l+ue?=
 =?us-ascii?q?y8ejnbK/mqoefN4BqkAH+NLohmsilDeQ/KAgOUG6W8vm/2r375UD1XqhGguMsn?=
 =?us-ascii?q?qXHrpzXJ94XqrO5DgNPz4ou5A6zAjOo3dgCgHUKIlJIdAiGgoXnIV3CPf/1APi?=
 =?us-ascii?q?5jl+xijlk3erGMafkApjVLnjMjrPhfbFl5k5Zzwoz0Mxf64haC74fO/3/QFL+u?=
 =?us-ascii?q?8LAAh84NQy73frnBc1j2o8DR26DGLGVPL3QvFOS++4iI/OAaJIatTrlLvgq/f/?=
 =?us-ascii?q?ujXs3mV8Heqmp2IMaZneiEfR8IEWZfGHsjs0OH2cOsAo+Vu3qiFuNUTNIaXe9Q?=
 =?us-ascii?q?bkz6ismB424FYvDXJyigKSd3CenGZ1bfnxJCleQHnj0doWJQOwMaSKXIs95iDM?=
 =?us-ascii?q?IT7mhS4k71RGvrgD20bRnLvDM8C0CqZ3jzMR15/HUlRwq8Tx7Fcqc3HuJT2Fwh?=
 =?us-ascii?q?W4JRj423KVkrkxn0FiPy6l4g/pCFdxS/fxFSAk6NYSPh9B9XvLvXgPINvOAV1+?=
 =?us-ascii?q?iRp3yAyw1T9t3x9YRakJ5M9SklBHKmSSwVftdqbiCH4A196PYl1L4LcV0gyLY3?=
 =?us-ascii?q?qArjFAOWdZUOCutlPgs2RLUAtvsml+air3iWKASxi/L+y/X6GOUv1xDFiN0X7/?=
 =?us-ascii?q?EW383eUbc69j0sBCRB4SyAKgqZ1MSgfWJLbFHP5iw1Q0urBbLPdPDfySulm32C?=
 =?us-ascii?q?RvanttkiaL1dm9b0CiPUCDsfCgM8HzAOQVsX0+c?=
IronPort-Data: =?us-ascii?q?A9a23=3AxNmWY6JGOUfouLLWFE+RgpQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC41Dhz02MFzGMfXm6FM/aKamv0ftAjPYm+o0gBsJ/TmKc2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRH+KjULe?=
 =?us-ascii?q?s1h1ZHGeIdg9x0XqPpMZi2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?glavnNFIHSPjeMGBiiFIMAvLk2EId4HVvlP9nXBYfQR8/ZzGhutlry8hW87G0R?=
 =?us-ascii?q?x0oOKLkh+kXFRVVe817Ffcdp+OfeCXXXcu7lhCaLSK1nZ2CFnoeNooT8edfGnB?=
 =?us-ascii?q?L7fVeKTYXbxnFifje6LayVeBoguwxLczhJopZu3d6zDifA+xOfHxpa7GSsIQeg?=
 =?us-ascii?q?SNp05gIReKEMpJfM2cxMgCbNkUJZ0NIXbsguMytoFX/VxxRjmmQqZYtxVbS6Rg?=
 =?us-ascii?q?oiO21dILBEjCRbcBSg1reuW/MuWj0aiz2/ee3kVKtmk9ATMeW9c86ZG4TKFF83?=
 =?us-ascii?q?vttnUHV2WEZThEbPbd+iZFVlWbmM++z6WRNksbtkUT23FOmRJ/xUnVUZVaa6wU?=
 =?us-ascii?q?EVYM4//ISsWmwJ2m93+pdLncJRHhNZbTKcedeqSMCjje0oj8iOdCjXHB5h55QG?=
 =?us-ascii?q?nd4YA5e4RQoEFI=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASZDqAawL1fnOUgOiluglKrPwCL1zdoMgy1kn?=
 =?us-ascii?q?xilNoNJuA6mlfrOV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCigh?=
 =?us-ascii?q?rPEGgA1+XfKl/bdxEWn9Q1vcpdmupFebnN5DNB7foSjjPIcerIjOPnzEiy792u?=
 =?us-ascii?q?tEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AJAgAdy4dhhw4P49RaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgVmDIVc6MQOERI5vgXeSS4wSCwEDAQ01CQECBAEBhQICglMCHQc?=
 =?us-ascii?q?BBDQTAQIEFQEBBQEBAQIBAwMEARMBAQEMDQ4IJxMkhWgNgjUpAYNkAwMjFQgBA?=
 =?us-ascii?q?REmAQ8LGgImAgJXBgEMBgIBAReCVgGCVAEDMwurDIExgQGCCAEBBoE+AQMCgwM?=
 =?us-ascii?q?fLCJRgVoDBoEQKoojgwx6JxCBVUSBPIMDPoJjA4FfgxiCZZBhApRBrEAzB4ILg?=
 =?us-ascii?q?TCBOQuJCpQbBhQtg1oBkgkOBpEwlhAfjFWZOIF4gX0zGiSDOFEZD44gGYQMgQu?=
 =?us-ascii?q?DVoVLQDMCATUCBgsBAQMJhUcBAYssAQE?=
X-IPAS-Result: =?us-ascii?q?A0AJAgAdy4dhhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAgVm?=
 =?us-ascii?q?DIVc6MQOERI5vgXeSS4wSCwEDAQ01CQECBAEBhQICglMCHQcBBDQTAQIEFQEBB?=
 =?us-ascii?q?QEBAQIBAwMEARMBAQEMDQ4IJxMkhWgNgjUpAYNkAwMjFQgBAREmAQ8LGgImAgJ?=
 =?us-ascii?q?XBgEMBgIBAReCVgGCVAEDMwurDIExgQGCCAEBBoE+AQMCgwMfLCJRgVoDBoEQK?=
 =?us-ascii?q?oojgwx6JxCBVUSBPIMDPoJjA4FfgxiCZZBhApRBrEAzB4ILgTCBOQuJCpQbBhQ?=
 =?us-ascii?q?tg1oBkgkOBpEwlhAfjFWZOIF4gX0zGiSDOFEZD44gGYQMgQuDVoVLQDMCATUCB?=
 =?us-ascii?q?gsBAQMJhUcBAYssAQE?=
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2374015"
X-MGA-submission: =?us-ascii?q?MDH8P3NMaSaNUL0anEIr8/+ksnsFyG7r7LF466?=
 =?us-ascii?q?61jPd86xyJxsOF9yfAAzTaOQicWfCgnE61ZAvOVA0t91YQEu3CCtkY/L?=
 =?us-ascii?q?neYzKChMe40nw8rn56t187AY1e+u3NqLJVo7zEIIBNiJUCX0srS5pZ8r?=
 =?us-ascii?q?1fvNk/ZbLQCA7syVNplIyOng=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 13:50:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1636289432;
	bh=KsHo21a7v3jwwArEjBlL7abizbx9l+pVxmEXl8X4msc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c9zeHineMnz5VVJIaZm3aiWNEOt7gfS4YoUmuC4qlOvXc4VbEFee5Q5KGQkKuXCWl
	 BlFNlkQi/MahZhUIjN2QYGs4O2/Wdzc86L6a3Gm0Dt7/x+XmE36oVWgH189alLh+hs
	 ZD4vJDYP/21Y6WI2I4cu4Y75GLqA7wGka6WSzBzk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.63.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MovjW-1mOA3a1NYk-00qFK0; Sun, 07
 Nov 2021 13:50:32 +0100
Message-ID: <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
Date: Sun, 7 Nov 2021 13:50:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Vlastimil Babka <vbabka@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
 <alpine.DEB.2.22.394.2111071321530.2988@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2111071321530.2988@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LhQEWINUlgmfz0Yd9Weei3spf/9TZ/8dalgECm8N1+ovFExM1va
 Ge9OKyoqKH4ecjO9YDO12BP2aZTT1+d1p0VghN8OKfH+DRll8N5ogADo1g3b/JvEl9Z+y33
 BB8GAIs8SSU/1PBWqN2VhoXThY4d7BKcJO/u/y2Q/TxB20lvlSI8DW7JeUWR7gbmxYjpR/8
 PX7sOWBrl8Lddmz0f+pwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mF8u90bFALo=:r0npl3XjRPZv3rDGekQNUe
 uhSRuMmAZUKpfG50MhdaTcq++N6Ly5uXNR4n+Frs5dx1F1c4x3ySZdFgn352XQv8CBWyVi6UQ
 2BIF33e9o9+P8PtrGoKI78M9SSXWs/EsM7Wa1krl5809cXIE39UW0CmfiDIrVBcGUXJxRSUYX
 wNVFPfQnv8HQt9KwnRtoe7tyWGR+eXUPMwVEwMqUEZtjy/kmMlmaIj5I1+aXfStDFmYHeXFAQ
 PyupREn0In/j54kg8LCws7Ouqd1cq11n98gnICXR0OKeoOcidRcu+Bh3zkQrSW5IiCyroBs1c
 N34xlfS9e06fWnpKR5LL8Lj7kOR6TbmpUQXl1MIk6ieF4V9afJf0WpjzD9l3HzBQpmHV9K48d
 QqbcS3mZbvyAUmg3GIYlG4VuU1ZE31rNgDF/UzilUP5Jx7wxLe7bCVhFBvJxaAr+0HfftcDBX
 ZltOGddWMribL8zDkh39EV23i5bEI5Rwa+A7Mmo/hduWDu7lIBgcV1M5C6bAl6gge+BJ4PU79
 cBPWmtbx9g5YXdXS/lRCO+k4Afe9d8sJnps+TdbYDO9fMiIqKfws64uMOU7whxvrS8nuVwSo3
 LslNhkXeGI8r3Quo/snUuWBRrJy9YpGnE18cdoKo8GM0bg8y3geNw5YAm9V/SZ0w+UA2QWYYX
 dgPFxBadCSTLM28kg/CILdEzsCpUTRGSdtLtwj5CTBPdlourwFAR2rriGIGrH7w3a6zjpcHmr
 uImmFzUcnkl128HWHg2JY72UetqALDdJ28kAaTXUuIUvJffoSL73CU2zIep+flsOsYCQTbShg
 ZUa5//xdBe1hskIOy3YKq2Mby7Tl8Z/BerIc+I51z+ANmvp1b8+0EFf3wlBAUKAHadO1syQtq
 e15xg55GzWVIzEf1xmx3RMPFqsGIWukqdfarQ1cXRPt1g6xfn6nf35N8FijJ41O3MfDl42Ph6
 EXMR9W7+f4juYJav/JaBKziZnaguJDAB3X1Zxp0E0l6yb8YGSXIu/yz67Vd9f9azeffVyGD9L
 T7reqNhj95yYlS5vsiMCxfLz/SAWaDIVy2/ZRCsyLIV81y1J56Cs/WXmWeTsjsqaCk6POZEsA
 YfCLHdxLGOwidA=
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 89
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/000e221f-1bac-6e29-8c68-2c1eab5b2128%40web.de>

>> * Will any guidance help to find nicer solutions?
>
> Luis already proposed a perfectly reasonable solution.

His proposal can look a bit too terse (for affected implementation details=
),
can't it?
https://sympa.inria.fr/sympa/arc/cocci/2021-11/msg00017.html
https://lore.kernel.org/cocci/YYVZva1hfwanXdyB@bombadil.infradead.org/

@@
@@
-struct page
+struct slab


Regards,
Markus
