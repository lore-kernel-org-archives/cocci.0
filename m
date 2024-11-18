Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB60D591AD
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tWcOwQCde8EH0FqIwSxzfWmKJIvnhmdodvrAU6+9Gkc=;
  b=pEvRKcSw2FBq2EC8VWqBsIdjOux2lmOlS4/yBFMnd+BpJza+eMJkqLaz
   /ntmjXDYwQ21tjys19eAQI27SOUrSo5D+DtC0I36MRRYPSq0nipXP/mSU
   0DY6ugAprGla2nbdNlSnwQV7Qosz1pFEQXVpuR5DS+S+tPK2NnMgGZF9P
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@avm.de
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194516814"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 241B6E0D47; Mon, 18 Nov 2024 19:54:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E5C7E00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 15:47:46 +0100 (CET)
IronPort-SDR: 673b5391_PpBOnvkHh12CPqDiH0jml7IayS8g6h9myw7Q6d0ncUSaupw
 AaAt9/lnRMtOh9wgKaIP/SBdtNv2ZjPQLMna2xA==
X-IPAS-Result: =?us-ascii?q?A0EPAAA3Ujtnj3j0KtRaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YFxUn1aMwQLSIRWg0+ETl+IcgOSTxwzinmBfg8BAwENMRMEAQEDAQOFAAKKS?=
 =?us-ascii?q?wIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBA?=
 =?us-ascii?q?QE5BUmFQQY0DYJiAYEkgSUBAQEBAQEBAQEBAQEBHQIIYwEBHgEBAQMjHQEBN?=
 =?us-ascii?q?wEPCxgCAiYCAisrBhODAQGCZAQDsSyBMoEBggwBAQaBCNsXgWQJgRouAYhLA?=
 =?us-ascii?q?YVpG4NieieBZESCUIE3OD6IHoJpgkVnU4JfdiVKA4clgQ2Df4hAeB6MNlJ7H?=
 =?us-ascii?q?ANZMgFLCjUMOHEhLAOCR4I1gVKCRoEUgy4cgUIFNwqDCYE0NwINAoJFcx+HZ?=
 =?us-ascii?q?oELg2FnLwMDAwOCI4EZgW2CFx1AA3g9NRQbBqBEAUaDMwF7DgUBGz9sMisbD?=
 =?us-ascii?q?CkGLJJqsxgHgjiBZYwWiF6MakWFSJFzkwCWGIJfo1kmhSiBZzqBXDMaJIM2C?=
 =?us-ascii?q?UYDGQ+MDoITGR+CZIERxXNCNTsCBwsBAQMJkTiBSwEB?=
IronPort-PHdr: A9a23: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
 a1MMT7FQ/RYkb4meW050Gc0VrNGB/saQaAWOXct
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:X52oOKhiXNWcOaC+3KzIpQLoYXBQXjQji2hC6mlwRA09TyVXra
 CTddAgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2+cs1PKZLXDbUQiTXeVfBOnZsl/d8kTFn4Y2uM
 tdmupFebjN5DNB/KXHCWeDcuoI8Z2f7LunjfrTpk0dMXAUV4hQqx5kEQiSD0EzbAQuP+tFKL
 OsotNavDSpZHhSTunTPAh8Y8Hz48TWj5zvfBJDHR415GC1/EmVwY+/CgSC0B8CX3dT0a4vmF
 K16DDE2g==
X-Talos-CUID: 9a23:yhNVrGDOgHkQ/6v6EwBOyXcWGcQJSH2H/kvLD0OxNmU1ZLLAHA==
X-Talos-MUID: 9a23:9KV3aArsBke4nEUsMGAezw94BehR5f2cMh4izsU/6s/dJyFCEQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="101940298"
X-MGA-submission: =?us-ascii?q?MDEQzsV6KoWNgl8ObbjiUJlLBu4dQ2+njTBMv5?=
 =?us-ascii?q?IU8TEA9cBd00iVGLyIFrt19/4aF0d4vcVYoATrO1/XQFypvyVc0sAa28?=
 =?us-ascii?q?HoMEHraXCnryyIhQgDh75u3/tfWMbXLpIDVh7u8y0iz9SdCJeHeoDLKf?=
 =?us-ascii?q?4tufqONbWy2d0YnI0EntGJzA=3D=3D?=
