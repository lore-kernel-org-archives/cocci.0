Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3469CC25B75
	for <cocci@archiver.kernel.org>; Mon,  3 Jun 2024 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zqP9S4nbMBeYlOfeJab+B5j1vuo4Z8qBfN99sVGKJkU=;
  b=cAiEh3CKZrm5KgBzySoWW7y/1wUb07pro7Yp/3VFtYlfD1vIyG7IJ3ae
   x8OYSWhveCrluezipMpnOwfI6KH5XG1RhMTfcYhqDtqOOMF8XQJ/TZBuU
   YNWCJJSTKeyupTGBg/3UMWquGmTCDMJYv2tKd8OoEKej30yDp8odAI4qJ
   Q=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,212,1712613600"; 
   d="scan'208";a="168810896"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jun 2024 18:37:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C367E0141; Mon,  3 Jun 2024 18:37:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A22D0E0035
	for <cocci@sympa.inria.fr>; Mon,  3 Jun 2024 18:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zqP9S4nbMBeYlOfeJab+B5j1vuo4Z8qBfN99sVGKJkU=;
  b=IQ3YWtluCXBYIvyU71GLgHBfJJOmMIvU9vb/vtTu4PqLjlOR/hOsptEE
   NsvezDG3Mw0gignZUfbFJelCDqiwRy9LNyq7oYUnvM0WLDsURql4mcuY/
   PDSVs/mIVRCFh7o009U7Faf8ADNzTEp+nd8eZ3ebPI0XGfgoou0mwc3/0
   M=;
X-IronPort-AV: E=Sophos;i="6.08,212,1712613600"; 
   d="scan'208";a="88703209"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:37:17 +0200
Date: Mon, 3 Jun 2024 18:37:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Thorsten Blum <thorsten.blum@toblux.com>
cc: nicolas.palix@imag.fr, cocci@inria.fr, linux-kernel@vger.kernel.org
In-Reply-To: <20240603155648.93989-1-thorsten.blum@toblux.com>
Message-ID: <4bc15f4-d93e-8c84-41d3-7fdc8c1117ba@inria.fr>
References: <20240603155648.93989-1-thorsten.blum@toblux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] scripts: coccicheck: Replace http with https
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1773
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/4bc15f4-d93e-8c84-41d3-7fdc8c1117ba%40inria.fr>



On Mon, 3 Jun 2024, Thorsten Blum wrote:

> The Coccinelle website is also available via https.

Thanks for the suggestion, but that link is actually completely out of
date.  I will change it to the correct one.

julia

>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  scripts/coccicheck | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e52cb43fede6..9b6b29fb8224 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -11,7 +11,7 @@ DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
>
>  if [ ! -x "$SPATCH" ]; then
> -    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +    echo 'spatch is part of the Coccinelle project and is available at https://coccinelle.lip6.fr/'
>      exit 1
>  fi
>
> @@ -233,7 +233,7 @@ coccinelle () {
>  	echo " in $FILE."
>  	echo ''
>  	echo ' More information about semantic patching is available at'
> -	echo ' http://coccinelle.lip6.fr/'
> +	echo ' https://coccinelle.lip6.fr/'
>  	echo ''
>
>  	if [ "`sed -ne 's|^//#||p' $COCCI`" ] ; then
> --
> 2.39.2
>
>
