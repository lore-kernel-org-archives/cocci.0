Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961A9C77B7A
	for <cocci@archiver.kernel.org>; Thu, 25 May 2023 05:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3CJ3M0DDsyJrCxfQNggtTyY0Dwy9Bnc5hVFb+2wLbmg=;
  b=FPhxIv3Hdw9bt+nDRDUKhuB+bkMhQ1YwOdevR5BpLe9VZ3zXye+/xin5
   sy0/N9x9zkbhwA6R+nCT6tRTcUojqnmn+Z/ysv748Isv7WNrMXEslg4Pi
   qxpPgftovu4Uv4Uvycaym0u3wP1lLOLsVraggHASDIe6EY6n1bZTMA6IW
   I=;
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
   d="scan'208";a="109556924"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 May 2023 07:03:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69326E00A3; Thu, 25 May 2023 07:03:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 369D7E0082
	for <cocci@sympa.inria.fr>; Thu, 25 May 2023 07:03:57 +0200 (CEST)
IronPort-SDR: 646eec3c_trX6fvBqhnR8ln1A6DEXhiOXpOY9A0nz15+ORkZMwMrtJrd
 KpK2mKN8yCyn9uIAnxsyGZEPVmavEp3mbTjUWsg==
X-IPAS-Result: =?us-ascii?q?A0EQAABr625kgAMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIudQNTMAQLR4RSiB2GfIF2MYQzjnSIaoFWgUA+DwEDA?=
 =?us-ascii?q?Q09BAECBAEBAwSBTD+CdAKFXAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAUBAhABASQXBw4OKYVoDYI3KQERZIEIAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQESAg06PwECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnoBg?=
 =?us-ascii?q?icBAw4jBw2wcoEygQGCCAEBBpwOHywiVYFfAwaBFS0BjSyDN3onD4FVRIE8g?=
 =?us-ascii?q?lMxPoJLFwEDGIFGg1uCZ4lRhVyNPoEwcoEjgSiBAgIJAhFngQ4IZoFzQAINZ?=
 =?us-ascii?q?AsLbIE7WkOBaQICETQODBUFWAKBBBABEwMHBAKBDhAxBwQ3CxgJBgkdHRgtB?=
 =?us-ascii?q?l0HLyQJExVTB4QrAwoKgQclBA4DGSsdQAIBCzs6PTUGAwsfBiYBHgIrgVgEL?=
 =?us-ascii?q?1p7BgEkJJ1xA4N6GySYSq16NQeCMIFbgV0MihKVCQYTL4N/jGqGKA4Gkisul?=
 =?us-ascii?q?2AgjTqaWIFjOoFcMxokgzZPAxkPjiA3g3CEYYpnPzQCAQE3AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBhX4BAQ?=
IronPort-PHdr: A9a23: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
 VNpPnHISuAJ54Y=
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:5DYh86nlEGMMt/liq0TYTUp6GKnpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:NmgLaWyiaYM52IhheK1jBgVPId8/b1zEkE6JLh6pVkJmZLyZVmKPrfY=
X-Talos-MUID: 9a23:tmJrEwvBokYdzAdBR82nmBxHDOxq7vuSUGMysq5dtdu9KghZEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,190,1681164000"; 
   d="scan'208";a="56931539"
X-MGA-submission: =?us-ascii?q?MDFNzvj/rvT/MUmZqBFHhEL2xT1Ql1RphrsKjs?=
 =?us-ascii?q?S5nONQME8HdNpOuOtHEfrqPRWw0GpvRCnp+FwkPXrhTjCGTG2PIhGI9Q?=
 =?us-ascii?q?gorCpBOUCg1VnzdPiyd2OKOkBDHirWneyO5SMDW3SQr3nzZzW+z/3aV0?=
 =?us-ascii?q?CoMPm8nlwzUSVXuk9Fya5yUw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 07:03:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1684991027; x=1685595827; i=markus.elfring@web.de;
 bh=3CJ3M0DDsyJrCxfQNggtTyY0Dwy9Bnc5hVFb+2wLbmg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=v8P8LtBn0XiUgHz6up0j6v8DeuWCEddxSPH8PznXkTMpIdGiohX59b//I8ksc0+dW86xHkV
 blK+XziUGj33g+bip8YVrFcg+WpY5+e1IuOSBWZJp6kFRz4ZR/r1yNUEJc6UVvIIRg8m6rI1L
 K66byEqtqldWdNNM07EWQdxjHTpDPd/1QNLfxsPcOucmt0GXAn2g/0sjohjI0F6/9Wv89dhIF
 ARO+8vbz4kWgQrXacmVcu9Tg/HvY9gqyxwu0xFu325ZjcnTqyDTAp7jCT4sgn1PiJneXVlkyC
 I2qpE7nFZvqLHk3CQE/hAkZ3pa2V+NwtZ3DYMwRnSHcAZ1vuB7Sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLARS-1pjpnV2x1e-00IEXO; Thu, 25
 May 2023 07:03:47 +0200
