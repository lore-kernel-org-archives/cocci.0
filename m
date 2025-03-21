Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B513C36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=z/skIuByZpaEAEMK6UFD9ovb6633/CsLIA4CQbB61Qs=;
  b=e0gAslXXGtBVUzpMjxng9dIwAABfEPAcRznZDcDqvyfYmmE29arFFNBa
   UbyFepCj4T4s+RfrQg76z396kt4WA6GwuoVqPdlTE13CoUb/ryPvdyIBm
   IWuXli20D2xAbd72SfwwJwUKzNYZ7op2IsmvhWgRutHHpw++Pb727/mfH
   o=;
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
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214144005"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 15:00:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF9B1E0261; Fri, 21 Mar 2025 15:00:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40210E0264
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 15:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z/skIuByZpaEAEMK6UFD9ovb6633/CsLIA4CQbB61Qs=;
  b=DmxhU0WtOgZM3BLeW6+aPj142SxAgwikXQAg9dGsIFEw++Hk+W6Ahwcz
   Marj3UmNUl72rw5fPNwJjz0ewMc/jt5p3E946GVpDTQdHoUQiZnb6zBWs
   vVm1T6tW5GuA+5vU/14zAehGdizfNxyxczp22TgMElBPDIKtHTPBmWKA/
   s=;
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112261989"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:00:33 +0100
Date: Fri, 21 Mar 2025 15:00:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, =?ISO-8859-15?Q?H=E5kon_L=F8vdal?= <hlovdal@gmail.com>
In-Reply-To: <93d554e9-7b42-4d1c-b65d-5be649f93f5f@web.de>
Message-ID: <8fb86d6e-f95c-da18-d750-609c77927897@inria.fr>
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr> <CAACXqO9vVrOFyrcZhKZxvO=H9C7Kp-x2jM9O_mCTd=RA0mQ5XA@mail.gmail.com> <634d9530-6d94-49ae-8abc-7b93d6c4fa7e@web.de> <dd7cb31e-bf5e-2cd3-3f62-1e572c72da0@inria.fr>
 <93d554e9-7b42-4d1c-b65d-5be649f93f5f@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-320716143-1742565632=:3459"
Subject: Re: [cocci] scoped_guard
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2672
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/8fb86d6e-f95c-da18-d750-609c77927897%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-320716143-1742565632=:3459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 21 Mar 2025, Markus Elfring wrote:

> >> https://docs.python.org/3/reference/compound_stmts.html#the-with-statement
> >
> > It seems related, but I don't see a generic name that would be suitable
> > for a metavariable type in that documentation.
>
> Would the term “with block” be too generic?

So then we would have:

with block name scoped_guard;

I'm not sure it makes a lot of sense...

julia
--8323329-320716143-1742565632=:3459--
