Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28C4D591A7
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hAdrR2RL4m4TlmGNSRVEbbss3yhCIMvc+FXywwS5JLs=;
  b=WoQwX7Efzhz2g5a6rY6RXgO4uSbAPtwRDg/uTxTpXhXNy39sts4lBK4d
   q0zcHlmLnOuEEUjjkCthScye5gnouIPARgHx4Lr+95jZP2+xnWfXeO1s7
   +I/+F22EkIDqPD/by94ZxB86jBe+9Uaoeu2zNlPcl1gGxri5F1CQXwPgg
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194501366"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 18:02:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 438A9E0133; Mon, 18 Nov 2024 18:02:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 35749E013D
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 18:02:47 +0100 (CET)
IronPort-SDR: 673b7336_v005iZwc1e8iKZOO8/nCWg99IBljREYYEsyuQqQHKkiZFy4
 AIyiljv5PRS5ZBlsmWvLGHQXsmNv1SUPOSIDW3A==
X-IPAS-Result: =?us-ascii?q?A0FhAQDwcTtnhdlUsotaHgEBCxIMQIFIC4JEfVozBAtIh?=
 =?us-ascii?q?FaDT4UtiHIDkx6KeYF+DwEDAQ0xEwQBAQMBA4UAAopOAh4HAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFASYVBBjQNgmIBM3GBJ?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEdAg1+AQEBAyMdAQE3AQ8LCwMKAgIZDQICIRMFHQYTC?=
 =?us-ascii?q?IJ5AYJkA7FagTKBAYIMAQEGgQjbF4FkCYEaLoVqgmIBgWyDfRuDYnonG4FJR?=
 =?us-ascii?q?IFKgQZtSjg+hEMVg0aCaYEUgTFnU4JfdiVNhyWBDYN/iEB4HoQXiCEJHQMHB?=
 =?us-ascii?q?w4NHkkPBRwDWSERAVUTFwsHBWBJISwBAgGCRn+BNoFRAYMQSoMuHIFCBTcKP?=
 =?us-ascii?q?4JKaUs3Ag0CNoIkfYJPhReBC4EVgkxOGS8DAwMDgzyECx1AAwtiCz01FBtMn?=
 =?us-ascii?q?34BRoM0AXsOBQEbgSsyKxsMHgsGLJJqkhWhA4QkgWOKM5VHM4VbkWWTDpYYg?=
 =?us-ascii?q?l+jWSaFKIFnOoFcMxowdAaCMAlGAxkPjA6CExkfgmSFcsEgNDU7AgcBCgEBA?=
 =?us-ascii?q?wmGSIpwgUsBAQ?=
IronPort-PHdr: A9a23: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
 RYMh7TiItZLXrA=
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:lru04K02mqzkWZxDezulDAqjBE0kLtp133Aq2lEZdPWaSL3jqy
 nIpoVm6faUskdtZJhEo7290ca7MBThHPJOkO0s1PKZLWzbUQiTXeJfBOnZskTd8kTFn4Y3v8
 tdmupFeb/N5DNB/L7HCWeDYq0d6ejC36aym+/EwnthCS1sYbpx9hp0B2+gfXGehzMpObMJUL
 SZ7spD4xy6eXoWacy/Ql0IRfLKqdGOtL+OW29hO/fq0mizZPqTiILHLw==
