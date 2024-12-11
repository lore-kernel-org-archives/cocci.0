Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6BDE7717F
	for <cocci@archiver.kernel.org>; Wed, 11 Dec 2024 02:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6bcvCIe56mYSnaHQ/lb+7UCeggtH9RqQzh7v2MXFLFA=;
  b=f4MJ3LCm8WdlSwMpqTgW8s18UP4RZpfxa/YHrR7r6PYyw/qbclkGgOOU
   GxpIfftl1rktF8yD6tyWuC8ez17QWgUNOtohmCIiRoKB7rG5V6b3J9dzl
   vXN5aWyWDGEozlfexqLJi3ESh+CJwZaYNkC4Ww5vkcYWvi9RwSB9MEXKb
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,224,1728943200"; 
   d="scan'208";a="198519301"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2024 03:37:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60E09E0137; Wed, 11 Dec 2024 03:37:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 903EFE0077
	for <cocci@sympa.inria.fr>; Wed, 11 Dec 2024 03:37:28 +0100 (CET)
IronPort-SDR: 6758fae8_3ntnjZo1Jf7Kn4lX9R79HWEH/8Cyw0S5josyJ0jp/iVzw4a
 VKz9O/yDqgMJ3tdEhvJF1LXF2oQKR48SlXV5bXg==
X-IPAS-Result: =?us-ascii?q?A0EeAQDo+Vhnj1vBS5NaHgEBCxIMQIFIC4JEgVczBAtIh?=
 =?us-ascii?q?FaIfIZRgiSeGIF+DwEDAQ1EBAEBAwSFAAKKagIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgEBAQMjHQEBNwEPCwsNAgImAgIhEwUdBhODAYJlA7AZg?=
 =?us-ascii?q?TKBAYIMAQEG3B+BZAmBGi6Fa4JjAYFsg3+DfXonG4FJRIFKgnU+hEMVg0aCa?=
 =?us-ascii?q?YEUgSyDF4I9gQyDfolQhEaCfIcnJgkdAwcHDg0eSQ8FHANZIREBVRMXCwcFY?=
 =?us-ascii?q?UggLAECAYEVggUcgT8FNwo9gklpSTcCDQI2giR8gk2FF4ELgRWCSUoZLwMDA?=
 =?us-ascii?q?wODO4YmghmBAB1AAwtiCz03FBtMnAlGg1x8ggQzfwOlA4t0lRCEJIFjn3szl?=
 =?us-ascii?q?0OTDph7qSqBZzqBXDMaMHQGgjBPAxkPjiEZH4hWux00NTwCBwEKAQEDCYZIi?=
 =?us-ascii?q?guBSwEB?=
IronPort-PHdr: A9a23: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
 3M1
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:FLJw266/xXFc1n4iHQPXwDfXdLJyesId70hD6qm+c20uTiX+rb
 HToB17726ItN91YhwdcL+7Sc69qB/nhPpICMwqTNKftWrdyQiVxeNZnPLfKlTbckWUnIJgPO
 VbAspD4bbLfCBHZKjBkXKFOudl79+d7qiyiOvSi1trRxp7crxt4m5CZTpz0XcZeCB2QbQ8HJ
 qYouxdpzShfnwTKuC2HGMMUeSGh/CjruOBXffLPX8aAcC17Q+V1A==
X-Talos-CUID: 9a23:MNdkCm3yObGWrh/NCQ6HTLxfGPsXT0326jDpGF6yEHRzc6y2bkWXwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AK4eTDQ/yEPw99wv0dVJIBeeQf5p25Y31NHgHq7s?=
 =?us-ascii?q?bgJahaBNpFROA3B3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,224,1728943200"; 
   d="scan'208";a="198519298"
X-MGA-submission: =?us-ascii?q?MDFM8MKj83ggIced0HdFNcs6RDQtxu2NDUvfMB?=
 =?us-ascii?q?Es+uViw26Gj1KZmRmV2MROVckrNZNr4rSS2+0lGQmZHu9XqwuuJCzuUn?=
 =?us-ascii?q?tw29eqacBPvolMaHqu5Jcwu4uR4qUapM0x05yLBonvMoONOIcM1jOMRX?=
 =?us-ascii?q?6t6xB/1PmBYAH2EL+M8vOIGQ=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:37:28 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C0E9EA41D95
	for <cocci@inria.fr>; Wed, 11 Dec 2024 02:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1374C4AF0B
	for <cocci@inria.fr>; Wed, 11 Dec 2024 02:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884646;
	bh=DUGkTeY3nF0d2mRRcn/oCpk/z0595BnJpRO/MgGaiaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aDZQ5TfR+4C1PqenyMh1oqQju/YOUFkb6ygJR8YzB1WOKjmo5tNGwigXcPSvQ/h6U
	 1l8VaztRWGNz/QuhI5AiGWRL9ShooogOqFidV1X9FsEWUdB9gFhhFfUsY1FxsZ0ArV
	 9nkUs/lWqYZnPBxZDoela9CTfLYqZulfpsh4EzsucipTznBMjCSwFGuuZbqqlClvuC
	 5Z6cK/PE8uOBKYHnY3bTvNXfwEU6xQhSvywHILzhTvYtK6Xkjj+PpGWVUaIFRW+myo
	 QgAULhYb8nApF6Rq+lsFsVkTxoNeboVwvyiJFZ7wWiqrAPytThVw/N20D7G1qp0yGj
	 QdRSm4/ciAUzg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df80eeeedso5940140e87.2
        for <cocci@inria.fr>; Tue, 10 Dec 2024 18:37:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD2WO2352Rs3Zgok4sORQKFBHToGZ3O97wHD9BoEROfqiCcKAPNHhrdn1fH10CYsWo3vYYpg==@inria.fr
