Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F08BC71141
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ULDRRP8J1r9OalZxRSTmjUvWqANoUHadkiZtzLelOB4=;
  b=dsO+YWgndZ7E9LgDeMcj9es5eQrmIpOIT96/g4hi2lAaB2X172BVMiAu
   EM1NDXIQ5tA+j+l4K1Fpkb/McT0vbvvIaRE4jhLBapaWyzvYByJLZNF5J
   ObmH+ELGGwWOgWOFaXsukbkJ68gHQr4MVDUYFz6XR1Ege3CkMKmhbC8vO
   g=;
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
   d="scan'208";a="226896186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2AC77E0D75; Thu, 12 Jun 2025 15:49:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B7421E0131
	for <cocci@sympa.inria.fr>; Wed, 11 Jun 2025 09:59:49 +0200 (CEST)
IronPort-SDR: 68493775_J+KXhE6cBRyXQnSv0niR3NeBPToqXt4O99TG/N9+fJeLcto
 tvoP16cpZmq+B6SRy+g//kuj3zAFVDa6G3Uj78A==
X-IPAS-Result: =?us-ascii?q?A0EHAABJNklofCmnVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgQBaMwRUhFWIHF+GVYIhA4ETnQOBfQIPAQMBDAFED?=
 =?us-ascii?q?QQBAQMEhQACi2YCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEiGQcOEimFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECA?=
 =?us-ascii?q?RIRHQEBNwEPCwsDCgICJgICIRIBBQEcBhMigmABgiEBBiIkAxGkE4EFQopEe?=
 =?us-ascii?q?oEygQGCDAEBBtwjgWUDBgkBCoEHLgGITwGBbYQaKYM5eicbgg2BFTWBBoE3O?=
 =?us-ascii?q?D5phzWCaYIoRFKQH4UTizgmCR0DBwcODR5GDwUcA1ksAVUTFwsHBVtFQwECA?=
 =?us-ascii?q?YEOI0sFLR2CDYUZH4FzgVkDAxYPAYFrghcchGKEA0YrT4MigRJtZUGDYRENB?=
 =?us-ascii?q?nIPBzZAAwtiCz03FBtMmG+DcHsTLIFaOQELE5MJHZAbg1afVoQlhHCHLZVQM?=
 =?us-ascii?q?5dLkxYuh2WQcYwOgXmVS4U7AgoHBxEkgUQ6gVwzGggoCGwGgjBPAxkPjiGJE?=
 =?us-ascii?q?7JGQTUCOgIHCwEBAwmQS4FLAQE?=
IronPort-PHdr: A9a23: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
 xtwjRFxM7xFyQ==
IronPort-Data: A9a23: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
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:wxBwb6wwjDmEAnq1vwwYKrPxy+skLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBHpTnyAtj4fZq8z+8D3WB1B9uftWbdyQ+Vxe1ZjLcKoAeQbREWlNQtsp
 uIGpIWYLKfMbEQt7eY3ODMKadE/DDxytHLuQ6x9RdQZDAvT5slwxZyCw6dHEEzbhJBH4AFGJ
 2V4dcCjya8eFwMB/7LTkUtbqzmnZnmhZjmaRkJC1oM8w+Vlw6l77b8DlyxwgoeaTVS2r0vmF
 K12DARp5/T+c1T+CWsm1M73K4m1+cJDeEzSvBkv/JlZwkETDzYJbiJFYfy/Azd69vfkGrC2O
 O82CvIef4Dok85N1vF2yfFyk3u1i0j5GTlzkLdiXz/odbhTDZ/EMZZg5lFGyGpmXbIkesMoJ
 6j5VjpxKZ/HFfFhmDw9tLIXxZlmg69pmcji/caizhaXZEFYLFcoIQD9AcNea1waB7S+cQiCq
 1jHcvc7PFZfReTaG3YpHBmxJipUm4oFhmLT0Aesoie0iRQnnp+00wErfZv60so5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMbTc6+GgX2MGPx2aKpUCra/Y08Sg3wQsTMkcgIDcmRCeA18Kc=
X-Talos-CUID: =?us-ascii?q?9a23=3APRa6xGu59UMDsP+827siiK7v6IscUECC/SaKPHW?=
 =?us-ascii?q?XBFxAD7OsCmGh//hNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ADFrGQgzwb/CksjCtDKvJxvJ4zJKaqLWoNF4Tg5Y?=
 =?us-ascii?q?ah8SFLjZdYWy9tAmmQIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,227,1744063200"; 
   d="scan'208";a="226240127"
