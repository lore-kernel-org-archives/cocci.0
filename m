Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C60E7717D
	for <cocci@archiver.kernel.org>; Thu, 12 Dec 2024 02:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hl2FuQ7+bH5joQNskWy3f4aqcXxZxbPiZym/E/X03N4=;
  b=iJff4vDZKvEd/7cgkeAbX9Ci/AxgFOFw9b+DCpoPX/8ekjXH0MdA+Xsd
   JJlnvW4yqQvWtrvPbILXm+v8t/HlyP90/R5UY0+iV9iHRvuduCjiEBldq
   4KsA0K8KcyXVqjkUBh8S7iN7I3Qd7vcdTDAw5gyw/gAuy6ZgD9FztEgwV
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
X-IronPort-AV: E=Sophos;i="6.12,227,1728943200"; 
   d="scan'208";a="198710214"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Dec 2024 03:09:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4B54E0137; Thu, 12 Dec 2024 03:09:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 42845E0077
	for <cocci@sympa.inria.fr>; Thu, 12 Dec 2024 03:09:18 +0100 (CET)
IronPort-SDR: 675a45cd_F2Y5HgstHcZTrdIbKR77utVTu1lYXDLAP5qKw6OwXzhRDy6
 BjAgs3dNt2VR9TCcPuhTIqEkvWdLNrqqSJUWoAw==
X-IPAS-Result: =?us-ascii?q?A0FGAQAMRVpnj9lUsotaHgEBCxIMQIFIC4JEgVczBAtIh?=
 =?us-ascii?q?FaIfIZRgiEDnhiBfg8BAwENRAQBAQMEhQACimwCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgEBAQMjBBkBATIFAQ8LCw0CAiYCAiETBR0GE4MBgmUDs?=
 =?us-ascii?q?A9/M4EBggwBAQbcH4FkCYEaLoVrgmMBgWyDf4N9eicbgUlEgUqCdT6EQxWDR?=
 =?us-ascii?q?oJpgRSBLIMXg0mVMYcpJgkdAwcHDg0eSQ8FHANZIREBVRMXCwcFYUggLAECA?=
 =?us-ascii?q?YEVggUcgT8FNwo9gklpSTcCDQI2giR8gk2FGYELgRWCSUoZLwMDAwODOYYkg?=
 =?us-ascii?q?hmBQh1AAwtiCz03FBtMnDhGg1oGMkqBP0UVHoECkj2QKoIdnkKCQ4QkgWOfe?=
 =?us-ascii?q?zOEBI0FhjqTDph7qSqBZzqBXDMaMHQGgjBPAxkPjiEMDQkWiFa7CTQ1PAIHA?=
 =?us-ascii?q?QoBAQMJhkiJPoFLAQE?=
IronPort-PHdr: A9a23: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
 sNmolpzV1EvEP4eTEN/E45aSKo=
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:mMtqZ6vq9IGgBouPb93rupVy7skDidV00zEX/kB9WHVpmwKj5r
 qTdZMgpGPJYVcqKQwdcLW7VZVoLkmskqKdjbNhWYtKGTOW3VdAT7sSjrcKoQeQYhEWn9Q1vc
 wLH5SWSueAb2SS5vyKmDVQfexQu+WvweSGg/zBx2xhQQwvR6Zr9BdhFwqXe3cYeOCEP/QEPa
 vZyM5Opz/lX28WYMS9DnxAe+TYvdXEmNbHTHc9dngaAcW17A9AIYSbLySl
X-Talos-CUID: 9a23:qO57GGwipPNNC5gooSzKBgUVA+ACQ1PE5kv2LkimIF1Ueb/PRX2PrfY=
X-Talos-MUID: 9a23:z/YuAQVoM32XPH3q/CXenQhobsVG34ajSx1dmrkissi4LyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,227,1728943200"; 
   d="scan'208";a="104093189"
