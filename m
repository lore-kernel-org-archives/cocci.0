Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52117E7716D
	for <cocci@archiver.kernel.org>; Thu,  5 Dec 2024 02:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sTRMx4tMvilCJATC+fdir90vctQJh71VrvdtJWNI3i8=;
  b=ilqKXxWcvFrZST5Fl0Jrg64vJno27l5VBoRFe+A5g+fzHkzBYkopJkmZ
   lEpX6QuVcjb/kFZcKS/35BjqU3FrMXxQW1ZmpCx21DvDr3R19ivvoIgPa
   ijGV1k+uSItTkW9is/Es16apb/hAv/Oqq0Dx+AIJfxMZKaR+c6jrgH4E3
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208";a="197436087"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2024 03:34:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC226E0D1C; Thu,  5 Dec 2024 03:34:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3FE5CE00B6
	for <cocci@sympa.inria.fr>; Thu,  5 Dec 2024 03:34:14 +0100 (CET)
IronPort-SDR: 67511125_fXa/apqBOGu2ESSmDLJ373NXwsP68NgVSpuQY7XKx3De4oc
 3HLkuc/Ue/OIxnytsEJ7SCIX3szoqJbdI2rDifQ==
X-IPAS-Result: =?us-ascii?q?A0HuAQCYD1FnhdlUsotagQmBU4JEgVczBAtIhFaIfIZRg?=
 =?us-ascii?q?iSeGIF+DwEDAQ1EBAEBAwSFAAKKagIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QINfgEBAQMjHQEBNwEPCwsNAgImAgIhEwUdBhODAYJlA7EsgTKBAYIMAQEG3?=
 =?us-ascii?q?B+BZAmBGi6Fa4JjAYFsg3+DfXonG4FJRIFKgnU+hEMVg0aCaYEUgS9ngzV2J?=
 =?us-ascii?q?YU2g0qUF4gzJgkdAwcHDg0eSQ8FHANZIREBVRMXCwcFYUkhLAECAYJHf4E2g?=
 =?us-ascii?q?VEBgxBKgy4cgUIFNwo9gkppSzcCDQI2giR9gk2FF4ELgRWCSUoZLwMDAwODO?=
 =?us-ascii?q?4YqgWAdQAMLYgs9NxQbTKIVRoJkcoQ1pQOhBIQkgWOfezOXQ5MOmHujW4VPg?=
 =?us-ascii?q?Wc6gVwzGjB0BoIwTwMZD446H4hWui00NTwCBwEKAQEDCYZIjVaBSwEB?=
IronPort-PHdr: A9a23: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
 AEHk+qQxWE7NYDh3UFmLF5gk9aSc3c=
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:7GqZTKifTU/wGk4/H4F84HdE/HBQXiUji2hC6mlwRA09TyVXrb
 HVoB19726JtN9xYgBcpTnkAsS9qBznhPlICOUqTNOftUzdyQ6VxeJZnOjfKl/balTDH4dmvM
 8KGcRD4Z/LfDpHZK3BkXGF+rgbsaK62ZHtquHE0X93QA1mL41m5RxoExuWHyRNKzWuxqBWKL
 OsouRCrzqkPVINbsq6AXEBG8zOvcfCmp6jQTNuPW9A1OBDt1KVAXfBcySl4g==
X-Talos-CUID: =?us-ascii?q?9a23=3AG8of42uBHth3fGo9VMOTj1/h6IsmXln2lVTzBna?=
 =?us-ascii?q?HADtpdZ2MYgWwqKZrxp8=3D?=
X-Talos-MUID: 9a23:XffpWgRNgjH06UJ7RXTlx2x/Bd956J2VFX0kuKgj5pLcNCNvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208";a="103473238"
X-MGA-submission: =?us-ascii?q?MDGtcik6jYK+EO6d+DkwzvCDyBBA6jaZfxuwGm?=
 =?us-ascii?q?oKbnegahvAiORk60uJCAyWwqg9MQZraAmSqchsEyHeSMSfrjB/8U9bos?=
 =?us-ascii?q?zI1K1YpcRrK48FWZR3ezaZ60JJyI5rS19ldjNpPOc5TDItDSlTJ/WdNu?=
 =?us-ascii?q?i4MxufgWQBk2bljsKBSxJEog=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:34:14 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 212A05C5C6B
	for <cocci@inria.fr>; Thu,  5 Dec 2024 02:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCFAC4CECD
	for <cocci@inria.fr>; Thu,  5 Dec 2024 02:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733366050;
	bh=UA2Uea6IGitYgfix2+eS7XWDk5SRJWyMNtpCYH383+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pxz5O1FA21sHXdqJoW4ydp49kC1q4DawugzBJoe+FT3XF2PqO2AGafugxpJmwrQjm
	 8zak05K8DnETcDGQaMVRlwW2faNQrfb72FXjtNG+SBj5I+4XqJ7La59tMTOy0JKRA0
	 9k248/V0ecp1Y4odMbdmbKp6kdWegA1N3vkFEABK5rdVmocSM7nBK7LMMYp8BIixI0
	 K6nNAo9sFTXKhHvlEW9xAJ+9rowBo628XgK4/wCUVGCm4wPwzV7xVc3HIf4V5Xfm7z
	 NiMIj94y2QbkiS1ehvIU8g3B1Xx6VCi0j+Vo0Ab5Pf2cfUq3IBD+zaUrSzPMEp61g1
	 UQkgOHgcpBFLg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df1d1b726so445701e87.0
        for <cocci@inria.fr>; Wed, 04 Dec 2024 18:34:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXHE/AhP8o5h9x9+P3EctMzaHdagsXNMJF8ioUbd5PwpK8YpaIA9redQPyQ98XGi8o7suMdTQ==@inria.fr
