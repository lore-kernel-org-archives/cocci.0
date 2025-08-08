Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08FFC87FD3
	for <cocci@archiver.kernel.org>; Fri,  8 Aug 2025 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lMvetQLWndDO15N4vsZ9mN1dPRor3k9urtlS1d9Nu9w=;
  b=duZOPqmzekkH2xcJnR862+1V746qQuu8Au3SBw23JgYbSUITttEvs9dC
   6cO2X3yB/QKuMrbcC7x0tcZ1xRLmBeT82CZAXx6dwVVu8JHJobW2bLN27
   G/pJRBzkgKJy9EZIUicB6nsyeqdOztnddwIZwKjo/y6DWMXZEhhe2km2c
   s=;
X-CSE-ConnectionGUID: 4pAGxdeaSM2SodffGbRkRA==
X-CSE-MsgGUID: /Q+6AgobSZqrw7iff4Niog==
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
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234525222"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2025 10:29:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 37944E0BE9; Fri,  8 Aug 2025 10:29:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2EB4AE0171
	for <cocci@sympa.inria.fr>; Fri,  8 Aug 2025 10:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lMvetQLWndDO15N4vsZ9mN1dPRor3k9urtlS1d9Nu9w=;
  b=roEhpBtzhhogZ+xVkEZXccQilNbu2XmiO98dvqcYBgHo7/lFwbuWymrA
   buoPGfOWvAs0HQ4g541UCQWrgpYb6HNlYl4Ml2nMt4/0t+lVZxzJTCVwh
   JnJzDGiI3JLMH8BOmllAGPDdvOJ1rWmm1xR8oWRZQt9d7x4BtwHduY7Io
   s=;
X-CSE-ConnectionGUID: XDlK5d6/T2O7f0eMhLsNsg==
X-CSE-MsgGUID: l/x4m7S4Sn+52FRE+qH5/A==
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234525212"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:29:40 +0200
Date: Fri, 8 Aug 2025 10:29:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Michele Martone <michelemartone@users.sourceforge.net>
In-Reply-To: <22cfa841-e385-4d02-be5e-ae7c88188d5d@web.de>
Message-ID: <24c7cda-a3d9-a41d-aa3f-21b16bc975d0@inria.fr>
References: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de> <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr> <22cfa841-e385-4d02-be5e-ae7c88188d5d@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1566962626-1754641780=:3519"
Subject: Re: [cocci] Searching for C++ delete expressions (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2970
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/24c7cda-a3d9-a41d-aa3f-21b16bc975d0%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1566962626-1754641780=:3519
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 8 Aug 2025, Markus Elfring wrote:

> >> Another SmPL script example:
> >> #spatch --c++
> >> @display@
> >> expression e;
> >> @@
> >>  delete
> >> ?[]
> >> *e
> >>
> >>
> >> Questionable test result (by the software combination “Coccinelle 1.3.0” for example):
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> /usr/bin/spatch --parse-cocci show_delete_expressions.cocci
> >> …
> >> warning: incompatible arity found on line 5
> >> …
> …> In general, I don't think you can put ? on random subterms.
>
> How will the support evolve further for key word variants of the programming language “C++”?
>
>
> >                                                              You could do
> > what you want with a disjunction.
>
> Under which circumstances will the mentioned “warning” be reconsidered better?

None.
--8323329-1566962626-1754641780=:3519--
