Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F090EC27C76
	for <cocci@archiver.kernel.org>; Sat, 28 Jan 2023 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=b/mIjW/6TKuRH6rklUvThM8g03RP+jfPhJ8E7ZrUQ48=;
  b=EsACEWeEnO6igCLvDr0ZE26kBI8Y7oqQkJjD4i+YAzrrjQfjnnwwtba8
   8pJbbQ2E5i92ggBUqGxkZxGz7zAnVAKc6zZbwvQsLozyW5ixCdt4N+noK
   OIN7xsGHEeW1Uw5pX4hCWkpZpm7tKYJYRNmK5w7e2Fd/SLiKqwNCmMIDV
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89860251"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2023 10:49:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D4F17E0294; Sat, 28 Jan 2023 10:49:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D041AE027E
	for <cocci@sympa.inria.fr>; Sat, 28 Jan 2023 10:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b/mIjW/6TKuRH6rklUvThM8g03RP+jfPhJ8E7ZrUQ48=;
  b=RCVCvPiYvI2Xndjo3HP8tcpgOLTIL2wyGeUY6ujoGeHilnwFQ0DTrU+0
   tUWALfB+6WN1RZJdDa3cFpo9AOIdH60aqCk5WAsF3lA0LEqDio9DgqdpI
   DmjloxMlPICLxBrayXTesffeITbyXT335jJkjqW0ofKbzoIsImVejr23P
   E=;
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89860243"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:49:17 +0100
Date: Sat, 28 Jan 2023 10:49:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Luca Coelho <luca@coelho.fi>, cocci@inria.fr
In-Reply-To: <808cd549-f96d-872d-a4db-30ea33095207@web.de>
Message-ID: <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi> <alpine.DEB.2.22.394.2301272148570.4094@hadrien> <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi> <808cd549-f96d-872d-a4db-30ea33095207@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-928944294-1674899356=:2822"
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 826
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301281048270.2822%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-928944294-1674899356=:2822
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 28 Jan 2023, Markus Elfring wrote:

> > @@
> > identifier nested_macros.nm;
> > function f;
> > identifier dev_priv;
>
>
> How do you think about to use the following SmPL code variant instead of
> the metavariable type “function”?
>
>
> identifier dev_priv, f;

Good suggestion,  Function is not really supported.  I think it behaves
just like identifier, but it would be better to just use identifier.
Function was an idea thta never actually got implemented.

julia

>
>
>
> > expression e;
> > @@
> > f(...) {
> > 	...
> > -	struct drm_i915_private *dev_priv = e;
> > +	struct drm_i915_private *i915 = e;
> >
> > 	<+...nm(...)...+>
> > }
>
> Regards,
> Markus
>
--8323329-928944294-1674899356=:2822--
