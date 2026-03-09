Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B16EFCD71
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=N2EabwjW5WxPwX5Blg+/kL5UKsujhBTVnxIyzjEUEx4=;
  b=HR4IsLofzWDjsCe9naMrNL5Vv0uEKejWW3c7U0MFTeDPZsxALzcmbXDv
   KKyp6P2V96KjmrdXJYaUZW38SXkNb3bC6fANkbP7NB5bU3OxkTxZVzNpC
   HJE1m6CBbhNx6JC2d/ab8w8/jTESTd88AAj0Czfrpsohu1QzddyvoT23E
   E=;
X-CSE-ConnectionGUID: 1pNd7elhS5K4FUvtzJ1a5A==
X-CSE-MsgGUID: RpiQfhKcTu6QzG+wnEFCAw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266839832"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 10:49:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E847181883; Mon,  9 Mar 2026 10:49:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 902C481263
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 02:22:46 +0100 (CET)
X-CSE-ConnectionGUID: /0D5wBvEQgCyJCzaSOPinA==
X-CSE-MsgGUID: 6P6VmgUQS6iyfIOpuqFHFA==
IronPort-SDR: 69ae20e4_ftz6Fs/fA0xyxQC1hKZJ4p76Ae+UUXvazgpb/Ufy9yyLUOJ
 oI8+3meM1Fxbh/WRy5fGQOpCnZY30d8WQIj2V4w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GxAgB2IK5pgSrgfUpagQmEEYEHXjQECxkwhFiPU4IhA?=
 =?us-ascii?q?5NMjA49Ag8BAwENPRQEAQEDBIUAAo0hAh4HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQEiGQcOO4ZPDYJiAVhMYQIFAzsBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBCgINH14BAQEBAgESER0BGx0BA?=
 =?us-ascii?q?wELBgULDQICJgICIAEBEQEFARwGEyKCYYIiAQYQAQMPJwMRnhuBAkKKQ3qBF?=
 =?us-ascii?q?QUCFoEBgg0G2mUKGSgNcYFkAgEGFAEBgQkuhHcpXQGCNx8BgXCIBHonG4INg?=
 =?us-ascii?q?UqCdT6BUk1CA4EmORWDRoJHIgSDMIkXiW4mCAEGFwMHBwkFBAkTBgUFAj8JB?=
 =?us-ascii?q?gUKEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTCg0LBwUfCgIMFAooIgQOK?=
 =?us-ascii?q?woBAgFVMAEIBgICBAQCBAIKAgkCAgUHAhEDBAEBCAICAyoDAQMZCAkIAgsFE?=
 =?us-ascii?q?RgMCwcxAxAJAwIdFxQFCAERNAgGFgEaBwUGCwEhFhQBBQwREQECBgUDAgEDB?=
 =?us-ascii?q?AMDAwMDAgQCAgICBgcLAgoEBAQDBQMDBQYDAQMEAwgDCgIECw0GBQICAgECD?=
 =?us-ascii?q?AwDAwoEBAMCBQIGCQMCAwMBAwEDORwTBAUCBQMDAToDDgQDCB4CAQECBgIBA?=
 =?us-ascii?q?wMIAgMBAwIHAxQFAQYIAgQECgIDAwcGBQcCESgEAgICAgQDAwMKBwcEAwEHA?=
 =?us-ascii?q?wMMAgIQAgQEAhQDAwQDEAMBAhIYBgEDBwgDAgcEFgMCCRkEAgQDAgICAgEuA?=
 =?us-ascii?q?wUHAgQBBwEDAwcDAgwCAgISBQQGAgEDDAMEAwUFCy0RBxMKBgQHBQICAhQGA?=
 =?us-ascii?q?gQBCxIDAwQEAgECAgI6BAcBAgoaCgQECAcDBwEYBQIDAgUBAwEHBxICBgQIA?=
 =?us-ascii?q?gEOARICCQICBAIJAQEKDwIBAQYCAgEDCBgDBB8EAwMHAgIMCQMEDQEBEQEKE?=
 =?us-ascii?q?hsDAwsDDRIHBAMMChQFFwsOBAIJCAMNAgsLBgUKBRkCAgIGAgMDAwIFCQECA?=
 =?us-ascii?q?QEBAQEBAQIHAwMDAgMDBgMPAw4PAwsJCBM9AQsHMgQ2ARQUBykhX44KPoIzA?=
 =?us-ascii?q?VgJLSoCgRh8pgmgIHEVU4M+hHCHLo8+hhYzqmuIKZBdjgmECZceESQSgUkjg?=
 =?us-ascii?q?VxwgQGCNk8DGQ+SIYUTxDU5MgIBOQIHAQoBAQMJkWo0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:dB9jxqkUOQ7jvcPlji+R4OIoD9HpDfLA3DAbv31ZSRFFG/FwyP
 rDoB1L73LJYWgqMk3IV+rwRJVoJkmsi6KdgLNhQotKOTOIhILGFvAa0WKP+UyHJ8S6zJ876U
 4CSdkaNDSTNykAsS+S2mDReOrIguP3lJxA7t2utUuFIzsaFp1I3kNXDB2EGlZ6SAQDKZ0yD4
 qE+8ZLzgDARV0nKuq+QlYIV/XevNHQ/aiWGSIuNloI7E2hg1qTmd3H+tujviv2kQkg/V7qyx
 mmrzDE
