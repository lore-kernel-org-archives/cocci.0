Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD1AC54EBC
	for <cocci@archiver.kernel.org>; Sat,  7 Jan 2023 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5FvIL7KL5O+s1p1ZhG9ixtXIwMFujbbxlL+iPgoWJIU=;
  b=QLDsiIkXXwMo3Fv9gY15RQHQq5LylbxNWwP1b+ZWrFzCNcRbijao85m0
   3mLZSchevfD+F7Fza3SrmPawq8jnHoBL2hGcgpRRPo9RO3JqnKe5xKiYp
   euW0YJUr3izv01JNAZIAeNR38P+kTFIl0Na+40mdz55ewZgCzX1cOaRgd
   g=;
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
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="86415769"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2023 14:25:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E15A9E5A73; Sat,  7 Jan 2023 14:25:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 089C7E5A70
	for <cocci@sympa.inria.fr>; Sat,  7 Jan 2023 14:25:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5FvIL7KL5O+s1p1ZhG9ixtXIwMFujbbxlL+iPgoWJIU=;
  b=uu5ybC9yCwnUE1szIkx0Y+A5MWkuN/zuyXRKLQDvmvMGdsYt05WjiP9c
   pCXDneyBouImHp3OSaKbPuB/+T7qeGfl1Od+o51JH5k/8242o/lvwTzc4
   kyCHyzjuTtDqLkEsvgdx5FuaMaPyynwo0u3IP3KMmaeAAjgnd15AVwGd3
   g=;
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="44405204"
Received: from 186.120.68.85.rev.sfr.net (HELO hadrien) ([85.68.120.186])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 14:25:10 +0100
Date: Sat, 7 Jan 2023 14:25:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <cfa05a5d-1835-c58b-dc28-4b017cebe2f2@web.de>
Message-ID: <alpine.DEB.2.22.394.2301071423590.2774@hadrien>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de> <alpine.DEB.2.22.394.2212260740380.2980@hadrien> <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de> <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr> <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
 <alpine.DEB.2.22.394.2301071354000.2795@hadrien> <cfa05a5d-1835-c58b-dc28-4b017cebe2f2@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-599156893-1673097909=:2774"
Subject: Re: [cocci] Working with filled data structures
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 809
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301071423590.2774%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-599156893-1673097909=:2774
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 7 Jan 2023, Markus Elfring wrote:

> > If you want to be sure that the list is not empty, you can either use
> > python to put a constraint on the length
>
>
> Would this data processing approach need an extra SmPL rule for
> a supported scripting language?

No, eg, expression list[n] es : script:ocaml(n) { n > 0 };

>
>
> > or make a pattern that contains one element followed by a list.
>
> Would this design variant need pairs of metavariables?
>
>
> How do you think about the possibility to add a corresponding metavariable
> type like “array”?

Array does not suggest to me anything like what you are asking for.

julia

> Regards,
> Markus
>
--8323329-599156893-1673097909=:2774--
