Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A381E7716D
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BBhzhUYBIcNIAOOM9Q7IfM3Uc0C+QwfFcS/5X57Pm0o=;
  b=PNFDIcpWezdS64YZd1gk6evR6DO4kf56n9m9aGjUnd74PqHMpmzNXrG6
   s5lzT/B5e1lxau6GeNpFSuHxRriI3UEje13F1ykwOX7+hF51Iw/saYoWm
   +rDvEvVBkItdbu0uyi12+1zwln5IShDTwAzwISwwAgY0w7eYTfIOpuLA0
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421454"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDEE9E0D7A; Wed,  4 Dec 2024 23:28:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 966EEE00B6
	for <cocci@sympa.inria.fr>; Wed,  4 Dec 2024 21:51:32 +0100 (CET)
IronPort-SDR: 6750c0d3_YwkxfZcfctqWuesV+VhAxy+5YWNDMuvSE0BZNz+FQFCMyQz
 BfRVfroJK3wgvrUsfHH5mZC12eJfO+nHhjFyPsg==
X-IPAS-Result: =?us-ascii?q?A0ELAACxv1BnjxFBr8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVk0BAtIiCWETl+GUYIhA4ETkDeBVIp6gUA+DwEDAQ0xEAECB?=
 =?us-ascii?q?AEBAwEDhQACimkCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBAQEBOQUOO4V7DYJiAYEkXgcJNwEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQERAg1eAQEdAQEBAQIBOgYBATcBDwsYLhBGBhODAQGCQSMDsCh4g?=
 =?us-ascii?q?TSBAYIMAQEGgQjbF4FkCYFIAYVqgmMBhWuDfXonD4FVRIEVgTuBNzg+iweDK?=
 =?us-ascii?q?laCX3YlhTaCPYENgW+CD4NGhEspeB4dHTBGgWiBMYpBUnt4MgFVExcLBwWBK?=
 =?us-ascii?q?iEsA4JIf4E2gVEBgxBKgy4cgUIFNwo9gkppSzcCDQI2giR9gk2FF4ELg15jL?=
 =?us-ascii?q?wMDAwODO4YqgUkdQAMLbT03FBuiVQFGgl5yAXsEDwEbgSABCjIrJykykmuPe?=
 =?us-ascii?q?4IgoE00B4QdgV0GDIoolXqFW6R2lhuCYKNbAQsmhR2BZzqBXE0jgzcJRgMZD?=
 =?us-ascii?q?44hGR+CZF6GUbh8JTI8AgcLAQEDCYVGAQGOVoFLAQE?=
IronPort-PHdr: A9a23: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
 MM9ht9ov1yi1OKIz2g+OCc=
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:d5ntGq0kOoOqG0O0evr/bAqjBHIkLtp133Aq2lEZdPWaSL3gqy
 mLpoVl6faUskdsZJhEo7u90ca7MBfhHPJOkO4s1PKZLXfbUQiTXfxfBOnZskbd8kTFn4YypM
 JdmupFeafN5DNB/L7HCWeDYrAd6ejC2pqFwc3ZyHBgRxxrbaZP0ydVYzzwc3FedU1tP7Z8MI
 CTyPZmilObFBQqh4OAdxo4tu74y7K79q7bXQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AcgV4dWmRKCtRrV2Dq7q2LnMn3V3XOTrm9i33ZEi?=
 =?us-ascii?q?+MzoqF7bJbnivp6FCycU7zg=3D=3D?=
