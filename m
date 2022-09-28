Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8EDC04A95
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ioivS1V7GHsdJzqdrKuGG5bWn6AGbWF3vEj9IyVfMR4=;
  b=odPeobPNCJ8Vc3IwnszoeEK+8UvM/AGA/4vbkmi0B/pGm+19CKtaU/ZE
   cLHYpQCV2uWgpUs9eD/Jn8PoskTJfhWr2dKW2sH1EtWiUACB+H2y0FM+Y
   fs9jfnUrK1fwPumUMelcYpHgRKBxHzPP9JOqLoXhq1Zu05WnPDv0FPONp
   4=;
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
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="55023345"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 21:26:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 07197E028F; Wed, 28 Sep 2022 21:26:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 97B76E0076
	for <cocci@sympa.inria.fr>; Wed, 28 Sep 2022 21:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ioivS1V7GHsdJzqdrKuGG5bWn6AGbWF3vEj9IyVfMR4=;
  b=ngVg+Spbf8JunaZyoJNZVrTFUd69LfuNvL3JE2V5IBfFMYh7+spTxga3
   ZeXx7SdetuWFmua3kIuLyETW5sl/ofPJ2C6/eb1DsnwfD7GzS3i6Re2lN
   Vyt4+Iqwtwo1poSvwEL4zcrTq+bN5NmSGBeVttes2Fvjiv3FLf/7qItJH
   4=;
X-IronPort-AV: E=Sophos;i="5.93,352,1654552800"; 
   d="scan'208";a="55023344"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 21:26:08 +0200
Date: Wed, 28 Sep 2022 21:26:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
In-Reply-To: <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
Message-ID: <alpine.DEB.2.22.394.2209282125470.2984@hadrien>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien> <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-879309369-1664393168=:2984"
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 599
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209282125470.2984%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-879309369-1664393168=:2984
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 28 Sep 2022, Markus Elfring wrote:

> > @lock@
> > type t;
> > t o;
> > identifier f;
> > identifier lock = {spin_lock,…
> > …,mutex_lock_io};
> > position p;
> > @@
> >
> > lock(\(&o.f@p\|&o.f@p[...]\),...)
>
>
> I got the impression that you demonstrate a special application of
> the metavariable kind “type” here.
> (I imagine that addresses would be determined from data structure members
> according to passed identifiers.)
> * How do you think about to explain such an implementation detail a bit more?
> * Can the SmPL manual be adjusted accordingly?

t is a metavariable that gats bound to the type of o.

julia
--8323329-879309369-1664393168=:2984--
