Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89496E7716F
	for <cocci@archiver.kernel.org>; Thu,  5 Dec 2024 02:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nLKoeDqXCe0wuEpwUR5jK9ONZ4rjRC0hbaLbE7G3fv0=;
  b=qLmWjTM1cpecwKQFijR5JYEm0AL6WpuRSdoXwG2x/Kg4YsqN9fi6RwdA
   EfmtE1MRZMeyYfZ0dfbXGsHD3ljs8SME7cb3cYVCwC4O62xptUN33iRUQ
   mqiE7FgyKvQensUpZLxR5oKjgppSjOmsG8CaRXCkqNRA011E/NetDtnPC
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
   d="scan'208";a="197436733"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2024 03:48:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1941E0133; Thu,  5 Dec 2024 03:48:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 776F0E00B6
	for <cocci@sympa.inria.fr>; Thu,  5 Dec 2024 03:48:48 +0100 (CET)
IronPort-SDR: 6751148f_MUDlSO74V69Ud2rL6EpifBRWqtQlQ/MofTIXyLWRGLb2A+V
 QOXB7ESLpcCw7v14+J/AX+h4Vg577cKqZOI6F2g==
X-IPAS-Result: =?us-ascii?q?A0HwAQDvE1FnhVvBS5NagQmBU4JEgVczBAtIhFaIfIZRg?=
 =?us-ascii?q?iEDgROdBYF+DwEDAQ1EBAEBAwSFAAKKagIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINfgEBAQMjHQEBNwEPCwsNAgImAgIhEwUdBhODAYJlA7EmgTKBAYIMA?=
 =?us-ascii?q?QEG3B+BZAmBGi6Fa4JjAYFsg3+DfXonG4FJRIEVNYFzSjg+hEMVg0aCaYEUg?=
 =?us-ascii?q?S9ngzVkEiWFNoNKlBeIMyYJHQMHBw4NHkkPBRwDWSERAVUTFwsHBWFJISwBA?=
 =?us-ascii?q?gGCR3+BNoFRAYMQSoMuHIFCBTcKPYJKaUs3Ag0CNoIkfYJNhReBC4EVgklKG?=
 =?us-ascii?q?S8DAwMDgzuGKoFhHUADC2ILPTcUG0yiFUaCdWGBEDCBFiozgQKSPZJGi3STU?=
 =?us-ascii?q?oE+hCSBY597M5dDkw6Ye6kqgWc6gVwzGjB0BoIwTwMZD446H4hWuic0NTwCB?=
 =?us-ascii?q?wEKAQEDCYZIjVaBSwEB?=
IronPort-PHdr: A9a23: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
 RwSzuGgRbk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WaGonKsMx8xyj1ETPnylHEUP7skDidV00zEX/kB9WHVpmwKj5r
 qTdZMgpGPJYVcqKQwdcLW7VZVoLkmskqKdjbNhWYtKGTOW3VdAT7sSjrcKoQeQYhEWn9Q1vc
 wLH5SWSueAb2SS5vyKmDVQfexQu+WvweSGg/zBx2xhQQwvR6Zr9BdhFwqXe3cYeOCEP/QEPa
 vZyM5Opz/lX28WYMS9DnxAe+TYvdXEmNbHTHc9dngaAcW17A9AIYSbLySl
X-Talos-CUID: 9a23:Lowry2O5s8Ugxe5DADZf+UIQFPkeXmTCnF3WERDmOEttR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AjJPGOg1sEnUjUkgPjwYrrHuKcjUj7pWHT2EQgLA?=
 =?us-ascii?q?9nsCFNT5/FT7eoTLra9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208";a="197436730"
X-MGA-submission: =?us-ascii?q?MDEpGvkkSWWSctWslsJ4TOGU3K5gAvD8Nx+Zx9?=
 =?us-ascii?q?sRzF5UAVzD6fV/2mVehf8yYeb8AAL49AMIZOpvkmCKd8uTfJ4b4kwoer?=
 =?us-ascii?q?1MFykumclTpqCvSvyzYedmzcINXAIHLXdR2FPaoyZ9qCzAaciHwq9Qxl?=
 =?us-ascii?q?0w8VBuRyJ+0xqrfZNKqcjvdA=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:48:47 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4BA5AA42066
	for <cocci@inria.fr>; Thu,  5 Dec 2024 02:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1FFC4CECD
	for <cocci@inria.fr>; Thu,  5 Dec 2024 02:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733366926;
	bh=DGF70DZln5IThYnEF4xvE0h/pdv3E5Nk+vHPdXkKDoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rftoUn15aGFBIRnpVaAVAmjIxPc1EwQ3BMQFjAukWCAx3UVBHpa9OAIC6h7DD6gCp
	 8r/y6Mpg+o8vmanLhEGUwptePJ69vGvd9JMBvbEQ1ZPN456Kqx2oq+9ZxFaOebQI7s
	 kL8vjhNoflVNWSGY4pPohDFu7M5LgRdzv+MWj7iHogn4MZTlOZKtbKj9uSItqCF7Dl
	 9+6W4bXbBF5VJ41yhJqsRPOe2p4TD7OpcD3y0TKxzDmKJFlpRLHxVw2W+Cl71Z+pgf
	 I8L/qSQ8gCX/jB91bX2jKyM2tO7vh3Isk9IkqLSOgboVIIOlPalDuuqgQyLQfkI9nt
	 GPSWBYnes70Lg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e1f673ca8so532047e87.3
        for <cocci@inria.fr>; Wed, 04 Dec 2024 18:48:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgcCBmgC0C2zVfK3c3+bAblCXT7wac8NJTGax14R10PXtZTqzu6mQmY6i/3bvdt+Yu3+g71w==@inria.fr
