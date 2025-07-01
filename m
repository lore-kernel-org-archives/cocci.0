Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E305C83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=eOx+NJIuGMqcVMjBJyWzTaqY/o8fbaagPSR0kojIRHQ=;
  b=NhE9zs41Osgfo1ktVnhAs3NLiAslxNsS8aotEg2NwU0xaNHeyYwVd7ei
   qQwZcqmcIjLjoCJlCcQYWkOOu1gKHGirFIEfpf7UiMb1XJLE8tahgTUyV
   aue3okrFas4QXMJcDru6L3PoNYlB9E77WghThtcmCQF/LogBe6dOqlAbW
   w=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229825848"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 16:01:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 926F9E0AF1; Tue,  1 Jul 2025 16:01:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 690D7E01A8
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 16:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eOx+NJIuGMqcVMjBJyWzTaqY/o8fbaagPSR0kojIRHQ=;
  b=Rafo8qxL8mxayNRmWFdZfr2RgwmMg+QVaP5cd8UpQB0LOxfpFkEXzAAl
   BCJZ0+rp7LHaGE+NcY1BSdN/76BwUvbMELnWBAZcPocPN7NZT8OXKg0NZ
   JLg61SwoSYPm8iypkZ3iaS8nGJP38l3foV2qJFgw0ZP7c+ZRLXG0PKHEv
   E=;
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229825817"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:01:07 +0200
Date: Tue, 1 Jul 2025 16:01:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <12e9c764-18ed-417e-baab-66accbe52cd0@web.de>
Message-ID: <4341664-8fa5-728-756d-3a3e95c2857b@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <bd958cff-a9bb-4f6e-8305-e5a09375ccc6@web.de> <5da0fab5-ebbd-491b-84b1-69db7cec524e@web.de> <92cfc83e-99b8-409e-8691-e761b3ede15f@inria.fr> <12e9c764-18ed-417e-baab-66accbe52cd0@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1218773111-1751378467=:7618"
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2843
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/4341664-8fa5-728-756d-3a3e95c2857b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1218773111-1751378467=:7618
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 1 Jul 2025, Markus Elfring wrote:

> >> Another SmPL script example:
> >> @display3@
> >> statement s;
> >> identifier i;
> >> type t;
> >> @@
> >>  t i;
> >>  <+...
> >> *s
> >>  ...+>
> > You don't need the +
>
> Would we occasionally like to show a “list” of statements (detailed control flow)?

What you like doesn't really matter in this case.  The only thing that is
supported is when the list of statements is precisely the body of a {}.
There is no unit in the cfg that a metavariable can be mapped to in the
other cases.

julia
--8323329-1218773111-1751378467=:7618--
