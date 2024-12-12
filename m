Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F054E77180
	for <cocci@archiver.kernel.org>; Thu, 12 Dec 2024 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=w6B/EKj1/Xee5Fe1udkBIQjnN/ijEFvvMOt17Y/DTuY=;
  b=hUXpOgCDweKFt7+KDmytoIo/kQbZG8icFlzxXgkEMS72GQtSY3TLTfY5
   IQfHN/eXeS8X/FLEpiwALMfK6P5q67oLV4F7Cx1Wm3huhcua4rer/kF30
   LTenAXzEIyCgzOcUXacb29t+V0thlcViqepJiS5clatxx2i3vBJjNW8OY
   o=;
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
X-IronPort-AV: E=Sophos;i="6.12,228,1728943200"; 
   d="scan'208";a="198869591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Dec 2024 16:50:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68899E0137; Thu, 12 Dec 2024 16:50:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 00152E0077
	for <cocci@sympa.inria.fr>; Thu, 12 Dec 2024 16:49:59 +0100 (CET)
IronPort-SDR: 675b0627_OYDFfHjqT45CYHmqMNFZprMVWDtc1EYfM1Q9VQ+sVSo+wXI
 ehEIRAySC3P46jPGjxy0avD5OT8GWonyAAno98w==
X-IPAS-Result: =?us-ascii?q?A0FBAQA6BVtnj1vBS5NaHgEBCxIMQIFIC4JEgVczBAtIh?=
 =?us-ascii?q?FaIfIZRgiEDnhiBfg8BAwENRAQBAQMEhQACimwCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgEBAQMjBBkBATIFAQ8LCw0CAiYCAiETBR0GE4MBgmUDs?=
 =?us-ascii?q?AF/M4EBggwBAQbcH4FkCYEaLoVrgmMBgWyDf4N9eicbgUlEgUqCdT6EQxWDR?=
 =?us-ascii?q?oJpgRSBLEyCS4NJlTiHTQkdAwcHDg0eSQ8FHANZIREBVRMXCwcFYUggLAECA?=
 =?us-ascii?q?YEUggUcgT8FNwo9gklpSzcCDQI2giR8gk2FF4ELgRWCSUoZLwMDAwODPIYjg?=
 =?us-ascii?q?hmBRB1AAwtiCz03FBtMnDZGg1oGMkqBP0UVHoECkj2QKoIdnkKCQ4QkgWOfe?=
 =?us-ascii?q?zOEBI0FhjqTDph7qSqBZzqBXDMaMHQGgjBPAxkPjiEMDQkWiFa8BjQ1PAIHA?=
 =?us-ascii?q?QoBAQMJhkiJbIFLAQE?=
IronPort-PHdr: A9a23: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
 5cUTLJfElsvGaFDYnk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VIIdfqCsQCRbnVLlHelT55DYdb4zR+YMi2TDGXoBMyC9Ffbo6/
 xG/c5rqCMc7Qx9ZJhOo6HmBEDtewK5yXcx2/h1AV7AZniEhILLFvAa0WKK+VSJcEeTygce79
 YDT0EUMqyJMbEVt7eA3CCIV/kn28eO662liKPzyH13XRh2Z6wI1WhE48WgfHFedU1pAZI4Ed
 67/cpIpz2pfDAyYt6gDncIG8jvzue78q4OrSRmO/fv0mmzsQ8=
X-Talos-CUID: 9a23:hG7qbWwuUZv+DYEnIPbkBgVFKMoBKXPQkU7vBBekFU1bbpKVRhyfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A7At5Kg+PHwOJrvzPHFDoQQ+Qf85xybX1T0I3qKU?=
 =?us-ascii?q?5g9uhagFfOG2+vCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,228,1728943200"; 
   d="scan'208";a="198869565"
