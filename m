Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8316AC71143
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7xWU0+iIZBfV5Nl2WnjT76QONoK6dozWW2aQjG6ZTA8=;
  b=kcyhCUgxfy3zj/JTHhIADe149jjpD19rJYhPXHLZPOKojQlFJCTFclwp
   ALlq/LuE5ipYg+9J6xY4n/W/56d/vscEdraDQcOPFAM4+ejZZoKV5f2Xo
   LfDk0bzGRvBooBMK9WO1D6+jCYCFb/VMCiM1NuY+aqqKkNLk8Fm3zxD1h
   A=;
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
   d="scan'208";a="226896159"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0CF04E0CD7; Thu, 12 Jun 2025 15:49:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5BC5BE0157
	for <cocci@sympa.inria.fr>; Wed, 11 Jun 2025 09:56:43 +0200 (CEST)
IronPort-SDR: 684936ba_csOgmigIXLHH/ijRH60bGHzW7aTJrrYpWwkWf/HiFO7nDlW
 qk05yH9nZ1HK8yHDCw2yWaqwxSaWV4lQ1usTRvw==
X-IPAS-Result: =?us-ascii?q?A0ERAABeNUlofCmnVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDgQBaMwRUBIRRiHuGVYIhA4ETnQMUgWkCDwEDAQwBR?=
 =?us-ascii?q?A0EAQEDBIUAAotmAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBIhkHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBA?=
 =?us-ascii?q?gESER0BASwLAQ8LCwMKAgImAgIhEgEFARwGEwgagmABgiEBBiIkAxGkEoEFQ?=
 =?us-ascii?q?opEeoEygQGCDAEBBtwjgWUDBgkBCoEHLgGITwGBbYQaKYJQaXonG4INgRU1g?=
 =?us-ascii?q?j04PmmDHYQYgmmCKERSig2WXSYJHQMHBw4NHkYPBRwDWSwBVRMXCwcFW0VDA?=
 =?us-ascii?q?QIBgQ4jSwUtHYINhRkfgXOBWQMDFg8BgWuCFxyEYoRJK0+DIoESbWVBg2ERD?=
 =?us-ascii?q?QZyDwc2QAMLYgs9NxQbTJhvg3B7EyyCM4pci36afJN1gSGEJYRwhy2VUDOXS?=
 =?us-ascii?q?5MWLodlkHGMDoF5lXkYhHUCCgcHESSBSwopgVwzGggoCDsxBoIwEzwDGQ+OI?=
 =?us-ascii?q?T6IVbJGQTUCATkCBwsBAQMJkEuBSwEB?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:zl7A7K3Qobmhc+Lj08cuFgqjBDskLtp133Aq2lEZdPWaSL3pqy
 nOpoVp6faQslwssR4b6Kq90cW7MAjhHNtOkPEs1NSZLW/bUQmTXf5fBOLZqlWKak+Ok9K1l5
 0QCpSWYOeAbmSS5vyKnjVQfexQseWvweSGg/zBx2xhQQwvR6Zr9BdhFwqXe3cbNW17LKt8Op
 7ZycZOuia6dW5/VLXGOlA1G8bG4/PE/aiJXffEPXEawTjLozeh6Lu/NQOZ0BcYWzYK5bs562
 DKn0jYy8yYwoyGI93nulM7I642pDIp8LszY/Cxtg==
X-Talos-CUID: 9a23:tB8eeGOJOVKOwe5DBTE51koIFdoZXHjv50XqOGukJltPR+jA
X-Talos-MUID: 9a23:kUjIcgWpUCZrA8Pq/DurhjZ4bstC2IeFN10Kj5s0uMaYbSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,227,1744063200"; 
   d="scan'208";a="226239192"
X-MGA-submission: =?us-ascii?q?MDFjPMoX3oU4T6i8CAzGeF3M3tJXi1O0R44vmd?=
 =?us-ascii?q?/MCYDgEN2cc3yq8TrtnZdm54XN33vzpRO2cbubxRseDvx32t/jTneeVX?=
 =?us-ascii?q?yMG0EKtYhggJ4aW5UkTQyDcVvtr2yVScmxuuH7TSfttDlBUkzpOmWLCV?=
 =?us-ascii?q?bLKezRElO2pIqWIQVQb7pNoQ=3D=3D?=
