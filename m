Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD05AC77B7E
	for <cocci@archiver.kernel.org>; Thu, 25 May 2023 05:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Zvvwc8cnnW4Wc+pZOkXa60n/k+NdYaDNQDSle5oyfG4=;
  b=RQOql9FW/GqqHS5u8AkvJ7wxufhfgjlMWMO1bJ4l4egEryYmxIWmmDlz
   yz3uGXZXz6Egp3zFkYf2QMb8hEmp7+huuMquOv8qPpnSmAse8fHs5EjAU
   8E7CVFN4YRYi9lWLOrXr6ByvUmer/i4RdO+NdQxvlJgYoalIBbx5xs+1s
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.00,190,1681164000"; 
   d="scan'208";a="109558856"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 May 2023 07:33:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9DC3BE00A2; Thu, 25 May 2023 07:33:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A9C6E0082
	for <cocci@sympa.inria.fr>; Thu, 25 May 2023 07:33:45 +0200 (CEST)
IronPort-SDR: 646ef338_AlTBods2HA2v0BCRikU1wJcbUfS7l+u93WC/5AOBojEcoK8
 ojQuKv3z1LeYf7w+kd0/4YEafyNiWhuwL3h7AQw==
X-IPAS-Result: =?us-ascii?q?A0FDAAAy8m5kh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYIueFMwBAtHhFKPGYF2MYQzhzCQLoFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiBFIMzAoVcAh0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc/AQICASMEGQEBESYBDwkCGgImAgJXBgEMCAEBgnqCKAEDDiMHlGKcI?=
 =?us-ascii?q?n8zgQGCCAEBBpwOHywiVYFfCYEVLQGNLIM3eicPgVVEgTyBFYFvPoEFAYM+g?=
 =?us-ascii?q?1uCZ4lRhVyDRYl5gTBygSOBKIECAgkCEWeBDghmgXNAAg1kCwtsgTtaQx+BS?=
 =?us-ascii?q?gICETQODBUFWAKBBBABEwMHBAKBDhAxBwQ3CxgJBgkdHRgtBl0HLyQJExVTB?=
 =?us-ascii?q?4QrAwoKgQclBA4DGSsdQAIBCzs6PTUGAwsfBiYBHgIrgVgEL1p7BgEkJKB0e?=
 =?us-ascii?q?oEFmAStejUHgjCBW4FdDJ8bBhMvlxEOBpIrLpdgIKgSgWoKKYFcMxokgzZPA?=
 =?us-ascii?q?xkPjiAXAoQOj0g/NDsCBwEKAQEDCYVGAQGFfgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 P8hoYfi5ejAsex4TCjB
IronPort-HdrOrdr: A9a23:eOoKiqHlwKOncQc3pLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:5DD08m9Af+4rwhafn2qVv1cvO9onTXHn9mqOAB+pBGJbeqe8WUDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AtBgt1Q9quNoUkZN++fwPsXCQf/lXyo+wI38Nqpw?=
 =?us-ascii?q?Xv829LnNxODCWhg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,190,1681164000"; 
   d="scan'208";a="56933539"
X-MGA-submission: =?us-ascii?q?MDGEfocj3iytKpybufo7IZVaKlp/gMHCownMWw?=
 =?us-ascii?q?dVYWKv5TR6IEw2g6ufhVn3tsDv09Gvk2dlIQe2Q2WkUPOjjHY5Iq4Gsa?=
 =?us-ascii?q?1Mk+KEcNJZbvWBdQidoxndvUMqrysdwSSf5/n/h9ewn7q69E8nbGpsdB?=
 =?us-ascii?q?ol4rFyp/+B8FSoVMGgq2G8lw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 07:33:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684992816; i=markus.elfring@web.de;
	bh=Zvvwc8cnnW4Wc+pZOkXa60n/k+NdYaDNQDSle5oyfG4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GwjDEkE5rWV+5yH5IitMwi/haRSHrdnfmhEDRd9ydx/dweQuoNKKPpUKJUf+mhi9U
	 k7qJqdtOpaiiTftJB41IvxD4WYXYGU2i6FKy5WwUih3MijnTb2DgAECyNuybBZxCWS
	 riqiRh4ZiIO/CRaoRgWihwpKKY7RiOHzyGixWVuQ+Rs7x1zt260hoGtAbc0KyCYP6g
	 /uaiNH8IsWYq5dIPObeoV6vjqxqiyCOZekEeVrPxXP8aIp90+nAbv8syxYaAYLDbc4
	 ONye3Ft8I5Vc7C5ZL/973KpuFd6ikH+NFv9iw2CNW1EIUBCUeZ+I2Ati/PrFMhdbm5
	 dyHe+BojiQY7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1pkOEC2Wqu-00HgoC; Thu, 25
 May 2023 07:33:36 +0200
