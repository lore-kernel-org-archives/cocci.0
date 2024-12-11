Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767E4E7717F
	for <cocci@archiver.kernel.org>; Wed, 11 Dec 2024 02:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PkMSREqMl7FLQImfxUK4nwA/pTgEjC6GLdyYty9jyJI=;
  b=VahgCg6NjmQfY8FX5JnXZQimHKRRp5Ywt3FWvWCWPJC0/x+fu2UW8KCM
   Nnh+CCIbzlhmvWQCrGk8VRd5qnWaIzpgLxaIB9gt+BlcyWTAGgQ3IBj8A
   +gfp/5jPCDpNHLc/VJ6X1bhxb4wGaoJwKtx+cUYzjImNizZBoCROTtBor
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,224,1728943200"; 
   d="scan'208";a="198519408"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2024 03:40:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE172E0077; Wed, 11 Dec 2024 03:40:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 35073E0077
	for <cocci@sympa.inria.fr>; Wed, 11 Dec 2024 03:40:07 +0100 (CET)
IronPort-SDR: 6758fb86_NEP+fagMFajUhvRkTTfG4SoFUohc5BuwClRAZs3neWo+SzD
 epPCv+lqJZh/A2ubKP1muEyz2rQtuH6Yty50+WA==
X-IPAS-Result: =?us-ascii?q?A0FtAQDo+Vhnj1vBS5NagQmBU4JEgVczBAtIhFaIfIZRg?=
 =?us-ascii?q?iEDnhiBfg8BAwENRAQBAQMEhQACimoCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNgluBLIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINfgEBAQMjBBkBATIFAQ8LCw0CAiYCAiETBR0GE4MBgmUDsBl/M4EBg?=
 =?us-ascii?q?gwBAQbcH4FkCYEaLoVrgmMBgWyDf4N9eicbgUlEgUqCdT6EQxWDRoJpgRSBL?=
 =?us-ascii?q?IMXg0mVEIcnJgkdAwcHDg0eSQ8FHANZIREBVRMXCwcFYUggLAECAYEVggUcg?=
 =?us-ascii?q?T8FNwo9gklpSTcCDQI2giR8gk2FF4ELgRWCSUoZLwMDAwODO4YmghmBAB1AA?=
 =?us-ascii?q?wtiCz03FBtMnAlGg1YGMkqBP3iBApI9kCmCHZ5BgkOEJIFjn3szl0OTDph7q?=
 =?us-ascii?q?SqBZzqBXDMaMHQGgjBPAxkPjjofiFa7HTQ1PAIHAQoBAQMJhkiKC4FLAQE?=
IronPort-PHdr: A9a23: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
 HLrYrxWTlo4ErUdEEs3RLQ/
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xTK1aaMU6CE3zMBcTj6jsMiBIKoaSvp037Dk7TEKdfUzSL3lqy
 nOpoVn6faQslsssR4b6Le90cW7MBfhHNtOkOws1NSZLWrbUQmTXfhfBOLZqlWKcUHDH6xmpM
 VdmsNFeaXN5DZB/L3HyTj9PNA63tGd/aykwcvYxWx8VBxnZshbgDuRyTz0LmRGACdDDZo9UL
 yG5sRGoDKkPVAadN6yCHVAf8WrnaysqHsrW3877tcciDWzsQ==
X-Talos-CUID: 9a23:a6z3ym1u5xmIc2d9sJ76CbxfQuJ/YnHB9lTpeV7pLklPFZDOeEKI5/Yx
X-Talos-MUID: 9a23:UGw3WQnIZEnJRrm9Cm+4dnpyP+dwpIuWI3kyjKlBo+eJGXAuPW+02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,224,1728943200"; 
   d="scan'208";a="198519401"
X-MGA-submission: =?us-ascii?q?MDEkJHiXF3P5iDAWE+LPG6W6zXUcEwf/qXA0Ep?=
 =?us-ascii?q?kSsS531DNS6rTVkL1WaZCVGvgeSGMyWV9oA93UAizmHEaYgzntfIDRpQ?=
 =?us-ascii?q?vME49kZrbdz88vAgZZHpKsF211n6drVN/szUq0BKQ7rH5pOvVdGk20lq?=
 =?us-ascii?q?cvlTWe3V8ODu0CfunfA1G0JA=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:40:06 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5AD00A41D8D
	for <cocci@inria.fr>; Wed, 11 Dec 2024 02:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B575C4CEDF
	for <cocci@inria.fr>; Wed, 11 Dec 2024 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884805;
	bh=rUN6+1EcdrSc29o0r+g71abVsqJjIdoI6ULiRDI6x/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MWCGyPWaSXDCTdWpb3EGz7nA//n219Cp04RJc56oc8qvZbq/qNAorRu8LZIoXRdCV
	 mEkI84TzxLxZwurnv8XI13FfZV/PC1lBlEqnvIbQJzhiiZKiqePua/+RhvQZWDGpfF
	 BBxo01jiltQJILqBZS1xQ0hTZ48D/RmysDYjZbOByg/EF6+NV2EnlqWxZTvST0XKyh
	 X53/zshwqiN98s+ujdKevHcQ3tXIXj6OO913jpjcg4c2N5El9vCmGqOGO7jZy+q5Od
	 M/TeefTCdQviUkgsjC5TWXp3zD5E4ruQq+ma1dMONTET6d72bAjMe4y/aB+R0v9aJa
	 qZdmnhG0aivQg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3022484d4e4so26235851fa.1
        for <cocci@inria.fr>; Tue, 10 Dec 2024 18:40:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULfLNyQ+PUR+5CkQrSO3FYlAOnlxKZs90zf6R8mevz6OmPD0UBZXHcoB2yrJIAb9ClzP8Pww==@inria.fr
