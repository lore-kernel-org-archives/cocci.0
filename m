Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C95CDD1D6
	for <cocci@archiver.kernel.org>; Mon, 30 Sep 2024 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NX6y8GlHJBGgCMqdvEH9ttasFFoDzL05lMD7ZH8evq0=;
  b=KlBiqHTyeFjezakJlL+GAil730PRmPddR/Cj8E9CDfOLVbLG8BsroZlF
   ew/hIAx0vUaMLS+ZgBsjJowxyuCQalEar2JT65v53yt0FD432NKn8kmz5
   m0R1IYmUEUauNPRYBaBm0xIJywrtvjmC9KNr7H/5s+HMbuGV/XpnQlElI
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186068040"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2024 21:56:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 19420E0CD0; Mon, 30 Sep 2024 21:56:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ABC41E0035
	for <cocci@sympa.inria.fr>; Mon, 30 Sep 2024 19:45:06 +0200 (CEST)
IronPort-SDR: 66fae3a1_nsKgRl8HPMqST+UNAknneWnM3H6HcsVPzCf8gS0vUo7aCgD
 ytf2J0Yz41t793GEfbPDIRv3SS6eULzAey9R6hw==
X-IPAS-Result: =?us-ascii?q?A0GsBACh4vpm/yvQVdFaHgEBCxIMQIQTB3ZZNAQLSAMqh?=
 =?us-ascii?q?CmQIAoGgTwGi3KTYz4PAQMBDTsJBAEBAwEDgUmCcUYCd4khAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBCggLhS9GDYJjAYEJG2ECB?=
 =?us-ascii?q?QMJMAIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0fX?=
 =?us-ascii?q?wEBAQMSEQQZARsdAQMMBgULDQICJgICIQERAQUBHAYTIoJggi8BAzEDEQajM?=
 =?us-ascii?q?4EFQos8fxYFAhaBAYINBtpbChkoDRVXA4FgAgEGFIEGLoRzKVuCVAGBbIcOa?=
 =?us-ascii?q?XonG32BEIFKglgdPoJhBIFeFYNGgmkEkgmHZIQKJU1ViCmQaiYIAQYXAwcHC?=
 =?us-ascii?q?QUECRMGBQUCQgkGBQoSAwQDBAQBAgsTCQMDAg4CCAMCCAYOAhEBPxIEEwoNC?=
 =?us-ascii?q?wMGBR8IAgQHDBEKFwIDAwICAwIFAwMFBQUCAwUDBAMFAwMCEQEGAgUNCAYLB?=
 =?us-ascii?q?QUHAgYCBAgFAgIDAwMCBA8DAwMCBQICAwMBAgYPBgICAwUGAwMDAwMGAwMCB?=
 =?us-ascii?q?gMDAgIDAgMBAwIDAQIDAgICCAICAwUEBQICBAgQAgICAgMDCAMDCgQCAgQBB?=
 =?us-ascii?q?AIEAgQGAgQCAgEGAgMDAgMCBwICBAICAgIDAgQFAgMDAwICAgEJAgUBAQYCA?=
 =?us-ascii?q?wMCAwUDCQMEBQIDCAEBAgIHBwMDBAMBAgEFBAICBgUCAwICBAIEBQMCAwYGA?=
 =?us-ascii?q?gEDAgoGAwUDAwMDAgMCAwMCBQIIAgIEBAUEAgUEAgQDAwMBCgIGAwICBQEBA?=
 =?us-ascii?q?gIEAwIEBAcCAgcPAwIHBQIFBQUCBwEGBQICAwIGAQICBgEGAgQBAg0BAQICA?=
 =?us-ascii?q?wEDAwMHAgQDAggCAwMPAQMDCQYFBAUEAwkEDwIEAQgDAQEECAIEAwIMAgIgA?=
 =?us-ascii?q?gULBAQXCAMBAQMBAQICAgINAwIDAgIDCgIDAgoGBAIEAQEBBAQBBAIBAgcED?=
 =?us-ascii?q?gkFCAgBAwIBBAYBAhAFEAkDBwQCEAYKBQMCAwUBBRUDCAMJAgQMAwUIAgMCB?=
 =?us-ascii?q?gMGAgYBBgMHCwEBBwgFAwMDAhUBAgIPCAQGDggCAwMDBAoDEgIGDgMDAgMCA?=
 =?us-ascii?q?QICAgMFBAUCBwMDCgUCCAMCCAUDBwkECgIKAgYDAgICAgUMAQEBAQIDAgUDB?=
 =?us-ascii?q?wcICAQFBAMBAQYGDB4CAgMEDwMJAwYLAQUFAQMCAg4DBgIDBgYBCQQBBQQJA?=
 =?us-ascii?q?gUHBgUCARQHDQcGAgoCBwICAgMBAggJCAIDAgoEAQ4EGQIFAQICAwcCAwITA?=
 =?us-ascii?q?wMFBAgCAgICAwIBCgsDAgIDAwMDBQUDAhkDAwIBCgUMBQQDBAICAR0DAQUCA?=
 =?us-ascii?q?woBBQkBBgICAwIFAgMGBAIEAQ4BAQEDBgsJFAICAgkIAwgDBQ0CDQIDBQICC?=
 =?us-ascii?q?z0LBQEBBAMBCAEXLQIEAgYMAQEBAgMGAgICFQUFAwUDCAEDAQITCAYCAQMKC?=
 =?us-ascii?q?gICBAIGAwMCCgMBCAICAg8DCQIHAg0CAgMDDA8EAwMDAwgCAgIRCQoCAgIMB?=
 =?us-ascii?q?AoCCQICAwYBAgMDBQMCAQEBBC8CBAcBAwYKAwICAgkICgkDAwUDDAEGBAECA?=
 =?us-ascii?q?wwBAQITBAkDAgECAQEGCAEBAgQBBAIHBgICAgIKAwUDAgMFEwUEAgIZAwQFA?=
 =?us-ascii?q?wUDAwQHAQIFBAoJAgUDAgQDAwIEBAIIBQkEAwsGAQEBAwQDAQEIBwcDAgEBA?=
 =?us-ascii?q?wEBCgsIDQgDCAMGCQMBBgEBBRIIAgMOAgICAwIBCgYIBQIDBg0CBAIZAQwDA?=
 =?us-ascii?q?QMDBQ4EFAMEBQICDwwBAgMDBAUDBQICAgMCAgIFBAECBAIEAQgECQECAgIDA?=
 =?us-ascii?q?gEBAgQGBQICAgMCBwwHAwQCBgIGAgMCBwsLAgMGBQUDBQIeAgMCAgQDAxUBA?=
 =?us-ascii?q?QMBAgECAwICAwIDBAEDAwIBAQEDBwICAgQBAQEEBgUCAgMMAgMDAQEGAQMBA?=
 =?us-ascii?q?g8GBQYEAQoDAhQDAyICDwUIASYBBAICAQI2AgIDBA0IBQICBwIEDAIEDwUDA?=
 =?us-ascii?q?w4GFgYBBAgEBQQEDAoDBg4HFxEBAQQEAggEAgINBwIMAgIGBAICByMGAwUJA?=
 =?us-ascii?q?wIFBRACAgsCBAMVBAQbAwECCgICGAIBBwECEgEHAgIBFAIKAwIHBgcCHAICA?=
 =?us-ascii?q?wMHBAYBCQMECREDCwEFBgUBAQQRAQIBAgEBAgMDDgECAgMEAgIBCQICAQECD?=
 =?us-ascii?q?QgBBAMBBwIFAwUDCgEBAQIBBAkEDwYDBQMDBwMEAgMCBgIEBAICAwMCAwEFA?=
 =?us-ascii?q?wIBAgMJAgEPEQoPAgIDBAIGAgIBBCsEARUFAgMEAgIHAgIDAQIBAgICBAIEA?=
 =?us-ascii?q?gIGAwkIAQICBwECAgIDFgIFAQQJAwMFEg0jAwMBAgICAwcKAwUCAQECBAMFA?=
 =?us-ascii?q?wMJDQcCAwECAQMFAwECAQIJAwcCAgMDBRIZBQMCDwMCAQUEAggSCwcBAQ8WB?=
 =?us-ascii?q?QQJBRUDBgIDBhcLBAUDAwMBDAUMDgICCwMXBQEEBwEDEAsDBAQCAwMSAgESA?=
 =?us-ascii?q?QMEAgkCBAECCAICAgICBAEBBQQCBAMCBQIEAQgEBQMDDgQDCAkDBQMMFAICA?=
 =?us-ascii?q?gkCAwECAwMDBA0IFg0DAg4bChcTBwcDAwQLAgkDBA0CBAICAQYDBgoGFgECG?=
 =?us-ascii?q?AICBg4EAwMIAwIDAgIBAgICARMCAgkIDQUJBQcCFgQCAwgBCQMRAgMCFAEGA?=
 =?us-ascii?q?ggDBwEBBAICGhEKAQEDAQIBBycCCwoRCxEMAgQTHQIJAyMPAwsJCBM9AQsHM?=
 =?us-ascii?q?gQ0ARQUByshX6sDgVsBR4QEpUeCHaEAZ4M7jBaVQDOqRZh2jXuVYYUwESMSg?=
 =?us-ascii?q?UkmgVlwgQGCNlILDg+OIYN6vFk/MgIBBTMCBwEKAQEDCYwJgUsBAQ?=
