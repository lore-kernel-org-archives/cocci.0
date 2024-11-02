Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFA0E677E8
	for <cocci@archiver.kernel.org>; Sat,  2 Nov 2024 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LEG95Ilkl4hMTpCgxKpMpBS52sFFmIpD0s1VQkq2PMs=;
  b=MsYj7X6/vgh0XYfHhBlqNMqJUYaE0+S9FgMCQxnVgcWATzoIkGnY6xjD
   opSwuqBbmI3BfKJdGbZXOW3UC16gwOQEaoYv9vmZ6JIDtS4XuPsK95E7X
   6ljXZIkZrLPofZkdKgPH2P7f81s5NJpYZU5I9ktJurD7/VcMma9ZBpLsF
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.11,253,1725314400"; 
   d="scan'208";a="191824302"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2024 19:23:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B03EE013D; Sat,  2 Nov 2024 19:23:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E0848E00B7
	for <cocci@sympa.inria.fr>; Sat,  2 Nov 2024 19:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LEG95Ilkl4hMTpCgxKpMpBS52sFFmIpD0s1VQkq2PMs=;
  b=VSvOlmHY/rKrGRWLVlhn2/FTaliKAALCtMuXlGLRz3TQxYqpRDNLvwEk
   73dAOt4TuUCsicYIb5ByoFdDHmJB5WLNVlnZjRxsRZb1PZ+ZTjAjRBggo
   5DdItqiheB5nLP/gavFDzanKV+yWDVSdkxTks3/XB19MO9atQbxMePdFU
   8=;
X-IronPort-AV: E=Sophos;i="6.11,253,1725314400"; 
   d="scan'208";a="100583611"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 19:23:50 +0100
Date: Sat, 2 Nov 2024 19:23:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <922a51a3-ec27-4059-8697-09c90385ffc9@web.de>
Message-ID: <alpine.DEB.2.22.394.2411021921580.15958@hadrien>
References: <922a51a3-ec27-4059-8697-09c90385ffc9@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-752501729-1730571829=:15958"
Subject: Re: [cocci] Searching for selected identifiers in code parts (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1961
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/alpine.DEB.2.22.394.2411021921580.15958%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-752501729-1730571829=:15958
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Nov 2024, Markus Elfring wrote:

> Hello,
>
> I tried another tiny script variant out for the semantic patch language
> together with the software combination “Coccinelle 1.2-00097-g7bc8a7ac”.
>
>
> @display4@
> expression e;
> identifier i;
> @@
>  while (
> *       --i > 0
>        )
>  e(..., <+... i ...+>, ...);
>
>
> This source code search approach is working to some degree (as expected).
> Can the following SmPL script variant become similarly usable to find
> remaining update candidates?
>
>
> @display@
> identifier i;
> @@
>  while (
> *       --i > 0
>        )
>  <+... i ...+>;

Use (<+... i ...+>);.  Of course it looks nonsensical, but it will get it
through the parser and an isomorphism will drop the ().

To avoid parser conflicts, the parser needs to be able to decide
immediately when it sees a <+... what kind of <+... it is.  The choice is
that it is the start of a statement in this case, but that turns out to be
wrong.

julia

>
>
> Examples:
> * t7xx_dpmaif_rx_buf_alloc
>   https://elixir.bootlin.com/linux/v6.12-rc5/source/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c#L229
>
> * t7xx_dpmaif_rx_frag_alloc
>   https://elixir.bootlin.com/linux/v6.12-rc5/source/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c#L384
>
>
> Unfortunately, I observed the following information.
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci show_questionable_while_condition2.cocci
> …
> minus: parse error:
>   File "show_questionable_while_condition2.cocci", line 10, column 1, charpos = 249
>   around = '<+...',
>   whole content =  <+... i ...+>;
>
>
> Regards,
> Markus
>
--8323329-752501729-1730571829=:15958--
