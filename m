Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682EFC77B7E
	for <cocci@archiver.kernel.org>; Thu, 25 May 2023 05:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=44jzQKbb7MjR3uCsx2BXVqGpBTh6Yhma67xUVGqxG2c=;
  b=rH8nfzXMi6aaxu6SCeyFodPxRElXyfbP1v2q4EdbKHD2FYSo4vKtANii
   HsXOkSa4ruFE5QhLnZFYPbNxskTj4I8QbhkPGj6Mk657Ls9MTidRsT+cO
   zUtBb/wge2fE+RjHwOqJn2oot/6rjC6NYIKu4UEPc55PR7m/dhKuTAAUU
   0=;
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
   d="scan'208";a="109556858"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 May 2023 07:03:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D82A0E00A3; Thu, 25 May 2023 07:03:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4783FE0082
	for <cocci@sympa.inria.fr>; Thu, 25 May 2023 07:03:05 +0200 (CEST)
IronPort-SDR: 646eec07_TGylbPYl7+RSkzFiaoRcUhdeWbTQOb16I0wSNCzovK3hzqG
 lk2bt01/egQa9X5oweDJwuEg7RtWrlEGhK9mTuQ==
X-IPAS-Result: =?us-ascii?q?A0HpAAD16m5kgAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIudQNTMAQLR4RSjxmBdjGEM450hGeEA4MWPg8BAwENPQQBAgQBA?=
 =?us-ascii?q?QMEgUw/gnQChVwCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEkFwcODimFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgINOj8BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6AYInAQMOIwcNs?=
 =?us-ascii?q?HeBMoEBgggBAQacDh8sIlWBXwMGgRUtAY0sgzd6Jw+BVUSBPAyCeD6CSxcBA?=
 =?us-ascii?q?xiBRoNbgmePLY0+gTBygSOBKIECAgkCEWeBDghmgXNAAg1kCwtsgTtaQx+BS?=
 =?us-ascii?q?gICETQODBUFWAKBBBABEwMHBAKBDhAxBwQ3CxgJBgkdHRgtBl0HLyQJExVTB?=
 =?us-ascii?q?4QrAwoKgQclBA4DGSsdQAIBCzs6PTUGAwsfBiYBHgIrgVgEL1p7BgEkJJ1xA?=
 =?us-ascii?q?4QVJMZENQeCMIFbgV0MihKVCQYTL4N/jGqGKA4GkisuhzaQKiCNOppYgXkkg?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIIQnhGGKZz80AgEBNwIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
 xZamdvF
IronPort-Data: A9a23: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
 D3QFrAc/vR8/32xedsu2w==
IronPort-HdrOrdr: A9a23:NtdY86CAyG2k2xvlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:VVQu1m2qEN4bSK9Ztyg+5bxfRuMoL0LEj1rsHkqTGEo2YeafSE6S9/Yx
X-Talos-MUID: 9a23:wZDr5QjthawyYBcvmjWYWcMpbt5Jv6D2VRExsNZF6pmNGw9wPDLetWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,190,1681164000"; 
   d="scan'208";a="109556857"
X-MGA-submission: =?us-ascii?q?MDFZoQJxB0QvcQcKiz9OrqxTR+W4j0fFvZ1sdq?=
 =?us-ascii?q?dt1FOfYPPhl48/rIMfP1FBkKOl+tIig/S+5difQLOFtYhV2zOdg+dWHu?=
 =?us-ascii?q?G9J/6wq+12eFHvC5EHPYTb6gQWgVC4x4O4fYLTWa3QcZEKS89Qltgobv?=
 =?us-ascii?q?eF09tRG6MrWrAgPIdIKoWZgg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 07:03:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1684990983; x=1685595783; i=markus.elfring@web.de;
 bh=44jzQKbb7MjR3uCsx2BXVqGpBTh6Yhma67xUVGqxG2c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=q5Y9zulOj7dtV3EZ+zF/41XY/Gnk7cg2CVVYNVRMqCLf4+r/H7wWDmBIwFLfjJbBoMnp7rY
 oKcD1IIegJkxjo8kOQRJPubpap5F7KR8vrPqZxuaEVWaaGpmTFw8K7xb8EVrLdAYwuxxhXzBi
 XmJ8p6nemc6hQP9XLcL6Romq87xFBucpjdb57TC99KEZdvC0AbN73/gQLXZSLF0uMggwJoUXL
 D56AoUo3qSOFg92ggBCIM3HiWrLwxaIfry9QqSTjIpDX7bGhcY8AfdAzdY+RUR/WmQ3X6iWAA
 rojNFJE09O9g/wTjzNa0Fx61/uE7m1FS7w7zaDEuA+5Mj5Y2Rp5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxs3-1pnQI43NXL-00O1P4; Thu, 25
 May 2023 07:03:03 +0200
