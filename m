Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB102C00140
	for <cocci@archiver.kernel.org>; Thu, 18 Aug 2022 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=okDQaoLb3/1/sWiHy2RAUaFjpuxQWOhcWOZlK9dhLDo=;
  b=W1ktv5pWt5cqMwULX2XrqdJBxQZkDG0EKU/mYjQWQ5HuTjCagHQKtW8U
   9BZcjLkFg0KVTQTvEkRe+oUyn8icfer/vfhwS5LrvrGDK83pargyBdLGh
   tFNOq0SSbHb5gsfRgiKLjVlMek4mhp9ey7Xn0eLsAwfHkHvSQPQrecHx4
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,246,1654552800"; 
   d="scan'208";a="49126671"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Aug 2022 14:54:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F13AAE0AC3; Thu, 18 Aug 2022 14:54:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9CC3FE0380
	for <cocci@sympa.inria.fr>; Thu, 18 Aug 2022 14:51:13 +0200 (CEST)
IronPort-SDR: FUoD8s52cbR7ZVI2i/8IpkNfuH4X75HtzH/yBr/BY/b8M6nOJqC2u4hY1S6dsVb+CecmtmD6Rg
 q0TZCBEcH4rGo08Yuipq6vwRCBzmjF7N3zVPfUk/r6lIKupKYdDWJGmBNBuipjdIVc+oM5sHZV
 9yGaO0gqmZTzDmAzqvx76sXSgcG8b7e/DETmf4U5hRjiUAeeuss5i9mhhGVPvub9qjQuwbd2cL
 gZbBDapRb+0209RL2qnOSTEgdjtFInwzECvGA4kZYTmaGdn5uvCz3ms9uWsuO/bXmxYOxiA3JH
 PWmXtfmOyYfRS522t0D134u/