X-MGA-submission: =?us-ascii?q?MDHuUO5lfryInoavoPzI5rxpWnOnTTQUBJDsS4?=
 =?us-ascii?q?evraNiXtVsbkdnBdAZfud+sfQNM4heenWKlRvxj8dY9kq/LOTvVbl+io?=
 =?us-ascii?q?SemoQYjdkDUhwpsDlA7Fc7TGTRhvEAO2taHCch0F/1p6Bedsh4M2JDnj?=
 =?us-ascii?q?qcXQHugLLruHTT15jXXywCRQ=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 16:49:59 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DED94A4210D
	for <cocci@inria.fr>; Thu, 12 Dec 2024 15:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C949FC4CEE1
	for <cocci@inria.fr>; Thu, 12 Dec 2024 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734018597;
	bh=htv+UPiuxFH5l75rnUXHTUNj6KGcw1im7Z97ayXbG/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DyXGlV9Vn8wlOexZkTcy223Q18awPcPgYx5ZzmT4EBKM240MJ/+ituocvDsDxMNBp
	 4xwfHWhaTpgEMJWMxDHEcTVce0P/w6RUd3B20NV8zNXxNPI+UYgiF/tendoxqNTTJM
	 d9vflwHPch2Ug/8zBkQ3pJWHpV3v0L5P6GN7SSQ/ccI3sUNE4KmoixrwHbprxx7E1h
	 maG+2IFhxSmsETe/1oe2+XXNRv1x3ZpF//WrkVlI03W3hPM8Km12ozcUEGsM/Ca/Ii
	 WYE0hVGDtIrwhQfzw18GWGXrqsV9kxVBfxhDDp7zblqor9AOaKctOBLggtH5C4ajNE
	 POKdAH+snE/+g==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3003c82c95cso5503511fa.3
        for <cocci@inria.fr>; Thu, 12 Dec 2024 07:49:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVtXnKbA6QcQMfcvaYdj4luRLb4jTdhBmop49A9dh90TNJJ5Fp1EMW31njQmn1sp7VTHXwzw==@inria.fr
X-Gm-Message-State: AOJu0YxAf+RTTEqBfsOLuPF7F3A4hGNUzxKhe4P6IM8w0ehFC1Pv/QTC
	CoXA9gO4EJ7aO7IBYa0Ks4GfQscUZymSL4oeZ5k7szM0viecwH9vKcOTMfNLWHmS3GQEL1/uU1J
	a+YYtbsgTqCUJ03hriS5WLz7PEZs=
X-Google-Smtp-Source: AGHT+IHmrKLcaLYW/lzhCLoUQyw/UlgK8Yt9mn+tMxhedsH8J/pZYJ7bPWpqt83lK+884t/Y0Jonc8vuqh39q6arPdE=
X-Received: by 2002:a2e:2c15:0:b0:2fa:d2c3:a7e8 with SMTP id
 38308e7fff4ca-30251e0f3f8mr2145091fa.13.1734018596433; Thu, 12 Dec 2024
 07:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <bdd5ff13-ec66-4ab6-985a-1fe433e85f91@nvidia.com> <CAK7LNATgL=vOr37+XfF7du+_ak5yKgXYyNNNTEQdVvy5J2MMyA@mail.gmail.com>
 <b20db4db-afb4-4f58-bc01-ae1250abc8b0@nvidia.com> <CAK7LNATzdVrvmqm2wYHojVhNEiBNTaz6+4xgGBJwFixDvL=TMA@mail.gmail.com>
 <eb21a546-a19c-40df-b821-bbba80f19a3d@nvidia.com>
In-Reply-To: <eb21a546-a19c-40df-b821-bbba80f19a3d@nvidia.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 13 Dec 2024 00:49:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzvkKgC+1-O+X2wchR6=Zc2raOc4Sb5YPMp_-AbhcpBg@mail.gmail.com>
Message-ID: <CAK7LNASzvkKgC+1-O+X2wchR6=Zc2raOc4Sb5YPMp_-AbhcpBg@mail.gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, cocci@inria.fr, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2181
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNASzvkKgC%2B1-O%2BX2wchR6%3DZc2raOc4Sb5YPMp_-AbhcpBg%40mail.gmail.com>

