Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D86C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cO39370VtQtqphEmZUqo/vdz5Ks//iXnVcC+FwG8BVs=;
  b=ILYpVvv9dj382TagEu/3VGmJD5A7f6Zl0pB7AkQp8QF5d+XSKSckyVjJ
   w2aULmekwYZe0hNFN6Y2tUfczoC99f2Of3H7Z12XWYQ+ucv9+7xxruKSg
   ESkn0gG7Y3EpCY1slQCnnSr20j/0Cr8b5VzXHK4mksIIjYGxH5aupSEcq
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205516748"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 09:41:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA155E0D1D; Wed, 29 Jan 2025 09:41:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CCE3E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 09:41:04 +0100 (CET)
IronPort-SDR: 6799e9a0_bqCxSjf8NVBVXUVme/CpK6FRk8y6X91KaWJwkHkGEged9u9
 VfND73mqEixfmLc7mCNZHW6bwJAKlM35jCT4XIw==
X-IPAS-Result: =?us-ascii?q?A0EFAADb6JlnfDanVdFaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUECAQEBAQELAYJDgVczBFOEVoh8hlOCIQOBE50Eg?=
 =?us-ascii?q?X4PAQMBDAFEBAEBAwSFAAKKdQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABASIZBw4SKYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?g1+AQEBAxIRHQEBNwEPCwsNAgImAgIhEgEFARwGEyKCYIIxAzEDqAWBBUKKR?=
 =?us-ascii?q?HqBMoEBggwBAQbbJiJXgWQJCQEKgQYuAYhNAYFshxNpeicbgg2BFTWCPTg+a?=
 =?us-ascii?q?YNaFYNGgmmCM4Fzgllnl0OJUSYJHQMHBw4NHkkPBRwDWSwBVRMXCwcFYUhIA?=
 =?us-ascii?q?QIBgRAjgSYFNUE6gg1pSToCDQI1gh58giuCIYI7ghiCLUeECoVbghSBZQMDF?=
 =?us-ascii?q?hABgXOBNHgcgiwdQAMLYgs9NxQbTJ1fPIR+G4JDHjqSQB2DM5Axij6VEYQlh?=
 =?us-ascii?q?G+ccTOEBI0GA4Y3kw8uh2SQaqNKRoRzAgoHBhEjgUsFLoFcMxoIKAhsBoIwT?=
 =?us-ascii?q?wMZD44hiQ3FB0I1PAIHAQoBAQMJkBeBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z87q6ZhLYxbNrz/dJbFY+4UvJI=
IronPort-HdrOrdr: A9a23:OgrYPaE9i92XMbFxpLqEZ8eALOsnbusQ8zAXPo5KOGxom6uj5r
 KTdZUgpGzJYVMqMk3I9urwQpVoLUmsjqKdpLNhRYtKPzOW3ldATrsSkrcKqgeIc0aOlJ856U
 4jSdkGNDSZNykYsS+Q2njHLz9P+qj3zImYwcjZ1GlkVgxnZuVN6A1jGh+HHkAefmU2YaYRJd
 6z4o5pqzK8ZW8adK2AdwU4dtmGidmOupyOW3A77t0chzWmvHeH7Lb7Fly/xRcRUzRGxPMH/X
 LemwL0ooWP2svLtyM0FVW/032borrcIxJ4ZL3qtvQo
X-Talos-CUID: =?us-ascii?q?9a23=3A0NZTjGltMR8dbjXVkRR0itNJ2TXXOXLA/VvKBRe?=
 =?us-ascii?q?aMGxGSIzNe1SA3KBpvsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AAEENiAze2A42/jeFadA6qHyCZgyaqJ6xNWsrsLQ?=
 =?us-ascii?q?mge+/CAl3IQiwrCaKXpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205516644"
X-MGA-submission: =?us-ascii?q?MDHLrLF35uGFfGdaoNwXzVYPy0+UMfpUe9W5tZ?=
 =?us-ascii?q?GRo/9bIXpVQd92OJdpAqnSzvYGYmzVFyUYH4CsFb/VITMSAqYEj8VvB4?=
 =?us-ascii?q?azDycEwZcS13RVwXIrrI8lzwEvbt/eQHeBgZUErateYaVDn8mDGFFam6?=
 =?us-ascii?q?6ig5QX2mNfzANA/8wnDADD2w=3D=3D?=
