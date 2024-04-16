Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE987C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lwJdmAUAGjo5XlKYImrypGenO5EDNxyflFLlUfqTWMk=;
  b=M7qK4Xfe7GLgb4oB1Z1Io6M+rMEvEnHw4Py74i5IKYq3g1asd1sjZcfc
   PcDctYvq+/Z/cn6vWXQmhEhWXNsCoGFRZNkx/LeYqYrLJS9oeVo5FfEdm
   kcrFpESBL4OKRbUbpuma/ZxqdY4evkwB25PTrwlx/vqukFL26FYzu71aG
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161851127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:14:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8C8EFE0D7E; Tue, 16 Apr 2024 14:14:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CBF83E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 13:33:12 +0200 (CEST)
IronPort-SDR: 661e61f7_EP4+zTZWINv4v3ojGlAVd+FoH/zlkTW5uk8hS5DfGm4q8o/
 idtX6br2MywLD9jrDDa5jW9js9sreWaDIbJ+WLw==
X-IPAS-Result: =?us-ascii?q?A0EVAACJYR5mfzTaVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPQQBAQELAYJDgVIzBFOEVoh8iG+eCIF+DwEDAQwBRAQBAQMEhH8Ci?=
 =?us-ascii?q?BoCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEiG?=
 =?us-ascii?q?QcODimFbQ2CZwGBHoEmAQEBAQEBAQEBAQEBHQINewEBAQECARIRHQEBNwEPC?=
 =?us-ascii?q?wsNAgImAgIhEgEFARwGEyKFCgMOIwOnB4EFQopBeoEygQGCCgEBBtskIleBY?=
 =?us-ascii?q?QkJAQqBBi4BiC0BgVmHaXonG4INgUqCPTg+aYNaFYNGgmiCFYUylDSGIwkdA?=
 =?us-ascii?q?wcHEA0eSREFHANZIREBVRMiCwQMGgIbFA0kIwIpPgMJChACFgMdFAQwEQkLJ?=
 =?us-ascii?q?gMqBjYCEgwGBgZbIBYJBCMDCAQDUAMgcBEDBBoECwd1gUQ4gT0EE0QCARCBM?=
 =?us-ascii?q?ooVDIMxKYFOKYQyS3GEHIFgAQIBQx1AAwtiCz01FBsoASahAYE/ghvGEoQdh?=
 =?us-ascii?q?GycWzOXOJJ8mGKoWwIKBwYRI4FIBi2BXDMaCCgIbAaCME8DGQ+OIIkOkQpBN?=
 =?us-ascii?q?TsCBwEKAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z86eodV312r5w==
IronPort-HdrOrdr: A9a23:7a7Z3q7aQ9IeQQgo0APXwCfXdLJyesId70hD6qm+c20qTiX+rb
 HfoB17726EtN91YhsdcL+7SdK9qB/nhOZICMwqTM6ftWrdyQyVxeNZnPbfKlTbckWUh40tt5
 uIMZIObuEYZWIbsS+Q2njFLz9P+qj5zImYwcjZ1GlkVgxnZuVN6A1jGh+HHkAefmU2YKbR16
 Dy2uN34xSlcXQTKuKhBncEWODH4/nGjojvbxJDJzNP0nj1sdpr0tPH+tSjsCv2mgkvsNMfzV
 Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A75LcpmmMLTyRDJsdPkYG9Wo0CSHXOXbt6VzwLgy?=
 =?us-ascii?q?KMjhSD7a0d1CM9oJPr+M7zg=3D=3D?=
X-Talos-MUID: 9a23:yJOzDAZxLxpTPeBThjmygGFlLt1R5+eJCRk3msso5IqBHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="84945779"
X-MGA-submission: =?us-ascii?q?MDGaqd0fOHk3nn+y+v1nRN35nGHewomhrw0uVc?=
 =?us-ascii?q?rfiv6d7jGzhuaUv0PypZ3uu/yAkCOIW76eG3ouBaFKqXcsYjIqrVoH3V?=
 =?us-ascii?q?Gyxmc8M4Jct28NkWt0C9YwDlvRCz8Eegfi4lfauFY44WhG6mg51Qqsy+?=
 =?us-ascii?q?qXh/s7kPmYQlzEijCEL/+EWg=3D=3D?=
