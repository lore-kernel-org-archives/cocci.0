Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A63C19F32
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=19Mo4mrPVY4IVus2xnI9+DeakYjJeXPfgi4j0RRHtj4=;
  b=YQJBq1mzJpUWXx4nOmGu1hPJIXVNPcPbJ7MzAqwRsDDOk2oZ14W7TODp
   ar5UnCVYXn64mqvXqhRKBxXLQHd4rmGbQZU+MtfylFDNXmM0GQ160C+GS
   WItf48etiwDlmBRq4ldXtWHqDr/Bay74EJWd9djjtCgUBBf++0T2K49Xr
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
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210735433"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 13:59:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4ADBCE0261; Sun,  2 Mar 2025 13:59:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 481BEE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 13:59:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=19Mo4mrPVY4IVus2xnI9+DeakYjJeXPfgi4j0RRHtj4=;
  b=eiTCP5i30WUcoLMoX0sn85IXyyZZvVTBFDXgGolaWHpQ9r+eWCsPjJF7
   +q0NtkTnUfZ/A53B3FsOJt/ouy/+tWaNSVfTdV3NMjmgdLZhxMl0wzHcG
   aKF8ystum90D3qlkHudnzTwAUx/pZTJNUP8DpkTYljG9zIl7U1ElSQbN9
   A=;
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="110424983"
Received: from unknown (HELO hadrien) ([50.225.219.62])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 13:59:46 +0100
Date: Sun, 2 Mar 2025 07:59:44 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, 
    Alyssa Rosenzweig <alyssa@rosenzweig.io>
In-Reply-To: <410c55e5-0a41-4c7e-84ba-55e936795813@web.de>
Message-ID: <fcdad933-12c3-66bf-c39d-bee193371fb3@inria.fr>
References: <Z7zjkyOeoPNYeOR3@blossom> <alpine.DEB.2.22.394.2502252132540.3444@hadrien> <410c55e5-0a41-4c7e-84ba-55e936795813@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-921919629-1740920386=:3240"
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2467
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/fcdad933-12c3-66bf-c39d-bee193371fb3%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-921919629-1740920386=:3240
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 1 Mar 2025, Markus Elfring wrote:

> > What version of Coccinelle do you have?  For me it works fine...
>
> Under which circumstances will a transformation approach (like the following)
> become better supported?
>
> @adjustment@
> expression lhs, rhs;
> @@
>  lhs
> -=

Actually, it is the above line that doesn't parse, because -= is an
operator in C.

julia

> +|= myfunc(
>  rhs
> +         )
>  ;
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --version && spatch --parse-cocci suggestion1_for_Alyssa_Rosenzweig-20250301.cocci
> spatch version 1.3-00043-gcca22217d-dirty compiled with OCaml version 5.1.1
> …
> plus: parse error:
>   File "suggestion1_for_Alyssa_Rosenzweig-20250301.cocci", line 10, column 1, charpos = 227
>   around = '|=',
>   whole content = +|= myfunc(
>
>
> Regards,
> Markus
>
--8323329-921919629-1740920386=:3240--