X-MGA-submission: =?us-ascii?q?MDE6CgQq8otKYhiHBfgCh/b+YrUwR9+emcTlG5?=
 =?us-ascii?q?r+IBHkkSbPUJ/Mi0hEw/jEZiYU+dXP9Qk/YlBWDBuDVzqXFbgTsy0nR8?=
 =?us-ascii?q?+8/TxN/l+p2gsqZRlBp5kD1xg+pNrd4s/uJWVr6jBzl0r8ZXSz5aXojT?=
 =?us-ascii?q?MvQIBigMGrMSRMA05HMmOCRg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:09:17 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 447B65C6770
	for <cocci@inria.fr>; Thu, 12 Dec 2024 02:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689F2C4CEDF
	for <cocci@inria.fr>; Thu, 12 Dec 2024 02:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733969354;
	bh=RX1KM030pVU5SrawI2Bpt7O7lQKBznHQJyKYqseyMrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xp1kzy9lKs5Y6tnQlhNJ4JHBfuHXEkK7578NGBOpcervYUOIqvqkw4auqfpNGEee/
	 pfSBBa4O9h61rSD9KQ7E89DHKyFyh2O87ThZWl3YK/5YePxA+CnyZdd0qH/2p7ni7S
	 yyrLOAS7+T/0Ihq42ZF9BuCaA0RE0j5sqBEQ+krP6azEPAmCfG2HJBPKYxyQmh4GXn
	 tm3xPrYcsH3CsVnfFiut2hc18XwW1Ri189UaABaVBR8XvC7o4pId+29L42bUVMOALS
	 kwBaM3x/Iqob3x7f2SByzOBP0r001DvfB4s3BYgefHF7kBXlraasZzhJiGMqXQ8QvA
	 b5KToMlHcCeIg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30039432861so697021fa.2
        for <cocci@inria.fr>; Wed, 11 Dec 2024 18:09:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQQPc+AH70a6J+rjI6BYptRyA7655lLg3ZKexxZrLonop7D9SjOfGYWDCSbxpODg1Z2hiWLQ==@inria.fr
X-Gm-Message-State: AOJu0YxHEVdMay8Qw5onB8aKzFkOYxr2skZ1Eqo4kJz+jxxj/fBULFVd
	XjmJvs/5f8OHaUajmy5mljPxl24r9lD8zbIv+JiWZ7pvGuikgEO8Q/o08aFIdv5LVleOsXvrMoM
	D5iep0iDvpQv6sadAWoj6fyQsTP8=
X-Google-Smtp-Source: AGHT+IHggMs6oY4itU/JqMKfM3nJ5pIoKS9RIS5+JCWG241xKHM5udlZpFhablRTqOzWEHtv0kN5CA+KWbNcYlDCuMU=
X-Received: by 2002:a2e:bd81:0:b0:300:3778:4dbb with SMTP id
 38308e7fff4ca-30249e01d2amr5268561fa.1.1733969352988; Wed, 11 Dec 2024
 18:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <bdd5ff13-ec66-4ab6-985a-1fe433e85f91@nvidia.com> <CAK7LNATgL=vOr37+XfF7du+_ak5yKgXYyNNNTEQdVvy5J2MMyA@mail.gmail.com>
 <b20db4db-afb4-4f58-bc01-ae1250abc8b0@nvidia.com>
In-Reply-To: <b20db4db-afb4-4f58-bc01-ae1250abc8b0@nvidia.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 12 Dec 2024 11:08:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzdVrvmqm2wYHojVhNEiBNTaz6+4xgGBJwFixDvL=TMA@mail.gmail.com>
Message-ID: <CAK7LNATzdVrvmqm2wYHojVhNEiBNTaz6+4xgGBJwFixDvL=TMA@mail.gmail.com>
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
X-Sequence: 2179
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNATzdVrvmqm2wYHojVhNEiBNTaz6%2B4xgGBJwFixDvL%3DTMA%40mail.gmail.com>

