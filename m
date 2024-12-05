Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89BFE7716F
	for <cocci@archiver.kernel.org>; Thu,  5 Dec 2024 02:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CLnF/eppMZbau5d0z6M1xDnduaCWyGrG50HNaZ79pDM=;
  b=uG0rBH1Gt1Tmts42lfFpXeYkTWk+SPD4QIyK0kJOuFFQV/l3rqJ0JgbZ
   VJpQuRZCnRobQmKh57PU3gIanTXDtjUIgD67uuniwK11Jy5oSWESkcYWk
   Ippq/Qoydt1I0xlsJJ48vnqmtuxwvZMwV6b1DS9w43MdKz5ysKoKyQs6U
   c=;
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
   d="scan'208,217";a="197434973"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2024 03:07:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9EF1E0D1C; Thu,  5 Dec 2024 03:07:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 038A2E00B6
	for <cocci@sympa.inria.fr>; Thu,  5 Dec 2024 03:07:00 +0100 (CET)
IronPort-SDR: 67510ac3_6m/e7VqmUtdROk3992LIkM5ylNsTnFm62Jl37LTnLmjxlI6
 ol2xBwZO1RUadlB7C8EbZfMtXFfwdxEgsjBmFDQ==
X-IPAS-Result: =?us-ascii?q?A0F9AgDiCVFnhdlUsotaHgEBCxIMgggLgUGBA31aMwQLS?=
 =?us-ascii?q?IRWgSOCLIUthlGBfwUdA4ETkguKeoElA1YPAQMBDT0HBAEBAwEDhQACHIpOA?=
 =?us-ascii?q?h4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFAS?=
 =?us-ascii?q?YV7DYJbO3GBJQEBAQEBAQEBAQEBAQEBAQEBAQEXAg0fPwEfAQEBAgEaCR0BA?=
 =?us-ascii?q?TcBBAsJAgstCgICIRMFHRkIgnkBgkEjAxGUYJxFgTKBAYIMAQEGgQjbF4FkC?=
 =?us-ascii?q?YFIhWuCYwGBXAIOg3+DfXonG4FJRIEVNYEGgTc4PoJhAQECFQOFIYJpgkNnV?=
 =?us-ascii?q?oJfdiWFBoJtgQ2Bb4IPiDp4Hh0dMIIugTGKMyYmAwcHDg0eSQ4BIQMmMyERA?=
 =?us-ascii?q?VUTFwsHBWFJISwBAgGCR3+BNoFRAYMQSoMuHIFCBTcKPTmCEWlLNwINAjaCJ?=
 =?us-ascii?q?H2CTYUXgQuBFYJJShkvAwMDA4M7hiqBXx1AAwtiCz03FBtMohQBRoNWAXsED?=
 =?us-ascii?q?wEbEIEQCzIrJykykmuPe4IdoQSEJIFjijSVRzOFW5Fokw6WG4Jgo1wLhUOBZ?=
 =?us-ascii?q?zo8gSAzGjB0BoIwCUYDGQ+OIRkfgmRehRS6JzQ1PAIHAQoBAQMJlB6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 F8vUapan7FaWPYIa9WzWjT3a2Fr2f0sKEQ=
IronPort-HdrOrdr: A9a23:lQgafaqTNONt2kKzgrDbgNQaV5rSeYIsimQD101hICG9vPbo7f
 xG/c5rqCMc7Qx9ZJhOo6HmBEDtewK5yXcx2/h1AV7AZniEhILLFvAa0WKK+VSJcEeTygce79
 YDT0EUMqyJMbEVt7eA3CCIV/kn28eO662liKPzyH13XRh2Z6wI1WhE48WgfHFedU1pAZI4Ed
 67/cpIpz2pfDAyYt6gDncIG8jvzue78q4OrSRmO/fv0mmzsQ8=
X-Talos-CUID: 9a23:+vNcdGDN6GnDw8P6EyJW+U5TOsV9SDryy1XsIFCeM0toQ7LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AztxJ0w9n9l9nV3hapZVYIAuQf9ZQ3K2uVFo2q4Q?=
 =?us-ascii?q?pv+SicjR2OBG61R3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208,217";a="103472421"
X-MGA-submission: =?us-ascii?q?MDHvkt0czuQ2RWMAREw9WoXr+9OutbL+BtxIPt?=
 =?us-ascii?q?fKsZfJmmJEzv0NNFnFWnevBaDYkLTgT41Xot6osajSjnXYY25VzQXnYp?=
 =?us-ascii?q?sdhkehhpJXLWvjaNv0VSuZhKOCEKb89oshy93kUprgwjRll22TQl0Y41?=
 =?us-ascii?q?/rQmVwdbHvTt3oLqkTf0Y+Pw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:06:59 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 052C15C4B55
	for <cocci@inria.fr>; Thu,  5 Dec 2024 02:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E89AC4CED2
	for <cocci@inria.fr>; Thu,  5 Dec 2024 02:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733364416;
	bh=gPM3+fCIm8vZkZ4Y4/JBCNsZhJHQRDfoPXDU4kcVaI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A3XK6EzBEJHczf8+EfwN42Bifp8WJvhbkqbzxB0VXrvd44l+naR5gba9vFWnNesEr
	 vrsuZ4xj5REkCGM1dn6SA+UWHOU2zDnA2YF2kVKSwzz1+IhN9UVYc+MxTMVlzAaAkp
	 DOPo28RWnYEb2w4l1mCpCITS0WEnfrxlI97AjH+n2yNeFNdZUK8pCZJPS4b44GzYTw
	 n7bspX/Bs1Wc/RDy1tgr1QcaS1dX6Ns5uUwQKrny22MbfuxPHRxzSqXThdZF10ngdu
	 AXqIp3jxZUFcT93rVEiUABsD/dqJ5Sxli8Eda/lJLNj21DQ1yDVEDltKr8XKTfYeuM
	 P0SMX/TWOySxA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so396205e87.3
        for <cocci@inria.fr>; Wed, 04 Dec 2024 18:06:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUzs+NoYEIXhOwXZRLkj0H2PxTbrUFxrWqHtHeG2gP3KxpOS0pE5kI7BM+o97YhWD/UM4zFQ==@inria.fr
