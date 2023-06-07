Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88108C77B7A
	for <cocci@archiver.kernel.org>; Wed,  7 Jun 2023 09:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VItb0Sx4/20fRlUbFbydrSn0LtSMWdtqET4bVw9sDX8=;
  b=fnbraX6h3mgnHbHB0ciHZ/Sxl9lwC094sl4+v78ERty5rDZEXqCLYixS
   NdGaFdFZ4wi2OqX2pR49QR/+Qugl0jqcpeZ3jTdvF6E0mlDO+ZEicf8Hu
   a6aYKQydAXw1WYTdQVCLscjit7yoVErdetINHXwWWhfqjIo/Lwugde8zZ
   U=;
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
X-IronPort-AV: E=Sophos;i="6.00,223,1681164000"; 
   d="scan'208";a="111661370"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2023 11:08:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3377CE0CCC; Wed,  7 Jun 2023 11:08:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EF7E2E00BA
	for <cocci@sympa.inria.fr>; Wed,  7 Jun 2023 11:08:10 +0200 (CEST)
IronPort-SDR: 648048f9_6xOjHtk2lpcILMTVz/iIVJtmN0wX53DTVononKkDWbKP5AH
 Qq0Re9jpKcAxTOaism+TZtvevH7itSU/EZZbUfg==
X-IPAS-Result: =?us-ascii?q?A0E5AACjR4BkgA4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIudQNTMAQLR4RSiB2JNIQzjnSIbIFWgUA+DwEDAQ00D?=
 =?us-ascii?q?QECBAEBAwQ4gRQ/gnQChWoCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQFAQIQAQEkFwcOBQkphWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARICDTo/AQICASMdAQERJgEECwsaAiYCAlcGAQwGAgEBgnoBg?=
 =?us-ascii?q?icBAw4jBw2taIEygQGCCAEBBpwOHywiVYFfAwaBFS0BjS6DN3onD4FVRIE8g?=
 =?us-ascii?q?wQ+gQUBgRorFwEDGIUhgmeOM4UdiUuBKW+BHoEifwIJAhFngQoIX4FzQAINV?=
 =?us-ascii?q?AsLY4EdUj0egSgCAhEpExQFTXsdAwcEAoEFEC8HBDIJFQkGCRgYGCcGUwctJ?=
 =?us-ascii?q?AkTFUIEg1oKgRFAFQ4RgkQlBA4DGSsdQAIBC3A9NQYDCx8GJgEeAiuBVzBYb?=
 =?us-ascii?q?wokJJ1OA4MDfD9GOpdMjSegVDUHgjCBW4FdDIoSlQkGEy+DbpMlDgaSLS6XZ?=
 =?us-ascii?q?iCLSYFxmluBYzqBXDMaJIM2EzwDGQ+OIBeEEIRhimc/NAIBAQcwAgcLAQEDC?=
 =?us-ascii?q?YVGAQGFfgEB?=
IronPort-PHdr: A9a23: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
 UljKSuCWL9bybdtJzgDYOr0ppZFX/JRH/UsXQ==
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:a0ozta++5jnxcwKt3ptuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:DbntMGPBPmk0Su5DH3dcyWgQE8YeWyfG3lTJAGCRUm01YejA
X-Talos-MUID: 9a23:d5X+vAWZbGyQmy3q/AO2uxE9KOxq2ZaNGEMispBdnu6jKxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,223,1681164000"; 
   d="scan'208";a="111661361"
X-MGA-submission: =?us-ascii?q?MDGjQTOFaQapPtc2XuxUrOYvr2NQMGWmlXPrb6?=
 =?us-ascii?q?FTnQmVgO8fampzKUMUsLRE60hdGZimfZXl2Lo7W8MCGZyWWQEA+gbcU/?=
 =?us-ascii?q?gMugJjmnWNifhdswRFsJwlkgx0rAlGK7eW8y+VT69Bb1f6/pqvbbW2Ra?=
 =?us-ascii?q?GFNGEnAfSuDBerCQzFTKleSw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 11:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686128881; x=1686733681; i=markus.elfring@web.de;
 bh=VItb0Sx4/20fRlUbFbydrSn0LtSMWdtqET4bVw9sDX8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HLoi2klC/omwU1T319lQhG1bk5mLG+NJleJ4t3xlVS798WU6L4lkfzcr0iaO6so3oJFrnjb
 J+CzpnpdE85Yml/sNsIqTt3GpZuUoMMk0KnGpArU5Kk/4opRfH7ehYBWwDC+4ZgUQGsKdvWng
 Kk3+pZyJXVhPY9IMTIoRZeebbsO5BNc7yfuXdGqBM91K0Z8HASMf5wmkYGdAdcmpASexckinf
 bESOlFDaJ/K6JJG5xyMLBS7sjyTWZoWtB+U1GLG4Z6ujjLsxja2OdDIWaKE7rzKIZYTxYUC5d
 uMayXzWmz2IpHOMGlo5COE8ZR8cBLS9uvwAXOPYqiq6R9/Cc8GRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4bO-1qIOvS3yos-00By47; Wed, 07
 Jun 2023 11:08:01 +0200
