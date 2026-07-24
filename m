Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C339C5321C
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+1l0UO6IoBtzLodlS8aLRj3wfaO+WA4HpECbIgyuWaU=;
  b=pRr+1AgUYnJQy2VJhd6j03FOuK8IBwVd3sWITZBqtZzFg5dTwZQtyg8Y
   sFVdnp3GiWZtbe2quihGmnb9YXLHU2KcoJ99m8atGWpvAqKu5ya1/8p5Q
   OlZmo+Bk/tbtXe1GO2rm6u/seLsOnlkfLFZFtTOBmIZMaLmRVCFkCH+pj
   s=;
X-CSE-ConnectionGUID: Fk1lfKqqTL+M19zUNMN+sA==
X-CSE-MsgGUID: /xCCl/cmQAq7DwHSz7pHAA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="287871580"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:37 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6DBEE80587; Sat, 25 Jul 2026 13:44:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 397C581A04
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 17:23:11 +0200 (CEST)
X-CSE-ConnectionGUID: XxbzTswHQM6b/hpM6CHwwQ==
X-CSE-MsgGUID: X8STowkXTVCHyg0c/T2GKw==
IronPort-SDR: 6a63835e_EQe4gh0ND8C2BwDY348or6qGcZHZ9As5yUiz7IbSW3sykU4
 mRvEVRrKTJ2ZJPrknmfwSAzlA4zsndxLfg53NHQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GJBAAJgmNqfK6AVdFagluCP1qBDjQEC0mEWI9SgiEDi?=
 =?us-ascii?q?S6CGTACkE2DFD0CDwEDAQ1RBAEBAQIEOIRGAo1gAh4HAQQ0EwECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBDAGCC?=
 =?us-ascii?q?wGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBB?=
 =?us-ascii?q?QIsXgEBAQECARIRBBkBGx0BAwELBgULAwoCAiYCAiABAREBBQEcBhMIGoUDA?=
 =?us-ascii?q?QYQAQMQJwO2W4ECQopDen8WBQIWgQGCDQbaaAoZKA11gWYCBxQBAYEJLoR4K?=
 =?us-ascii?q?l0DgjoEHAEFbn2EB4QCeieBGIEQgUqBdIECPoIfgiQVg0aCagSBDoEUgQyBD?=
 =?us-ascii?q?YtDhT8mAQcBBhcDBwcJBQQJEwYFAwICPwkGBQoSAwQDBAQBAgsTCQMDAg4CC?=
 =?us-ascii?q?AMCCAYZAT8SBBMCCAkECwcFHwoCDBQKKCIEDisKAQIBVRAGGgEIBgICBAQCB?=
 =?us-ascii?q?AIKAgkCAgUDBAIEDQMEAQEIAgIDKgMBAxkICQgCCwURGAwLBzEDEAkDAh0DF?=
 =?us-ascii?q?BYFCBE0CAYWARoHBQYLASAWFAEFDBEBAhsCIQQdARAIAwEHAw4EBAIBCwMBA?=
 =?us-ascii?q?wEVBAgJBAwCDwEKEhUDAwsDBw8CDQcUBRULAwIOAgkIDBcCAgIGAgMDAwoBA?=
 =?us-ascii?q?gEBAQEBAQECBwMDAwIDGQcGAwMBAQMBBAQDAwIDBQEDAwMFAgIKBgkBAQEBA?=
 =?us-ascii?q?wICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMIBQMEAgMDAwQBAgIBAQECA?=
 =?us-ascii?q?wEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDA?=
 =?us-ascii?q?gEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBA?=
 =?us-ascii?q?gICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHA?=
 =?us-ascii?q?gMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECAQIIB?=
 =?us-ascii?q?QYDAgIRBQgKBQYCAgIdAyEBAgEPBgEJBQIBBQ4HBQICChIDBgEBAwQFBQEDA?=
 =?us-ascii?q?QoBCwEBAgMDAQQFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDB?=
 =?us-ascii?q?AUFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCA?=
 =?us-ascii?q?wECCAQGBQMDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLA?=
 =?us-ascii?q?gIDIQIFAwMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLG?=
 =?us-ascii?q?AMLCQgTPQELBy4EBAwqARQUBSkhXxCNbiOBXlsHAXMbBwMROUuBCQEVH4EcA?=
 =?us-ascii?q?QEBkhoOkiaBfZ4kSR4JAQYCYIFngQoVCi+Ke5BkhhYzhASNFJlUkyuFXZITk?=
 =?us-ascii?q?VeFSBEkEoFJI4FcMxojgQFtgUlQAxkPji0Wg2DODjgyPgEHAgcPAoFzhF6GF?=
 =?us-ascii?q?4U/gUwBAQ?=