On Thu, Dec 12, 2024 at 3:00=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 12/12/2024 02:08, Masahiro Yamada wrote:
> > On Wed, Dec 11, 2024 at 9:21=E2=80=AFPM Jon Hunter <jonathanh@nvidia.co=
m> wrote:
> >>
> >>
> >> On 11/12/2024 02:39, Masahiro Yamada wrote:
> >>> On Wed, Dec 11, 2024 at 12:34=E2=80=AFAM Jon Hunter <jonathanh@nvidia=
.com> wrote:
> >>>>
> >>>> Hi Masahiro,
> >>>>
> >>>> On 10/11/2024 01:34, Masahiro Yamada wrote:
> >>>>> Currently, Kbuild always operates in the output directory of the ke=
rnel,
> >>>>> even when building external modules. This increases the risk of ext=
ernal
> >>>>> module Makefiles attempting to write to the kernel directory.
> >>>>>
> >>>>> This commit switches the working directory to the external module
> >>>>> directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix fro=
m
> >>>>> some build artifacts.
> >>>>>
> >>>>> The command for building external modules maintains backward
> >>>>> compatibility, but Makefiles that rely on working in the kernel
> >>>>> directory may break. In such cases, $(objtree) and $(srctree) shoul=
d
> >>>>> be used to refer to the output and source directories of the kernel=
.
> >>>>>
> >>>>> The appearance of the build log will change as follows:
> >>>>>
> >>>>> [Before]
> >>>>>
> >>>>>      $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >>>>>      make: Entering directory '/path/to/my/linux'
> >>>>>        CC [M]  /path/to/my/externel/module/helloworld.o
> >>>>>        MODPOST /path/to/my/externel/module/Module.symvers
> >>>>>        CC [M]  /path/to/my/externel/module/helloworld.mod.o
> >>>>>        CC [M]  /path/to/my/externel/module/.module-common.o
> >>>>>        LD [M]  /path/to/my/externel/module/helloworld.ko
> >>>>>      make: Leaving directory '/path/to/my/linux'
> >>>>>
> >>>>> [After]
> >>>>>
> >>>>>      $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >>>>>      make: Entering directory '/path/to/my/linux'
> >>>>>      make[1]: Entering directory '/path/to/my/externel/module'
> >>>>>        CC [M]  helloworld.o
> >>>>>        MODPOST Module.symvers
> >>>>>        CC [M]  helloworld.mod.o
> >>>>>        CC [M]  .module-common.o
> >>>>>        LD [M]  helloworld.ko
> >>>>>      make[1]: Leaving directory '/path/to/my/externel/module'
> >>>>>      make: Leaving directory '/path/to/my/linux'
> >>>>>
> >>>>> Printing "Entering directory" twice is cumbersome. This will be
> >>>>> addressed later.
> >>>>>
> >>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>>>
> >>>>
> >>>> Since this change I have been observing the following build error wh=
en
> >>>> building an external module ...
> >>>>
> >>>>     MODPOST Module.symvers
> >>>> ERROR: modpost: drivers/gpu/host1x/host1x: 'host1x_device_init' expo=
rted
> >>>>        twice. Previous export was in drivers/gpu/host1x/host1x.ko
> >>>> ERROR: modpost: drivers/gpu/host1x/host1x: 'host1x_device_exit' expo=
rted
> >>>>        twice. Previous export was in drivers/gpu/host1x/host1x.ko
> >>>>
> >>>> Now host1x is an upstream driver, but I have a local copy that using=
 to
> >>>> stage development changes (and avoid polluting the upstream driver).
> >>>> Plus I can swap between which version I am using on a live system.
> >>>>
> >>>> What I noticed is that previously the Modules.symvers for the extern=
al
> >>>> module had the full path of the external module for the name. Howeve=
r,
> >>>> now the name is just the relative path and in this case
> >>>> 'drivers/gpu/host1x/host1x'. Hence, this clashes with the in-kernel
> >>>> driver and we get the 'exported twice' error.
> >>>>
> >>>> I have been looking to see if there is a way to fix this because it =
has
> >>>> been a useful feature to override an upstream driver with a locally
> >>>> modified version.
> >>>
> >>>
> >>> I do not know how to reproduce it.
> >>>
> >>>     if (s && (!external_module || s->module->is_vmlinux || s->module =
=3D=3D mod)) {
> >>>
> >>> is not checking the module path at all.
> >>> I do not understand why it was affected.
> >>
> >>
> >> So this is not explicitly checking the path, but comparing the content=
s
> >> of the Module.symvers before and after this change for the external
> >> module I see ...
> >>
> >> $ grep -r host1x_device_init Module.symvers
> >> 0x00000000      host1x_device_init      /absolute/path/to/drivers/gpu/=
host1x/host1x        EXPORT_SYMBOL
> >>
> >> And now I see ...
> >>
> >> $ grep -r host1x_device_init Module.symvers
> >> 0x00000000      host1x_device_init      drivers/gpu/host1x/host1x  EXP=
ORT_SYMBOL
> >>
> >> So the problem is that now there is no longer an absolute path in the
> >> external modules Module.symvers and so conflicts with the kernel's.
> >>
> >> Does that make sense?
> >
> >
> > As I said, I do not know how to reproduce it.
> >
> > Please provide the steps to reproduce it.
>
> Got it! The steps would be ...
>
> 1. Create an external module by copying using an existing upstream
>     driver (such as host1x).
> 2. Create a new external module that uses the external module from step
>     1 and uses KBUILD_EXTRA_SYMBOLS to reference the Module.symvers for
>     the driver in step 1.
>
> Thanks!
> Jon


OK, now I understand, and posted a patch.
Thanks.

--=20
Best Regards
Masahiro Yamada