X-Talos-MUID: 9a23:s/RrEQpJpgWij25pwHMezwFZGMR6zpWjMmsu0q05ktavL3VpOSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="103458629"
X-MGA-submission: =?us-ascii?q?MDHZUY3dC2DuZoRTVIKtuNZIu/NrHDLXYa+dPm?=
 =?us-ascii?q?tKueQxAF8X1qg74uaDoOqYqyWebbCK/O1Syg7wLaH1hqXOtTYbCJqhvp?=
 =?us-ascii?q?p87TO7cS1JbxClYRqCZWvR27g3H+WKUQ6hJlr9hCpJpgtsyoIH0hyz4j?=
 =?us-ascii?q?IRhXBYsr0gUhyw1zKEDNmCmw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 21:51:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733345491; x=1764881491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mrv1kSdGE80XLwjHV+eey2rwpc0dLczINrcEBQoEm5I=;
  b=FAKtPu64G01GBjaKVj6dlXXqEYXKsFewUwJdWThooUZnFLd2YTP1ATbn
   LPaLwXe86ieygOR7EALNhDrDxFn8a1bPJHu/+4SjnsO6yw+kwcxleMITH
   g7QAdh87ebUji2BKpo7XthSDTXfHoLe5b4Mui3ElbHlTlfYu1ViAlSTFd
   zCkzvh+jJJGDe2LVtauN+GZfxQZVrBM8ZSLc8Z754cYGfEKft9/DPbbMG
   4gbIwDYjXedqtqdNkVqpeZXfUrzRiMIu/zSaUcySKi9n7uCLooqD0yZQJ
   XdgugRf3VQMENnxFcSvBDp8rU5xqzPSpiMX84UqRBUccygVZ9dV6V0FO8
   w==;
X-CSE-ConnectionGUID: neZvJqH6RticvRM1s4J1fQ==
X-CSE-MsgGUID: 8VEvQfN5Ru62GCmvyA3jcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33695332"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33695332"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 12:51:28 -0800
X-CSE-ConnectionGUID: b5tCPzJORbCNwYmtiKX9Xg==
X-CSE-MsgGUID: Y+NfdIyYTjymdSRNd4BSTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="117126345"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.90])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 12:51:27 -0800
Date: Wed, 4 Dec 2024 12:51:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	cocci@inria.fr
Message-ID: <Z1DAzaKYD_rfgGnk@aschofie-mobl2.lan>
References: <20241110013649.34903-1-masahiroy@kernel.org>
 <20241110013649.34903-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110013649.34903-6-masahiroy@kernel.org>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Alison Schofield <alison.schofield@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2155
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/Z1DAzaKYD_rfgGnk%40aschofie-mobl2.lan>

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

