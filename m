Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2986C7114A
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lHgVganSUXqkPMCFr70WEyU8s9NnpUIxuGsS5BNhkwY=;
  b=HM1UNw8H5tF3tQfmDeUcM161InrhVTMaAox5h385N7hzFuoabghVi+eB
   6QnF0kQBNjt1vrP5gv7EIBQKHaJw1zS2dJXHZ4M5Xj0KS5yJL58DAgqIQ
   jSGi+NiR6Z/Rob1g4xHnUIlQUzPJxyt6r3RNwsr4fVq8WxSx0DZwkBaVv
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226896058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AADB2E0D27; Thu, 12 Jun 2025 15:49:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 771FDE0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 15:09:33 +0200 (CEST)
IronPort-SDR: 68482e8c_jKuUeyxKQraRu9yW44EF/v57SDZZfAu20drWWOAI8IRi6zX
 cYApSz7gHSdJLCn5OoDW3pX/d0ThVR5jSEML+GA==
X-IPAS-Result: =?us-ascii?q?A0ECAAC2LUhofDCnVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVozBFSEVYgcX4ZVgiEDgROdA4F9Ag8BA?=
 =?us-ascii?q?wEMAVEEAQEDBIUAAotlAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBIhkHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BA?=
 =?us-ascii?q?QEDEhEdAQE3AQ8LCwMKAgImAgIhEgEFARwGEyKCYIIiAQZGA6IkgQVCikR6g?=
 =?us-ascii?q?TKBAYIMAQEG3COBZQkJAQqBBy4BgleFeAGBbYRDgzl6JxuCDYEVNYEGgTc4P?=
 =?us-ascii?q?mmHNYJpgihEUpAfhROLJyYJHQMHBw4NHkYPBRwDWSwBVRMXCwcFW0VDAQIBg?=
 =?us-ascii?q?Q4jSwUtHYINhRkfgXOBWQMDFg8BgWuCFxyEYoQDRitPgyKBEm1lQYNhEQ0Gc?=
 =?us-ascii?q?g8HGkADC2ILPTcUG0yYX4NwexOCPwELkxwdkBuDVopAlRaEJYRwnH0zl0uTF?=
 =?us-ascii?q?i6HZZBxo1KFOwIKBwcRJIFEOi6BLjMaCCgIbAaCME8DGQ+OIYkTskZBNTwCB?=
 =?us-ascii?q?wsBAQMJkEuBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:TQzIdKO8upv2DsBcTkijsMiBIKoaSvp037Dk7TEAdfU1SL3qqy
 nKpp4mPHDP+UwssR0b6Ku90ey7MAvhHP1OkO8s1NWZLXbbUQKTRekInOmSpgEIWReOj9K1vZ
 0QEJSWY+eAc2SS4/yKkTWQIpIOxsKY+Lukieqb43BmVhFydq1shj0Ue2KmO3wzag0DKpYwCY
 aG6tAvnUvdRV0nKuq+QlcKNtKsmzQJrv3bSC9DKRou6AzLqyip5r78Gx3d+hsFSTtAzfMD3A
 H+4nHED2eY3s1TBiW864Yb1fQm/+fc9g==
X-Talos-CUID: 9a23:U8znD2PHcZBNH+5DVg9Z0FAIAsMfbSPn0HCAJHLhCGl1V+jA
X-Talos-MUID: 9a23:POGjyQjbVZCLd0RuKc2k88MpFcZt8fSxD14xiJg7m9agNnFIMg/Bk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118655600"
X-MGA-submission: =?us-ascii?q?MDHmTGgA4x8aP2ZiXHHR0prQrkNipSa+TokZNg?=
 =?us-ascii?q?b9sT4OXAU2j57pajg27IJsfl8LVZQ/L8zZKL3qfljZ9VYUvk9bmIUuyv?=
 =?us-ascii?q?D6NgfgSMkTrTosYrTTAvijhUnqc0swUWj7nvUkqn4qindbTWiqZNvfU6?=
 =?us-ascii?q?ybutXbPlua/AyjlC7OMnUXFA=3D=3D?=
Received: from mail-lf1-f48.google.com ([209.85.167.48])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 15:09:33 +0200
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55350d0eedeso5606131e87.2
        for <cocci@inria.fr>; Tue, 10 Jun 2025 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749560971; x=1750165771; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lHgVganSUXqkPMCFr70WEyU8s9NnpUIxuGsS5BNhkwY=;
        b=k+GopKFjk6nTLta/tB9+GrkhDKdoabm78MK0bQmPyhjIbp5mIwrB5c49Vb4/B8xu2o
         9aGEwDotSJ64doItE+b5ChWw13DWBHQHupoHPCMI5k1cIguaROvqW4X+cESFlHFZbxEz
         A5682XgV4AUkAzgQ7gj+uU7nQvD/p6giIT808=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560971; x=1750165771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHgVganSUXqkPMCFr70WEyU8s9NnpUIxuGsS5BNhkwY=;
        b=xCPYSF7XdDPD8DX9oq/qF8Xbx70i6fSwnWyWSJVpcYb+Ubgf7cMd/CMzWzeUNZbq9e
         wDaMg7f8Fj4IIRmdwQoyCud2DDEkaaDYIRFEdY9/HLqG5s615gD8GYIdk6uDLeWrgX46
         03wpMy4NTryzvdfdoy8dz/BHa2zmRha8gkja+xgKDVuQT8eEtDsBII7VDLdtF8Q3TWWT
         jvVV/wUplKYMaNreEuw0p5jJD6GP6NVANvl5ESJjgNSVcSEBZhg5CAHLTII2zPyhBbYq
         YvLwrEXF3HNqVoGCmlmwKEwLIZXGoa6JHrt5fRqafSOFkYhbtgr4c7ioej4MuYMJ9Zif
         FqlA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RcLaRbR+eAa2xQy798wSwjjaX9hAR191s7jQ3GjW/wsiOLl7P180bLOvd0moId6R9AZnYg==@inria.fr