X-Talos-CUID: 9a23:ezjhBmN+qiUMd+5DZ3JXzVwzHM0ef3DZ8WfcBH2GMjlnV+jA
X-Talos-MUID: 9a23:dq628QuduzwOoPeF7s2nthZkJeJSwomXI1kTqbY/osiZEWtSJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="101957540"
X-MGA-submission: =?us-ascii?q?MDGYqLy03k9yYihcrUKJFmwNgqvcw3NO6Ce0ZZ?=
 =?us-ascii?q?rYtxaUETWU04CeUuEXRzVcAB1VLVrVkWtu/tPJ5DM0OdfC5ej73JLlNu?=
 =?us-ascii?q?sRCzZpiC/1HvL1z6NqRwFYeSjKBls0vtGkftTlB47iAnoaOhBiVEF12W?=
 =?us-ascii?q?RpT7fAODHpr4C2Ur/BkajL3w=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 18:02:46 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7E92C5C5B81
	for <cocci@inria.fr>; Mon, 18 Nov 2024 17:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47440C4CED6
	for <cocci@inria.fr>; Mon, 18 Nov 2024 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731949363;
	bh=6uU3qeWUrQgIC8hoTBHlwCN3jHJLvKONTL8T4W4b/rA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mvPyIokSH/sa4foQL8SXErsQHRcLYVF7FBe5LI5ZsHAG0WS1lBU2yQhlekIYuz0cd
	 VDBlQVqLuPrjXLmvTSvvGfXkirnnAlfAXoYGP+Lrp95wEIvmzGJ8ePZ/ZRJ57FlyT7
	 noE/LUqxGH8IB9rRFoiDdslwBXF4jd1ilqS+9OdyVVYtpVwbum3zDTTNlmuGyY9eug
	 TKFFCLK+CoJH5ZXXvuTdJ7RQRz0kl4m19ZxFLH86PF+/rETwz532dndYWi4hsY7zgn
	 kC30IwevFv5OOTE9Zjec+T9CT9+Cq3kX1JkvRKnifsN4YEuSsngp/4FhFNNzCQZsqR
	 vOt3Xh0VTRqPw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so3422220e87.2
        for <cocci@inria.fr>; Mon, 18 Nov 2024 09:02:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz+3ZdD6j4wDYuWPWDbPTMmT/a+yYvEKr9DwXKm3hX7yKR3FOcJDk9NLajOHFZWJ8NVKcQ0w==@inria.fr
X-Gm-Message-State: AOJu0YwAa31r1U0TUCGJTaTGl4D4vP5MAn6sPliDM9NcjwDoz+mWFH1q
	2W0D551UVUTF8qMoFkPeIafo/dzrbkX2CFb9AUiWW6A7zDsWBuN+WuZbyuv3RU4d1OgjXD1LAYs
	MYsBEFJeTtR6F7LaCEbHv2c0SoIY=
X-Google-Smtp-Source: AGHT+IHBAPTsXiOHJ2mPXQyIzCUWtagYGH5APYGWenfco8rRysZHH+4SoZK4R1lUx6SQUfS/FnsDshIQKbUAhGvK7U4=
X-Received: by 2002:a05:6512:3c9c:b0:53d:a2da:d396 with SMTP id
 2adb3069b0e04-53dab2a6441mr7069883e87.23.1731949361488; Mon, 18 Nov 2024
 09:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <20241118-dazzling-gifted-bettong-133eb7@buildd>
In-Reply-To: <20241118-dazzling-gifted-bettong-133eb7@buildd>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 19 Nov 2024 02:02:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATomVVvxHgy=e7rwq7EPgP7Z2UUERkyDJGQe63n6BuW3Q@mail.gmail.com>
Message-ID: <CAK7LNATomVVvxHgy=e7rwq7EPgP7Z2UUERkyDJGQe63n6BuW3Q@mail.gmail.com>
To: Nicolas Schier <n.schier@avm.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, cocci@inria.fr, 
	Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2078
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/CAK7LNATomVVvxHgy%3De7rwq7EPgP7Z2UUERkyDJGQe63n6BuW3Q%40mail.gmail.com>

On Mon, Nov 18, 2024 at 11:47=E2=80=AFPM Nicolas Schier <n.schier@avm.de> w=
rote:
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
> >
> > Changes in v2:
> >  - Introduce a new 'srcroot' variable and clean-up code
> >  - Reword Documentation/dev-tools/coccinelle.rst
> >
> >  Documentation/dev-tools/coccinelle.rst | 20 ++-----
> >  Documentation/kbuild/makefiles.rst     | 14 +++++
> >  Makefile                               | 80 +++++++++++++++-----------
> >  rust/Makefile                          |  4 +-
> >  scripts/Makefile.build                 |  2 +-
> >  scripts/Makefile.clean                 |  2 +-
> >  scripts/Makefile.compiler              |  2 +-
> >  scripts/Makefile.modpost               |  6 +-
> >  scripts/coccicheck                     |  6 +-
> >  scripts/nsdeps                         |  8 +--
> >  scripts/package/install-extmod-build   |  7 +++
> >  11 files changed, 85 insertions(+), 66 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev=
-tools/coccinelle.rst
> > index 535ce126fb4f..6e70a1e9a3c0 100644
> > --- a/Documentation/dev-tools/coccinelle.rst
> > +++ b/Documentation/dev-tools/coccinelle.rst
> > @@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:
> >  - Your directory from which spatch is called is processed next
> >  - The directory provided with the ``--dir`` option is processed last, =
if used
> >
> > -Since coccicheck runs through make, it naturally runs from the kernel
> > -proper dir; as such the second rule above would be implied for picking=
 up a
