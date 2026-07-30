Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82651C531D0
	for <cocci@archiver.kernel.org>; Thu, 30 Jul 2026 05:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oA/yM7993V3G7vZ25VVtzm+hcAHQdUmIt636sa9kV+g=;
  b=VMcmAMfh2kd5aO4OizQTTyUjBDXYBbuU1WVPEy+ija+VTPl/Iqi6jjyX
   oOqWr7q9n8+UEawBKohwUBGpP9c5lxU3xATD7e9gLO6m3Jn8B2Bh+BUwo
   39rox3elYkkWsEYqLB+W0OoD5f3h9GnEwg+0I3qk7MprLVJ7GCNPXOy8H
   M=;
X-CSE-ConnectionGUID: EIv34WOUS8OZH8ZOXMl9gg==
X-CSE-MsgGUID: 7ru4/fsjSVSrHYQwnIO8pg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,193,1779141600"; 
   d="scan'208";a="288429579"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jul 2026 07:56:05 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6E84D81DD2; Thu, 30 Jul 2026 07:56:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D014581D0B
	for <cocci@sympa.inria.fr>; Thu, 30 Jul 2026 07:55:59 +0200 (CEST)
X-CSE-ConnectionGUID: oGv6UshCQKGaq6Xq9SGLsw==
X-CSE-MsgGUID: HSZPTjlaRPOP7BjY7HtaYA==
X-IronPort-AV: E=Sophos;i="6.25,193,1779141600"; 
   d="scan'208";a="153251658"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 07:56:00 +0200
Date: Thu, 30 Jul 2026 07:55:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-2022-JP?Q?=1B$BAj1=3A=3E4=1B=28J_=2F_AIURA=1B$B!$=1B=28JAKIRA?= <akira.aiura.bj@hitachi.com>
cc: "corbet@lwn.net" <corbet@lwn.net>, 
    "Julia.Lawall@inria.fr" <Julia.Lawall@inria.fr>, 
    "maennich@google.com" <maennich@google.com>, 
    "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
    "workflows@vger.kernel.org" <workflows@vger.kernel.org>, 
    "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "cocci@inria.fr" <cocci@inria.fr>, 
    =?ISO-2022-JP?Q?=1B$BE{0fM&2p=1B=28J_=2F_TSUTSUI=1B$B!$=1B=28JYUSUKE?= <yusuke.tsutsui.gt@hitachi.com>, 
    "=?ISO-2022-JP?Q?=1B$B0$8}=40=3F=3BJ=1B=28J_=2F_AGUCHI=1B$B!$=1B=28JSE?=
 =?ISO-2022-JP?Q?IJI?=" <seiji.aguchi.tr@hitachi.com>, 
    "=?ISO-2022-JP?Q?=1B$BLZB=3C=3E-4u=1B=28J_=2F_KIMURA=1B$B!$=1B=28JMASA?=
 =?ISO-2022-JP?Q?KI?=" <masaki.kimura.kz@hitachi.com>, 
    "=?ISO-2022-JP?Q?=1B$B=40FF#2mOB=1B=28J_=2F_SAITOU=1B$B!$=1B=28JMASAKA?=
 =?ISO-2022-JP?Q?ZU?=" <masakazu.saito.jn@hitachi.com>, 
    "=?ISO-2022-JP?Q?=1B$B=3B3FbBgOB=1B=28J_=2F_YAMAUCHI=1B$B!$=1B=28JHIRO?=
 =?ISO-2022-JP?Q?KAZU?=" <hirokazu.yamauchi.hk@hitachi.com>
In-Reply-To: <TYTPR01MB1104567F06F7DA6B366C264A9D5C92@TYTPR01MB11045.jpnprd01.prod.outlook.com>
Message-ID: <c511e35e-ded-839c-c2e9-6774e2e5ac0@inria.fr>
References: <TYTPR01MB1104567F06F7DA6B366C264A9D5C92@TYTPR01MB11045.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-512528533-1785390959=:3901"
Subject: Re: [cocci] [PATCH] coccinelle: update Coccinelle website URL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3664
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/41S65GBRiNuwSXhURR7qhg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-512528533-1785390959=:3901
Content-Type: text/plain; charset=iso-2022-jp



On Thu, 30 Jul 2026, 相浦彰 / AIURA，AKIRA wrote:

>
> The old Coccinelle project URL is no longer available. Replace it with
> the current Coccinelle homepage already referenced by
> Documentation/dev-tools/coccinelle.rst.
>
> Signed-off-by: Akira Aiura <akira.aiura.bj@hitachi.com>

Applied.  Thanks for the update.

julia


> ---
>  Documentation/process/4.Coding.rst | 3 ++-
>  scripts/coccicheck                 | 4 ++--
>  scripts/nsdeps                     | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
> index c0f57d0c4f73..c23b9e48ce49 100644
> --- a/Documentation/process/4.Coding.rst
> +++ b/Documentation/process/4.Coding.rst
> @@ -312,7 +312,8 @@ be found at https://sparse.wiki.kernel.org/index.php/Main_Page if your
>  distributor does not package it); it can then be run on the code by adding
>  "C=1" to your make command.
>
> -The "Coccinelle" tool (http://coccinelle.lip6.fr/) is able to find a wide
> +The "Coccinelle" tool
> +(https://coccinelle.gitlabpages.inria.fr/website) is able to find a wide
>  variety of potential coding problems; it can also propose fixes for those
>  problems.  Quite a few "semantic patches" for the kernel have been packaged
>  under the scripts/coccinelle directory; running "make coccicheck" will run
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 8dd766009de1..a0a0e0f72bc7 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -11,7 +11,7 @@ DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
>
>  if [ ! -x "$SPATCH" ]; then
> -    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +    echo 'spatch is part of the Coccinelle project and is available at https://coccinelle.gitlabpages.inria.fr/website'
>      exit 1
>  fi
>
> @@ -229,7 +229,7 @@ coccinelle () {
>  	echo " in $FILE."
>  	echo ''
>  	echo ' More information about semantic patching is available at'
> -	echo ' http://coccinelle.lip6.fr/'
> +	echo ' https://coccinelle.gitlabpages.inria.fr/website'
>  	echo ''
>
>  	if [ "`sed -ne 's|^//#||p' $COCCI`" ] ; then
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index a3372166ac01..d4b5ebcc2016 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -8,7 +8,7 @@ SPATCH_REQ_VERSION="1.0.4"
>  DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
>  if [ ! -x "$SPATCH" ]; then
> -	echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +	echo 'spatch is part of the Coccinelle project and is available at https://coccinelle.gitlabpages.inria.fr/website'
>  	exit 1
>  fi
>
> --
> 2.53.0
>
>
--8323329-512528533-1785390959=:3901--