IronPort-PHdr: A9a23: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
 BQMzPXzKoFBbuXG
IronPort-Data: A9a23:EbnA4a8jItnj3nr2l5mMDrUDv3+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 zNNXj/QbKqLamuhc41/Ydm19kNQ6J7cztMyGgVu+CtEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWctWo4ow/jb8k837a+q4G9wUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE3qllAh02D4oi0LhrKEYf1
 aU6dzAMcUXW7w626OrTpuhEg80iKIzmMNpatC07iz7eCvkiTNbIRKCiCd1whm9hwJATW6yGN
 4xFMlKDbzyYC/FLEkwRD4w/gOCsglHwdjRZrBSeoq9fD237lVwviOW2YIKPEjCMbdltomjJi
 kT/w2LSJzoKEsSgjiDZ0m3504cjmgu+Aur+DoaQ/flhi1y73X0WEBRQVF2hoPD/hFTWZj5EA
 0kd+y5roKRrsUL3FZ/yWBq3pHPCtRkZMzZNL9AHBMi24vK8y26k6qIsF1atxfR/3CPqbVTGF
 2Nlnu8FwRRqubyRDH+Rr/Ka8Wj0Ni8SImsPIyQDSGPpJjUlTJ4b1nryohRLScZZTeEZ3Rn/x
 jmLqG41gLB7YQsjyfCg5V6e696zjsGhc+P2jzk7mkqq6wp4YMiuYInABZ03KxpfBN7xc2Rtd
 0ToVyRTAC7iwH1NeOGwrD0xIYyU