> > -.cocciconfig when using ``make coccicheck``.
> > -
> >  ``make coccicheck`` also supports using M=3D targets. If you do not su=
pply
> >  any M=3D target, it is assumed you want to target the entire kernel.
> >  The kernel coccicheck script has::
> >
> > -    if [ "$KBUILD_EXTMOD" =3D "" ] ; then
> > -        OPTIONS=3D"--dir $srctree $COCCIINCLUDE"
> > -    else
> > -        OPTIONS=3D"--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> > -    fi
> > +    OPTIONS=3D"--dir $srcroot $COCCIINCLUDE"
> >
> > -KBUILD_EXTMOD is set when an explicit target with M=3D is used. For bo=
th cases
> > -the spatch ``--dir`` argument is used, as such third rule applies when=
 whether
> > -M=3D is used or not, and when M=3D is used the target directory can ha=
ve its own
> > -.cocciconfig file. When M=3D is not passed as an argument to coccichec=
k the
> > -target directory is the same as the directory from where spatch was ca=
lled.
> > +Here, $srcroot refers to the source directory of the target: it points=
 to the
> > +external module's source directory when M=3D used, and otherwise, to t=
he kernel
> > +source directory. The third rule ensures the spatch reads the .coccico=
nfig from
> > +the target directory, allowing external modules to have their own .coc=
ciconfig
> > +file.
> >
> >  If not using the kernel's coccicheck target, keep the above precedence
> >  order logic of .cocciconfig reading. If using the kernel's coccicheck =
target,
> > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/=
makefiles.rst
> > index 7964e0c245ae..d36519f194dc 100644
> > --- a/Documentation/kbuild/makefiles.rst
> > +++ b/Documentation/kbuild/makefiles.rst
> > @@ -449,6 +449,20 @@ $(obj)
> >    to prerequisites are referenced with $(src) (because they are not
> >    generated files).
> >
> > +$(srcroot)
> > +  $(srcroot) refers to the root of the source you are building, which =
can be
> > +  either the kernel source or the external modules source, depending o=
n whether
> > +  KBUILD_EXTMOD is set. This can be either a relative or an absolute p=
ath, but
> > +  if KBUILD_ABS_SRCTREE=3D1 is set, it is always an absolute path.
> > +
> > +$(srctree)
> > +  $(srctree) refers to the root of the kernel source tree. When buildi=
ng the
> > +  kernel, this is the same as $(srcroot).
> > +
> > +$(objtree)
> > +  $(objtree) refers to the root of the kernel object tree. It is ``.``=
 when