X-IPAS-Result: =?us-ascii?q?A0BTAADZNP5iXUTaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYIjByqBJy4EUI1MiBGEJYcOA4EGkEOBfAsBAwELAQFAAgQBAYUHA?=
 =?us-ascii?q?oR6Ah0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEGHAsJB?=
 =?us-ascii?q?xIVDgVgAWEDAUSBT4F0CwMxDYI1KQGDYwEBAQECARIoBgEbHQEDAQsGBQsBD?=
 =?us-ascii?q?BwSIxEBBQEIFAYTIoJbgm0BAw0lAwSbdIEEQoo4eIEXBReBAYIJBoJhgW4KG?=
 =?us-ascii?q?SgNFVIDW34CBwkBCIErAYZOhEaEMyeBGYEQgTwMEIJnPoREFYN4gi4EmSQEB?=
 =?us-ascii?q?RQPAwMCIAMJBAcFLB4CCQMjEQMLEBEHDgEWAQQIAQQDAQEBDgIFBwIGAwMCA?=
 =?us-ascii?q?gICBQECCgIBAgQDBgYCAxABAgQBCgQCAwgCBwMCBgQKBAIIAgQFAw0BAwUCA?=
 =?us-ascii?q?wEBAwMCBAECAQEDCAEDAgMDAgICAgUCAwICAgkDBAEHAwIDAQQDAQIKBAQDB?=
 =?us-ascii?q?AICBwIHAgQHAgECBgMFBgICAQcBAQQKBAMDAwMCBQICAwIGEgYGAgQBAwQCC?=
 =?us-ascii?q?gICCwIHAQECAQEBAQIDAgcFCwEBAQMCAwYFAgEBAwgGAgEEAQUDAQQFAwcCA?=
 =?us-ascii?q?QUGAgkDAwEIAwEBBQEDBAMDAwIHAwECDAQIAwMCAwQCAgICAQMCBwUIBAIJA?=
 =?us-ascii?q?gICAQICAgQCAQMaAQIDBQICCQsBBAICAwEDAQECCAQJBAIDBAIBAQMCAQICA?=
 =?us-ascii?q?QUCDgYBAQEBAgMDAQIDAQYHAggCDg4KAQMDAwICBQICAQIDAgIMAQEEAgECA?=
 =?us-ascii?q?QIGAQMBAgIDAQMBAgIDAgYJAgQBBQMDAgIDAQEFDgUCBAIBAgYFAgEBAQQBA?=
 =?us-ascii?q?wQEBgICAQMDAg4CBAEEAQIBASMDBAIDAQMXAQIBAgMDAwQGBwUCAQITAQIBA?=
 =?us-ascii?q?QEFAQIBAQMEBAcJAwICBAMDBQEBAgMCAQEBBwwCAgITAhMDAQYBDgUUAwIEA?=
 =?us-ascii?q?gIBAgIKAwECAgEDAgkCAQIBBSADAQEPJAEBAgICAgMEBwIBBAYDDQICAQEBB?=
 =?us-ascii?q?QYNAwIDCAEMAgcDAgEDBQECAgIEAQIECgkBAgIBAgQFBwIBCAYFDQUJCwEBA?=
 =?us-ascii?q?gEDBwQDEQIFAwUFAwMCAQYEBQIDAQIBAQMEAQMEBgEBAgMCAgEGAgIBAQMDB?=
 =?us-ascii?q?AMBAgYCAgcCAwIBBAIDAwEBAQQCAgICAgMDCAMCCAcFAQYBAgEEAwICAQIHA?=
 =?us-ascii?q?QQBCAIBAwMFAwQBCgMPAwUDAQMDAhQKBQEFCAYJAgQFAgUDAgQCAwMCAggDA?=
 =?us-ascii?q?gQDAgsDAgYEAgcTBwIDAgIFAgICAgIFBAMBAgICAgICBQIEAgEFAQICAQICA?=
 =?us-ascii?q?gQBAgIHBAIDAQMEDgQEAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFAgQBAwECB?=
 =?us-ascii?q?gIEAwoCAgMCAgIGCAMDDAkCAwUCBgEBAgcEAgILAQYCBwICAQIDEQEDAgEEB?=
 =?us-ascii?q?QUDAwMJAgIDAgQCAgoBAQEBAgIBBQUCBAcPAgICBAICAgEDAgIBAQICBQQJE?=
 =?us-ascii?q?gEBAgMGBAYFAwIIGAEGAgIBAQICAgMDAgYCAQIIAgQBBAUCAQICAgIEAQMGA?=
 =?us-ascii?q?gMBAQIBAgIDAwIBBAIEAwMBAQIBAgICAwICAgMCAgEQAgYGAQICAgICAwICA?=
 =?us-ascii?q?QIBBQECAQIEAgcCBAMCAQICBQICAgMBAQYCBAsBAwIHBgEDAgcFAgMBBAMEA?=
 =?us-ascii?q?wMFBgUMCAEFAQMBBR8DAgIIAgcCAQUDBQEPAwICAwICAQQKAQIDBQIEAgECA?=
 =?us-ascii?q?QQJBwIEAQINAwMIAgcFGAECAgcEDAoCAgIFBgIEAQEBAQMBAgIBAgMHAgMCB?=
 =?us-ascii?q?AUBBQIBAgUEAgIBAQIFAgwBAgEHBgIYTZkxgUgTgTGUHa5+BwGDVI51kS4EL?=
 =?us-ascii?q?pZjDpIAlwKjC4QmAgQBAQEDBwYQIxKBLgKCETMaI1AqAQaCNj4QAQIBAQENA?=
 =?us-ascii?q?QIBAQMBAgECCQEBAo4dg3KKYD80OwIGCwEBAwmFRoUrAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:2E2JcqN1ruCeGCvvrR1okcFynXyQoLVcMsEvi/4bfWQNrUoi12NVz
 mdJCzuFbKvcY2r3LYx3a4ni9h5UvJLSyNZgGXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EkLd9IR2NYy24DpWlPV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2Om/Vt1
 pJXn6eWVCV0GZTymbkmcThXRnQW0a1uoNcrIFC6uM2XikDEKj7inaUoA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3bvmhuzrIgVvrpxLwM3DPoAb6is4iz7YEd4pRJnCR+PB4towMDIY2pEXR6iHN
 5dxhTxHZijrRDpgOE0sC48wwMe2iUfVKgFfgQfAzUYwyzGLkFYZPKLWGN7cZdWOQe1Hn0OSv
 GuA/mLjAxhcOsb34TGC+XmtrvTemDvyHoMUDryxsPBw6GB/3UQWARwSEFa5+Ly31B74VNVYJ
 EgZvCEpqMDe6XBHUPH6WzikvjmelCU6RvgNNNQE6Vy26IvbtlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOdCJmO3FIZ563ufExQ5eKRT5PkdZOnBZFVptD83L5dBs3kiWH76PBYbs1oWtcQwc1
 Qxmu8TXuln+pcsC1qH+8FKexjzy9t7GSQk64giRVWWghu+YWGJHT9zygbQ4xawYRGp8crVnl
 CVU8yR5xL1RZaxhbATXHI0w8EiBvp5pygH0j191BIUG/D+w4XOldo04yGggeh82bJ9cImS4O
 BG7VeZtCHl7bCvCgUhfM9LZNijW5fWI+SnNDa2KMIIfMvCdiiferXowPyZ8IFwBYGB1yf1lU
 XtqWcmrCnkeBMxaIMmeFo8gPUsQ7nlmnQv7HMilpzz+iOb2TCPLFN8tbQTWBshkvfvsiFiEr
 r53apraoz0BCrGWSneMquY7cwtaRUXX8Liz9KS7gMbdclo6cIzgYteKqY4cl3tNxfkJxrmUp
 i/tAye1CjPX3BX6FOlDUVg7AJuHYHq1hStT0fUEMQn61n49T5yo6atDJZI7caN2puNmxP9wC
 fICfpzYUPhITz3G/RUbbIX8/NQyLkT12VrWMnr3eiU7cr5hWxfNpY3pcw7pwy8EUXi6uM44l
 Lu/216JWpEEXQljUJ3bZav3nVO8tHQQgsxoWE7MLoUBcUng6tk4JCn4j/txKMYJcE2Ryjyf3
 geQIBEZueid+99voIeV3fiJ9t77HfF/E0xWG3jgwYy3bSSKrHC+xYJgUfqTeW+PWW7x/pKkb
 7oHwvz5NsoBgw8W4YdxFrBczZU+6cHqkLlUw1k2B37MdVmqVuptL3Taj8lCsqpBmu1QtQesA
 Bnd/9BbPfCEOpqgHgBBYgUiaeuH2LcfnTyLtaY5J0Dz5SlW+rubUBUNY0Pd1nQFdLYlYpk4x
 eoBudIN71DtgBQdNNvb3Dtf8H6BLyBdXqh75IsWBpTn1lgixl1YO8eODyb35NSCaYwJPBd6Z
 DCTg6XGivJXwU+bKyg/En3E3Ox8g5USuUAVkAVTeQzRwteV1OUq2BBx8CgsSlgHxBtw1e8ua
 HNgMFd4JPnT8jpl7CSZs7tAx+2c6NylFk3NJ58hkWTYSwylVDWIIjNtf+mK+08d/iRXeT0zE
 HR0Dor6eW6CQS0z9nJatY1ZRzjLQtl49wmEk8eidyhAN4dveiLr28dCekJRwyYKwqoNaInvq
 uxj/eI2Yqr+XcLVT2vXFKHCvYktpNu4yKCujB2vEG7l3Y0RRd1q5QWzFg==