X-Gm-Message-State: AOJu0YwNGWfa5Q4JI6Wr9MlJrXkkq4xDLTW4vCvbH/X0SyYff7v+KzrA
	H+v1C1NN9ANrRT/OQcXq7k9X6UXSGkxRTE4xhMfledTg0KDsj1hzqS8A1PzOU5D3DwkUtNGFrGR
	wSKzBcZ+GQy7yM8Huhu9euXamu9E=
X-Google-Smtp-Source: AGHT+IGrXJnAWJ9eKTc0ln8iyn1stVLkq01FLiKFwS5cJm5ma4gHywwcy98ADbBgmYN9C9+w2atpMxYn2UYI0iUGHDc=
X-Received: by 2002:a05:6512:1247:b0:53d:a321:db74 with SMTP id
 2adb3069b0e04-53e12a28208mr4826786e87.50.1733366049377; Wed, 04 Dec 2024
 18:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <Z1DAzaKYD_rfgGnk@aschofie-mobl2.lan>
In-Reply-To: <Z1DAzaKYD_rfgGnk@aschofie-mobl2.lan>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 5 Dec 2024 11:33:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCz1s2z_mBJgL_S+=o8jWOGSmRb017WLFXaKdp5EDiqw@mail.gmail.com>
Message-ID: <CAK7LNARCz1s2z_mBJgL_S+=o8jWOGSmRb017WLFXaKdp5EDiqw@mail.gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2157
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNARCz1s2z_mBJgL_S%2B%3Do8jWOGSmRb017WLFXaKdp5EDiqw%40mail.gmail.com>

On Thu, Dec 5, 2024 at 5:51=E2=80=AFAM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Sun, Nov 10, 2024 at 10:34:33AM +0900, Masahiro Yamada wrote:
> > Currently, Kbuild always operates in the output directory of the kernel=
,
> > even when building external modules. This increases the risk of externa=
l
> > module Makefiles attempting to write to the kernel directory.
> >
> > This commit switches the working directory to the external module
> > directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
> > some build artifacts.
> >
> > The command for building external modules maintains backward
> > compatibility, but Makefiles that rely on working in the kernel
> > directory may break. In such cases, $(objtree) and $(srctree) should
> > be used to refer to the output and source directories of the kernel.
> >
> > The appearance of the build log will change as follows:
> >
> > [Before]
> >
> >   $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >   make: Entering directory '/path/to/my/linux'
> >     CC [M]  /path/to/my/externel/module/helloworld.o
> >     MODPOST /path/to/my/externel/module/Module.symvers
> >     CC [M]  /path/to/my/externel/module/helloworld.mod.o
> >     CC [M]  /path/to/my/externel/module/.module-common.o
> >     LD [M]  /path/to/my/externel/module/helloworld.ko
> >   make: Leaving directory '/path/to/my/linux'
> >
> > [After]
> >
> >   $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >   make: Entering directory '/path/to/my/linux'
> >   make[1]: Entering directory '/path/to/my/externel/module'
> >     CC [M]  helloworld.o
> >     MODPOST Module.symvers
> >     CC [M]  helloworld.mod.o
> >     CC [M]  .module-common.o
> >     LD [M]  helloworld.ko
> >   make[1]: Leaving directory '/path/to/my/externel/module'
> >   make: Leaving directory '/path/to/my/linux'
> >
> > Printing "Entering directory" twice is cumbersome. This will be
> > addressed later.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> With this in v6.13-rc1 the cxl-test module fails depmod.
> It causes depmod  to be invoked from the incorrect place
> (or something doesn't respect INSTALL_MOD_PATH)
>
> Is there something additional that this cxl-test module needs
> to do?
>
> Repro:
> /git/new$ make V=3D1 M=3Dtools/testing/cxl INSTALL_MOD_PATH=3Dqbuild/mkos=
i.extra/ modules_install

Kbuild changes the working directory, so you need to specify
an absolute path for INSTALL_MOD_PATH.

INSTALL_MOD_PATH=3D$(realpath qbuild/mkosi.extra/)




--=20
Best Regards
Masahiro Yamada