IronPort-PHdr: A9a23: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
 0djMWWdL48=
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:wzUNoKPYbYFVIsBcTiajsMiBIKoaSvp037BK7StMoH1uA66lfq
 WV8cjzuiWE7gr5NEtQ+uxoRpPwJk80hKQFhLX5VI3KNGOHhILCFvAH0WKN+UyYJwTOssBYkY
 lvGpIRNDQyNzdHZATBjDVQa+xQuOVvOZrIuc7ui0x2VAlvZuVJ5Rp4DAHzKDwMeCB2QaEiDZ
 KZ645+uza9dTA2Y62AdwQ4dtmGnMfTnJbqJSQLHAEq82C1/EmVwY+/KQGR2hpbaD9U3bI+mF
 K17zDE2g==
X-Talos-CUID: 9a23:zfzHMGB+g+5H5gn6Exl3/lwoAd8FS1iDxjDQO2rmIkZ2V4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3APRjoTQ78Az1N6pPG81pf8frWxoxYs5+SD18Ooak?=
 =?us-ascii?q?4kOmVOnR7fAvHoxeoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287803246"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFxH9nVMJzV7GrniVApOIPWMH+y1aZ2VRatAX?=
 =?us-ascii?q?9OqDP0Js96FH16JecTIBuXnB/Cq9kFWOpYaIhqOFHkXfpnGlHphwyJzY?=
 =?us-ascii?q?oT1E6krYZB8Pv/axNP67NVUXe2udk0OVwVwDV8TRh4mn0IdttRWg3Fvd?=
 =?us-ascii?q?DnUmZ+xKnQmPGlhd0/yMZZIQ=3D=3D?=
Received: from mail-yw1-f174.google.com ([209.85.128.174])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:10 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81e69a2db34so6116447b3.0
        for <cocci@inria.fr>; Fri, 24 Jul 2026 08:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906589; cv=none;
        d=google.com; s=arc-20260327;
        b=keRnBqbRE97/NR99RAPNcoYofJI8aQAzM0ERLUN0bJcOmaOLMykN3jFNTd/2OoKIjx
         gqwO23t1o2fEQj99dFXKD0MGumGHfiDouiMT+Xc3dHPkTVYu7E5syQcJN1t5EG5SPl/d
         tz0izhp2rmKSO/izYLIV6BmN7+0U3fTHzYTl5hYNjoOj6Htchw3tmuw8nSxPB4O0YL2q
         /jfNaLACGOVLjEK1QfGfS0wgz/l01dVmV1GURPM+nICrUDnWt8B0QL1+US9FNZhPTFvl
         VPkOfv4WJ2VqrgoYMeICYYmNAwDcG41J/0w4iHiV5+J/aAxgYAuqOIk35+DbAGCVUKKv
         6a2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+1l0UO6IoBtzLodlS8aLRj3wfaO+WA4HpECbIgyuWaU=;
        fh=BE16+NzPHjMqJf9Uq1ewIcNUkST3kz40Sysk/P4mMs8=;
        b=PBb4jOKAKClTV5dLYsk099Wsuvy86YRblbXMbgK5xMjJtZpkX9yZExOytSEZz9Vq9c
         ObWQnS/Ie1XddR+I6NhuhML01ijMIdIrb5eO69h0tbps34NiSyz+tsNnQTOKKf8rJPoF
         3rrXXgIQHyr23q52PL+MzzWMJSwonxYA3o/17cANhFCEPX5qqYCxRgg86bpNABalrsDH
         z1op65H9twGsXnKaoDZl3cwrGGBf/gW0dhHTNatHa6VgB2pKKMxHfcTXYtKtdAy+Fh/2
         MpRVnJwitFOLATzQv72sMeWwkLTxwOLexQQ41MZcyJ1Ygru1Or2flfbtRtAqdVY//lKF
         6MSw==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906589; x=1785511389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1l0UO6IoBtzLodlS8aLRj3wfaO+WA4HpECbIgyuWaU=;
        b=qrOOSiynM+x4OS17buK/ksoKPWj5wYjWBbJPoNcElE74WWPf6126MEcAAFAKf9Ga+U
         BpxMD1LW2z1cbBj8dR50PahyXPpA3GAOveVHixH0tg5dD4kEZ1JJiKq5T47EuERs1NeR
         Y25q2+QIGWFvleJy92sUjZe2t0YzvCctl1OU3bI0aDN3k69M6vsjv/YziNLNm062IVIe
         TMJPa5nNeko2VSyUN4cj+0Y4+5jnIM6VYC6f7x3xpTMnjQIQWuSJfoaYWVUmTnFT/lUu
         2Ogxr6XsYg+lfK+3CRCTXsyDcXDYJXRWo8Re7ZL+ilu5kQxz7xFn1Nv/upxk0C8vre7k
         +acw==
