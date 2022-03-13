Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9864C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=289JoH18pfiuA+eihIdLxQJos+5UKIW+SvGlzhfVotk=;
  b=WOz4nL3Nho13qBmZ41ZzMmcu15Nf/No1R1Vtz2UON6KTejQ/ZAUlIjXj
   nOxkyioS8Xi4RF/xURojst66R0T0ogwj7hihmVZecLr4QwhTm0QvR817s
   uvnDjFkqOmJJ8BTbaAWNi7VRa/JvmWJmK6f3S9Qi4pEDNQQcdEZO/+OFW
   8=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25870632"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 18:33:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E8EF8E006C; Sun, 13 Mar 2022 18:33:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E77FCE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 18:33:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=289JoH18pfiuA+eihIdLxQJos+5UKIW+SvGlzhfVotk=;
  b=WtcQeZSAePqpNgLTFLULWN/obe/AO4UEVDtPhSkXJTijTdf7uu9mcPZ4
   DA6jnxEqk7Z7MajUMdFTaYacl+rF74mDEXXOnkn7SofiLLKrhCoxEzk4a
   qcrJkp7x1XfuBiZXx4YDTD3H1vI3/HRBTls48KrXVVt3s9cYO1b/jFl3k
   Y=;
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="8405331"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 18:33:52 +0100
Date: Sun, 13 Mar 2022 18:33:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Luis Chamberlain <mcgrof@kernel.org>, 
    Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <fdf66d4d-8e82-77ca-b35f-13427bee0a02@web.de>
Message-ID: <alpine.DEB.2.22.394.2203131833250.18925@hadrien>
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net> <Yi4ce+2k03795Rut@bombadil.infradead.org> <fdf66d4d-8e82-77ca-b35f-13427bee0a02@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-342904282-1647192831=:18925"
Subject: Re: [cocci] Can Coccinelle concatenate or append to existing string
 literals?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 223
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203131833250.18925%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-342904282-1647192831=:18925
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 13 Mar 2022, Markus Elfring wrote:

> …
>
> > @initialize:python@
> > @@
> >
> > def make_my_fresh_expression(s1, s2):
> > return '"' + s1.strip('"') + "/" + s2.strip('"') + '"'
> >
> > @r3 depends on c1 && c2 && c3@
> > expression c1.E1;
> > identifier c1.sysctls;
> > expression c2.E2;
> > identifier c2.base;
> > identifier c3.header;
> > fresh identifier E3 = script:python(E2, E1) { make_my_fresh_expression(E2, E1) };
> > @@
> >
> > header =
> > -register_sysctl_table(base);
> > +register_sysctl(E3, sysctls);
>
>
> How relevant is such a SmPL script example (which seems to demonstrate the selection
> of a name pattern) when string literals should be constructed?

It shows how to generate noew code from some matched information, as was
asked for.

julia
--8323329-342904282-1647192831=:18925--