X-Gm-Message-State: AOJu0YyQeD9FKEJwcHVG6EoZBszDrM/05fK43E4GxRBDgfuOENr64LBo
	YsxV97LmmYjabTnmgwNYAc/pGntgFrnDh2b/DKpSI2sORhi0S5F//7TwyDDqpjCcL41pGKuItPV
	9VXI5CvjHXiUWTrj+CqdmcBufD/fRkoX7lfiHrk4rVZBjB2Clwf7fMF/2z/997X0z/PA=
X-Google-Smtp-Source: AGHT+IGLJmurdCdenT7k0vnbKXbqh0kdptn5AG/kUblL+MzYZRYd1b92xGEWPBxlxSDoAWk2B6qZqduAygAeoVaaDFZBUk0lnpRvHS/Q
X-Received: by 2002:a05:6512:1249:b0:53d:e077:deed with SMTP id
 2adb3069b0e04-53e12a344f0mr4595761e87.52.1733364414807; Wed, 04 Dec 2024
 18:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
In-Reply-To: <20241110013649.34903-6-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 5 Dec 2024 11:06:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQefghyrAZSVNJPWd15DBbgNPo2PPawZsasmxr8a9CkxQ@mail.gmail.com>
Message-ID: <CAK7LNAQefghyrAZSVNJPWd15DBbgNPo2PPawZsasmxr8a9CkxQ@mail.gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000003612a106287c5adc"
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2156
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNAQefghyrAZSVNJPWd15DBbgNPo2PPawZsasmxr8a9CkxQ%40mail.gmail.com>

--0000000000003612a106287c5adc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=98=8A

Masahiro =E3=81=95=E3=82=93=E3=81=8C Gmail
<https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&utm_medi=
um=3Det&utm_campaign=3Demojireactionemail#app>
=E3=81=A7=E3=83=AA=E3=82=A2=E3=82=AF=E3=82=B7=E3=83=A7=E3=83=B3=E3=81=97=E3=
=81=BE=E3=81=97=E3=81=9F

2024=E5=B9=B411=E6=9C=8810=E6=97=A5(=E6=97=A5) 10:37 Masahiro Yamada <masah=
iroy@kernel.org>:

> Currently, Kbuild always operates in the output directory of the kernel,
> even when building external modules. This increases the risk of external
> module Makefiles attempting to write to the kernel directory.
>
> This commit switches the working directory to the external module
> directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
> some build artifacts.
>
> The command for building external modules maintains backward
> compatibility, but Makefiles that rely on working in the kernel
> directory may break. In such cases, $(objtree) and $(srctree) should
> be used to refer to the output and source directories of the kernel.
>
> The appearance of the build log will change as follows:
>
> [Before]
>
>   $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
>   make: Entering directory '/path/to/my/linux'
>     CC [M]  /path/to/my/externel/module/helloworld.o
>     MODPOST /path/to/my/externel/module/Module.symvers
>     CC [M]  /path/to/my/externel/module/helloworld.mod.o
>     CC [M]  /path/to/my/externel/module/.module-common.o
>     LD [M]  /path/to/my/externel/module/helloworld.ko
>   make: Leaving directory '/path/to/my/linux'
>
> [After]
>
>   $ make -C /path/to/my/linux M=3D/path/to/my/externel/module
>   make: Entering directory '/path/to/my/linux'
>   make[1]: Entering directory '/path/to/my/externel/module'
>     CC [M]  helloworld.o
>     MODPOST Module.symvers
>     CC [M]  helloworld.mod.o
>     CC [M]  .module-common.o
>     LD [M]  helloworld.ko
>   make[1]: Leaving directory '/path/to/my/externel/module'
>   make: Leaving directory '/path/to/my/linux'
>
> Printing "Entering directory" twice is cumbersome. This will be
> addressed later.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>  - Introduce a new 'srcroot' variable and clean-up code
>  - Reword Documentation/dev-tools/coccinelle.rst
>
>  Documentation/dev-tools/coccinelle.rst | 20 ++-----
>  Documentation/kbuild/makefiles.rst     | 14 +++++
>  Makefile                               | 80 +++++++++++++++-----------
>  rust/Makefile                          |  4 +-
>  scripts/Makefile.build                 |  2 +-
>  scripts/Makefile.clean                 |  2 +-
>  scripts/Makefile.compiler              |  2 +-
>  scripts/Makefile.modpost               |  6 +-
>  scripts/coccicheck                     |  6 +-
>  scripts/nsdeps                         |  8 +--
>  scripts/package/install-extmod-build   |  7 +++
>  11 files changed, 85 insertions(+), 66 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst
> b/Documentation/dev-tools/coccinelle.rst
> index 535ce126fb4f..6e70a1e9a3c0 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:
>  - Your directory from which spatch is called is processed next
>  - The directory provided with the ``--dir`` option is processed last, if
> used
>
> -Since coccicheck runs through make, it naturally runs from the kernel
> -proper dir; as such the second rule above would be implied for picking u=
p
> a
> -.cocciconfig when using ``make coccicheck``.
> -
>  ``make coccicheck`` also supports using M=3D targets. If you do not supp=
ly
>  any M=3D target, it is assumed you want to target the entire kernel.
>  The kernel coccicheck script has::
>
> -    if [ "$KBUILD_EXTMOD" =3D "" ] ; then
> -        OPTIONS=3D"--dir $srctree $COCCIINCLUDE"
> -    else
> -        OPTIONS=3D"--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> -    fi
> +    OPTIONS=3D"--dir $srcroot $COCCIINCLUDE"
>
> -KBUILD_EXTMOD is set when an explicit target with M=3D is used. For both
> cases
> -the spatch ``--dir`` argument is used, as such third rule applies when
> whether
> -M=3D is used or not, and when M=3D is used the target directory can have=
 its
