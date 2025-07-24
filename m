Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA88BC83F1A
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XrcvUuHLBMwF9ST7GA4K2qCqIEdXBb3Kk1/ONs74ueY=;
  b=YF2SCi1VEhxHyXsoK53tJWKZ/MjlXMGwlGbWJ2Tet9VqiViiEAsDaqUQ
   M6LUpL7Hkwkfg5qUAeL5D99H1qiR1VqQSotoEaIUID8uSYV6crcuQrlXu
   Ucu0Cmc01szt8wl3SsvYmiooPc0PJoJCAXjLfwOQgn1BzYDVZSvyI1+Xp
   0=;
X-CSE-ConnectionGUID: PvU6iZK2Q+W09aEwuBxIFw==
X-CSE-MsgGUID: cJwkMr84S4GIc01yIN3i3Q==
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
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="232924309"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 11:35:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1AD01E0CD5; Thu, 24 Jul 2025 11:35:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0F397E0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 11:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XrcvUuHLBMwF9ST7GA4K2qCqIEdXBb3Kk1/ONs74ueY=;
  b=V868vQrcwb0jjr8+OMKRPHsGnUNMjS9pb3/bmRZtWBXfwefQghYJgTJJ
   aC56O3veYKLi2imBD2Z68Toueq2JavRWAN6uPWoN8GTHhwKiZWWciLATs
   psgYDwCwz49/VEJj+2eyKXz/IBsLYmkTUosE2QixbDoABHS6ZJ6Uv6l26
   M=;
X-CSE-ConnectionGUID: LUjuy0VZRgOhOwBZpM5y4w==
X-CSE-MsgGUID: B8+CM3nhQ0etXV+iweBzzQ==
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="232924305"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:35:41 +0200
Date: Thu, 24 Jul 2025 11:35:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Anon Anonson <anon@chud.cyou>, cocci@inria.fr
In-Reply-To: <ed3aba00-d6b4-48f0-bb67-fe3d9e65bbec@web.de>
Message-ID: <68bc3cd7-5d9-033-b731-54c299d3d3b9@inria.fr>
References: <0ddb6d0c-b974-490f-b498-52e41c319368@chud.cyou> <ed3aba00-d6b4-48f0-bb67-fe3d9e65bbec@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-746808082-1753349740=:3509"
Subject: Re: [cocci] Replacing function declarations by pointer variables
 (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2905
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/68bc3cd7-5d9-033-b731-54c299d3d3b9%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-746808082-1753349740=:3509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Jul 2025, Markus Elfring wrote:

> > @ depends on decl @
> > type T;
> > parameter list ps;
> > identifier F;
> > fresh identifier F_fn = F ## "_fn";
> > @@
> >
> > - T F ( ps );
> > + T ( * F_fn ) ( ps );
>
> Another SmPL script variant can be tried out.
>
> @replacement@
> type T;
> parameter list pl;
> identifier F;
> fresh identifier F_fn = F ## "_fn";
> @@
>  T
> -F
> +( * F_fn )
>  (pl)
>  ;
>
>
> …
>
> > Example C input:
> >
> >
> > void f(void) {
> >     puts("...");
> > }
>
> void f(void);
>
>
> …
>
> > SP line 25: Not found a value in env for: T
> >
> >
> > I would like to know what I'm doing wrong or whether on off chance its a bug.
>
> Another test result (by the software combination “Coccinelle 1.3.0” for example):
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time /usr/bin/spatch convert_function_declaration_into_pointer_variable3-20250724.cocci example_for_Anon_Anonson-20250724.c
> …
> @@ -2,4 +2,4 @@
> …
> -void f(void);
> +void (* f_fn)(void);
>
> real    0m0,050s
> user    0m0,034s
> sys     0m0,012s

There was indeed a bug, which was that changes on the trailing ; were
being ignored at one key point.  The fix will be available shortly.
Markus's version gets around that by pushing the change into another part
of the code.

julia
--8323329-746808082-1753349740=:3509--