Received: from mail-ej1-f52.google.com ([209.85.218.52])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:33:11 +0200
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a523524e5baso510679066b.3
        for <cocci@inria.fr>; Tue, 16 Apr 2024 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713267190; x=1713871990; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwJdmAUAGjo5XlKYImrypGenO5EDNxyflFLlUfqTWMk=;
        b=Fmo8pEFkiqBk1uzRmB8mmjp9iT8DhX+UOM7/lD3AFQMqZw1PHqaFr+m/GxYrxONQxI
         G3H3H4kh/O5+T2BrfAWGaxNtpvRE0QY0VGFI9fElnzjsysSdZ9BbvHryttVQQMsUe53P
         ERnkmdDmyDdUFDh3zF7WUaP7AL5x5M2/QCeNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267190; x=1713871990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwJdmAUAGjo5XlKYImrypGenO5EDNxyflFLlUfqTWMk=;
        b=UWA05tG8BwH5OthbgotKnTeaHajzX8Ze7GViQDwqhEkZJGyViUoCX9iFMZrvlyqYc0
         zLIdF5WdrII75QhaHnpoTTkwZhJqOWzQxyQSnt81WnBdiG8B6kmItaL3PfWKzmPgfqW3
         iwn4vLGz/om3u7Dr2RFwMOG2/XBDxNjhxtGCm6bV2ymPiWKtdnsmQZbMPa9G4TElVJe5
         /NWce1yqZqHxJ3KVkVvgsBAwIVfVMxdlKQfPWn6qDOVAwjIPclGjdM+0bHQdi0ZeL7Yq
         rRZm5VaKIvd57/tQn2x4oeucPaUqbIjDFYC54xMDQjkrLF/Y8gwJjjOdg8lYrB+lbbcc
         +iOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCNRWotlskpC3AgIdtldoCqaxy6SIQurkWf2GnWmLSWgYbDTRJXPXeS8W+JBebg0nJ6mBCBvgqsHGdc/u4RA==
X-Gm-Message-State: AOJu0Yzkq+iull+JJkZi8VCYOPt24IpI81cdqv9FD1XruAWNxqbNE2Sl
	Ur8hm938fO3oUIBADZZ8bpZo/Z6PTwOH+DXd9VR9s9Do1mPcqQvegN4sNARdmd8sfRZ/jCtnvLN
	oXS4K
X-Google-Smtp-Source: AGHT+IFBAwTNyVfderOWhVMtnpPe3jre66gu7GkWop3CY/FY9nTmEEhlUWy0S+AAJycoWp621lgFvA==
X-Received: by 2002:a17:907:7247:b0:a52:55c6:692c with SMTP id ds7-20020a170907724700b00a5255c6692cmr8530005ejc.76.1713267190482;
        Tue, 16 Apr 2024 04:33:10 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id qk11-20020a1709077f8b00b00a51d88e6164sm6696633ejc.203.2024.04.16.04.33.10
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 04:33:10 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d1003106so3037429f8f.1
        for <cocci@inria.fr>; Tue, 16 Apr 2024 04:33:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWHGMX7vhzKZe0kor8eP4d75jdcLoE87qjBOVZYe7vnRg1niyXQgYM/4IdHNfLr9I6pmHmRy59oRRFvU0hYQ==
X-Received: by 2002:adf:e80b:0:b0:341:c210:3d1b with SMTP id
 o11-20020adfe80b000000b00341c2103d1bmr10320976wrm.8.1713267189995; Tue, 16
 Apr 2024 04:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org> <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
In-Reply-To: <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 16 Apr 2024 13:32:52 +0200
X-Gmail-Original-Message-ID: <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
Message-ID: <CANiDSCuvXvjfhw2mjSef1wR8RiL=9KrDEoh+3o1ed4+8P+AqGw@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1662
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/CANiDSCuvXvjfhw2mjSef1wR8RiL%3D9KrDEoh%2B3o1ed4%2B8P%2BAqGw%40mail.gmail.com>

Hi Markus

On Tue, 16 Apr 2024 at 13:30, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> =E2=80=A6
> > +++ b/scripts/coccinelle/misc/minmax.cocci
> > @@ -50,11 +50,26 @@ func(...)
> >       ...>
> >  }
> >
> > +// Ignore errcode returns.
> > +@errcode@
> =E2=80=A6
>
> I see that you would like to omit the specification =E2=80=9Cdepends on p=
atch=E2=80=9D
> from the previous SmPL rule location.
>
> Would you really like to influence and adjust SmPL code any more
> according to affected coccicheck operation modes?

I probably do not know what I am doing :), it is my first .cocci patch.

If I leave the "depends on patch", then the change is ignored in report mod=
e.

I think errcode needs to be executed in report and in patch mode, but
there might be a better way to do it.

>
> Regards,
> Markus



--=20
Ricardo Ribalda