Received: from mail-lf1-f54.google.com ([209.85.167.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 09:41:03 +0100
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5439a6179a7so525899e87.1
        for <cocci@inria.fr>; Wed, 29 Jan 2025 00:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738140061; x=1738744861; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO39370VtQtqphEmZUqo/vdz5Ks//iXnVcC+FwG8BVs=;
        b=KMy54Djtas0qT0HOliMYNXhVJ+uPF+szJ0Uh9hQcMpzi+uDedNjo53VWibRaWb7dvP
         SBcpfEZMKYJ5jF1IXRg/txaOnkdhQGuEN1l9+Ni+eEa0pLFCkEOngPxR0pRShikSbHfX
         bSn0JdGHjGFQYBYP5jhbVHcpYS2ancuf4RCJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738140061; x=1738744861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO39370VtQtqphEmZUqo/vdz5Ks//iXnVcC+FwG8BVs=;
        b=tmvK2Z6h5oKSuj7QQvOcPVIJeLWx+Fj08JIhymF81HFHHXwj5zNZU9fTJ4SteKt93k
         8pVVt8epOsCcvq7LFXaGW+f8QHKauIdkBP1C+b9C7EDEdPl5GQD+5BrvV2Ho0m/stCmx
         FoYdrwkjorxL/6K0AZ2tvp7hX2WADLzFT7Da995RdRO28gWCUVTGpV45ABOZA/MDlDlR
         h6afEa196QWDnp7IKIemlzN3inSOu1maa2wjyEIvg9UXPQa1L2R2OEBLpYySsBtnKHyy
         vZU9Dcs+V4t8je3cuDv3l+QCl+kKUdkUnYfRwwRkUPuhZH13/LLgOy+cVh4+PmJG9eLa
         hPdg==
X-Forwarded-Encrypted: i=1; AJvYcCUYhvbMWaauLsDnNmyEQT8aG4fobflmtdbuDA4it7Xri4EdRNNiSKocts/KsxzHqMJGNsEXFw==@inria.fr
X-Gm-Message-State: AOJu0YzsNJotgV5bQvDyo7EkmAyt3+pGqvFy0H4VsDQs+vd4LS1VguDs
	pUxrWUhvV7yMRZpf0RKRnK8FlDrMsmiCNOY9iMhtkWYLhQ9V0AfsKkXKfm9UgB/JobfrmfITQV0
	BZA==
X-Gm-Gg: ASbGncu9i7X3wfhISqz6I99ublGAwO+PA7UQFf+LU1Y+vbVbJeiTRGhBGvazbYrxcr+
	5fQLTTIGEnC7S8o1fa5Gk4fYy3KCkIngUYaJUwEobG8mHV2orZ3Dgv/KOSKV35h8+zan5wInemB
	v0khy6RCwGYdszZnUWlO8Gv62LDi2Aw2OKn/DX5cKC6hdDcKSmWmLkQ2dBaTZmI93SGnYLZOhYZ
	QCbo2hN2Dc957OsmY1Qs1d8ntcI7b0YrcpiJlJO/KVsbwvQA1ZXN8QSTyYGcvJO7ANPmQtAIbBx
	ILScD658J8DDpTGWf3E4PVMEFE7kJFsEu2FNgIXowxi9veDfDvnmXLMWmA==
X-Google-Smtp-Source: AGHT+IGKbSBE81qdIfBee4DKhXHLZeMevDkSHsyA1goNm/QO3U41MqNLFPstr7cT4TGR98PGNc39xw==
X-Received: by 2002:a05:6512:2349:b0:53e:3852:999c with SMTP id 2adb3069b0e04-543e4a7a000mr748649e87.12.1738140061284;
        Wed, 29 Jan 2025 00:41:01 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c822f8cdsm1920800e87.78.2025.01.29.00.40.59
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 00:40:59 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30219437e63so4822681fa.1
        for <cocci@inria.fr>; Wed, 29 Jan 2025 00:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/Yn7y8mDss1GS+/ABcEjhLZgGlYkgk8+HGMCvewpqSHDSx0DFPlwwTmlgZv1GZJAdGk7a1g==@inria.fr
X-Received: by 2002:a05:6512:1313:b0:542:8bf0:2fa3 with SMTP id
 2adb3069b0e04-543df6ae7a2mr2036916e87.5.1738140058920; Wed, 29 Jan 2025
 00:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org> <fe13604a-2626-4641-908e-87eeaca53288@web.de>
In-Reply-To: <fe13604a-2626-4641-908e-87eeaca53288@web.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 29 Jan 2025 09:40:46 +0100
X-Gmail-Original-Message-ID: <CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC=gj41Hxtgiw@mail.gmail.com>
X-Gm-Features: AWEUYZlpM9GVhs5ldC_citqJGj5iIReMpwx347jREvFQp64Ws0GIJSK33decl3Q
Message-ID: <CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC=gj41Hxtgiw@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Victor Gambier <victor.gambier@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies script:
 Create dummy report
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 2301
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC%3Dgj41Hxtgiw%40mail.gmail.com>

Hi Markus

On Wed, 29 Jan 2025 at 09:37, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > When running cocci in report mode, eg:
> > $make coccicheck M=3D"$dir" MODE=3Dreport
> >
> > It returns this error:
> > virtual rule report not supported
> > coccicheck failed
> > make: *** [Makefile:251: __sub-make] Error 2
>
> I hope that more collateral evolution will happen because of such informa=
tion.
>
>
> > Create a dummy rule to avoid this error and run the other cocci scripts=
.
>
> Please add proper support for operation modes around discussed source cod=
e analysis approaches.
> Will it be more helpful to work with function calls like the following?

My main concern is to fix the CI that was broken when this semantic
patch was introduced.

I am sure that a person more capable on cocci patches can implement
the report mode in a follow-up patch.

Regards!

>
> =E2=80=A3 coccilib.org.print_todo(p[0], "WARNING: opportunity for =E2=80=
=A6")
> =E2=80=A3 coccilib.report.print_report(p[0], "WARNING: opportunity for =
=E2=80=A6")
>
>
> Regards,
> Markus



--=20
Ricardo Ribalda