IronPort-HdrOrdr: A9a23:7VhiRqw+eSFmwkP1ao+xKrPwD71zdoMgy1knxilNoNJuA7Wlfq
 eV7YwmPH7P+VUssRQb8+xoV5PwJ080maQFhbX5eI3SOzUOxlHYV72KnLGSoQEIcheWnoU86U
 4jSdkFNDSZNzlHZK3BkWyF+rgbsaS6GWOT6ds2DU0BceinUc5dBn9Ce3qm+4RNKjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,246,1654552800"; 
   d="scan'208";a="49126185"
X-MGA-submission: =?us-ascii?q?MDFXFkjKaSw+iVtQM/VjowGkm/3++z5wMLkp06?=
 =?us-ascii?q?56X90hceajTjgEPXgpwtlgi5wM7RHHBuX5IUrNhszjlHqcXaeHm+mLSf?=
 =?us-ascii?q?9+JHfn5eyak2IPzv/a9/opymwWjwfxuzxuKW+mM8BSnZ97nne9oW7iy7?=
 =?us-ascii?q?vURWn4mZDwa+OG+Gw5YSping=3D=3D?=
Received: from mail-ej1-f68.google.com ([209.85.218.68])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 14:51:13 +0200
Received: by mail-ej1-f68.google.com with SMTP id dc19so3012150ejb.12;
        Thu, 18 Aug 2022 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=okDQaoLb3/1/sWiHy2RAUaFjpuxQWOhcWOZlK9dhLDo=;
        b=m8jWW/MU3J3wr7NckFgjYaKrJkr2HFygo+aSV971MlFOpTnP1nwcOEjk6cRRgXdbHQ
         ArqgH3ugCg5BDPCFUFPKQ0LJDfnDgr9eQzb5woHDIB4HxlJuY3b3UUDPs9akDoAM6gYd
         S/otScU65EwzhDcpj8+l/Ae4x8Wx51l04NFOE1GhSPkeyKPzYds1AbJOT831dGck9QQF
         UXN7d0/9lzQTI952bpnS2CNt0Wi5JABLZyqYf31dg5QBKngGpCE2wvJ1qLDasfpRKL8X
         EagPCBeDivzi7vr0njv0KdOIFO5dkC1ppgLkk24fEAN6d6EfazveDXUyfy//2sgP7DJ5
         UaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=okDQaoLb3/1/sWiHy2RAUaFjpuxQWOhcWOZlK9dhLDo=;
        b=1Jrxi4/AxaZU+fshoUxqI/Cxr2lr6Kd2XuYRWJcEB4RHAajkBh+ULhu+pzr0ip4c0C
         UhWkMYs/mouthG97R1a5UsKxOz0vzfkeM5/az/lE/yMZ3LCRxQpWxI+InDcIYRWXaA38
         pPRK8aFVwbNURZAMits9XvukEeQvtdsPxsFqDcIWnty7lUrd+V4OyMxlFZtCrsuP9N1f
         J3AFd2+KoUUPY1TUBcvYzIQBsvYB3bmO/LU1QB0jMnHTjitTJ7p4/Nsgj5BmgE8C379v
         tpEZCzxhg/0Gbn55EjQopJ47lxFs8gOm/IoQwdAAxnIZuwrkRZV2Sk9DI3QDk40wiXcC
         bNrA==