IronPort-HdrOrdr: A9a23:PmHPX6N/q8JuwsBcTvSjsMiBIKoaSvp037Dk7TEJdfUzSL3iqy
 nOpoVi6faQslwssR4b6LW90cW7MBHhHNtOkOos1NSZPTUO2lHYSL2KhLGKq1bd8m/FltK1vp
 0QFJSWZueAa2SSTvyX3OB7KbsdKRW8n5xATN2x80tQ
X-Talos-CUID: 9a23:9Nnv+m9b1dTTwImsEImVv1NIEc55ck/a9l2OP2afWEYwauKVSEDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A7Uqi9wxePfhfT3jwC4ZxAr1DNaGaqLiWNG5cvbM?=
 =?us-ascii?q?/h8+vEAdgHS+iyy7rYpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186053802"
X-MGA-submission: =?us-ascii?q?MDFWHNjCSXSShHFirOUta2P6ag1pu7a8YWA1D2?=
 =?us-ascii?q?+BB0KuLxvlfbkPiLp5hxibH4zTPNUhiuHEC0xAgfWbU4+iyCJX02hnl4?=
 =?us-ascii?q?VyzQN5DoFeOlz9mhdBFigcLKjPPvyRmA8lDTvIs/sfRhw4WTSSouqsrc?=
 =?us-ascii?q?c+3u3S8gQk9Dk/xrYw3zg0xg=3D=3D?=