X-Gm-Message-State: AOJu0YzpCIyHkfIQvt/HEhfgZwPe5XfkAHYvN/gd9WHxYnd5Iqmjw1qd
	mAHg7C+iCj5duQhNKDRvjtCA3nj0m3FnIKdXMi1iIa8w1kqeF994v6JVck6KM7vzN1C31BX4hp4
	19T2rBNEGvjsO5c5l5sNgzW1sT7c=
X-Google-Smtp-Source: AGHT+IFCBAQTSON6KO7eKz9ICddrwpuu6tdofnQ5qKiK3Z8z33N+AkdWTWu4fSDeOy/kXzQjn9HZXL3f2oJE/UZT//g=
X-Received: by 2002:a05:6512:224b:b0:53e:1ead:e33a with SMTP id
 2adb3069b0e04-53e1eade521mr1490930e87.49.1733366924705; Wed, 04 Dec 2024
 18:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20241110013649.34903-1-masahiroy@kernel.org> <20241110013649.34903-6-masahiroy@kernel.org>
 <Z1DnP-GJcfseyrM3@ghost>
In-Reply-To: <Z1DnP-GJcfseyrM3@ghost>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 5 Dec 2024 11:48:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0jmafdi7GAxq58AU-=tuWdVas02q=sQXC4zaOg4JcEA@mail.gmail.com>
Message-ID: <CAK7LNAR0jmafdi7GAxq58AU-=tuWdVas02q=sQXC4zaOg4JcEA@mail.gmail.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2158
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAK7LNAR0jmafdi7GAxq58AU-%3DtuWdVas02q%3DsQXC4zaOg4JcEA%40mail.gmail.com>

On Thu, Dec 5, 2024 at 8:35=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
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
>
> This change has caused O=3D<relative directory> to fail.
>
> For example:
>
> make O=3Dbuild defconfig
> make -j$(nproc) V=3D1 O=3Dbuild bindeb-pkg
>
> outputs:
>
> make ARCH=3Dx86 KERNELRELEASE=3D6.13.0-rc1 KBUILD_BUILD_VERSION=3D3  run-=
command KBUILD_RUN_COMMAND=3D'+$(srctree)/scripts/package/builddeb linux-li=
bc-dev'
> dh_installchangelogs -plinux-image-6.13.0-rc1
> ../scripts/package/builddeb linux-headers-6.13.0-rc1
> dh_compress -plinux-image-6.13.0-rc1
> dh_fixperms -plinux-image-6.13.0-rc1
> dh_gencontrol -plinux-image-6.13.0-rc1 -- -fdebian/image.files
> Rebuilding host programs with x86_64-linux-gnu-gcc...
> make[6]: Entering directory '/scratch/kernels/linux/build'
> /scratch/kernels/linux/Makefile:190: *** specified kernel directory "buil=
d" does not exist.  Stop.
>
> It is stepping into this directory and then trying to find the directory
> it just stepped into so $(realpath $(KBUILD_OUTPUT)) returns an empty
> string.
>
> Using an absolute directory resolves this problem, but I believe it
> shouldn't be necessary.


Agree.

I will apply the following fixup unless I have a better idea.




diff --git a/scripts/package/install-extmod-build
b/scripts/package/install-extmod-build
index 64d958ee45f3..85af1573db31 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -69,7 +69,7 @@ if [ "${CC}" !=3D "${HOSTCC}" ]; then
        #
        # Use the single-target build to avoid the modpost invocation, whic=
h
        # would overwrite Module.symvers.
-       "${MAKE}" HOSTCC=3D"${CC}" KBUILD_EXTMOD=3D"${destdir}" scripts/
+       "${MAKE}" O=3D. HOSTCC=3D"${CC}" KBUILD_EXTMOD=3D"${destdir}" scrip=
ts/

        cat <<-'EOF' >  "${destdir}/scripts/Kbuild"
        subdir-y :=3D basic
@@ -78,7 +78,7 @@ if [ "${CC}" !=3D "${HOSTCC}" ]; then
        EOF

        # Run once again to rebuild scripts/basic/ and scripts/mod/modpost.
-       "${MAKE}" HOSTCC=3D"${CC}" KBUILD_EXTMOD=3D"${destdir}" scripts/
+       "${MAKE}" O=3D. HOSTCC=3D"${CC}" KBUILD_EXTMOD=3D"${destdir}" scrip=
ts/

        rm -f "${destdir}/Kbuild" "${destdir}/scripts/Kbuild"
 fi



--
Best Regards
Masahiro Yamada