X-Gm-Message-State: ACgBeo0xC/+WnS5tzs7PfaWO9LiKgzYvvqzR2ENLRuo7ZbGoKxwF2tYU
	va+NNjxrz9+7IbGg1Dwo324=
X-Google-Smtp-Source: AA6agR4qXyjhYh/dppSvHUuTUHGTRB92xGueptRJ4AD+d7HhRJAiSylRJFWG1ArgWtmWDTBP5V5YNA==
X-Received: by 2002:a17:907:7284:b0:731:82a3:16e3 with SMTP id dt4-20020a170907728400b0073182a316e3mr1843139ejc.30.1660827072523;
        Thu, 18 Aug 2022 05:51:12 -0700 (PDT)
Received: from smtpclient.apple (ip5f5bf4bd.dynamic.kabel-deutschland.de. [95.91.244.189])
        by smtp.gmail.com with ESMTPSA id s18-20020a1709062ed200b00722e50dab2csm793266eji.109.2022.08.18.05.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 05:51:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
Date: Thu, 18 Aug 2022 14:51:09 +0200
Cc: Julia Lawall <julia.lawall@inria.fr>,
 cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 518
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/88152C77-84AD-4515-A403-71F827180FD9%40gmail.com>

Hey,

> On 17. Aug 2022, at 21:48, Markus Elfring <Markus.Elfring@web.de> =
wrote:
>=20
>>> I just tried:
>>>=20
>>> @main4@
>>> parameter list Ps;
>>> @@
>>>=20
>>> int func1(Ps) {
>>> ...
>>> }
>>>=20
>>> @main5@
>>> expression list main4.Ps;
>>> identifier func;
>>> @@
>>>=20
>>>  func(Es);
>>> + // add comment
>>>=20
>>> but that throws:
>>>=20
>>> meta: semantic error: incompatible inheritance declaration Ps
>>>  File "test.cocci", line 45, column 24, charpos =3D 539
>>>  around =3D ';',
>>>  whole content =3D expression list main4.Ps;
>> OK, there is a specific context in which this works, but it is only =
for
>> generating semantic patch rules.
>=20
>=20
> I would appreciate further explanations for such information.

I've finally managed to get it working. Always when I struggle with =
coccinelle
and get it working in the end it looks completely obvious.=20

Thanks a lot of for all the help Markus & Julia!

Let me show what I was trying to archive and how I solved it:

    @r1@
    parameter list [n] ps;
    type t;
    identifier i,f;
    position p;
    @@

    f(ps, t i, ...) {
    ... when any
    interesting_func@p(..., i, ...)
    ... when any
    }

    @r2@
    identifier r1.f;
    expression list [r1.n] es;
    expression e, e1;
    position p;
    @@

    e =3D e1
    + // here the argument to interesting_func was assigned
    ... when any
    f(es, e, ...)@p;


I'm running it with this sample code:


    int interesting_func(int argc, char *str) {

    }

    int main(int argc, char *argv[]) {
      int x =3D 0;

      func1(x, "asdf");
    }

    int func1(int number, char *str) {
      int y =3D 0;
      char *x =3D "x";

      interesting_func(number, str);

      interesting_func(number, x);

      interesting_func(y, str);

      interesting_func(y, x);

      return 0;
    }

with the desired result:

diff =3D
--- test1.c
+++ /tmp/cocci-output-test1.c
@@ -6,7 +6,8 @@ int interesting_func(int argc, char *str
 }

 int main(int argc, char *argv[]) {
-  int x =3D 0;
+  int x =3D 0
+    // test;

   func1(x, "asdf");
 }

Thanks,
Jakob

>=20
> Regards,
> Markus
>=20
>=20