X-Gm-Message-State: AOJu0Yx6uFKvYL6wB3Od7k9ttuPYFU04dzMnY53Gzb4yUd47d/m9w/mP
	0vn5kxfnOf7c7EOaqBSsPNyxIG5DIUertgGXkTKSpho/TrBsa/SZf0ALJutYitgiig7Lg/ad7os
	25QY=
X-Gm-Gg: ASbGncvlCWX4iPNeDW+ZUV9gIbtn0VXh9oD8ZVOzpYQNC2ZFiYa4y54uqja0FDaT4v8
	6Li0vzp/o65ptIceJdotnQoBaLk1xNbeztVQJPei6aDrHlw1Ct0TOQCuQMihTKdQbHGwhAOHWVk
	9Cg0oSUSpTJYVPKypklyv2Cb3JOcj28oY2D3jdheTY2n3zooKYflOacTRk1jDkbKTHmFpvEMoMf
	mPtmSNT5xcn6eKvbKxR478Z9HDh1QIabwt+yTQrlqt5FjYiF5Op+bqmvuwCnMDiNkvxXAv87/Lb
	sW0fQzTLspwEXKXzQLihI+7stJbEq2YVNEz2SWRay1T+8dej73O5hLyw4HaaCKBieZix8qgZcKE
	aSpNDgtjYF17eZa9OEUvdIWKn
X-Google-Smtp-Source: AGHT+IG46wVLJSqOJu72vFTF922NI9lzPLLfrEabzwqXzKOzyMK1ceqMazCxSi2+TWN/M5rR3qhQ1Q==
X-Received: by 2002:a05:6512:689:b0:553:33d5:8463 with SMTP id 2adb3069b0e04-55366beeac8mr4010126e87.24.1749560971438;
        Tue, 10 Jun 2025 06:09:31 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553676d04d2sm1534753e87.33.2025.06.10.06.09.30
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 06:09:30 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-551efd86048so5515014e87.3
        for <cocci@inria.fr>; Tue, 10 Jun 2025 06:09:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6TjuwmAeJgRN1kEJhkz97ydB1i3Tn4cLB1teVAcjh4Fe/7H4B4moRgoWryvMUJWAs9A18Jg==@inria.fr
X-Received: by 2002:a05:6512:1294:b0:553:543d:d963 with SMTP id
 2adb3069b0e04-55366c30244mr4804636e87.36.1749560970095; Tue, 10 Jun 2025
 06:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org> <aeacb653-efb8-42ed-a7ed-3e7be31b8f9d@linux.microsoft.com>
In-Reply-To: <aeacb653-efb8-42ed-a7ed-3e7be31b8f9d@linux.microsoft.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Jun 2025 15:09:18 +0200
X-Gmail-Original-Message-ID: <CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d=S6vFdvZzVqbif7NKfA@mail.gmail.com>
X-Gm-Features: AX0GCFvQjJu9HZ-Os99-ShsNpf-gTaw_io6WlDFV5wQCq_AZ0qq2K5O0Ohea78c
Message-ID: <CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d=S6vFdvZzVqbif7NKfA@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Andrew Morton <akpm@linux-foundation.org>, cocci@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies script:
 Create dummy report
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 2769
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d%3DS6vFdvZzVqbif7NKfA%40mail.gmail.com>

Hi

On Wed, 29 Jan 2025 at 18:38, Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> On 1/29/2025 12:06 AM, Ricardo Ribalda wrote:
> > When running cocci in report mode, eg:
> > $make coccicheck M="$dir" MODE=report
> >
> > It returns this error:
> > virtual rule report not supported
> > coccicheck failed
> > make: *** [Makefile:251: __sub-make] Error 2
> >
> > Create a dummy rule to avoid this error and run the other cocci scripts.
> >
> > Fixes: 551dbd1ec7ff ("coccinelle: misc: add secs_to_jiffies script")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  scripts/coccinelle/misc/secs_to_jiffies.cocci | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > index 8bbb2884ea5d..2d85dca16418 100644
> > --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > @@ -10,6 +10,7 @@
> >  //
> >
> >  virtual patch
> > +virtual report
> >
> >  @depends on patch@ constant C; @@
> >
> > @@ -20,3 +21,8 @@ virtual patch
> >
> >  - msecs_to_jiffies(C * MSEC_PER_SEC)
> >  + secs_to_jiffies(C)
> > +
> > +// Dummy rule for report mode that would otherwise be empty and make spatch
> > +// fail ("No rules apply.")
> > +@script:python depends on report@
> > +@@
> >
>
> Sorry about that, and thanks for the patch!
>
> FWIW,
>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

I just checked on 6.16rc1 and it is still failing.

Could we land this while Mark's series is under review?

Thanks!


-- 
Ricardo Ribalda