Message-ID: <1d7228fb-f1f8-364c-aa29-5719a9da1fc6@web.de>
Date: Thu, 25 May 2023 07:33:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: Helge Deller <deller@gmx.de>, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zheng Wang <zyytlz.wz@163.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 1395428693sheep@gmail.com, alex000young@gmail.com, hackerzheng666@gmail.com
References: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
 <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
 <c551c670-7458-ed50-eb2f-5a2b7ba421a8@web.de>
 <7e5643de-5d64-272e-cb36-bbe1e5c187ec@gmx.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7e5643de-5d64-272e-cb36-bbe1e5c187ec@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LMZlbeHN89kCJKhe59rpM7y9XNJxfVfn5bd0SmDU7/INgTp4/UN
 dL7/6qAwYe4mZzU2+/hnlf4zf5onXrRlcxdNx41t3V06tWGLtDA7q/e9SEJzSW8wJMsLSqp
 bYOgZ/wFwTbTXT7r4rpeMukoW9KwizCTPWq94ZaI20SmdvkRC8BxU+kGmQwMMGFYLnQtmgo
 /Jti0y2U2fziIa0JBqhKA==
UI-OutboundReport: notjunk:1;M01:P0:YOk3GgHWx4Q=;+P5zxHh4/35y8At3rtCdG5R0TSO
 6L/t2D/HT210rPm69YC2+uEAUL8rdurzRlbTSXZ5duG0s9p9J/ZDh05CmZkladr8b7SvukfVK
 40H9pUcIA832+OVAGtV7lkTltdRh3AjYlZH+v8139KG3jaaKPr+aH6pob0fNuX+1/xemqDYJZ
 NAx0CxGdV05n8B6np5TRF6FoxxuLxJDi7/2n1ntoUnPHc3XfzrBhuZRSBE5XhakxZcbuEUtho
 u9e9QMkylP/yojl1h/rM5m9LMSY1KW6esKP2pqZSFtawh1K0IR9+PSpb0dYJ8U/a2o4ZxtT7p
 yfVx6faSScGmV+mkta7NZ6uLnM1+pqUUkaDFUOt+pjE0PEH2/GXVA4S2WUUYwFKAJJx2/7tKQ
 g56HvEaDm4bnwMu4t3CITT1ef3n0fQ/ZO1cy+shEVZGQgDaM3nqHqkf1bHghpbZmhMagFLOVL
 jVQvFJw82BHvUfkjV3i11yV3Ag5b+K1hErGhsH4x1Lz/u7fcv3fgRfbo9kXMXM7q+i1QVIc31
 H9+CNFssgjAykaNhusKfy3EMrK+XZnM7SpsfNaUQsaqaRR/CJ5U6CTGhO6Cc7r0k5Qd4HtYtk
 rBMobpCvIK7itiYwo9/wGxaFXgKDY1LNDkLzJWTA2KjCiaNRFGQPRS7GY9eY+wCh2ZbR36hpx
 p/QXCSrd9MpldipVxdZ65/KKXpOFICeDZbGvjgBJqdCxd1CKrJn0ezCT4MYh6mGn72xcOsAKv
 dJzk9vTKcNl/EYzGK0SPuSnuiNq8M1q2vvcabIG7iVKChjYMewnx7kytGR39SXE748BHedeKn
 /UzYEsW6tfM0AWXOgTndLqD53S77TkJCxl5srUT4fUZDvH3YISzSVBnELmBsStSDcDQL/sJ1S
 Jn4DrH4EZEcYefuavgbu7kCXAtCJN2k+HW1VI7Rktw7JHjWK/nyO3CpMS7Vv4/iXL5uJZx2Uy
 c4hsoBS/3k1fGcxNXtj+tuuR+6M=
Subject: Re: [cocci] [PATCH 1/4] fbdev: imsttfb: Fix error handling in
 init_imstt()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1158
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/1d7228fb-f1f8-364c-aa29-5719a9da1fc6%40web.de>

>> The return value was overlooked from a call of
>> the function =E2=80=9Cfb_alloc_cmap=E2=80=9D.
>>
>> * Thus use a corresponding error check.
>>
>> * Add two jump targets so that a bit of exception handling
>> =C2=A0=C2=A0 can be better reused at the end of this function.
=E2=80=A6
>> +++ b/drivers/video/fbdev/imsttfb.c
=E2=80=A6
>> @@ -1452,17 +1452,25 @@ static int init_imstt(struct fb_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FBINFO_HWACCEL_FILLRECT |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FBINFO_HWACCEL_YPAN;
>>
>> -=C2=A0=C2=A0=C2=A0 fb_alloc_cmap(&info->cmap, 0, 0);
>> +=C2=A0=C2=A0=C2=A0 ret =3D fb_alloc_cmap(&info->cmap, 0, 0);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto release_framebuffer;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (register_framebuffer(info) < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 framebuffer_release(info);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fb_dealloc_cmap(&info->cmap=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto e_nodev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D (read_reg_le32(par->dc_regs, SST=
ATUS) & 0x0f00) >> 8;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fb_info(info, "%s frame buffer; %uMB vra=
m; chip version %u\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->fix.id, in=
fo->fix.smem_len >> 20, tmp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +e_nodev:
>> +=C2=A0=C2=A0=C2=A0 ret =3D -ENODEV;
>
> I think the return value isn't checked at all, so you could
> simply return below "-ENODEV" for all cases (instead of "return ret").
> Then you don't need the e_nodev label and can simplify the flow.

Can it be helpful to distinguish involved error codes better?

How should return value ignorance be avoided further?

Regards,
Markus