X-Forwarded-Encrypted: i=1; AHgh+RoYPt/KeEgaSrkLydvIULcM/bVhaz6nRh7SqbpkrzfutT6jXfnB9eEVWm/nPLSdNQMo8jfbgQ==@inria.fr
X-Gm-Message-State: AOJu0Yx383hQEgZBjo27sne59S8K4KUfRXqFrYZwuu64h2UtxWScYm60
	i3NixA9uKE75Jk/j08AtNjJadk/Nn8AwMivdR6yN2LAvnB/Ej/yVXN1yUV5dR3nUYdUaniVRD+5
	DaeihuUrmEhhd7nMV0fi4Yl8Q6CF2yfc=
X-Gm-Gg: AR+sD12dfMkUGvpJCwnmxNDJ9x8T7f/RwVMztDFULVXtr9DDE+0YdCphlmfhq0ByLqd
	UKir9PE45EK0htY5OvFoDF2ILOwODg9oodlSZiXTRMiax6xOEYkT6b+DTR44SHAHyaCXMM88j2o
	mMNyfU4g/QysNNFY9Spwdxkc8OwDUq9uD3oYXzRHUPuLLgFhVYNM/aDaMKG4bHO1GeQzIu5VKlE
	TBgHtwdS8D0aOhiB9mFxTe+U2H99fvS2vCYSPL8cAy0NWeCKZhMmdjfSJ8=
X-Received: by 2002:a05:690c:6712:b0:809:86c6:ee18 with SMTP id
 00721157ae682-81f4c3224c9mr27486987b3.37.1784906589296; Fri, 24 Jul 2026
 08:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-16-ekffu200098@gmail.com> <20260724013827.612dd9ab@jic23-huawei>
In-Reply-To: <20260724013827.612dd9ab@jic23-huawei>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 25 Jul 2026 00:22:57 +0900
X-Gm-Features: AUfX_mzX9ECIP2A7hSt2nQZv-eQ3QZfZjoIfj4c4mOlqdwyuUp2aBUYDEVG7syo
Message-ID: <CABFDxMFzZEqk+60O1+x6O0gGCdOwJuCXNnsWRxedcZ2hpkUtSQ@mail.gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Julia.Lawall@inria.fr, Linus Walleij <linusw@kernel.org>, cocci@inria.fr, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 15/36] iio: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3650
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/PI_g7yeaS-D0DnBfX7LTEw>

Hello,