X-Gm-Message-State: AOJu0YwSxdoLtexmDAINKMKxsFt4XFipsgwq1R78cBdqEEBCybQC6nAB
	BEBbKrDbzpXkucBGE4KTeH8AVlbYEd3JmjupltTx+LlubgfCg61Kue66q7zplCulOyMB12jz2SC
	3OZo8wxJVHlWtlaU+L0TJ+Ymxqvo=
X-Google-Smtp-Source: AGHT+IHisRqzbuD8pT7SfEVDcme2Sdu/LmQSV5wOJ2448T01ybCZo4dCmRJBHcF7WEz49Yxqox0CwmVDEgAWJqSqBAA=
X-Received: by 2002:a05:6512:108f:b0:53e:12dc:e805 with SMTP id
 2adb3069b0e04-5402a5ff555mr264802e87.45.1733884645446; Tue, 10 Dec 2024
 18:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <82FA2E02-05A5-4297-B364-9D7D89001D9D@linux.dev> <1116D946-05F3-4463-A61F-DE221F258A3F@linux.dev>
 <CAK7LNAQ1MvB_wXa6F8aZB_srrLTQupRXNsz6Rav27fyjznXZJQ@mail.gmail.com> <838D0FCD-EA9C-46C8-BCA7-FECFD3DC04D8@linux.dev>
In-Reply-To: <838D0FCD-EA9C-46C8-BCA7-FECFD3DC04D8@linux.dev>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 11 Dec 2024 11:36:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARi9t1mtUAW=X7bxiR_xWzaXX+Tq4dd8FfXW+LSm6o=ww@mail.gmail.com>
Message-ID: <CAK7LNARi9t1mtUAW=X7bxiR_xWzaXX+Tq4dd8FfXW+LSm6o=ww@mail.gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2174
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNARi9t1mtUAW%3DX7bxiR_xWzaXX%2BTq4dd8FfXW%2BLSm6o%3Dww%40mail.gmail.com>

On Tue, Dec 10, 2024 at 8:06=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> On 10. Dec 2024, at 11:47, Masahiro Yamada wrote:
> > On Mon, Dec 9, 2024 at 10:56=E2=80=AFPM Thorsten Blum wrote:
> >> On 9. Dec 2024, at 14:46, Thorsten Blum wrote:
> >>> On 10. Nov 2024, at 02:34, Masahiro Yamada wrote:
> >>>>
> >>>> Currently, Kbuild always operates in the output directory of the ker=
nel,
> >>>> even when building external modules. This increases the risk of exte=
rnal
> >>>> module Makefiles attempting to write to the kernel directory.
> >>>>
> >>>> This commit switches the working directory to the external module
> >>>> directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
> >>>> some build artifacts.
> >>>>
> >>>> The command for building external modules maintains backward
> >>>> compatibility, but Makefiles that rely on working in the kernel
> >>>> directory may break. In such cases, $(objtree) and $(srctree) should
> >>>> be used to refer to the output and source directories of the kernel.
> >>>>
> >>>> The appearance of the build log will change as follows:
> >>>>
> >>>> [Before]
> >>>>
> >>>> $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >>>> make: Entering directory '/path/to/my/linux'
> >>>> CC [M]  /path/to/my/externel/module/helloworld.o
> >>>> MODPOST /path/to/my/externel/module/Module.symvers
> >>>> CC [M]  /path/to/my/externel/module/helloworld.mod.o
> >>>> CC [M]  /path/to/my/externel/module/.module-common.o
> >>>> LD [M]  /path/to/my/externel/module/helloworld.ko
> >>>> make: Leaving directory '/path/to/my/linux'
> >>>>
> >>>> [After]
> >>>>
> >>>> $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >>>> make: Entering directory '/path/to/my/linux'
> >>>> make[1]: Entering directory '/path/to/my/externel/module'
> >>>> CC [M]  helloworld.o
> >>>> MODPOST Module.symvers
> >>>> CC [M]  helloworld.mod.o
> >>>> CC [M]  .module-common.o
> >>>> LD [M]  helloworld.ko
> >>>> make[1]: Leaving directory '/path/to/my/externel/module'
> >>>> make: Leaving directory '/path/to/my/linux'
> >>>>
> >>>> Printing "Entering directory" twice is cumbersome. This will be
> >>>> addressed later.
> >>>>
> >>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>>> ---
> >>>
> >>> Hi Masahiro,
> >>>
> >>> I get the following error since this patch is in master, but only whe=
n
> >>> using COCCI=3D in combination with M=3D<relative or absolute path>.
> >>>
> >>> It works when I either use COCCI=3D or M=3D, but not with both.
> >>
> >> Using the absolute path of the cocci script fixes my problem, but this
> >> used to work with relative paths too.
> >>
> >> $ make coccicheck COCCI=3D$(pwd)/scripts/coccinelle/misc/flexible_arra=
y.cocci M=3Darch/
> >
> > M=3D looks a bit weird for the upstream code, but
> > I think using the absolute path is the right thing to do.
>
> The documentation[1] uses M=3D and also COCCI=3D with relative paths and
> some of the examples don't work anymore.

I know.

This is what cocci people hoped to work.

If something is broken in coccicheck, it must be fixed.




--=20
Best Regards
Masahiro Yamada