Received: from mail.avm.de ([212.42.244.120])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 15:47:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1731941263; bh=O1VcKtHxNtdxKa3gZCjgb7ogeAv4PN4jwrhly4wJ1VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AoLdfwvDPdlTSCjS5oNEKbT/id9cOOyqz7d1+Psq1s+kfoDomUe+f9SeUBXBQqMjC
	 ap+GpDIznwJr1tj8UHlgXB22n+sUJ4HS4NW5UU7GJG4e4ymk/nNOnbl6Jrcj3lBEmJ
	 uE94HZ9HosCH6FTClcggAtG75RDec+tv9MlAgFOM=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 18 Nov 2024 15:47:43 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id D3F5D80905;
	Mon, 18 Nov 2024 15:47:43 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id C790718CA1A; Mon, 18 Nov 2024 15:47:43 +0100 (CET)
Date: Mon, 18 Nov 2024 15:47:43 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, cocci@inria.fr,
	Nicolas Schier <nicolas@fjasle.eu>
Message-ID: <20241118-dazzling-gifted-bettong-133eb7@buildd>
References: <20241110013649.34903-1-masahiroy@kernel.org>
 <20241110013649.34903-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241110013649.34903-6-masahiroy@kernel.org>
X-purgate-ID: 149429::1731941263-6E2E1E9C-5DA14DCE/0/0
X-purgate-type: clean
X-purgate-size: 9472
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Nicolas Schier <n.schier@avm.de>
X-Loop: cocci@inria.fr
X-Sequence: 2082
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241118-dazzling-gifted-bettong-133eb7%40buildd>

On Sun, Nov 10, 2024 at 10:34:33AM +0900, Masahiro Yamada wrote:
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
>   $ make -C /path/to/my/linux M=/path/to/my/externel/module
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
>   $ make -C /path/to/my/linux M=/path/to/my/externel/module
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
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 535ce126fb4f..6e70a1e9a3c0 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:
>  - Your directory from which spatch is called is processed next
>  - The directory provided with the ``--dir`` option is processed last, if used
>  
> -Since coccicheck runs through make, it naturally runs from the kernel
> -proper dir; as such the second rule above would be implied for picking up a
> -.cocciconfig when using ``make coccicheck``.
> -
>  ``make coccicheck`` also supports using M= targets. If you do not supply
>  any M= target, it is assumed you want to target the entire kernel.
>  The kernel coccicheck script has::
>  
> -    if [ "$KBUILD_EXTMOD" = "" ] ; then
> -        OPTIONS="--dir $srctree $COCCIINCLUDE"
> -    else
> -        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> -    fi
> +    OPTIONS="--dir $srcroot $COCCIINCLUDE"
>  
> -KBUILD_EXTMOD is set when an explicit target with M= is used. For both cases
> -the spatch ``--dir`` argument is used, as such third rule applies when whether
> -M= is used or not, and when M= is used the target directory can have its own
> -.cocciconfig file. When M= is not passed as an argument to coccicheck the
> -target directory is the same as the directory from where spatch was called.
> +Here, $srcroot refers to the source directory of the target: it points to the
> +external module's source directory when M= used, and otherwise, to the kernel
> +source directory. The third rule ensures the spatch reads the .cocciconfig from
> +the target directory, allowing external modules to have their own .cocciconfig
> +file.
>  
>  If not using the kernel's coccicheck target, keep the above precedence
>  order logic of .cocciconfig reading. If using the kernel's coccicheck target,
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 7964e0c245ae..d36519f194dc 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -449,6 +449,20 @@ $(obj)
>    to prerequisites are referenced with $(src) (because they are not
>    generated files).
>  
> +$(srcroot)
> +  $(srcroot) refers to the root of the source you are building, which can be
> +  either the kernel source or the external modules source, depending on whether
> +  KBUILD_EXTMOD is set. This can be either a relative or an absolute path, but
> +  if KBUILD_ABS_SRCTREE=1 is set, it is always an absolute path.
> +
> +$(srctree)
> +  $(srctree) refers to the root of the kernel source tree. When building the
> +  kernel, this is the same as $(srcroot).
> +
> +$(objtree)
> +  $(objtree) refers to the root of the kernel object tree. It is ``.`` when
> +  building the kernel, but it is different when building external modules.
> +

