Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA895D13564
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DWVfrLiSQ1mLXzmeAJ2FQ1vcpLRRj7dDdM9zmE1eltc=;
  b=km29u3C4XUIKIid3fLTwMTGKlbYEPgjXo6yLoof7W4OX6N3Wn2qFpYEU
   vEtLqScWAQTGMeUqa99e3ndW26Dw697IR8MP92VnM3DJbenZNOaEmT90c
   ZG9rzf9DT1y3rv5EivNtNgIyvsbJ/X7AZISZw+LPfFWEYwGfEqIzUc4mn
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190922898"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 16:26:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1C5EBE0D24; Sun, 27 Oct 2024 16:26:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4BD6EE00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 16:07:21 +0100 (CET)
IronPort-SDR: 671e5728_VXSYibTctEIdKVa5vKDEh+G70C+d0QcBOZEOQPTuPCz0HcX
 neaQMZCfiiR41iAuDXtKqiCpphyhT9+x1LdFwlA==
X-IPAS-Result: =?us-ascii?q?A0FRAgBlVh5ngSzaVdFagQmBU4JEgVY0BAtIhFaPTYIki?=
 =?us-ascii?q?3WHVYpLgUA+DwEDAQ1EBAEBAwSFAAKKJwIeBwEEMQgOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABASIZBw47hXsNgmIBgSRhAgUDOwEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLF8BAQEDEhEdARsEG?=
 =?us-ascii?q?QEDDAYFCw0CAiYCAiEBEQEFARwGNYUPAQMxA6I+gQVCiz2BFQUCFoEBgg0G2?=
 =?us-ascii?q?lwKGSgNbAOBYAIHFIEGLoRzKU4OAYI2HQGBbId6eicPgVVEgUqCdT6EQxWDR?=
 =?us-ascii?q?oJpBIERgU6HZiWBGocdaooChz8IAQYXAwcHCQUECRMGBQUCQgkGBQoSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYfAT8SBBMKDQsHBR8JBAcMEQopBSMFEB4EIBABA?=
 =?us-ascii?q?gEhBgIJAgIDBgECAwMFAwIBAQEELAIEBwEDBgoDAgICCgYJAwMFAwwBBgQBA?=
 =?us-ascii?q?gMMAQECDAQJAwIBAgEBBggBAQIEAQQCBgYCAgICCgMFAwIDBRAdAwQFAwUDA?=
 =?us-ascii?q?wQHAQIFBAkJAgUDAgQDAwIEBAIIBQcEAwsGAQEDBAMBAQgHBwMCAQEDAQEKC?=
 =?us-ascii?q?wgNBgMIAwYJAwQBAQUQCAIDDgICAgMCAQoGCAUBAwYhAQwDAQMDBQwEFAMEB?=
 =?us-ascii?q?QICDwwBAgMDBAUDBQICAgICAgIFBAECBAIEAQgECQECAgIDAgEBAgYEAgICA?=
 =?us-ascii?q?wIHDAcDBAIGAgYCAwIHCwoCAwYFBQMFAh4CAwICBAMDFQEBAwECAQIDAgIDA?=
 =?us-ascii?q?gMEAQMDAgEBAQMHAgICBAEBAQQGBQICAwwCAwMBAQYBAgECDwUFBgQBCgMCF?=
 =?us-ascii?q?AMFIgIPBQgBJgEEAgIBAisCAgMEDQgFAgIHAgQMAgQPBQMDDgYWBgEECAQGB?=
 =?us-ascii?q?AwKAwQOBxcRAQEEBAIIBAINBwIMAgIGBAICByMGAwUJAwIFBRACAgsCBAMVB?=
 =?us-ascii?q?AQbAwECCgICGAIBBwECEgEHAgIBFAIKAwIFBgcCHAICAwMEBAMBBQMEEAMLA?=
 =?us-ascii?q?QUGBQEBBBEBAgECAQECAwMOAQICAwQCAgEJAgIBAQINCAEEAwEHAgUDBQMKA?=
 =?us-ascii?q?QEBAgEECQQPBgMFAwMHAwQCAwIGAgQIAgIDAwIDAQMDAgECAwkCAQ8PCg8CA?=
 =?us-ascii?q?gMEAgYCAgEEKQIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICA?=
 =?us-ascii?q?gMVAgUBBAkDAwUSDSIDAgICAgMHCgMFAgEBAgQDAwMDDA0HAgMBAgEDBQMBA?=
 =?us-ascii?q?gECCQMHAgIDAwUSGQUDAg8DAgEFBAIIEgsHAQEPFgUECQUVAwYCAwMWCwQFA?=
 =?us-ascii?q?wMDAQwFDA4CAgsDFwUBAQcBAw4IAwQEAgMDCQIBEAEDBAIJAgQBAgoCAgICA?=
 =?us-ascii?q?gQBAQUEAgQDAgUCAgEIBAMDAw0EAwgIAwUDDBICAgIJAgMBAgMDAwQNCBYNA?=
 =?us-ascii?q?wIOGgoVEwcHAwMECwIJAwQNAgQCAgEGAwYKBhYBAhgCAgYMBAMDCAMCAwICA?=
 =?us-ascii?q?QICAgERAgIJCA0FCQUGAhYDAgMIAQkDDwIDAhQBBgIIAwcBAQQCAgoRCgEBA?=
 =?us-ascii?q?wECAQckAgoHHwIDAQkMBQUGEgkDEAMDAwMLAQICDgkDBEUGEwQCAwMCDgECA?=
 =?us-ascii?q?gsBAgIEAgMBDx0CCQMjDwMLCQgTPQELBzIEBi4BFBQHKyFfm0TMWDQHhB2BX?=
 =?us-ascii?q?QYMn2ozg3EBplkuh2SQZakQESMSgTMBOIFccIEBgjZPAxkPkhvMUEQyOwIHA?=
 =?us-ascii?q?QoBAQMJhkiJaoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 iaEuxADOahOFKydNHB6B+nEF1Kdn0/g1w30sTM=