X-Gm-Message-State: AOJu0Yx7eIpwnGkjdRpB9yi5MIckGieRQHA2SDZnwlXthx3HEaxy8YMA
	HC0Qv3etPVaRgiwyDZRkQH8FqX9YqE6uNsKMrlepGhDUYKH/KSbKMIZikqWaNy6jd0NIpXcRElu
	JX5wr3q6tYvbDF9YmL3dx9EKjBBQ=
X-Google-Smtp-Source: AGHT+IHxGpnB/myKvlJsuWzHOTwl8yjs6e6CcOHIGoQ3+14Q2O5vvCXnxMip8nROElsib4NPrDvqxoKteTG3GissR3A=
X-Received: by 2002:a05:651c:1582:b0:300:360b:bc36 with SMTP id
 38308e7fff4ca-30240d52cb2mr4501801fa.23.1733884804055; Tue, 10 Dec 2024
 18:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <bdd5ff13-ec66-4ab6-985a-1fe433e85f91@nvidia.com>
In-Reply-To: <bdd5ff13-ec66-4ab6-985a-1fe433e85f91@nvidia.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 11 Dec 2024 11:39:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATgL=vOr37+XfF7du+_ak5yKgXYyNNNTEQdVvy5J2MMyA@mail.gmail.com>
Message-ID: <CAK7LNATgL=vOr37+XfF7du+_ak5yKgXYyNNNTEQdVvy5J2MMyA@mail.gmail.com>
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
X-Sequence: 2175
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNATgL%3DvOr37%2BXfF7du%2B_ak5yKgXYyNNNTEQdVvy5J2MMyA%40mail.gmail.com>

On Wed, Dec 11, 2024 at 12:34=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> =
wrote:
>
> Hi Masahiro,
>
> On 10/11/2024 01:34, Masahiro Yamada wrote:
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
> >    $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >    make: Entering directory '/path/to/my/linux'
> >      CC [M]  /path/to/my/externel/module/helloworld.o
> >      MODPOST /path/to/my/externel/module/Module.symvers
> >      CC [M]  /path/to/my/externel/module/helloworld.mod.o
> >      CC [M]  /path/to/my/externel/module/.module-common.o
> >      LD [M]  /path/to/my/externel/module/helloworld.ko
> >    make: Leaving directory '/path/to/my/linux'
> >
> > [After]
> >
> >    $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >    make: Entering directory '/path/to/my/linux'
> >    make[1]: Entering directory '/path/to/my/externel/module'
> >      CC [M]  helloworld.o
> >      MODPOST Module.symvers
> >      CC [M]  helloworld.mod.o
> >      CC [M]  .module-common.o
> >      LD [M]  helloworld.ko
> >    make[1]: Leaving directory '/path/to/my/externel/module'
> >    make: Leaving directory '/path/to/my/linux'
> >
> > Printing "Entering directory" twice is cumbersome. This will be
> > addressed later.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
> Since this change I have been observing the following build error when
> building an external module ...
>
>   MODPOST Module.symvers
> ERROR: modpost: drivers/gpu/host1x/host1x: 'host1x_device_init' exported
>      twice. Previous export was in drivers/gpu/host1x/host1x.ko
> ERROR: modpost: drivers/gpu/host1x/host1x: 'host1x_device_exit' exported
>      twice. Previous export was in drivers/gpu/host1x/host1x.ko
>
> Now host1x is an upstream driver, but I have a local copy that using to
> stage development changes (and avoid polluting the upstream driver).
> Plus I can swap between which version I am using on a live system.
>
> What I noticed is that previously the Modules.symvers for the external
> module had the full path of the external module for the name. However,
> now the name is just the relative path and in this case
> 'drivers/gpu/host1x/host1x'. Hence, this clashes with the in-kernel
> driver and we get the 'exported twice' error.
>
> I have been looking to see if there is a way to fix this because it has
> been a useful feature to override an upstream driver with a locally
> modified version.


I do not know how to reproduce it.

  if (s && (!external_module || s->module->is_vmlinux || s->module =3D=3D m=
od)) {

is not checking the module path at all.
I do not understand why it was affected.



--=20
Best Regards
Masahiro Yamada
