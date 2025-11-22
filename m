Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF50CFC533
	for <cocci@archiver.kernel.org>; Sat, 22 Nov 2025 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9nRSfw1zczBVwsLS3jI9/thw9xOHnsaGr8RQuTZrtoc=;
  b=iJzvPPkgRlRSYEWW9ChghCQ0YY7l3mCgGI7vO2Q3I70g2vidEg/HEdgK
   Dn73AQHe3jis8WIppOIx+/RPtzQ+1ZdUoiTMnoF4AAWlu8YHYkfWkO4T0
   VgSyTOgl1O9YXmSIsjUyh/afq9hX+EzaOonZ/Ke8egHVy77VxGqLrLPCZ
   A=;
X-CSE-ConnectionGUID: Zdf7z/doSqeflQCFpgd7mw==
X-CSE-MsgGUID: 7wNHY7MOQEadhrE4a6B6Ww==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.20,218,1758578400"; 
   d="scan'208";a="250634912"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2025 13:48:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B6DCE0264; Sat, 22 Nov 2025 13:48:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4ADC0E0171
	for <cocci@sympa.inria.fr>; Sat, 22 Nov 2025 13:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9nRSfw1zczBVwsLS3jI9/thw9xOHnsaGr8RQuTZrtoc=;
  b=f3kNbJaHdkvsMYIlG/dH9o1ZjD0yCXwkxjsY3ZOSphzfF2nUSFZUHNA1
   QZjCEXTbQrXU4TzhSLf3J3kTTg0xBmeP8nmxs9b6x8+I/QgyFjmpjFC0f
   xW8Uo6RQO04hyv5FYRfBHcIqgSh6ZsR0dM/QcgfWHqWnadi799vdpng0x
   Y=;
X-CSE-ConnectionGUID: RFi4WOnESfCslRuhTYidmg==
X-CSE-MsgGUID: cjvbBPLJQqafrTMKK1wMvw==
X-IronPort-AV: E=Sophos;i="6.20,218,1758578400"; 
   d="scan'208";a="250634911"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 13:48:14 +0100
Date: Sat, 22 Nov 2025 13:48:13 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20251122114806.447303-2-thorsten.blum@linux.dev>
Message-ID: <fbc4739-8e2a-dc61-b65c-cc258e413222@inria.fr>
References: <20251122114806.447303-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH RESEND] Coccinelle: pm_runtime: Fix typo in
 report message
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3191
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/fbc4739-8e2a-dc61-b65c-cc258e413222%40inria.fr>



On Sat, 22 Nov 2025, Thorsten Blum wrote:

> s/Unecessary/Unnecessary/
>
> Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied, thanks.

> ---
>  scripts/coccinelle/api/pm_runtime.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
> index 2c931e748dda..e29ac3a87d96 100644
> --- a/scripts/coccinelle/api/pm_runtime.cocci
> +++ b/scripts/coccinelle/api/pm_runtime.cocci
> @@ -110,5 +110,5 @@ p2 << r.p2;
>  pm_runtime_api << r.pm_runtime_api;
>  @@
>
> -msg = "%s returns < 0 as error. Unecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
> +msg = "%s returns < 0 as error. Unnecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
>  coccilib.report.print_report(p1[0],msg)
> --
> 2.51.1
>
>