On Wed, Dec 11, 2024 at 9:21=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 11/12/2024 02:39, Masahiro Yamada wrote:
> > On Wed, Dec 11, 2024 at 12:34=E2=80=AFAM Jon Hunter <jonathanh@nvidia.c=
om> wrote:
> >>
> >> Hi Masahiro,
> >>
> >> On 10/11/2024 01:34, Masahiro Yamada wrote:
> >>> Currently, Kbuild always operates in the output directory of the kern=
el,
> >>> even when building external modules. This increases the risk of exter=
nal
> >>> module Makefiles attempting to write to the kernel directory.
> >>>
> >>> This commit switches the working directory to the external module
> >>> directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
> >>> some build artifacts.
> >>>
> >>> The command for building external modules maintains backward
> >>> compatibility, but Makefiles that rely on working in the kernel
> >>> directory may break. In such cases, $(objtree) and $(srctree) should
> >>> be used to refer to the output and source directories of the kernel.
> >>>
> >>> The appearance of the build log will change as follows:
> >>>
> >>> [Before]
> >>>
> >>>     $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >>>     make: Entering directory '/path/to/my/linux'
> >>>       CC [M]  /path/to/my/externel/module/helloworld.o
> >>>       MODPOST /path/to/my/externel/module/Module.symvers
> >>>       CC [M]  /path/to/my/externel/module/helloworld.mod.o
> >>>       CC [M]  /path/to/my/externel/module/.module-common.o
> >>>       LD [M]  /path/to/my/externel/module/helloworld.ko
> >>>     make: Leaving directory '/path/to/my/linux'
> >>>
> >>> [After]
> >>>
> >>>     $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
> >>>     make: Entering directory '/path/to/my/linux'
> >>>     make[1]: Entering directory '/path/to/my/externel/module'
> >>>       CC [M]  helloworld.o
> >>>       MODPOST Module.symvers
> >>>       CC [M]  helloworld.mod.o
> >>>       CC [M]  .module-common.o
> >>>       LD [M]  helloworld.ko
> >>>     make[1]: Leaving directory '/path/to/my/externel/module'
> >>>     make: Leaving directory '/path/to/my/linux'
> >>>
> >>> Printing "Entering directory" twice is cumbersome. This will be
> >>> addressed later.
> >>>
> >>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>
> >>
> >> Since this change I have been observing the following build error when
> >> building an external module ...
> >>
> >>    MODPOST Module.symvers
> >> ERROR: modpost: drivers/gpu/host1x/host1x: 'host1x_device_init' export=
ed
> >>       twice. Previous export was in drivers/gpu/host1x/host1x.ko
> >> ERROR: modpost: drivers/gpu/host1x/host1x: 'host1x_device_exit' export=
ed
> >>       twice. Previous export was in drivers/gpu/host1x/host1x.ko
> >>
> >> Now host1x is an upstream driver, but I have a local copy that using t=
o
> >> stage development changes (and avoid polluting the upstream driver).
> >> Plus I can swap between which version I am using on a live system.
> >>
> >> What I noticed is that previously the Modules.symvers for the external
> >> module had the full path of the external module for the name. However,
> >> now the name is just the relative path and in this case
> >> 'drivers/gpu/host1x/host1x'. Hence, this clashes with the in-kernel
> >> driver and we get the 'exported twice' error.
> >>
> >> I have been looking to see if there is a way to fix this because it ha=
s
> >> been a useful feature to override an upstream driver with a locally
> >> modified version.
> >
> >
> > I do not know how to reproduce it.
> >
> >    if (s && (!external_module || s->module->is_vmlinux || s->module =3D=
=3D mod)) {
> >
> > is not checking the module path at all.
> > I do not understand why it was affected.
>
>
> So this is not explicitly checking the path, but comparing the contents
> of the Module.symvers before and after this change for the external
> module I see ...
>
> $ grep -r host1x_device_init Module.symvers
> 0x00000000      host1x_device_init      /absolute/path/to/drivers/gpu/hos=
t1x/host1x        EXPORT_SYMBOL
>
> And now I see ...
>
> $ grep -r host1x_device_init Module.symvers
> 0x00000000      host1x_device_init      drivers/gpu/host1x/host1x  EXPORT=
_SYMBOL
>
> So the problem is that now there is no longer an absolute path in the
> external modules Module.symvers and so conflicts with the kernel's.
>
> Does that make sense?


As I said, I do not know how to reproduce it.

Please provide the steps to reproduce it.





--
Best Regards
Masahiro Yamada