Message-ID: <be1a89af-1aea-ca3c-6101-a0f61f4dc245@web.de>
Date: Thu, 25 May 2023 07:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Helge Deller <deller@gmx.de>, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <8f0bcb48-7677-340d-282e-27f6fe063c6b@web.de>
 <341b4af7-5c6c-cbd2-6fe3-c0e4e58f3c7d@web.de>
 <35bb7db7-bf14-20ba-3bff-80d05c42e28b@gmx.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <35bb7db7-bf14-20ba-3bff-80d05c42e28b@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iHotWRiwCKBzkAh507XuLUh2eyxN0hk8k+e73gOLfODGFt1C9h2
 vre4kFb/CS7BHA7MPJnEcq5nNwRQ3lImOgVF/nrmwEr1/DEY+DqZyZykcoYlai7K2b4+XO5
 tJdyNMNIXkgJkOgafecqVLy9O6t1JMd3ZN1hqwwvoTzMKeaL+6FN+H6kYbVxQbCvmwyDWii
 sOTZkUJ46HbYdyxco0WnQ==
UI-OutboundReport: notjunk:1;M01:P0:xH9KWPuDi0E=;pIYqpnRj2kFfLz61TRFfuSY0Jx+
 s8ismkxD9WSU5ZJaR+uU+rZ5EQn5dukr/AKtrd5fPxv/BxuqfcnepGU979Hd/PSTAhOXbIoo1
 Ujh88b8VbnGHkDyOZgFXxn2+OMv1P7aHkPtITR102W0iuZjnRt1NayIbKNTeMVbWWmtFjcdFx
 q7xlrz6WewkuXV2ciS7W3XcRzxMXNei99Q+TnxfM5GzWQI9z79x89YWF3FpFKcsL3VOXeLCgd
 2wzaLNPneBWfttI8ghmEAsKJjFLbkgxdB0rTs9zSKQyQMjs+EUUYrR/7v5puZoSp8LJayEPr8
 ZEyp+Sl6YOlOubNiLtUg5dA+NtrD/qbq6RCIgC8HsYRNwr/c5u24WoxOPO+Iphy3yBpZSXyfk
 NQMlnw/gWD1T8LPLY0ItUUh2fcIOqK7DTYrjmbP9VPnBMrMWmB2CrLu261xMHCBkpvg24pMAO
 ZdRyk8kstrbPAO3Fi69Ljr/4zs7s7qYPzoo9Dmuqki+NikfntdZXCIcCMBJR/YuUv3KK2see4
 PE1XnhxzIXfvhF9OkLwwSf5+Hol85yAU7IJRMCmqMCBNb0cREk7SRT1q2q6ac/Mn48ceKrfza
 0h2V5yELnbLS+W3ycb+rLmptkjsog44HKDnBkIye09cdcaRCrvnJDZJvOn2D1KM2emzcWXFwU
 OYYyYggS2mxnPS6HKCZ2DuREO3wLxg6WUvZzzaFk7ReKbem26HgbnaWCu1FVLtorr9a167Uki
 rBQnBXf8s2At1F1iUfACLCbofhUElllqP0AfzJhru4+UfxCNlX6/NODObGBAwEp3+WuXUrSJ1
 NSbyCk5WnBEyyYiSnvue7YeEFeuzmKhGUGw2m0UO6aa/1BcYiyMNgrjt3PDZGLc1Ay7+vZoPm
 ctZ46vzyUavU6EjizUtF169DykbmHMfoe4dNgx8Up++nZk2m8WRvnYZp17anjgzz4TvCpHKyR
 ed/YQQ==
Subject: Re: [cocci] [PATCH 1/2] fbdev: Move two variable assignments in
 fb_alloc_cmap_gfp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1156
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/be1a89af-1aea-ca3c-6101-a0f61f4dc245%40web.de>

>> Move the assignment for the local variables =E2=80=9Csize=E2=80=9D and =
=E2=80=9Cflags=E2=80=9D
>> because the computed values were only used in a single if branch.
>
> Please do not move such variables without real need.

Is there a need to explain desirable effects better?


> It makes backporting (of this and maybe follow-up patches) much more com=
plicated

I suggest to reconsider such development concerns a bit more.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dri=
vers/video/fbdev/core/fbcmap.c?h=3Dv6.4-rc3


> and the compiler will optimize it anyway.

How much do expectations fit to supported and documented software optimisa=
tions?

Regards,
Markus
