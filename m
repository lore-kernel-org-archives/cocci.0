Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF04C77B7A
	for <cocci@archiver.kernel.org>; Tue, 30 May 2023 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=M9A0vcVF8IA1gHsjyEyXBJrCT9Za4gxMa+ZTE7U7qVE=;
  b=B/VezYb9PGOsr464pp/HjwfZ51b3H7vcKd6YcmpJt2589dtQaauhW3tU
   hlUO2P3ZuWHpkuAmv4Tz+BJzhNVwLhtRt432shOdDo2rh3JqAn7WZ1Hya
   /xdv+o8wgZqT1ITnX5absm/p6DnqBtm0U/1SGBd7f8Ha02+6BgTRQAPRh
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
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="110279823"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 May 2023 14:26:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 350CAE2697; Tue, 30 May 2023 14:26:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 50EDAE0090
	for <cocci@sympa.inria.fr>; Tue, 30 May 2023 14:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M9A0vcVF8IA1gHsjyEyXBJrCT9Za4gxMa+ZTE7U7qVE=;
  b=S8e5VGyaP6g2R9mOEPLhyj18/8JGVlYxb98B1EIH4hYpbvfXw/pAAmyo
   xRTI1+QWbryrP7oH9mhubm2Wze5aLoWbch/0xeyA9LOTj/20Ou1xB076V
   UctW7tJw7+bKXPZHBOJ0G8soZFesMwdQaUjGaHS4ZzgQ6ZkekMLFppMcm
   4=;
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="110279814"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:26:08 +0200
Date: Tue, 30 May 2023 14:26:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Claudiu Beznea <claudiu.beznea@microchip.com>, cocci@inria.fr, 
    kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f16a66f7-460e-3577-ec5c-e4ccf00065f2@web.de>
Message-ID: <7f63dd13-f69a-8171-90f7-5a4f46ed5790@inria.fr>
References: <20230530074044.1603426-1-claudiu.beznea@microchip.com> <f16a66f7-460e-3577-ec5c-e4ccf00065f2@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1892626257-1685449569=:3727"
Subject: Re: [cocci] [PATCH] Coccinelle: kmerr: increase check list
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1163
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/7f63dd13-f69a-8171-90f7-5a4f46ed5790%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1892626257-1685449569=:3727
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 30 May 2023, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/null/kmerr.cocci
> …
> > @@ -51,7 +51,7 @@ position any withtest.p;
> >  identifier f;
> >  @@
> >
> > -x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
> > +x@p1 = \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|krealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|devm_kasprintf\|kstrdup\|kstrdup_const\)(...);
> >  ...
> >  x1@p = f@p2(...);
> >  if (!x1) S
>
> Can it be nicer to specify desired function names on multiple lines
> for such a SmPL disjunction?
>
> Would you sort them according to their call probability?

Please don't follow either of these suggestions.

julia
--8323329-1892626257-1685449569=:3727--