Received: from mail-ed1-f43.google.com ([209.85.208.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 19:45:03 +0200
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so3113023a12.1
        for <cocci@inria.fr>; Mon, 30 Sep 2024 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727718295; x=1728323095; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX6y8GlHJBGgCMqdvEH9ttasFFoDzL05lMD7ZH8evq0=;
        b=J+yrwXvk3OSrey0Ry/azN4cb/wlc7njb2dFFy+C5dAT6rkbjy1NgCnrf3WbF2XVSKm
         FgFNbl6YCEVsj2KTjo06Mfpu69Ti2xsyxP7yick+sfeH5eWwc+INPtAB8BvgTheqg4vy
         geXxiF/SCHGKl+sFvujQGGPBAMYgrbyPp7b/votUbRHpvah0zn4EN+1VHTHHrHr/lrF7
         bFlCJ/kDEvv9ohtyYnCQ/MdYuI2f6L/yUQZXLomFN0Sz3lvubtERV0hAQ0MWuE/o5pK3
         KsrzaSHV1AtSQ5p447asjPTPe85BD3O+5HwkuzgTgxNoXwGsshmsHyGEKKqeeRt5l1IG
         5tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718295; x=1728323095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX6y8GlHJBGgCMqdvEH9ttasFFoDzL05lMD7ZH8evq0=;
        b=LTINhKjhtf1XVW8otjvop/sd5Mq5kxFU/qxLqCJzzVJkG6Mmq/hePWxWv5kXCO4Nb7
         9wD6u8M7DieUN+FtRpqmPW/+txL8P4Fs57akbXItn9LKI7fMVmrSlabtKsSm84+xu1I5
         RmbjAHMxEolWKFhCjaKPrBzRJCzzgLaJJeyTruK2PZkkuRtv0rKcnX1m9Q1NuE7yNVt8
         NqenfOzFhYEqeQPxqbKo9jwe5b5tw6xHht+HoF33Ir6DxhHGWWP33/G3GCDKUu+xOd74
         rKNEqLZ4T0LeIpxKchtX0eMYT7yrFqjvngHbPqQEcWDYGRAdcIvhDAABlfw7hf+ogVV4
         djVg==
X-Gm-Message-State: AOJu0YwT8i2Vcpp3qhsMNLu/aoLPl4h+VZsdZu8rKRR5qNvAO8lK7gxV
	BOuigxCGZrW1roL3dlhKwAjBEyXcK8ySrgS+SQfoEzRX7lbeg/Zp00OBBOkLAirmAU/q7geHjcP
	xyaQAx+GqdMAp4lvhZZg1gIxm5MQ=
X-Google-Smtp-Source: AGHT+IEyXgz6ep74IK9HwfxZZSxtSv0iQc4K0UKATFuo/X80cJKWRCDXvefgHGhRJClv5sH4HneLmrohQn/1CG6rbYQ=
X-Received: by 2002:a05:6402:210f:b0:5c3:cc1c:4d9c with SMTP id
 4fb4d7f45d1cf-5c8a2a7819cmr477266a12.18.1727718294860; Mon, 30 Sep 2024
 10:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com>
 <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr> <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com>
 <fbd705ff-2c6d-4b96-aa71-114ed8789b99@web.de>
In-Reply-To: <fbd705ff-2c6d-4b96-aa71-114ed8789b99@web.de>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 30 Sep 2024 22:45:36 +0500
Message-ID: <CACzwLxiFrQx81F_NWDjWSEseu=ePn5PoPt59c74ud9-eUWCfFw@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Denis Efremov <efremov@linux.com>, 
	Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Assistance in Coccinelle script
Reply-To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1902
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/CACzwLxiFrQx81F_NWDjWSEseu%3DePn5PoPt59c74ud9-eUWCfFw%40mail.gmail.com>

On Mon, Sep 30, 2024 at 9:56=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Here is the modified script:
> >
> > // __user exists in parent function parameter.
> > @r1@
> > identifier f, param;
> > attribute name __user;
> > expression E2;
> > position p;
> > type T;
> > @@
> > f(..., T __user *param, ...)
> > {
> > ...
> > (
> > copy_from_user@p(..., param, ...)
> > |
> > copy_from_user@p(..., param + E2, ...)
> > )
> > ...
> > }
>
> Can an SmPL code variant (like the following) trigger further inspiration=
s?
>
>  {
>  ... when any
>  copy_from_user@p(...,
> (                 param
> |                 param + E2
> )                 , ...)
>  ... when any
>  }
>
>
> Would you like to try any fine-tuning out with SmPL disjunctions?
>
>
> > @script:python@
> > p << missing.p;
> > @@
> > msg =3D "match !!!"
> > coccilib.report.print_report(p[0], msg)
>
> Would you like to apply the following statement (instead of two)?
>
> coccilib.report.print_report(p[0], "match !!!")

Thanks for the suggestions. I've modified it like this
and now have much better matches, though there are several cases
left like this one:
https://elixir.bootlin.com/linux/v6.11-rc7/source/drivers/infiniband/core/u=
verbs_cmd.c#L2038

Going to improve the script further or it's much easier to filter out cases=
.

// __user exists in parent function parameter.
@r1 exists@
identifier f, param, addr;
attribute name __user;
expression E2;
position p;
type T;
@@
f(..., T __user *param, ...)
{
... when any
copy_from_user@p(...,
( param
| param + E2
| &param->addr
) , ...)
... when any
}

// __user exists inline copy_from_user() casting.
@r2 exists@
identifier f, ptr, addr;
expression E2;
attribute name __user;
position p;
type T;
@@
f(...)
{
... when any
(
T __user *ptr =3D ...;
... when any
copy_from_user@p(..., ptr, ...)
|
T __user *ptr =3D ...;
... when any
copy_from_user@p(..., ptr + E2, ...)
|
T __user *ptr =3D ...;
... when any
copy_from_user@p(..., &ptr->addr, ...)
|
copy_from_user@p(..., (T __user *)ptr->addr, ...)
|
T __user *ptr;
... when any
ptr =3D ...;
... when any
copy_from_user@p(..., ptr, ...)
|
copy_from_user@p(..., (T __user *)ptr, ...)
|
copy_from_user@p(..., u64_to_user_ptr(...), ...)
)
... when any
}

@missing@
position p !=3D {r1.p, r2.p};
@@
copy_from_user@p(...)

@script:python@
p << missing.p;
@@
msg =3D "match !!!"
coccilib.report.print_report(p[0], msg)