> > +  building the kernel, but it is different when building external modu=
les.
> > +
>
> Thanks, I think it's nice that there is now such a clear definition.
> $(srcroot) sounds fine to me.
>
> >  $(kecho)
> >    echoing information to user in a rule is often a good practice
> >    but when execution ``make -s`` one does not expect to see any output
> > diff --git a/Makefile b/Makefile
> > index cf1d55560ae2..e5f7ac7647a7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -180,7 +180,24 @@ ifeq ("$(origin O)", "command line")
> >    KBUILD_OUTPUT :=3D $(O)
> >  endif
> >
> > -output :=3D $(KBUILD_OUTPUT)
> > +ifdef KBUILD_EXTMOD
> > +    ifdef KBUILD_OUTPUT
> > +        objtree :=3D $(realpath $(KBUILD_OUTPUT))
> > +        $(if $(objtree),,$(error specified kernel directory "$(KBUILD_=
OUTPUT)" does not exist))
> > +    else
> > +        objtree :=3D $(CURDIR)
> > +    endif
> > +    output :=3D $(KBUILD_EXTMOD)
> > +    # KBUILD_EXTMOD might be a relative path. Remember its absolute pa=
th before
> > +    # Make changes the working directory.
> > +    srcroot :=3D $(realpath $(KBUILD_EXTMOD))
> > +    $(if $(srcroot),,$(error specified external module directory "$(KB=
UILD_EXTMOD)" does not exist))
> > +else
> > +    objtree :=3D .
> > +    output :=3D $(KBUILD_OUTPUT)
> > +endif
> > +
> > +export objtree srcroot
> >
> >  # Do we want to change the working directory?
> >  ifneq ($(output),)
> > @@ -230,35 +247,33 @@ else # need-sub-make
> >
> >  # We process the rest of the Makefile if this is the final invocation =
of make
> >
> > -ifeq ($(abs_srctree),$(CURDIR))
> > -        # building in the source tree
> > -        srctree :=3D .
> > -     building_out_of_srctree :=3D
> > +ifndef KBUILD_EXTMOD
> > +srcroot :=3D $(abs_srctree)
> > +endif
> > +
> > +ifeq ($(srcroot),$(CURDIR))
> > +building_out_of_srctree :=3D
> >  else
> > -        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
> > -                # building in a subdirectory of the source tree
> > -                srctree :=3D ..
> > -        else
> > -                srctree :=3D $(abs_srctree)
> > -        endif
> > -     building_out_of_srctree :=3D 1
> > +export building_out_of_srctree :=3D1
> >  endif
> >
> > -ifneq ($(KBUILD_ABS_SRCTREE),)
> > -srctree :=3D $(abs_srctree)
> > +ifdef KBUILD_ABS_SRCTREE
> > +    # Do not nothing. Use the absolute path.
> > +else ifeq ($(srcroot),$(CURDIR))
> > +    # Building in the source.
> > +    srcroot :=3D .
> > +else ifeq ($(srcroot)/,$(dir $(CURDIR)))
> > +    # Building in a subdirectory of the source.
> > +    srcroot :=3D ..
> >  endif
> >
> > -objtree              :=3D .
> > +export srctree :=3D $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
>
> With this patch applied, the following breaks for me:
>
>     $ make O=3Dbuild M=3Dfs/btrfs CONFIG_BTRFS_FS=3Dm
>     make[1]: Entering directory '/data/linux/kbuild-review/fs/btrfs'
>       CC [M]  super.o
>     In file included from <command-line>:
>     /data/linux/kbuild-review/include/linux/compiler_types.h:89:10: fatal=
 error: linux/compiler_attributes.h: No such file or directory
>        89 | #include <linux/compiler_attributes.h>
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>
> Adding 'ccflags-y +=3D -I$(srctree)/include' to fs/btrfs/Makefile breaks
> the build loudly.  I could make it build again with
>
> diff --git a/Makefile b/Makefile
> index e5f7ac7647a7b..3d95911f1a68f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -555,7 +555,7 @@ USERINCLUDE    :=3D \
>  LINUXINCLUDE    :=3D \
>                 -I$(srctree)/arch/$(SRCARCH)/include \
>                 -I$(objtree)/arch/$(SRCARCH)/include/generated \
> -               $(if $(building_out_of_srctree),-I$(srctree)/include) \
> +               $(if $(or $(building_out_of_srctree),$(filter $(srctree)/=
%, $(CURDIR))),-I$(srctree)/include) \
>                 -I$(objtree)/include \
>                 $(USERINCLUDE)
>
> but this does not feel good.  It building in-tree modules in this way a
> valid thing to do?

Yes, it is a valid way.

This got broken with this commit, and fixed by the later commit,
"kbuild: support building external modules in a separate build directory".

I will move the change for LINUXINCLUDE to this commit.

Thanks for comprehensive testing!

--=20
Best Regards
Masahiro Yamada