Message-ID: <f14c162f-7b48-39d2-7ff7-75a6dde01f7c@web.de>
Date: Thu, 25 May 2023 07:03:46 +0200
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
 <38cd2e4b-3df4-6c69-b790-5762d24e2c29@web.de>
 <a4b406f1-5395-1187-a27a-26fc4a5a00c5@gmx.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a4b406f1-5395-1187-a27a-26fc4a5a00c5@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GHRKgosjRZgvysKl/ZPmm5gXmI34Dy0rUc6HdIFE/xuI/AZoMk6
 0RhM2MN4wFwBix5wtGYQwwWDQbWvKuRYr3d2R9XUGRrwn3hPi++3K6E2hCB5lqg86OkGFBv
 IY6DViI8vbHt7yDKKqHcbCwIN16x5gkSvcUP1ark7tVXz5DutenMGmWlxrFEiie9WBpYKN+
 VxQsxK5S+Wjz27/nRmE+w==
UI-OutboundReport: notjunk:1;M01:P0:6ZC+WYkoz3A=;d/oi+nuIE1yEvvdGm8ycn6smubT
 wbT7SX4hdcDcBvUG/e7ipPwTo47tyHdYsBOX+y/3wheQaK9z5i3KQuuQ10fgiaIfspFgYnYAd
 vAaEaWVFfkplCkclOeIz1+zAAzVcOGyOwxQuieBVyh13g9QDd6Rm7TEutTrcEZ72ADkXA9Pbo
 0W+F819ObT0LkXjUAVws8cbvEyCkvnMZZx0gn0mnWM2hZcQe5gOEBIghhy8XEEV/4Dv7faNEm
 2ObBiBh6kPSK2B/tQxkQYyi6m4VtpQDnJJCTs7hMuFbUCjZNBpLnfBrM7/wxuPFPZLN6gVhcD
 Y1bBQJNdRtKdI1QnanHLYL7kExFqZ+2UGqCRdiO57dmSa1bWAfi/jfo1T72b3ZBYaCMei326F
 zGfcvEe21jieEMt5OgZNtj+FCDxjOZR8Lb4o4Qclu23j9R+6zNiOPBXUNawsB2qoR1mb0bVYE
 jsw9p3NJzedfC0Sm38vnMNESln7M5xGSfLxOiqP6Ilm0mkcEuaMqYViiduntv8MILcFuSR/X6
 Mev4/Dywn1+jH/zI12gwDhPvA0aJFjlxptg/JMn200ACfr6HpgrcMKifw8sOFmnAN7CMu/rgc
 Onej6CAH0uaiguK4u7jRUUj1nPZUsr5P0UbZeUNO1n5ek1gs4WJpzAR2WB9hKRx+44RJZ0+4F
 AExcxY3L7gH+jVX/YI3km0/c0ThnS9QK3e0PGw1e2RmzWiEbrpbTaSdCa+iMOemmDK9lc+Idp
 U/EdHLGklu3s4f0s04MI3dmqJUvEbfumQbx/3aCtZoKhsMqcNkslmB7h4Y9XUYLyUAmjdUIS7
 S+H9ukRUEHPlFSO4YYpU3E5ZeA5fuostFI7Zf7GqLEivosZt7kjf7gLyEXiqyNoYHbQQ2tOaq
 dfk3nhNDy/HVueJVbSgoHs9Gjby+sHxtOCgYaCcLNJT0XlxEIwL825sfgLZTipkKyP7JzdlXe
 6BFWHA==
Subject: Re: [cocci] [PATCH 3/4] fbdev: imsttfb: Move a variable assignment
 for an error code in imsttfb_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1157
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/f14c162f-7b48-39d2-7ff7-75a6dde01f7c%40web.de>

>> The value =E2=80=9C-ENOMEM=E2=80=9D was assigned to the variable =E2=80=
=9Cret=E2=80=9D
>> at the beginning.
>> Move this statement directly before the first ioremap() call.
>
> Please do not move such variables without real need.

Is there a need to explain desirable effects better?


> It makes backporting (of this and maybe follow-up patches) much more com=
plicated

I propose to reconsider such development concerns a bit more.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dri=
vers/video/fbdev/imsttfb.c?h=3Dv6.4-rc3


> and the compiler will optimize it anyway.

How much do expectations fit to supported and documented software optimisa=
tions?

Regards,
Markus