Message-ID: <dc893f7c-c517-4a30-818c-261d6c64b5ba@web.de>
Date: Wed, 7 Jun 2023 11:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
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
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7e5643de-5d64-272e-cb36-bbe1e5c187ec@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ePYFjpUfSnNiyvQ1dJJgtd6Eb7pJAYYz2Yrjv2wodsTZ4t5rB+k
 G0DXWUgvSRDBQJoAAJ9oL3RKG/sxvlkdhkJ5GdcsLd7yQBT4A5YLyruDhCXEf7B9x3XdZwq
 r9jeTFC5SJcwqMiQ8VGZ550oNbQ3GuAPFAyNfkDXJsYNwkzyA6sd2DvKbun0HzzQSVRIctO
 rELufPAqvXdK3G31NjqaA==
UI-OutboundReport: notjunk:1;M01:P0:NozEjkHBoME=;HBRRwY92dw6NXPRvbNvVTFrQyq8
 Of56V40YDaace08x0vKVzSmBaOhzdIXoveoRYfYQreTXpb8aHBOz22OnftsJY5DcxTYn8MF0m
 FAhAYUC8MEVihMs/cv5QFw6sur66c3eb3oT71/RsqT0CZwIyayGlul0rZVMTzgZJiaaZXfYMj
 tqxIWxMMODmldBLx0HAOKcqr0yh7RoGC3YadkOVWm8y4tLtoMKustQ91Sueyz3V3qsIjUoVkB
 NeDfduFN1z/TbdvbH1C+EAgmwATZBcc1VXFW43VCU6eOLeUhACGySuyNjRfydwOCrftiq8d0v
 pdg7zSY3/zFiDVUR4JAVZNZKONRog2QS0k+L6gCAKqRquRQw7AYANi7c2Uo24uXq9r724AF6q
 sk4diwDb089C8kheoPSqPPXMT9bUCBv0kvRfr3/h2iPlBDqSUYHyFxxr39XKfnHXmCq/ju7vd
 ude716P1Rc0QhDBylgFfEzGHuDidXUu6SQZzkdgZVx7b8yM/5Eo/7+IPmaJp9I6RLVibLAmo2
 E7E7Fa8OTE8oG6trGrAlG6wkGxDA3JS4JrphCRLYnUKlN8vcP+5VRW0C/peyyk2eG5izBH2CH
 RB9d7ewTvUHuQuPhf9QJfESGmP4m8F9NfIqSweYVW8vkOieXhoCl+QmfopLnwME9zmEWkQsRL
 Rxk6upBf0cpKy7/gNGlCbGQ30WU5XbsYEJ3RCdyuLMmgEfERDGocM8kjeGuU9BaeceM0h9F1l
 CgmBQ5T+FWhCshszbdpRB5ekEp8qmrlnu46wHdmj44DAI8JwrhXITu1HNx/QvTiTEkp1ZG4eD
 wbN0nOtZy2ZUoCA+Y9rSm6bxKRcj8/IN6iSUxhh2UcRKg0KeUSkLC/Rbp+a01MW4VUXH3XWCP
 d5KuDxlE3p8WUV79+2Kt9aOWIKaz+Tj6yYY7sxU3l+1sX5dlqEGN463keZtkoycR27fpptPu2
 /Q2UrQ==
Subject: Re: [cocci] [1/4] fbdev: imsttfb: Fix error handling in
 init_imstt()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1172
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/dc893f7c-c517-4a30-818c-261d6c64b5ba%40web.de>

> I think the return value isn't checked at all, so you could
> simply return below "-ENODEV" for all cases (instead of "return ret").
> Then you don't need the e_nodev label and can simplify the flow.

I noticed that the software evolution was continued with an other change variant.

fbdev: imsttfb: Release framebuffer and dealloc cmap on error path
https://lore.kernel.org/linux-fbdev/20230527093016.486521-1-deller@gmx.de/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/video/fbdev/imsttfb.c?h=v6.4-rc5&id=5cf9a090a39c97f4506b7b53739d469b1c05a7e9

Regards,
Markus