Thanks, I think it's nice that there is now such a clear definition.
$(srcroot) sounds fine to me.

>  $(kecho)
>    echoing information to user in a rule is often a good practice
>    but when execution ``make -s`` one does not expect to see any output
> diff --git a/Makefile b/Makefile
> index cf1d55560ae2..e5f7ac7647a7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -180,7 +180,24 @@ ifeq ("$(origin O)", "command line")
>    KBUILD_OUTPUT := $(O)
>  endif
>  
> -output := $(KBUILD_OUTPUT)
> +ifdef KBUILD_EXTMOD
> +    ifdef KBUILD_OUTPUT
> +        objtree := $(realpath $(KBUILD_OUTPUT))
> +        $(if $(objtree),,$(error specified kernel directory "$(KBUILD_OUTPUT)" does not exist))
> +    else
> +        objtree := $(CURDIR)
> +    endif
> +    output := $(KBUILD_EXTMOD)
> +    # KBUILD_EXTMOD might be a relative path. Remember its absolute path before
> +    # Make changes the working directory.
> +    srcroot := $(realpath $(KBUILD_EXTMOD))
> +    $(if $(srcroot),,$(error specified external module directory "$(KBUILD_EXTMOD)" does not exist))
> +else
> +    objtree := .
> +    output := $(KBUILD_OUTPUT)
> +endif
> +
> +export objtree srcroot
>  
>  # Do we want to change the working directory?
>  ifneq ($(output),)
> @@ -230,35 +247,33 @@ else # need-sub-make
>  
>  # We process the rest of the Makefile if this is the final invocation of make
>  
> -ifeq ($(abs_srctree),$(CURDIR))
> -        # building in the source tree
> -        srctree := .
> -	building_out_of_srctree :=
> +ifndef KBUILD_EXTMOD
> +srcroot := $(abs_srctree)
> +endif
> +
> +ifeq ($(srcroot),$(CURDIR))
> +building_out_of_srctree :=
>  else
> -        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
> -                # building in a subdirectory of the source tree
> -                srctree := ..
> -        else
> -                srctree := $(abs_srctree)
> -        endif
> -	building_out_of_srctree := 1
> +export building_out_of_srctree :=1
>  endif
>  
> -ifneq ($(KBUILD_ABS_SRCTREE),)
> -srctree := $(abs_srctree)
> +ifdef KBUILD_ABS_SRCTREE
> +    # Do not nothing. Use the absolute path.
> +else ifeq ($(srcroot),$(CURDIR))
> +    # Building in the source.
> +    srcroot := .
> +else ifeq ($(srcroot)/,$(dir $(CURDIR)))
> +    # Building in a subdirectory of the source.
> +    srcroot := ..
>  endif
>  
> -objtree		:= .
> +export srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))

With this patch applied, the following breaks for me:

    $ make O=build M=fs/btrfs CONFIG_BTRFS_FS=m
    make[1]: Entering directory '/data/linux/kbuild-review/fs/btrfs'
      CC [M]  super.o
    In file included from <command-line>:
    /data/linux/kbuild-review/include/linux/compiler_types.h:89:10: fatal error: linux/compiler_attributes.h: No such file or directory
       89 | #include <linux/compiler_attributes.h>
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.

Adding 'ccflags-y += -I$(srctree)/include' to fs/btrfs/Makefile breaks
the build loudly.  I could make it build again with

diff --git a/Makefile b/Makefile
index e5f7ac7647a7b..3d95911f1a68f 100644
--- a/Makefile
+++ b/Makefile
@@ -555,7 +555,7 @@ USERINCLUDE    := \
 LINUXINCLUDE    := \
                -I$(srctree)/arch/$(SRCARCH)/include \
                -I$(objtree)/arch/$(SRCARCH)/include/generated \
-               $(if $(building_out_of_srctree),-I$(srctree)/include) \
+               $(if $(or $(building_out_of_srctree),$(filter $(srctree)/%, $(CURDIR))),-I$(srctree)/include) \
                -I$(objtree)/include \
                $(USERINCLUDE)

but this does not feel good.  It building in-tree modules in this way a
valid thing to do?

Kind regards,
Nicolas
