Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B7C28B30
	for <cocci@archiver.kernel.org>; Thu, 20 Mar 2025 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qbjs8Uml9cwm/9P8hphLXy9QeS3nXI4Mre8zbOzxxrc=;
  b=TK83H8jrPo6IRF4q85maeVNnMh85eGoSFPwZTM2Ax6BpTgZiKArXCfMz
   Jkyp/7KsiA90URySDVT/fYzxny+TV5kJZEcxixXJ16db97XnZBFIC1l9c
   zGAnnCXN9Jfn1OSR7BNwSW+R9zv4srdXfDHc1WMwzO+bGUHtgOXORa0/v
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,261,1736809200"; 
   d="scan'208";a="213866287"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2025 10:41:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E83CBE007A; Thu, 20 Mar 2025 10:41:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 11E9DE007A
	for <cocci@sympa.inria.fr>; Thu, 20 Mar 2025 10:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qbjs8Uml9cwm/9P8hphLXy9QeS3nXI4Mre8zbOzxxrc=;
  b=ccdIaAcoenFWGTMy6I2xhyP5YhOKoOFCSekMq1GH4CcYd8T3eUCjJDfS
   AXFwp/+YOeBfO1HyNBO69n4Zb2VN2Ljhp45pNbYklJYr+jgQmDTfPhXkL
   MaOdJqjYBT+dTLAAVNHdUCHydnliXq4V9CWE2fVjmc7Vy539ia/66AvE2
   g=;
X-IronPort-AV: E=Sophos;i="6.14,261,1736809200"; 
   d="scan'208";a="213866269"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:41:23 +0100
Message-ID: <07992c10-99a5-4e0a-97df-19289dabd3e6@inria.fr>
Date: Thu, 20 Mar 2025 10:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250317221044.25197-1-olaf@aepfle.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <20250317221044.25197-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH v1] remove unused version files
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2661
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/07992c10-99a5-4e0a-97df-19289dabd3e6%40inria.fr>

Merged to master. Thank you!

On 17/03/2025 23:10, Olaf Hering wrote:
> The file scripts/genversion.sh is unused since commit ad7cfbe97
> ("Documentation build improvement.").
>
> The file version.ml is unused since commit 3277ba7a1 ("Next Makefile").
>
> The last user of CONFVERSION is removed, which makes
> AC_COCCI_CONFVERSION obsolete.
>
> Resolves coccinelle/coccinelle#121
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>   .gitignore            |  1 -
>   configure.ac          |  2 --
>   scripts/genversion.sh | 11 -----------
>   setup/cocci.m4        | 34 ----------------------------------
>   version.ml.in         |  2 --
>   5 files changed, 50 deletions(-)
>   delete mode 100755 scripts/genversion.sh
>   delete mode 100644 version.ml.in
>
> diff --git a/.gitignore b/.gitignore
> index ed2ecf88f..623370c8c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -20,7 +20,6 @@ scripts/spatch.byte
>   *.swo
>   *.swp
>   .depend
> -version.ml
>   
>   .flatpak-builder/
>   _flatpak-build/
> diff --git a/configure.ac b/configure.ac
> index f0c585329..83273a07e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -14,7 +14,6 @@ AC_MSG_NOTICE([configuring coccinelle $COCCI_VERSION in $COCCI_SRCDIR])
>   AM_INIT_AUTOMAKE
>   
>   AC_CONFIG_SRCDIR([cocci.ml])    dnl  this file must be present in our src directory
> -AC_COCCI_CONFVERSION
>   
>   dnl  reminder that this configure depends on macros generated by aclocal
>   AC_MSG_NOTICE([this configure program uses pkg-config m4 macros])
> @@ -605,7 +604,6 @@ dnl
>   
>   AC_CONFIG_FILES([
>     Makefile.config
> -  version.ml
>     commons/commands.ml
>     globals/cocciconfig.ml globals/regexp.ml python/pycocci.ml
>     ocaml/prepare_ocamlcocci.ml
> diff --git a/scripts/genversion.sh b/scripts/genversion.sh
> deleted file mode 100755
> index b70b837db..000000000
> --- a/scripts/genversion.sh
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -#! /bin/sh
> -
> -# fallback date (in RFC format)
> -VERSION=`date "+%a, %d %b %Y %H:%M:%S %z"`
> -
> -# use the date information from git, if git is present
> -if test -d ".git" && which git &>/dev/null; then
> -VERSION=`git log -1 --date-order --date=rfc --pretty="format:%cd"`
> -fi
> -
> -echo "let version_date = \"$VERSION\""
> diff --git a/setup/cocci.m4 b/setup/cocci.m4
> index 88fce3a05..d4dbb0ad4 100644
> --- a/setup/cocci.m4
> +++ b/setup/cocci.m4
> @@ -205,40 +205,6 @@ AC_DEFUN([AC_COCCI_PYVER],
>   ])
>   
>   
> -dnl  determine version date (RTC format)
> -AC_DEFUN([AC_COCCI_CONFVERSION],
> -[dnl
> -  AC_SUBST([CONFVERSION])
> -  AC_MSG_NOTICE([determining version suffix])
> -
> -  AS_IF([test -z "$CONFVERSION" -a -d "./.git"],
> -  [dnl  git administration found
> -    AC_MSG_NOTICE([building a version from a git repository])
> -    AC_PATH_TOOL([GIT],[git])
> -    AS_IF([test -n "$GIT"],
> -    [dnl  ask git
> -      CONFVERSION=`$GIT log -1 --date-order --date=rfc --pretty="format:%cd"`
> -    ])
> -  ])
> -
> -  AS_IF([test -z "$CONFVERSION"],
> -  [dnl  otherwise, take the current date
> -    AC_PATH_TOOL([DATE],[date])
> -    AS_IF([test -n "$DATE"],
> -    [dnl
> -      CONFVERSION=`$DATE "+%a, %d %b %Y %H:%M:%S %z"`
> -    ])
> -  ])
> -
> -  AS_IF([test -z "$CONFVERSION"],
> -  [dnl  fallback
> -    CONFVERSION=unknown
> -  ])
> -
> -  AC_MSG_NOTICE([version suffix set to $CONFVERSION])
> -])
> -
> -
>   dnl  find a tool, with specialized macros for certain cases
>   dnl  $1: name of the variable
>   dnl  $2: name of the tool
> diff --git a/version.ml.in b/version.ml.in
> deleted file mode 100644
> index a5969ce20..000000000
> --- a/version.ml.in
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -let version_date = "@CONFVERSION@"
> -let configure_flags = "@CONFIGURE_FLAGS@"
>
> base-commit: cca22217d1b4316224e80a18d0b08dd351234497