IronPort-HdrOrdr: A9a23:JaBieK0xnVYftWTJLaHdlAqjBGIkLtp133Aq2lEZdPWaSL3hqy
 nIpoVg6faUskdrZJhEo7q90ca7MBfhHPJOkOws1PKZLWvbUQiTTL2Kj7GSpAEIcheWnoVgPO
 VbAstD4bbLfD5HZKjBkXCFOudl79+d7qiyiOvSi1trRxp7crxt4m5CZjpz0XcYeOCFP/cE/V
 aniPavbgDARUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AOrHQ62odXb7L/c8h/ge20gnmUZFmUWTExkvuH1G?=
 =?us-ascii?q?XUXxjc5vLWUOhpooxxg=3D=3D?=
X-Talos-MUID: 9a23:Y5bZGgqsyzGt9cDoX9QezxdeEv5uxp6oM10utawnmMqKCHBOKQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="100137102"
X-MGA-submission: =?us-ascii?q?MDHuI3qpcnJc9PZ2cv1/cTUypTQQDS3DtcOFcE?=
 =?us-ascii?q?oNubtVYF6wqP0bxVdYnkmo1kChCBb+ad2S/rb7KuVJPmgAfSRdl7fFyy?=
 =?us-ascii?q?+32XNi2Pll1R05u7Ye1JpD23hLrPkMZcPWNvWMk2tsuIHbK8vdpWnHJ1?=
 =?us-ascii?q?7uiqjOxsWFzL6Y80J+WJIYkg=3D=3D?=