X-Talos-CUID: =?us-ascii?q?9a23=3A2ELIrGhS2/7gWP/tRgMNTEZ1HDJuNSXxkWj6PWK?=
 =?us-ascii?q?BBk14apaHQGS3wKJiup87?=
X-Talos-MUID: 9a23:AHukTgkYo0Fb9fIlmGSxdno8DJlW5quTMXtTkIQImu6cKDVeGxm02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266768817"
X-MGA-submission: =?us-ascii?q?MDF1FXdXDceJa/PW73NrsoBi/X7AJ8DPJIxuyp?=
 =?us-ascii?q?utpywHx4hxRTn8Ad9MWeiXQA4lxSv3Sfd2aovDtSiHhwUDIxuXNBqV/j?=
 =?us-ascii?q?YvrxXiMA9WHmxukA9y8s/ei56GY6qCFHE91MV6vC0PY0nzZgzdroS28x?=
 =?us-ascii?q?aW1a6AnqJdvP9afInFWL16aA=3D=3D?=
Received: from mail-yx1-f42.google.com ([74.125.224.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 02:22:44 +0100
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64cb577e79cso11808890d50.0
        for <cocci@inria.fr>; Sun, 08 Mar 2026 18:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773019363; cv=none;
        d=google.com; s=arc-20240605;
        b=cACFCalL4jxcy76sr0ewIVQkOeVw8B+7uorI29DNVFrUjPFCRrSlO0vT2sYJZJAsDf
         tEVK9OaqzznhlMvGdOVP43teKkHApuC09eJoG4MKOtLUyaStxa8AkNrB6dKV1haWdL38
         8BUB1wbQGtzfMSnPupfcS/dgl3hIvzy30yRD5+iuGF2tH9yLqPyHWop783gEJcqIXQLq
         RDEZSwaNlPtJHIITZC7F+5n0y64o+NzWQqxwiEJC/lJAK/BmZNp/5KA9ksqq42A/Fklv
         AqjP404kHNXDJW/DIWATDscyVLl6Rs8V8ygGcQLDQVLNoxikhaClxtOqZwa18VdMR3e9
         mZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2EabwjW5WxPwX5Blg+/kL5UKsujhBTVnxIyzjEUEx4=;
        fh=o14aakVS641X50QmwdKGaCeacyl1iip28ngyTrDu1AE=;
        b=JXVyv4BQVlFlBQr+hnRkF/6VQ+s89SPKHf+xn8Y4E0WrZOcqz6s0OsmMTTwwGCHHJF
         KkAUjq1vl3Lo2a7WuoPc2F/Q7eG97rSSJx6WpedQ3fNWWbCys6fOrwDMEun05KJSpyeB
         i1F6CL99LPaWoXl/ev5SxDpEscKk0DPbwymV8Vx4FQ4lt4GaOFpMvlPCnCj+DdYVEf4y
         hQuWqm9dQA5ox55/jXamne9sD3yjjtNtKWxyTKjA78w7iIg2b7a4rAd9LkETqNvWparS
         AEUbbO3o+qq3iqArFdzvpwIKM0YBjuF128Q9xPJFmrI56xBKlNYB21saZvt/n69QamCF
         /CIA==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773019363; x=1773624163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2EabwjW5WxPwX5Blg+/kL5UKsujhBTVnxIyzjEUEx4=;
        b=HIoBJMAChAhHX0Yuq20504jWkSHQ/axqKuA6cxkkZ6HwJ3fXn+kQ3vsDYa4SAsOlAf
         oqPjAgUKH0TZd5rPGAPF456CXq2r+5xq7FHnfzoHoixIMltA3KvgD1Y7saf7dnh6FSuR
         dv4uto9E91FEg1wkmj+xihR3xZzefxRBvFmzJ5sliA0gOwMvgPMYB8SkY9e12b1MNwmk
         3Ha67FVPso7izmMhlTFfGz28waRs611n107V0I1qDNKYqY4ACAhLhUYQjmRq6+WEzXOB
         NS5Aw2gTqXvMJAO6Ogzpdje+Ox8tFWs88X2HFbMG2OGFqT1DHbNXndJfhEJBbcEHPQaA
         P+ew==
X-Forwarded-Encrypted: i=1; AJvYcCU7BqMdShxXUvNIpEWJF1ZZla629Mbq2rvDHmkLHVd2+pSZ7OJ74uq5LKryQuO30CGjUj0MhA==@inria.fr
X-Gm-Message-State: AOJu0YxtplYDOhYqkBP5N2T32i/oP1fg1/UJ/TyDQFdUarrCXnUWr/xx
	2RPXfjgIFsGVagdTqsbeX0lkm4zmsjiPAxQkYHrJbBSzHDYlDxhwRM8JwvXYMnrZ4enW2Mdbzj5
	oVWdOsNvNCZtjK7Q3YKfS5uaNQeJakKQ=
X-Gm-Gg: ATEYQzy/56+2Tg1OY/Wb/Qm2+G4YJT9SBOHEla/0VjHPoxokLFVye4ODFQ7lDDDrlwr
	Ame8LjZKuC1l0BoDdBa1uoN54osIQTksk4NNyWDoY8KnvElOmN3MSnj4+DjRwVMDpHCf2Z5v/4H
	BuFGLDzAjkoJIPXv/pIEEJnsIO2CGiUokyR6Jiq/C+NbBqpXQns/Y2zfiQqFXrIn1iVRjTkWAtN
	hx3UGGbxs/nxgoss/0QW7Es1JHgjAMxTbWtEvobow6IDauvgi7unCwRJkg6NfzQBQieBCX6d4uQ
	+uR/2w==
X-Received: by 2002:a05:690e:144c:b0:64d:294e:9924 with SMTP id
 956f58d0204a3-64d294f2d51mr2796898d50.86.1773019362840; Sun, 08 Mar 2026
 18:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260308100851.341-1-tttturtleruss@gmail.com>
In-Reply-To: <20260308100851.341-1-tttturtleruss@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 9 Mar 2026 09:22:16 +0800
X-Gm-Features: AaiRm50wSmO0lVbz6Ja8d-X_hAJPknw6EK0FBsvvFyg25jIlfu5X_T3ch-YDw8s
Message-ID: <CAD-N9QV+xB+0zc2RM1rbO3L36FyFa7WLHZ+4vMgviGg717iTaA@mail.gmail.com>
To: LIU Haoyang <tttturtleruss@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, cocci@inria.fr, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] docs/dev-tools: fix a broken URL in
 dev-tools/coccinelle.rst
Reply-To: Dongliang Mu <mudongliangabcd@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3352
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/lDE9eMO-gyYfUg73S6MJPA>

On Sun, Mar 8, 2026 at 6:09=E2=80=AFPM LIU Haoyang <tttturtleruss@gmail.com=
> wrote:
>
> The original supplemental documentation for coccicheck is
> https://bottest.wiki.kernel.org/coccicheck, which redirects to a not foun=
d page,
> thus change it to https://bottest.wiki.kernel.org/coccicheck.html,
> which adds a suffix to original URL to make it direct to the right page.
>

Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

> Signed-off-by: LIU Haoyang <tttturtleruss@gmail.com>
> ---
>  Documentation/dev-tools/coccinelle.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-t=
ools/coccinelle.rst
> index 2b942e3c8049..f73ccf5397f3 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -61,7 +61,7 @@ Supplemental documentation
>
>  For supplemental documentation refer to the wiki:
>
> -https://bottest.wiki.kernel.org/coccicheck
> +https://bottest.wiki.kernel.org/coccicheck.html
>
>  The wiki documentation always refers to the linux-next version of the sc=
ript.
>
> --
> 2.53.0
>
>
