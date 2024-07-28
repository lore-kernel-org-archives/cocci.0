Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644DBC3DA49
	for <cocci@archiver.kernel.org>; Sun, 28 Jul 2024 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GlVWucmH3dz37aVHdSf27ae6hLOfOlBqolhANyAoDqQ=;
  b=jRiCrZR1ZpzLEY0mM6JyFFPQcq3sDJ8Robz2TqQDu57tREy754bFIcVk
   wEFwUOjSXEZj00D6VTsPXOhBOp0xF7f5yyXT1ilo5Kf5U41UzDlM79wip
   hcAC/81aYNsIYp7lAzmIc/yIQQLbwXwDVF8m0Z5SZJEbf04BOXyPgkiTQ
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.09,243,1716242400"; 
   d="scan'208";a="177252141"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jul 2024 09:33:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C7CBE0141; Sun, 28 Jul 2024 09:33:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 563EBE0035
	for <cocci@sympa.inria.fr>; Sun, 28 Jul 2024 09:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GlVWucmH3dz37aVHdSf27ae6hLOfOlBqolhANyAoDqQ=;
  b=k3r/YVR8qbO+FKl0BCVGL3MbS4YXg2YrPQr7J8zS/iTS/tdhrDUrhCn+
   v2P9HmigaPY7n3LboAPQ1BQ/rorjcyvs0+6aY9+vtBv4PvIJ4JO1K49Dg
   SeUaebjuJfyeaHRpOZLOvT5br3lqH7SZMD1TWt1eWJdHZEd/5ijAurjqu
   4=;
X-IronPort-AV: E=Sophos;i="6.09,243,1716242400"; 
   d="scan'208";a="177252140"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 09:33:04 +0200
Date: Sun, 28 Jul 2024 09:33:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <6619fd74-fea1-4ccd-ab69-fab324c4917e@web.de>
Message-ID: <alpine.DEB.2.22.394.2407280932210.3358@hadrien>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de> <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr> <74d26d15-2c7f-49d7-8081-3fdaedcac273@web.de> <alpine.DEB.2.22.394.2407271844070.3211@hadrien> <6619fd74-fea1-4ccd-ab69-fab324c4917e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2128616183-1722151984=:3358"
Subject: Re: [cocci] Code adjustment challenges according to the comma
 operator (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1828
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/alpine.DEB.2.22.394.2407280932210.3358%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2128616183-1722151984=:3358
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 28 Jul 2024, Markus Elfring wrote:

> >> I would like to point out that such a simple source code transformation approach
> >> found 156 files from the software “Linux next-20240726” for possible updates.
> >> Will further collateral evolution become interesting accordingly?
> >
> > I think that you have to look at the examples and judget whether the use
> > of the comma operator is helpful in each case.
>
> Would you become interested to support the integration of another SmPL script variant
> for the coccicheck tool?

I think that such a script already exists.  Or at least the transformation
has aready been extensively applied some years ago.

julia
--8323329-2128616183-1722151984=:3358--