X-MGA-submission: =?us-ascii?q?MDGOr62Vct5IA6R3CQlyJgoxmK1aid6FqPJ0cJ?=
 =?us-ascii?q?Ebb+uhWO5efAXS3xBztWyoZLVnbsX3YLEbfa4yaIdxXW02N0oHOHvHxi?=
 =?us-ascii?q?Sk3K9M1jywasw1lzXz8cZnAm6/4SODqK8HHC9lt16BFvV/SbrBHXL5MP?=
 =?us-ascii?q?hj1Un2FmEmg/vlHz7lTq/uYw=3D=3D?=
Received: from mail-lf1-f41.google.com ([209.85.167.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 09:59:49 +0200
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-551ed563740so7867515e87.2
        for <cocci@inria.fr>; Wed, 11 Jun 2025 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749628788; x=1750233588; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULDRRP8J1r9OalZxRSTmjUvWqANoUHadkiZtzLelOB4=;
        b=EGE88EyxbZWa+m2Cj6++akV+5GepVItfUrduXA7xB19RGGPHnzW3W2nfzg7eVP/0eX
         ltOZ5S+Hkz/TOjQTTB48mmzlKTBFfaIatriSBAGwZCkt2tfIwhOZvuZ4AsjrbbZym+ow
         3XDdlhOXZNcg3AOVmmv0EyTdNaWAuT6S0y8/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628788; x=1750233588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULDRRP8J1r9OalZxRSTmjUvWqANoUHadkiZtzLelOB4=;
        b=YYLTCfu2hMfhvwwYFUY8C+p6yktcrTtmup032gIlW06NVN4Wkbd+lx3frNHxyyhrHK
         3OnYX7ZWT8cDruLpbSjx4KfP7v9E/3tcXVqzqI3XpJv2ULDragA/cHpjbvt2wckpnJfS
         AaxqdOF6QB7HgrLikEunawGIEyzKwMOWlxtRrd/3yo0WiKBkS/OKFzVJOmxSOKSXbiLP
         8csvmwJL5JxhXVDq+HF3N6C/zIkwlVEBA/QhEdXezHYRThDYzXStAuAN8JJuBt6elgO9
         /49JFpH6ugWHUIe1Jbo5FIwZsKLqX5H4O9mfV8i59wiofRz3IMGC1K7+PmvO8nN9KqDU
         H52g==
X-Forwarded-Encrypted: i=1; AJvYcCW+Iv9FMcZfuQJNhLlxfPONNKqxsrhjY8YyGtG1sW4sLTTuf3FCDHySDfqvM6q0clKpe28Ffw==@inria.fr
X-Gm-Message-State: AOJu0YyC03xxfw6d9XayZY7RFvewyl8G5jwhWOdpaIKaeM9Wo+Fqov/C
	ufLIqwPfMLxgjvnMH77zFKk4D1ti4osGMqYlLREp9Abg+Kg27orK/RneFCHhXEDxUs1EhqZotcn
	PG/0=
X-Gm-Gg: ASbGnctienrKN7WvzP7+6uPwYEGF9W5XT2PG7lLXG/L55iTRpTgLC56LeKtWB9ZCeSe
	B3maQaCjbqiLnkbGWR9w/1k5ss8RP+DqWazGRkvjCeCh20NYrVaBZI1sXjO/SlzQ8wlxZH1tnQ+
	ojwYvosxoxPx9ds4ZVGZhITYTdPQ20cPreBPRF/ClFErAq7JkTWQNRpkt8H2v/qG0Bz2V87kyzu
	p+IaBtZbgNIawI/9K5ZC8bxs9W5OjPsGXNDfXChdPqVq12l0/y0y+1l982WDITG8AX3+UwnnZdf
	Mp/JvK21moh0H6R7sYbLaJocOUJVMviTWjqv987XYEWmBaiMEwSMjPNgWR12ESTHUXKsjlEw4/i
	Ndp99aJvWuFblDzPhgtEWLcxA
X-Google-Smtp-Source: AGHT+IGY/DKmTJr0ZyNLvQ5EkwkQOyRlJXCO5ZlDogwiOz/ufhjA0bSuPv5BI9UVwuIGGNxL5mloRQ==
X-Received: by 2002:a05:6512:ad0:b0:553:3446:beda with SMTP id 2adb3069b0e04-5539c13f8a0mr730527e87.35.1749628788272;
        Wed, 11 Jun 2025 00:59:48 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1b351d0sm17308201fa.41.2025.06.11.00.59.47
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 00:59:47 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5536b9be607so4303269e87.0
        for <cocci@inria.fr>; Wed, 11 Jun 2025 00:59:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVldsxpEX6xmg6gnCgSdD855d1SVZ3BcKfAp8HSWjm3atVVrH7R5LYLqQQ0wHRepjSQIm5q3Q==@inria.fr
X-Received: by 2002:a05:6512:3988:b0:553:2944:f3e with SMTP id
 2adb3069b0e04-5539c1d6f11mr678921e87.51.1749628787314; Wed, 11 Jun 2025
 00:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
 <aeacb653-efb8-42ed-a7ed-3e7be31b8f9d@linux.microsoft.com>
 <CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d=S6vFdvZzVqbif7NKfA@mail.gmail.com> <588d5a4b-72cf-4d2c-8eee-c4240ae067b5@linux.microsoft.com>
In-Reply-To: <588d5a4b-72cf-4d2c-8eee-c4240ae067b5@linux.microsoft.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Jun 2025 09:59:34 +0200
X-Gmail-Original-Message-ID: <CANiDSCuGo4CAaM2qd1FviWoZ-y0Dg6BWYXHmsNOBsXmxZj=ndQ@mail.gmail.com>
X-Gm-Features: AX0GCFuJ-OnqASEGSwJpRPA-DeamvypVOt4R7T55jGMIJ2aacHY0Bzr2ZdumOaY
Message-ID: <CANiDSCuGo4CAaM2qd1FviWoZ-y0Dg6BWYXHmsNOBsXmxZj=ndQ@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Andrew Morton <akpm@linux-foundation.org>, cocci@inria.fr, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies script:
 Create dummy report
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 2773
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/CANiDSCuGo4CAaM2qd1FviWoZ-y0Dg6BWYXHmsNOBsXmxZj%3DndQ%40mail.gmail.com>

On Tue, 10 Jun 2025 at 19:35, Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> On 6/10/2025 6:09 AM, Ricardo Ribalda wrote:
> > Hi
> >
> > On Wed, 29 Jan 2025 at 18:38, Easwar Hariharan
> > <eahariha@linux.microsoft.com> wrote:
> >>
> >> On 1/29/2025 12:06 AM, Ricardo Ribalda wrote:
> >>> When running cocci in report mode, eg:
> >>> $make coccicheck M="$dir" MODE=report
> >>>
> >>> It returns this error:
> >>> virtual rule report not supported
> >>> coccicheck failed
> >>> make: *** [Makefile:251: __sub-make] Error 2
> >>>
> >>> Create a dummy rule to avoid this error and run the other cocci scripts.
> >>>
> >>> Fixes: 551dbd1ec7ff ("coccinelle: misc: add secs_to_jiffies script")
> >>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>> ---
> >>>  scripts/coccinelle/misc/secs_to_jiffies.cocci | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> >>> index 8bbb2884ea5d..2d85dca16418 100644
> >>> --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> >>> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> >>> @@ -10,6 +10,7 @@
> >>>  //
> >>>
> >>>  virtual patch
> >>> +virtual report
> >>>
> >>>  @depends on patch@ constant C; @@
> >>>
> >>> @@ -20,3 +21,8 @@ virtual patch
> >>>
> >>>  - msecs_to_jiffies(C * MSEC_PER_SEC)
> >>>  + secs_to_jiffies(C)
> >>> +
> >>> +// Dummy rule for report mode that would otherwise be empty and make spatch
> >>> +// fail ("No rules apply.")
> >>> +@script:python depends on report@
> >>> +@@
> >>>
> >>
> >> Sorry about that, and thanks for the patch!
> >>
> >> FWIW,
> >>
> >> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> >
> > I just checked on 6.16rc1 and it is still failing.
> >
> > Could we land this while Mark's series is under review?
> >
> > Thanks!
> >
>
> Can you provide a pointer to Mark's series? I actually just implemented a proper report and context mode
> which I'm glad to send out.

My bad, it was your series:
https://lore.kernel.org/cocci/e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de/



>
> Thanks,
> Easwar (he/him)



-- 
Ricardo Ribalda