Received: from mail-ej1-f44.google.com ([209.85.218.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 16:07:21 +0100
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a998a5ca499so463594066b.0;
        Sun, 27 Oct 2024 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730041640; x=1730646440; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWVfrLiSQ1mLXzmeAJ2FQ1vcpLRRj7dDdM9zmE1eltc=;
        b=inHw7K5r5/VKXEalCEr3OraRDzZ+TBZ9jI/ZfM7O4MoQp5vxZ/8kdqi4vyiiF3J5sl
         Dr5jJWY/JpT+btnD0HPzNVx5xXTUh+hNDSk911BxYHe5QOJN2YAOfMqWtGlMMOMk3PuJ
         7nubhSqgFIYMSaUfmbzfvfAG5KihjqnqrIuZ1CgWGXJFzCTVXq7j0GVZOqKFvjNAD393
         oHzftZQ/pQ1EkEHpZWAPxmJh90DhL4LMW/VWsnRJ6+5gIOB/N2bjFFCJf5Jrcl0Xx/Pd
         2F45ZOLM2ZiSTfSu6Px8bz05OKdVRhwnLrqm5ig9YLViLT2Q0+D89q0/xfyqLACpQYvc
         GxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730041640; x=1730646440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWVfrLiSQ1mLXzmeAJ2FQ1vcpLRRj7dDdM9zmE1eltc=;
        b=oudryo+PsaBnvjiKjtHEWycNe7EmBPDAwAaAU34VffjIBt9eltpQRdJn/hYwW5XRor
         iyOIcYJXWY1yoXaX01vmXai37qMZY/3dvE0xR3/aTBYoEZ5w7gcBTgtKN6A1Sa2JUCQB
         SxPpa4FI/iciuJnKRc6YlZOKFpg8e4ZccBeD1PUKX7PHYet9k3Oh9dM8QrSUqt6RpkSZ
         GXMD4dk6cE/Hk/aInzAANcTSHumzuRbavqyF8ZvnD3y7nOjVS6hQWkdwHzrWyxRBYlaN
         dq4Vcn88fNpqUjyLcRqsmMCa39Z1unBtzJZa2HsO73NOiFVi4CIuWHsTRtoBwWsZ3GWj
         AzZw==
X-Forwarded-Encrypted: i=1; AJvYcCUiLbzdBlS5M7o/ckNBLVXKrnGwRghr3xuENZhMAxqqKq+l6wrNctXOYMs4R+9hYiATvoJIHVA=@inria.fr, AJvYcCVLQNhwP45TZZbaIW/gLU9M8He57us7li+N3Nyu4vJDlJ8oET1ZD/aQSVI+Vsykmu6k2kMYpiVVmWDH40s=@inria.fr
X-Gm-Message-State: AOJu0YxBEFxHXATE/25mjGPWb/YWYvjJlWGJc7asuTknTd2rGAJG/0VN
	+swvKR/7YlbRAAIlkr/22MwDw1behtq23Zay31SpRgsoyAtxCFDsi/bHHpsWEb6bBZm5Co4YRm3
	naZ6IxWIyobTEyKyhE+XQDTSWN7Q=
X-Google-Smtp-Source: AGHT+IHAMr1Prejw6UUMe3IADa5i/kKzZcgJeJyFLvdTQ0zMFs1aGYVL8QkXh0luqaJs01zHjAnHSrOxMr9J+/jUWMA=
X-Received: by 2002:a17:907:961c:b0:a99:55ab:b666 with SMTP id
 a640c23a62f3a-a9de5f27104mr510798466b.34.1730041639504; Sun, 27 Oct 2024
 08:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241027125858.1804-2-thorsten.blum@linux.dev>
In-Reply-To: <20241027125858.1804-2-thorsten.blum@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 27 Oct 2024 17:06:42 +0200
Message-ID: <CAHp75VeeUKWakOWW7ft8BB9Gg=29_z93fCjDk_VGsqd8py878A@mail.gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: Add str_off_on() and str_no_yes()
 rules
Reply-To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1945
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/CAHp75VeeUKWakOWW7ft8BB9Gg%3D29_z93fCjDk_VGsqd8py878A%40mail.gmail.com>

On Sun, Oct 27, 2024 at 2:59=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> In addition to str_on_off() and str_yes_no(), add rules to search for
> str_off_on() and str_no_yes() replacements.

I don't know cocci well enough, but this does simply not scale. We
also have cases where "Yes"/"No", "YES"/"NO" and all possible
variations of that.


--=20
With Best Regards,
Andy Shevchenko