With this in v6.13-rc1 the cxl-test module fails depmod.
It causes depmod  to be invoked from the incorrect place
(or something doesn't respect INSTALL_MOD_PATH)

Is there something additional that this cxl-test module needs
to do?

Repro:
/git/new$ make V=1 M=tools/testing/cxl INSTALL_MOD_PATH=qbuild/mkosi.extra/ modules_install

Outputs:
make  -C /home/cxluser/git/new/tools/testing/cxl \
-f /home/cxluser/git/new/Makefile modules_install
make[1]: Entering directory '/home/cxluser/git/new/tools/testing/cxl'
make --no-print-directory -C /home/cxluser/git/new/tools/testing/cxl \
-f /home/cxluser/git/new/Makefile modules_install
make -f /home/cxluser/git/new/scripts/Makefile.modinst \
sign-only=
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_acpi.ko
  cp cxl_acpi.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_acpi.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_acpi.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_acpi.ko
  :
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko
  cp cxl_pmem.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko
  :
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_port.ko
  cp cxl_port.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_port.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_port.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_port.ko
  :
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_mem.ko
  cp cxl_mem.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_mem.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_mem.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_mem.ko
  :
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_core.ko
  cp cxl_core.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_core.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_core.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_core.ko
  :
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_test.ko
  cp test/cxl_test.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_test.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_test.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_test.ko
  :
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock.ko
  cp test/cxl_mock.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock.ko
  :
# INSTALL qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock_mem.ko
  cp test/cxl_mock_mem.ko qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock_mem.ko
# cmd_strip qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock_mem.ko
  :
# cmd_sign qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock_mem.ko
  :
# DEPMOD  qbuild/mkosi.extra//lib/modules/6.13.0-rc1+
  /home/cxluser/git/new/scripts/depmod.sh 6.13.0-rc1+
depmod: WARNING: could not open modules.order at /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+: No such file or directory
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/test/cxl_mock.ko needs unknown symbol nvdimm_bus_register
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol to_nvdimm
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol __nvdimm_create
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol nvdimm_bus_unregister
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol nvdimm_region_delete
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol nvdimm_delete
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol nvdimm_provider_data
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol nvdimm_pmem_region_create
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol nd_fletcher64
depmod: WARNING: /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+/updates/cxl_pmem.ko needs unknown symbol nvdimm_cmd_mask
depmod: WARNING: could not open modules.builtin at /home/cxluser/git/new/tools/testing/cxl/qbuild/mkosi.extra//lib/modules/6.13.0-rc1+: No such file or directory
make[1]: Leaving directory '/home/cxluser/git/new/tools/testing/cxl'
cxluser@MySS:~/git/new$




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
>  
> -VPATH		:=
> -
> -ifeq ($(KBUILD_EXTMOD),)
>  ifdef building_out_of_srctree
> -VPATH		:= $(srctree)
> +export VPATH := $(srcroot)
> +else
> +VPATH :=
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
> -ifneq ($(filter all modules nsdeps %compile_commands.json clang-%,$(MAKECMDGOALS)),)
> +ifneq ($(filter all modules nsdeps compile_commands.json clang-%,$(MAKECMDGOALS)),)
>    KBUILD_MODULES := 1
>  endif
>  
> @@ -1107,7 +1122,7 @@ export MODLIB
>  
>  PHONY += prepare0
>  
> -export extmod_prefix = $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/)
> +export extmod_prefix =
>  export MODORDER := $(extmod_prefix)modules.order
>  export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
>  
> @@ -1799,14 +1814,10 @@ filechk_kernel.release = echo $(KERNELRELEASE)
>  KBUILD_BUILTIN :=
>  KBUILD_MODULES := 1
>  
> -build-dir := $(KBUILD_EXTMOD)
> +build-dir := .
>  
> -compile_commands.json: $(extmod_prefix)compile_commands.json
> -PHONY += compile_commands.json
> -
> -clean-dirs := $(KBUILD_EXTMOD)
> -clean: private rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
> -	$(KBUILD_EXTMOD)/compile_commands.json
> +clean-dirs := .
> +clean: private rm-files := Module.symvers modules.nsdeps compile_commands.json
>  
>  PHONY += prepare
>  # now expand this into a simple variable to reduce the cost of shell evaluations
> @@ -1948,7 +1959,7 @@ $(clean-dirs):
>  
>  clean: $(clean-dirs)
>  	$(call cmd,rmfiles)
> -	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
> +	@find . $(RCS_FIND_IGNORE) \
>  		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
>  		-o -name '*.ko.*' \
>  		-o -name '*.dtb' -o -name '*.dtbo' \
> @@ -1981,7 +1992,12 @@ tags TAGS cscope gtags: FORCE
>  PHONY += rust-analyzer
>  rust-analyzer:
>  	+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
> +ifdef KBUILD_EXTMOD
> +# FIXME: external modules must not descend into a sub-directory of the kernel
> +	$(Q)$(MAKE) $(build)=$(objtree)/rust src=$(srctree)/rust $@
> +else
>  	$(Q)$(MAKE) $(build)=rust $@
> +endif
>  
>  # Script to generate missing namespace dependencies
>  # ---------------------------------------------------------------------------
> diff --git a/rust/Makefile b/rust/Makefile
> index b5e0a73b78f3..742740816c4b 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -362,8 +362,8 @@ rust-analyzer:
>  	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
>  		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
>  		$(realpath $(srctree)) $(realpath $(objtree)) \
> -		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
> -		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
> +		$(rustc_sysroot) $(RUST_LIB_SRC) $(if $(KBUILD_EXTMOD),$(srcroot)) \
> +		> rust-project.json
>  
>  redirect-intrinsics = \
>  	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 \
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 64cd046f8fd8..1aa928a6fb4f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -3,7 +3,7 @@
>  # Building
>  # ==========================================================================
>  
> -src := $(if $(VPATH),$(VPATH)/)$(obj)
> +src := $(srcroot)/$(obj)
>  
>  PHONY := $(obj)/
>  $(obj)/:
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index 4fcfab40ed61..6ead00ec7313 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -3,7 +3,7 @@
>  # Cleaning up
>  # ==========================================================================
>  
> -src := $(if $(VPATH),$(VPATH)/)$(obj)
> +src := $(srcroot)/$(obj)
>  
>  PHONY := __clean
>  __clean:
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index e0842496d26e..8c1029687e2e 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -13,7 +13,7 @@ cc-cross-prefix = $(firstword $(foreach c, $(1), \
>  			$(if $(shell command -v -- $(c)gcc 2>/dev/null), $(c))))
>  
>  # output directory for tests below
> -TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
> +TMPOUT = .tmp_$$$$
>  
>  # try-run
>  # Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 12e7c15d099c..78d2ca4f25f5 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -111,13 +111,13 @@ endif
>  else
>  
>  # set src + obj - they may be used in the modules's Makefile
> -obj := $(KBUILD_EXTMOD)
> -src := $(if $(VPATH),$(VPATH)/)$(obj)
> +obj := .
> +src := $(srcroot)
>  
>  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
>  include $(kbuild-file)
>  
> -output-symdump := $(KBUILD_EXTMOD)/Module.symvers
> +output-symdump := Module.symvers
>  
>  ifeq ($(wildcard $(objtree)/Module.symvers),)
>  missing-input := $(objtree)/Module.symvers
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e52cb43fede6..0e6bc5a10320 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -80,11 +80,7 @@ command results in a shift count error.'
>      NPROC=1
>  else
>      ONLINE=0
> -    if [ "$KBUILD_EXTMOD" = "" ] ; then
> -        OPTIONS="--dir $srctree $COCCIINCLUDE"
> -    else
> -        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> -    fi
> +    OPTIONS="--dir $srcroot $COCCIINCLUDE"
>  
>      # Use only one thread per core by default if hyperthreading is enabled
>      THREADS_PER_CORE=$(LANG=C lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index f1718cc0d700..8ca12e2b5c03 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -19,12 +19,6 @@ if ! { echo "$SPATCH_REQ_VERSION"; echo "$SPATCH_VERSION"; } | sort -CV ; then
>  	exit 1
>  fi
>  
> -if [ "$KBUILD_EXTMOD" ]; then
> -	src_prefix=
> -else
> -	src_prefix=$srctree/
> -fi
> -
>  generate_deps_for_ns() {
>  	$SPATCH --very-quiet --in-place --sp-file \
>  		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
> @@ -34,7 +28,7 @@ generate_deps() {
>  	local mod=${1%.ko:}
>  	shift
>  	local namespaces="$*"
> -	local mod_source_files=$(sed "s|^\(.*\)\.o$|${src_prefix}\1.c|" $mod.mod)
> +	local mod_source_files=$(sed "s|^\(.*\)\.o$|${srcroot}/\1.c|" $mod.mod)
>  
>  	for ns in $namespaces; do
>  		echo "Adding namespace $ns to module $mod.ko."
> diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
> index 7ec1f061a519..64d958ee45f3 100755
> --- a/scripts/package/install-extmod-build
> +++ b/scripts/package/install-extmod-build
> @@ -51,6 +51,13 @@ mkdir -p "${destdir}"
>  if [ "${CC}" != "${HOSTCC}" ]; then
>  	echo "Rebuilding host programs with ${CC}..."
>  
> +	# This leverages external module building.
> +	# - Clear sub_make_done to allow the top-level Makefile to redo sub-make.
> +	# - Filter out --no-print-directory to print "Entering directory" logs
> +	#   when Make changes the working directory.
> +	unset sub_make_done
> +	MAKEFLAGS=$(echo "${MAKEFLAGS}" | sed s/--no-print-directory//)
> +
>  	cat <<-'EOF' >  "${destdir}/Kbuild"
>  	subdir-y := scripts
>  	EOF
> -- 
> 2.43.0
> 