Received: from mail-lf1-f41.google.com ([209.85.167.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:56:43 +0200
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55324062ea8so8208037e87.3
        for <cocci@inria.fr>; Wed, 11 Jun 2025 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749628602; x=1750233402; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7xWU0+iIZBfV5Nl2WnjT76QONoK6dozWW2aQjG6ZTA8=;
        b=GGQ11V/QyiTcOb1P2bRf7HiCOn8iAFlY8GLsfjPyCoh6xPUGPNiwMr/N0thil8WIVq
         YAu0e3R9Wi7C5TRG7ME4I2lQDog0misPuWcTuUenkD4zHZkCQdqAvbgYo5fdSv879Dya
         aeIK2C+JY8/VtRSjzFUtaHIBALj78wkYh+szI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628602; x=1750233402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xWU0+iIZBfV5Nl2WnjT76QONoK6dozWW2aQjG6ZTA8=;
        b=qo9OX5xo2wdY1t6gqQJx3roplhCpW1bykhlga51nt/1ZY8c1MD/oOx3mkdIA4Fj4RO
         wdpJ8uMjFpH6ObGoPDAniX/0xtXUTT+PuAdIZIfp559QxZyKrAlM/7SryJeVzMDNkMbF
         pubKkKwJGoXAZ/+Fz6cvTdVFX1ibDmva0g1RWc4CtFV+E09nVw73IFimMwkm0+Uq3PGG
         v5qqLV1HgtsgqZc47IDT0RKW2OPl1wiAvlSRr75IKaBUaxPAxyEjiwOryoyAZHhGqn6F
         nMJH5p1wJ19ECXA0vwUA/+0W7cYyYqFGgpiSjhTjtZeRnvblRsUi7ajtRIdXhAnND+gI
         4pYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRnJS0F+L4dgLYoyjkxzp7nf4r5fE+nR4RuMBnxB8m+pwSUEZB+ZoIlezVRcPVVyBMpdjYrg==@inria.fr
X-Gm-Message-State: AOJu0YywUcQuDMXJMoyKPX1xJL5ZgaFCgDVEDrqavY9uobM6L9zSrhPF
	YMCb3xtu/sJRMl3dg50I6DQ1hinR7q6EKHzq0HoNOHDDEzixH37Le5Xg7h+yVn9xX1BlHnMQPM8
	i1OI=
X-Gm-Gg: ASbGncsuYPUwb1VGyCsTISEl/sajq44k0Y0gAJfVNfaiUBCuJHPpxVc2V2vvnW7xK/k
	s4ADtidg40dkGeLLRsyBNcB3dQCou2ar7Oi51MIf0NgXGFS3DT48jP1ho2xrZ97sAu0cQgoG8KE
	kNBCrz3bqtpLVdR6SRrIRSByJcrdadAr0G99WvLJ2kIn0gyJlO+3IUZhWj+xfjsUFxNhBD1iz3K
	hYcedvQU+h4TxKUtDAOXmNo59g/fd31UadjyqXqYDab4+okInLL79TohU6rqbOO4yy0++pNa4oM
	M2QT9I2c5qyIeJp9mOjPvx8EylR5c+IZYrGNU4ALA5QXeAo/KG3bDFunjsdQzxilVFrAiB07kWm
	NhoiwI8QtiAzxZeR6IgiIm+CF2zrOdSHrITY=
X-Google-Smtp-Source: AGHT+IGBQCnugFNWFPiVFrKFN/fq3lXvlkS9XFtEg9IvKeXJFViqzaTY3qPQwakbPVjNzmFsaudj/A==
X-Received: by 2002:a05:6512:b23:b0:553:2767:e398 with SMTP id 2adb3069b0e04-5539c22d00cmr598887e87.39.1749628601657;
        Wed, 11 Jun 2025 00:56:41 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536772a945sm1852703e87.161.2025.06.11.00.56.41
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 00:56:41 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55324062ea8so8208016e87.3
        for <cocci@inria.fr>; Wed, 11 Jun 2025 00:56:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF9yNJ6LlzAbUppG259DvCc2iYmC2fJ/S8z/048VKt5iHOO1YgiIrKDs23gu+If8g8pmZyvQ==@inria.fr
X-Received: by 2002:a05:6512:1106:b0:553:3892:5ecc with SMTP id
 2adb3069b0e04-5539c21945amr752118e87.36.1749628600654; Wed, 11 Jun 2025
 00:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250610174521.12294-1-eahariha@linux.microsoft.com> <00e40c21-4797-41df-b082-318f474f76ae@linux.microsoft.com>
In-Reply-To: <00e40c21-4797-41df-b082-318f474f76ae@linux.microsoft.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Jun 2025 09:56:28 +0200
X-Gmail-Original-Message-ID: <CANiDSCsqfvYtD0ScAjWF0vensD3kRfA5tCLVi8UVYvcS8X_oSQ@mail.gmail.com>
X-Gm-Features: AX0GCFsSjG3YU2hML-YtpLfuMZy8nMEytDs7VdvUAV9hGvBg4DkTfOAumhHsTuI
Message-ID: <CANiDSCsqfvYtD0ScAjWF0vensD3kRfA5tCLVi8UVYvcS8X_oSQ@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	"cocci@inria.fr" <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies: Implement
 context and report modes
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 2772
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/CANiDSCsqfvYtD0ScAjWF0vensD3kRfA5tCLVi8UVYvcS8X_oSQ%40mail.gmail.com>

On Tue, 10 Jun 2025 at 19:49, Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> On 6/10/2025 10:45 AM, Easwar Hariharan wrote:
> > As requested by Ricardo and Jakub, implement report and context  modes
> > for the secs_to_jiffies Coccinelle script. While here, add the option to
> > look for opportunities to use secs_to_jiffies() in headers.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Ricardo Ribalda <ribalda@chromium.org>
Tested-by: Ricardo Ribalda <ribalda@chromium.org>

With this patch I can run coccicheck MODE=report with no error.

Thanks!


> > Closes: https://lore.kernel.org/all/20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org/
> > Closes: https://lore.kernel.org/all/20250221162107.409ae333@kernel.org/
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > ---
> >  scripts/coccinelle/misc/secs_to_jiffies.cocci | 49 +++++++++++++++++--
> >  1 file changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > index 416f348174ca..f3241ce75a7b 100644
> > --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > @@ -7,26 +7,65 @@
> >  // Confidence: High
> >  // Copyright: (C) 2024 Easwar Hariharan, Microsoft
> >  // Keywords: secs, seconds, jiffies
> > -//
> > +// Options: --include-headers
> >
> >  virtual patch
> > +virtual report
> > +virtual context
> >
> > -@depends on patch@ constant C; @@
> > +@pconst depends on patch@ constant C; @@
> >
> >  - msecs_to_jiffies(C * 1000)
> >  + secs_to_jiffies(C)
> >
> > -@depends on patch@ constant C; @@
> > +@pconstms depends on patch@ constant C; @@
> >
> >  - msecs_to_jiffies(C * MSEC_PER_SEC)
> >  + secs_to_jiffies(C)
> >
> > -@depends on patch@ expression E; @@
> > +@pexpr depends on patch@ expression E; @@
> >
> >  - msecs_to_jiffies(E * 1000)
> >  + secs_to_jiffies(E)
> >
> > -@depends on patch@ expression E; @@
> > +@pexprms depends on patch@ expression E; @@
> >
> >  - msecs_to_jiffies(E * MSEC_PER_SEC)
> >  + secs_to_jiffies(E)
> > +
> > +@r depends on report && !patch@
> > +constant C;
> > +expression E;
> > +position p;
> > +@@
> > +
> > +(
> > +  msecs_to_jiffies(C@p * 1000)
> > +|
> > +  msecs_to_jiffies(C@p * MSEC_PER_SEC)
> > +|
> > +  msecs_to_jiffies(E@p * 1000)
> > +|
> > +  msecs_to_jiffies(E@p * MSEC_PER_SEC)
> > +)
> > +
> > +@c depends on context && !patch@
> > +constant C;
> > +expression E;
> > +@@
> > +
> > +(
> > +* msecs_to_jiffies(C * 1000)
> > +|
> > +* msecs_to_jiffies(C * MSEC_PER_SEC)
> > +|
> > +* msecs_to_jiffies(E * 1000)
> > +|
> > +* msecs_to_jiffies(E * MSEC_PER_SEC)
> > +)
> > +
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +
> > +coccilib.report.print_report(p[0], "WARNING opportunity for secs_to_jiffies()")
>
> Sorry, I was testing sending this to myself before sending to the list, I've added the mailing lists now.
>
> Thanks,
> Easwar (he/him)
>


-- 
Ricardo Ribalda