> own
> -.cocciconfig file. When M=3D is not passed as an argument to coccicheck =
the
> -target directory is the same as the directory from where spatch was
> called.
> +Here, $srcroot refers to the source directory of the target: it points t=
o
> the
> +external module's source directory when M=3D used, and otherwise, to the
> kernel
> +source directory. The third rule ensures the spatch reads the
> .cocciconfig from
> +the target directory, allowing external modules to have their own
> .cocciconfig
> +file.
>
>  If not using the kernel's coccicheck target, keep the above precedence
>  order logic of .cocciconfig reading. If using the kernel's coccicheck
> target,
> diff --git a/Documentation/kbuild/makefiles.rst
> b/Documentation/kbuild/makefiles.rst
> index 7964e0c245ae..d36519f194dc 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -449,6 +449,20 @@ $(obj)
>    to prerequisites are referenced with $(src) (because they are not
>    generated files).
>
> +$(srcroot)
> +  $(srcroot) refers to the root of the source you are building, which ca=
n
> be
> +  either the kernel source or the external modules source, depending on
> whether
> +  KBUILD_EXTMOD is set. This can be either a relative or an absolute
> path, but
> +  if KBUILD_ABS_SRCTREE=3D1 is set, it is always an absolute path.
> +
> +$(srctree)
> +  $(srctree) refers to the root of the kernel source tree. When building
> the
> +  kernel, this is the same as $(srcroot).
> +
> +$(objtree)
> +  $(objtree) refers to the root of the kernel object tree. It is ``.``
> when
> +  building the kernel, but it is different when building external module=
s.
> +
>  $(kecho)
>    echoing information to user in a rule is often a good practice
>    but when execution ``make -s`` one does not expect to see any output
> diff --git a/Makefile b/Makefile
> index cf1d55560ae2..e5f7ac7647a7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -180,7 +180,24 @@ ifeq ("$(origin O)", "command line")
>    KBUILD_OUTPUT :=3D $(O)
>  endif
>
> -output :=3D $(KBUILD_OUTPUT)
> +ifdef KBUILD_EXTMOD
> +    ifdef KBUILD_OUTPUT
> +        objtree :=3D $(realpath $(KBUILD_OUTPUT))
> +        $(if $(objtree),,$(error specified kernel directory
> "$(KBUILD_OUTPUT)" does not exist))
> +    else
> +        objtree :=3D $(CURDIR)
> +    endif
> +    output :=3D $(KBUILD_EXTMOD)
> +    # KBUILD_EXTMOD might be a relative path. Remember its absolute path
> before
> +    # Make changes the working directory.
> +    srcroot :=3D $(realpath $(KBUILD_EXTMOD))
> +    $(if $(srcroot),,$(error specified external module directory
> "$(KBUILD_EXTMOD)" does not exist))
> +else
> +    objtree :=3D .
> +    output :=3D $(KBUILD_OUTPUT)
> +endif
> +
> +export objtree srcroot
>
>  # Do we want to change the working directory?
>  ifneq ($(output),)
> @@ -230,35 +247,33 @@ else # need-sub-make
>
>  # We process the rest of the Makefile if this is the final invocation of
> make
>
> -ifeq ($(abs_srctree),$(CURDIR))
> -        # building in the source tree
> -        srctree :=3D .
> -       building_out_of_srctree :=3D
> +ifndef KBUILD_EXTMOD
> +srcroot :=3D $(abs_srctree)
> +endif
> +
> +ifeq ($(srcroot),$(CURDIR))
> +building_out_of_srctree :=3D
>  else
> -        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
> -                # building in a subdirectory of the source tree
> -                srctree :=3D ..
> -        else
> -                srctree :=3D $(abs_srctree)
> -        endif
> -       building_out_of_srctree :=3D 1
> +export building_out_of_srctree :=3D1
>  endif
>
> -ifneq ($(KBUILD_ABS_SRCTREE),)
> -srctree :=3D $(abs_srctree)
> +ifdef KBUILD_ABS_SRCTREE
> +    # Do not nothing. Use the absolute path.
> +else ifeq ($(srcroot),$(CURDIR))
> +    # Building in the source.
> +    srcroot :=3D .
> +else ifeq ($(srcroot)/,$(dir $(CURDIR)))
> +    # Building in a subdirectory of the source.
> +    srcroot :=3D ..
>  endif
>
> -objtree                :=3D .
> +export srctree :=3D $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
>
> -VPATH          :=3D
> -
> -ifeq ($(KBUILD_EXTMOD),)
>  ifdef building_out_of_srctree
> -VPATH          :=3D $(srctree)
> +export VPATH :=3D $(srcroot)
> +else
> +VPATH :=3D
>  endif
> -endif
> -
> -export building_out_of_srctree srctree objtree VPATH
>
>  # To make sure we do not include .config for any of the *config targets
>  # catch them early, and hand them over to scripts/kconfig/Makefile
> @@ -711,7 +726,7 @@ endif
>  # in addition to whatever we do anyway.
>  # Just "make" or "make all" shall build modules as well
>
> -ifneq ($(filter all modules nsdeps %compile_commands.json
> clang-%,$(MAKECMDGOALS)),)
> +ifneq ($(filter all modules nsdeps compile_commands.json
> clang-%,$(MAKECMDGOALS)),)
>    KBUILD_MODULES :=3D 1
>  endif
>
> @@ -1107,7 +1122,7 @@ export MODLIB
>
>  PHONY +=3D prepare0
>
> -export extmod_prefix =3D $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/)
> +export extmod_prefix =3D
>  export MODORDER :=3D $(extmod_prefix)modules.order
>  export MODULES_NSDEPS :=3D $(extmod_prefix)modules.nsdeps
>
> @@ -1799,14 +1814,10 @@ filechk_kernel.release =3D echo $(KERNELRELEASE)
>  KBUILD_BUILTIN :=3D
>  KBUILD_MODULES :=3D 1
>
> -build-dir :=3D $(KBUILD_EXTMOD)
> +build-dir :=3D .
>
> -compile_commands.json: $(extmod_prefix)compile_commands.json
> -PHONY +=3D compile_commands.json
> -
> -clean-dirs :=3D $(KBUILD_EXTMOD)
> -clean: private rm-files :=3D $(KBUILD_EXTMOD)/Module.symvers
> $(KBUILD_EXTMOD)/modules.nsdeps \
> -       $(KBUILD_EXTMOD)/compile_commands.json
> +clean-dirs :=3D .
> +clean: private rm-files :=3D Module.symvers modules.nsdeps
> compile_commands.json
>
>  PHONY +=3D prepare
>  # now expand this into a simple variable to reduce the cost of shell
> evaluations
> @@ -1948,7 +1959,7 @@ $(clean-dirs):
>
>  clean: $(clean-dirs)
>         $(call cmd,rmfiles)
> -       @find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
> +       @find . $(RCS_FIND_IGNORE) \
>                 \( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o
> -name '.*.cmd' \
>                 -o -name '*.ko.*' \
>                 -o -name '*.dtb' -o -name '*.dtbo' \
> @@ -1981,7 +1992,12 @@ tags TAGS cscope gtags: FORCE
>  PHONY +=3D rust-analyzer
>  rust-analyzer:
>         +$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
> +ifdef KBUILD_EXTMOD
> +# FIXME: external modules must not descend into a sub-directory of the
> kernel
> +       $(Q)$(MAKE) $(build)=3D$(objtree)/rust src=3D$(srctree)/rust $@
> +else
>         $(Q)$(MAKE) $(build)=3Drust $@
> +endif
>
>  # Script to generate missing namespace dependencies
>  #
> -------------------------------------------------------------------------=
--
> diff --git a/rust/Makefile b/rust/Makefile
> index b5e0a73b78f3..742740816c4b 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -362,8 +362,8 @@ rust-analyzer:
>         $(Q)$(srctree)/scripts/generate_rust_analyzer.py \
>                 --cfgs=3D'core=3D$(core-cfgs)' --cfgs=3D'alloc=3D$(alloc-=
cfgs)' \
>                 $(realpath $(srctree)) $(realpath $(objtree)) \
> -               $(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
> -               $(if
> $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
> +               $(rustc_sysroot) $(RUST_LIB_SRC) $(if
> $(KBUILD_EXTMOD),$(srcroot)) \
> +               > rust-project.json
>
>  redirect-intrinsics =3D \
>         __addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3
> __nesf2 __truncdfsf2 __unordsf2 \
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 64cd046f8fd8..1aa928a6fb4f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -3,7 +3,7 @@
>  # Building
>  #
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -src :=3D $(if $(VPATH),$(VPATH)/)$(obj)
> +src :=3D $(srcroot)/$(obj)
>
>  PHONY :=3D $(obj)/
>  $(obj)/:
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index 4fcfab40ed61..6ead00ec7313 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -3,7 +3,7 @@
>  # Cleaning up
>  #
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -src :=3D $(if $(VPATH),$(VPATH)/)$(obj)
> +src :=3D $(srcroot)/$(obj)
>
>  PHONY :=3D __clean
>  __clean:
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index e0842496d26e..8c1029687e2e 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -13,7 +13,7 @@ cc-cross-prefix =3D $(firstword $(foreach c, $(1), \
>                         $(if $(shell command -v -- $(c)gcc 2>/dev/null),
> $(c))))
>
>  # output directory for tests below
> -TMPOUT =3D $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$=
$
> +TMPOUT =3D .tmp_$$$$
>
>  # try-run
>  # Usage: option =3D $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwi=
se)
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 12e7c15d099c..78d2ca4f25f5 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -111,13 +111,13 @@ endif
>  else
>
>  # set src + obj - they may be used in the modules's Makefile
> -obj :=3D $(KBUILD_EXTMOD)
> -src :=3D $(if $(VPATH),$(VPATH)/)$(obj)
> +obj :=3D .
> +src :=3D $(srcroot)
>
>  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
>  include $(kbuild-file)
>
> -output-symdump :=3D $(KBUILD_EXTMOD)/Module.symvers
> +output-symdump :=3D Module.symvers
>
>  ifeq ($(wildcard $(objtree)/Module.symvers),)
>  missing-input :=3D $(objtree)/Module.symvers
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e52cb43fede6..0e6bc5a10320 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -80,11 +80,7 @@ command results in a shift count error.'
>      NPROC=3D1
>  else
>      ONLINE=3D0
> -    if [ "$KBUILD_EXTMOD" =3D "" ] ; then
> -        OPTIONS=3D"--dir $srctree $COCCIINCLUDE"
> -    else
> -        OPTIONS=3D"--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> -    fi
> +    OPTIONS=3D"--dir $srcroot $COCCIINCLUDE"
>
>      # Use only one thread per core by default if hyperthreading is enabl=
ed
>      THREADS_PER_CORE=3D$(LANG=3DC lscpu | grep "Thread(s) per core: " | =
tr
> -cd "[:digit:]")
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index f1718cc0d700..8ca12e2b5c03 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -19,12 +19,6 @@ if ! { echo "$SPATCH_REQ_VERSION"; echo
> "$SPATCH_VERSION"; } | sort -CV ; then
>         exit 1
>  fi
>
> -if [ "$KBUILD_EXTMOD" ]; then
> -       src_prefix=3D
> -else
> -       src_prefix=3D$srctree/
> -fi
> -
>  generate_deps_for_ns() {
>         $SPATCH --very-quiet --in-place --sp-file \
>                 $srctree/scripts/coccinelle/misc/add_namespace.cocci -D
> nsdeps -D ns=3D$1 $2
> @@ -34,7 +28,7 @@ generate_deps() {
>         local mod=3D${1%.ko:}
>         shift
>         local namespaces=3D"$*"
> -       local mod_source_files=3D$(sed "s|^\(.*\)\.o$|${src_prefix}\1.c|"
> $mod.mod)
> +       local mod_source_files=3D$(sed "s|^\(.*\)\.o$|${srcroot}/\1.c|"
> $mod.mod)
>
>         for ns in $namespaces; do
>                 echo "Adding namespace $ns to module $mod.ko."
> diff --git a/scripts/package/install-extmod-build
> b/scripts/package/install-extmod-build
> index 7ec1f061a519..64d958ee45f3 100755
> --- a/scripts/package/install-extmod-build
> +++ b/scripts/package/install-extmod-build
> @@ -51,6 +51,13 @@ mkdir -p "${destdir}"
>  if [ "${CC}" !=3D "${HOSTCC}" ]; then
>         echo "Rebuilding host programs with ${CC}..."
>
> +       # This leverages external module building.
> +       # - Clear sub_make_done to allow the top-level Makefile to redo
> sub-make.
> +       # - Filter out --no-print-directory to print "Entering directory"
> logs
> +       #   when Make changes the working directory.
> +       unset sub_make_done
> +       MAKEFLAGS=3D$(echo "${MAKEFLAGS}" | sed s/--no-print-directory//)
> +
>         cat <<-'EOF' >  "${destdir}/Kbuild"
>         subdir-y :=3D scripts
>         EOF
> --
> 2.43.0
>
>

--0000000000003612a106287c5adc
Content-Type: text/vnd.google.email-reaction+json; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

{
  "emoji": "=F0=9F=98=8A",
  "version": 1
}
--0000000000003612a106287c5adc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><p style=3D"font-size:50px;margin-top:0;margin-bottom:0">=F0=9F=98=8A<=
/p><p style=3D"margin-top:10px;margin-bottom:0">Masahiro =E3=81=95=E3=82=93=
=E3=81=8C <a style=3D"color:unset;text-decoration:underline" href=3D"https:=
//www.google.com/gmail/about/?utm_source=3Dgmail-in-product&amp;utm_medium=
=3Det&amp;utm_campaign=3Demojireactionemail#app">Gmail</a> =E3=81=A7=E3=83=
=AA=E3=82=A2=E3=82=AF=E3=82=B7=E3=83=A7=E3=83=B3=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F</p></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">2024=E5=B9=B411=E6=9C=8810=E6=97=A5(=E6=97=A5) 10:37 Masahiro =
Yamada &lt;<a href=3D"mailto:masahiroy@kernel.org">masahiroy@kernel.org</a>=
&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">Currently, Kbuild always oper=
ates in the output directory of the kernel,<br>
even when building external modules. This increases the risk of external<br=
>
module Makefiles attempting to write to the kernel directory.<br>
<br>
This commit switches the working directory to the external module<br>
directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from<br>
some build artifacts.<br>
<br>
The command for building external modules maintains backward<br>
compatibility, but Makefiles that rely on working in the kernel<br>
directory may break. In such cases, $(objtree) and $(srctree) should<br>
be used to refer to the output and source directories of the kernel.<br>
<br>
The appearance of the build log will change as follows:<br>
<br>
[Before]<br>
<br>
=C2=A0 $ make -C /path/to/my/linux M=3D/path/to/my/externel/module<br>
=C2=A0 make: Entering directory &#39;/path/to/my/linux&#39;<br>
=C2=A0 =C2=A0 CC [M]=C2=A0 /path/to/my/externel/module/helloworld.o<br>
=C2=A0 =C2=A0 MODPOST /path/to/my/externel/module/Module.symvers<br>
=C2=A0 =C2=A0 CC [M]=C2=A0 /path/to/my/externel/module/helloworld.mod.o<br>
=C2=A0 =C2=A0 CC [M]=C2=A0 /path/to/my/externel/module/.module-common.o<br>
=C2=A0 =C2=A0 LD [M]=C2=A0 /path/to/my/externel/module/helloworld.ko<br>
=C2=A0 make: Leaving directory &#39;/path/to/my/linux&#39;<br>
<br>
[After]<br>
<br>
=C2=A0 $ make -C /path/to/my/linux M=3D/path/to/my/externel/module<br>
=C2=A0 make: Entering directory &#39;/path/to/my/linux&#39;<br>
=C2=A0 make[1]: Entering directory &#39;/path/to/my/externel/module&#39;<br=
>
=C2=A0 =C2=A0 CC [M]=C2=A0 helloworld.o<br>
=C2=A0 =C2=A0 MODPOST Module.symvers<br>
=C2=A0 =C2=A0 CC [M]=C2=A0 helloworld.mod.o<br>
=C2=A0 =C2=A0 CC [M]=C2=A0 .module-common.o<br>
=C2=A0 =C2=A0 LD [M]=C2=A0 helloworld.ko<br>
=C2=A0 make[1]: Leaving directory &#39;/path/to/my/externel/module&#39;<br>
=C2=A0 make: Leaving directory &#39;/path/to/my/linux&#39;<br>
<br>
Printing &quot;Entering directory&quot; twice is cumbersome. This will be<b=
r>
addressed later.<br>
<br>
Signed-off-by: Masahiro Yamada &lt;<a href=3D"mailto:masahiroy@kernel.org" =
target=3D"_blank" rel=3D"noreferrer">masahiroy@kernel.org</a>&gt;<br>
---<br>
<br>
Changes in v2:<br>
=C2=A0- Introduce a new &#39;srcroot&#39; variable and clean-up code<br>
=C2=A0- Reword Documentation/dev-tools/coccinelle.rst<br>
<br>
=C2=A0Documentation/dev-tools/coccinelle.rst | 20 ++-----<br>
=C2=A0Documentation/kbuild/makefiles.rst=C2=A0 =C2=A0 =C2=A0| 14 +++++<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 80 +++++++++++++++---=
--------<br>
=C2=A0rust/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +-<br>
=C2=A0scripts/Makefile.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0scripts/Makefile.clean=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0scripts/Makefile.compiler=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A0scripts/Makefile.modpost=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 +-<br>
=C2=A0scripts/coccicheck=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +-<br>
=C2=A0scripts/nsdeps=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +--<br>
=C2=A0scripts/package/install-extmod-build=C2=A0 =C2=A0|=C2=A0 7 +++<br>
=C2=A011 files changed, 85 insertions(+), 66 deletions(-)<br>
<br>
diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-too=
ls/coccinelle.rst<br>
index 535ce126fb4f..6e70a1e9a3c0 100644<br>
--- a/Documentation/dev-tools/coccinelle.rst<br>
+++ b/Documentation/dev-tools/coccinelle.rst<br>
@@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:<br>
=C2=A0- Your directory from which spatch is called is processed next<br>
=C2=A0- The directory provided with the ``--dir`` option is processed last,=
 if used<br>
<br>
-Since coccicheck runs through make, it naturally runs from the kernel<br>
-proper dir; as such the second rule above would be implied for picking up =
a<br>
-.cocciconfig when using ``make coccicheck``.<br>
-<br>
=C2=A0``make coccicheck`` also supports using M=3D targets. If you do not s=
upply<br>
=C2=A0any M=3D target, it is assumed you want to target the entire kernel.<=
br>
=C2=A0The kernel coccicheck script has::<br>
<br>
-=C2=A0 =C2=A0 if [ &quot;$KBUILD_EXTMOD&quot; =3D &quot;&quot; ] ; then<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 OPTIONS=3D&quot;--dir $srctree $COCCIINCLUDE&q=
uot;<br>
-=C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 OPTIONS=3D&quot;--dir $KBUILD_EXTMOD $COCCIINC=
LUDE&quot;<br>
-=C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 OPTIONS=3D&quot;--dir $srcroot $COCCIINCLUDE&quot;<br>
<br>
-KBUILD_EXTMOD is set when an explicit target with M=3D is used. For both c=
ases<br>
-the spatch ``--dir`` argument is used, as such third rule applies when whe=
ther<br>
-M=3D is used or not, and when M=3D is used the target directory can have i=
ts own<br>
-.cocciconfig file. When M=3D is not passed as an argument to coccicheck th=
e<br>
-target directory is the same as the directory from where spatch was called=
.<br>
+Here, $srcroot refers to the source directory of the target: it points to =
the<br>
+external module&#39;s source directory when M=3D used, and otherwise, to t=
he kernel<br>
+source directory. The third rule ensures the spatch reads the .cocciconfig=
 from<br>
+the target directory, allowing external modules to have their own .coccico=
nfig<br>
+file.<br>
<br>
=C2=A0If not using the kernel&#39;s coccicheck target, keep the above prece=
dence<br>
=C2=A0order logic of .cocciconfig reading. If using the kernel&#39;s coccic=
heck target,<br>
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/make=
files.rst<br>
index 7964e0c245ae..d36519f194dc 100644<br>
--- a/Documentation/kbuild/makefiles.rst<br>
+++ b/Documentation/kbuild/makefiles.rst<br>
@@ -449,6 +449,20 @@ $(obj)<br>
=C2=A0 =C2=A0to prerequisites are referenced with $(src) (because they are =
not<br>
=C2=A0 =C2=A0generated files).<br>
<br>
+$(srcroot)<br>
+=C2=A0 $(srcroot) refers to the root of the source you are building, which=
 can be<br>
+=C2=A0 either the kernel source or the external modules source, depending =
on whether<br>
+=C2=A0 KBUILD_EXTMOD is set. This can be either a relative or an absolute =
path, but<br>
+=C2=A0 if KBUILD_ABS_SRCTREE=3D1 is set, it is always an absolute path.<br=
>
+<br>
+$(srctree)<br>
+=C2=A0 $(srctree) refers to the root of the kernel source tree. When build=
ing the<br>
+=C2=A0 kernel, this is the same as $(srcroot).<br>
+<br>
+$(objtree)<br>
+=C2=A0 $(objtree) refers to the root of the kernel object tree. It is ``.`=
` when<br>
+=C2=A0 building the kernel, but it is different when building external mod=
ules.<br>
+<br>
=C2=A0$(kecho)<br>
=C2=A0 =C2=A0echoing information to user in a rule is often a good practice=
<br>
=C2=A0 =C2=A0but when execution ``make -s`` one does not expect to see any =
output<br>
diff --git a/Makefile b/Makefile<br>
index cf1d55560ae2..e5f7ac7647a7 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -180,7 +180,24 @@ ifeq (&quot;$(origin O)&quot;, &quot;command line&quot=
;)<br>
=C2=A0 =C2=A0KBUILD_OUTPUT :=3D $(O)<br>
=C2=A0endif<br>
<br>
-output :=3D $(KBUILD_OUTPUT)<br>
+ifdef KBUILD_EXTMOD<br>
+=C2=A0 =C2=A0 ifdef KBUILD_OUTPUT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 objtree :=3D $(realpath $(KBUILD_OUTPUT))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(if $(objtree),,$(error specified kernel dire=
ctory &quot;$(KBUILD_OUTPUT)&quot; does not exist))<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 objtree :=3D $(CURDIR)<br>
+=C2=A0 =C2=A0 endif<br>
+=C2=A0 =C2=A0 output :=3D $(KBUILD_EXTMOD)<br>
+=C2=A0 =C2=A0 # KBUILD_EXTMOD might be a relative path. Remember its absol=
ute path before<br>
+=C2=A0 =C2=A0 # Make changes the working directory.<br>
+=C2=A0 =C2=A0 srcroot :=3D $(realpath $(KBUILD_EXTMOD))<br>
+=C2=A0 =C2=A0 $(if $(srcroot),,$(error specified external module directory=
 &quot;$(KBUILD_EXTMOD)&quot; does not exist))<br>
+else<br>
+=C2=A0 =C2=A0 objtree :=3D .<br>
+=C2=A0 =C2=A0 output :=3D $(KBUILD_OUTPUT)<br>
+endif<br>
+<br>
+export objtree srcroot<br>
<br>
=C2=A0# Do we want to change the working directory?<br>
=C2=A0ifneq ($(output),)<br>
@@ -230,35 +247,33 @@ else # need-sub-make<br>
<br>
=C2=A0# We process the rest of the Makefile if this is the final invocation=
 of make<br>
<br>
-ifeq ($(abs_srctree),$(CURDIR))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # building in the source tree<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 srctree :=3D .<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0building_out_of_srctree :=3D<br>
+ifndef KBUILD_EXTMOD<br>
+srcroot :=3D $(abs_srctree)<br>
+endif<br>
+<br>
+ifeq ($(srcroot),$(CURDIR))<br>
+building_out_of_srctree :=3D<br>
=C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ifeq ($(abs_srctree)/,$(dir $(CURDIR)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # building in a su=
bdirectory of the source tree<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 srctree :=3D ..<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 srctree :=3D $(abs=
_srctree)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0building_out_of_srctree :=3D 1<br>
+export building_out_of_srctree :=3D1<br>
=C2=A0endif<br>
<br>
-ifneq ($(KBUILD_ABS_SRCTREE),)<br>
-srctree :=3D $(abs_srctree)<br>
+ifdef KBUILD_ABS_SRCTREE<br>
+=C2=A0 =C2=A0 # Do not nothing. Use the absolute path.<br>
+else ifeq ($(srcroot),$(CURDIR))<br>
+=C2=A0 =C2=A0 # Building in the source.<br>
+=C2=A0 =C2=A0 srcroot :=3D .<br>
+else ifeq ($(srcroot)/,$(dir $(CURDIR)))<br>
+=C2=A0 =C2=A0 # Building in a subdirectory of the source.<br>
+=C2=A0 =C2=A0 srcroot :=3D ..<br>
=C2=A0endif<br>
<br>
-objtree=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D .<br>
+export srctree :=3D $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))<br>
<br>
-VPATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D<br>
-<br>
-ifeq ($(KBUILD_EXTMOD),)<br>
=C2=A0ifdef building_out_of_srctree<br>
-VPATH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D $(srctree)<br>
+export VPATH :=3D $(srcroot)<br>
+else<br>
+VPATH :=3D<br>
=C2=A0endif<br>
-endif<br>
-<br>
-export building_out_of_srctree srctree objtree VPATH<br>
<br>
=C2=A0# To make sure we do not include .config for any of the *config targe=
ts<br>
=C2=A0# catch them early, and hand them over to scripts/kconfig/Makefile<br=
>
@@ -711,7 +726,7 @@ endif<br>
=C2=A0# in addition to whatever we do anyway.<br>
=C2=A0# Just &quot;make&quot; or &quot;make all&quot; shall build modules a=
s well<br>
<br>
-ifneq ($(filter all modules nsdeps %compile_commands.json clang-%,$(MAKECM=
DGOALS)),)<br>
+ifneq ($(filter all modules nsdeps compile_commands.json clang-%,$(MAKECMD=
GOALS)),)<br>
=C2=A0 =C2=A0KBUILD_MODULES :=3D 1<br>
=C2=A0endif<br>
<br>
@@ -1107,7 +1122,7 @@ export MODLIB<br>
<br>
=C2=A0PHONY +=3D prepare0<br>
<br>
-export extmod_prefix =3D $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/)<br>
+export extmod_prefix =3D<br>
=C2=A0export MODORDER :=3D $(extmod_prefix)modules.order<br>
=C2=A0export MODULES_NSDEPS :=3D $(extmod_prefix)modules.nsdeps<br>
<br>
@@ -1799,14 +1814,10 @@ filechk_kernel.release =3D echo $(KERNELRELEASE)<br=
>
=C2=A0KBUILD_BUILTIN :=3D<br>
=C2=A0KBUILD_MODULES :=3D 1<br>
<br>
-build-dir :=3D $(KBUILD_EXTMOD)<br>
+build-dir :=3D .<br>
<br>
-compile_commands.json: $(extmod_prefix)compile_commands.json<br>
-PHONY +=3D compile_commands.json<br>
-<br>
-clean-dirs :=3D $(KBUILD_EXTMOD)<br>
-clean: private rm-files :=3D $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTM=
OD)/modules.nsdeps \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(KBUILD_EXTMOD)/compile_commands.json<br>
+clean-dirs :=3D .<br>
+clean: private rm-files :=3D Module.symvers modules.nsdeps compile_command=
s.json<br>
<br>
=C2=A0PHONY +=3D prepare<br>
=C2=A0# now expand this into a simple variable to reduce the cost of shell =
evaluations<br>
@@ -1948,7 +1959,7 @@ $(clean-dirs):<br>
<br>
=C2=A0clean: $(clean-dirs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(call cmd,rmfiles)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNO=
RE) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0@find . $(RCS_FIND_IGNORE) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \( -name &#39;*.[ai=
os]&#39; -o -name &#39;*.rsi&#39; -o -name &#39;*.ko&#39; -o -name &#39;.*.=
cmd&#39; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o -name &#39;*.ko.=
*&#39; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o -name &#39;*.dtb=
&#39; -o -name &#39;*.dtbo&#39; \<br>
@@ -1981,7 +1992,12 @@ tags TAGS cscope gtags: FORCE<br>
=C2=A0PHONY +=3D rust-analyzer<br>
=C2=A0rust-analyzer:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is=
_available.sh<br>
+ifdef KBUILD_EXTMOD<br>
+# FIXME: external modules must not descend into a sub-directory of the ker=
nel<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(Q)$(MAKE) $(build)=3D$(objtree)/rust src=3D$(=
srctree)/rust $@<br>
+else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(Q)$(MAKE) $(build)=3Drust $@<br>
+endif<br>
<br>
=C2=A0# Script to generate missing namespace dependencies<br>
=C2=A0# -------------------------------------------------------------------=
--------<br>
diff --git a/rust/Makefile b/rust/Makefile<br>
index b5e0a73b78f3..742740816c4b 100644<br>
--- a/rust/Makefile<br>
+++ b/rust/Makefile<br>
@@ -362,8 +362,8 @@ rust-analyzer:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(Q)$(srctree)/scripts/generate_rust_analyzer.p=
y \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --cfgs=3D&#39;core=
=3D$(core-cfgs)&#39; --cfgs=3D&#39;alloc=3D$(alloc-cfgs)&#39; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(realpath $(srctre=
e)) $(realpath $(objtree)) \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(rustc_sysroot) $(=
RUST_LIB_SRC) $(KBUILD_EXTMOD) &gt; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(if $(KBUILD_EXTMO=
D),$(extmod_prefix),$(objtree))/rust-project.json<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(rustc_sysroot) $(=
RUST_LIB_SRC) $(if $(KBUILD_EXTMOD),$(srcroot)) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; rust-project.j=
son<br>
<br>
=C2=A0redirect-intrinsics =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 =
__ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 \<br>
diff --git a/scripts/Makefile.build b/scripts/Makefile.build<br>
index 64cd046f8fd8..1aa928a6fb4f 100644<br>
--- a/scripts/Makefile.build<br>
+++ b/scripts/Makefile.build<br>
@@ -3,7 +3,7 @@<br>
=C2=A0# Building<br>
=C2=A0# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
<br>
-src :=3D $(if $(VPATH),$(VPATH)/)$(obj)<br>
+src :=3D $(srcroot)/$(obj)<br>
<br>
=C2=A0PHONY :=3D $(obj)/<br>
=C2=A0$(obj)/:<br>
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean<br>
index 4fcfab40ed61..6ead00ec7313 100644<br>
--- a/scripts/Makefile.clean<br>
+++ b/scripts/Makefile.clean<br>
@@ -3,7 +3,7 @@<br>
=C2=A0# Cleaning up<br>
=C2=A0# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
<br>
-src :=3D $(if $(VPATH),$(VPATH)/)$(obj)<br>
+src :=3D $(srcroot)/$(obj)<br>
<br>
=C2=A0PHONY :=3D __clean<br>
=C2=A0__clean:<br>
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler<br>
index e0842496d26e..8c1029687e2e 100644<br>
--- a/scripts/Makefile.compiler<br>
+++ b/scripts/Makefile.compiler<br>
@@ -13,7 +13,7 @@ cc-cross-prefix =3D $(firstword $(foreach c, $(1), \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 $(if $(shell command -v -- $(c)gcc 2&gt;/dev/null), $(c))))<br>
<br>
=C2=A0# output directory for tests below<br>
-TMPOUT =3D $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$<=
br>
+TMPOUT =3D .tmp_$$$$<br>
<br>
=C2=A0# try-run<br>
=C2=A0# Usage: option =3D $(call try-run, $(CC)...-o &quot;$$TMP&quot;,opti=
on-ok,otherwise)<br>
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost<br>
index 12e7c15d099c..78d2ca4f25f5 100644<br>
--- a/scripts/Makefile.modpost<br>
+++ b/scripts/Makefile.modpost<br>
@@ -111,13 +111,13 @@ endif<br>
=C2=A0else<br>
<br>
=C2=A0# set src + obj - they may be used in the modules&#39;s Makefile<br>
-obj :=3D $(KBUILD_EXTMOD)<br>
-src :=3D $(if $(VPATH),$(VPATH)/)$(obj)<br>
+obj :=3D .<br>
+src :=3D $(srcroot)<br>
<br>
=C2=A0# Include the module&#39;s Makefile to find KBUILD_EXTRA_SYMBOLS<br>
=C2=A0include $(kbuild-file)<br>
<br>
-output-symdump :=3D $(KBUILD_EXTMOD)/Module.symvers<br>
+output-symdump :=3D Module.symvers<br>
<br>
=C2=A0ifeq ($(wildcard $(objtree)/Module.symvers),)<br>
=C2=A0missing-input :=3D $(objtree)/Module.symvers<br>
diff --git a/scripts/coccicheck b/scripts/coccicheck<br>
index e52cb43fede6..0e6bc5a10320 100755<br>
--- a/scripts/coccicheck<br>
+++ b/scripts/coccicheck<br>
@@ -80,11 +80,7 @@ command results in a shift count error.&#39;<br>
=C2=A0 =C2=A0 =C2=A0NPROC=3D1<br>
=C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0ONLINE=3D0<br>
-=C2=A0 =C2=A0 if [ &quot;$KBUILD_EXTMOD&quot; =3D &quot;&quot; ] ; then<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 OPTIONS=3D&quot;--dir $srctree $COCCIINCLUDE&q=
uot;<br>
-=C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 OPTIONS=3D&quot;--dir $KBUILD_EXTMOD $COCCIINC=
LUDE&quot;<br>
-=C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 OPTIONS=3D&quot;--dir $srcroot $COCCIINCLUDE&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Use only one thread per core by default if hyperthrea=
ding is enabled<br>
=C2=A0 =C2=A0 =C2=A0THREADS_PER_CORE=3D$(LANG=3DC lscpu | grep &quot;Thread=
(s) per core: &quot; | tr -cd &quot;[:digit:]&quot;)<br>
diff --git a/scripts/nsdeps b/scripts/nsdeps<br>
index f1718cc0d700..8ca12e2b5c03 100644<br>
--- a/scripts/nsdeps<br>
+++ b/scripts/nsdeps<br>
@@ -19,12 +19,6 @@ if ! { echo &quot;$SPATCH_REQ_VERSION&quot;; echo &quot;=
$SPATCH_VERSION&quot;; } | sort -CV ; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
=C2=A0fi<br>
<br>
-if [ &quot;$KBUILD_EXTMOD&quot; ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src_prefix=3D<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src_prefix=3D$srctree/<br>
-fi<br>
-<br>
=C2=A0generate_deps_for_ns() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $SPATCH --very-quiet --in-place --sp-file \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $srctree/scripts/co=
ccinelle/misc/add_namespace.cocci -D nsdeps -D ns=3D$1 $2<br>
@@ -34,7 +28,7 @@ generate_deps() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local mod=3D${1%.ko:}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 shift<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local namespaces=3D&quot;$*&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0local mod_source_files=3D$(sed &quot;s|^\(.*\)\=
.o$|${src_prefix}\1.c|&quot; $mod.mod)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local mod_source_files=3D$(sed &quot;s|^\(.*\)\=
.o$|${srcroot}/\1.c|&quot; $mod.mod)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for ns in $namespaces; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Adding n=
amespace $ns to module $mod.ko.&quot;<br>
diff --git a/scripts/package/install-extmod-build b/scripts/package/install=
-extmod-build<br>
index 7ec1f061a519..64d958ee45f3 100755<br>
--- a/scripts/package/install-extmod-build<br>
+++ b/scripts/package/install-extmod-build<br>
@@ -51,6 +51,13 @@ mkdir -p &quot;${destdir}&quot;<br>
=C2=A0if [ &quot;${CC}&quot; !=3D &quot;${HOSTCC}&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Rebuilding host programs with ${CC}.=
..&quot;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# This leverages external module building.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# - Clear sub_make_done to allow the top-level =
Makefile to redo sub-make.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# - Filter out --no-print-directory to print &q=
uot;Entering directory&quot; logs<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0when Make changes the working dir=
ectory.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unset sub_make_done<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0MAKEFLAGS=3D$(echo &quot;${MAKEFLAGS}&quot; | s=
ed s/--no-print-directory//)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cat &lt;&lt;-&#39;EOF&#39; &gt;=C2=A0 &quot;${d=
estdir}/Kbuild&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 subdir-y :=3D scripts<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EOF<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000003612a106287c5adc--