On Fri, Jul 24, 2026 at 9:38=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 24 Jul 2026 03:45:17 +0900
> Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>
> > Both branches of the check return the same value, so the check has
> > no effect. Remove it and return the value directly.
> >
> > This is the result of running the Coccinelle script from
> > scripts/coccinelle/misc/cond_return_no_effect.cocci.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  drivers/iio/light/isl29028.c      |  6 +-----
> >  drivers/iio/light/tsl2583.c       | 14 +++-----------
> >  drivers/iio/magnetometer/ak8974.c |  6 +-----
> >  3 files changed, 5 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.=
c
> > index b88e7c4eae3e..ea38d797082b 100644
> > --- a/drivers/iio/light/isl29028.c
> > +++ b/drivers/iio/light/isl29028.c
> > @@ -405,11 +405,7 @@ static int isl29028_write_raw(struct iio_dev *indi=
o_dev,
> >       if (ret < 0)
> >               return ret;
> >
> > -     ret =3D isl29028_set_pm_runtime_busy(chip, false);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return ret;
> > +     return isl29028_set_pm_runtime_busy(chip, false);
>
> That should have been a return 0.  The call to pm_runtime_put_auto_suspen=
d()
> can return positive (in theory anyway).  The intent here was probably to =
eat
> that positive and ensure we return 0 or negative only from this function
>
> Please split up a fix for this as a separate patch.
>
> Even better if you have time would be to do that and then a second patch =
to
> get rid of this helper that adds no obvious value.  Smells like code
> that evolved into a slightly silly form!
>

I looked into it briefly and I agree with your analysis. Not eating
positive looks like a mistake to me too. Removing unnecessary helper
this time also sounds like a good idea.

> >  }
> >
> >  static int isl29028_read_raw(struct iio_dev *indio_dev,
> > diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> > index a0dd122af2cf..a38a0130d854 100644
> > --- a/drivers/iio/light/tsl2583.c
> > +++ b/drivers/iio/light/tsl2583.c
> > @@ -456,12 +456,8 @@ static int tsl2583_chip_init_and_power_on(struct i=
io_dev *indio_dev)
> >
> >       usleep_range(3000, 3500);
> >
> > -     ret =3D tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
> > -                                         TSL2583_CNTL_ADC_ENBL);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return ret;
> > +     return tsl2583_set_power_state(chip,
> > +                                    TSL2583_CNTL_PWR_ON | TSL2583_CNTL=
_ADC_ENBL);
> >  }
> >
> >  /* Sysfs Interface Functions */
> > @@ -790,11 +786,7 @@ static int tsl2583_write_raw(struct iio_dev *indio=
_dev,
> >               return ret;
> >       }
> >
> > -     ret =3D tsl2583_set_pm_runtime_busy(chip, false);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return ret;
> > +     return tsl2583_set_pm_runtime_busy(chip, false);
> Similar to case above.   It should have been eating the positive return
> by return 0;  Also the same suggested follow up cleanup applies in this d=
river.

Ditto. Nice catch :)

> >  }
> >
> >  static const struct iio_info tsl2583_info =3D {
> > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetomet=
er/ak8974.c
> > index c7fdb7c2f543..c988d0e40cea 100644
> > --- a/drivers/iio/magnetometer/ak8974.c
> > +++ b/drivers/iio/magnetometer/ak8974.c
> > @@ -379,11 +379,7 @@ static int ak8974_getresult(struct ak8974 *ak8974,=
 __le16 *result)
> >               return -ERANGE;
> >       }
> >
> > -     ret =3D regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
> > -     if (ret)
> > -             return ret;
> > -
> > -     return ret;
> > +     return regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
> This one I agree with.
>
> Thanks for looking at these.  I suspect you may want to take a closer
> look at any other changes you've scripted that are similarl
>
> When code is doing something silly it might just be that, or it might
> be intended to do something not so silly!

I agree. This patch was generated by the script, and I only checked
whether it is a false positive or breaks the existing logic. Fixing
mistakes and improving code itself is always a good thing. I'll drop
this patch from the series and send it separately to IIO, including
the fixes and cleanups discussed here.

Thanks for your detailed review.

> Jonathan
>
> >  }
> >
> >  static irqreturn_t ak8974_drdy_irq(int irq, void *d)
>

Best Regards,
Sang-Heon Jeon.
