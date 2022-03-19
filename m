Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082A7C433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RIThztDeLEmkfYylMYnOTllUG9hauODAoIYQJWHhSwc=;
  b=ApwYhGkqYwM+t0Bcq4sLw/pD9DPcvIg/fNFXAfDP6HZHNQ09sFehrsUY
   Ui46Uw49STn0zHpkFKxCMpeVeBIaC8Zh4oPAEX2qKtYtZq70N2xxsCkUa
   GuyMhY1gycwq+MJasqAAZJx+2HhRAfD5c0h4aKFLYYOwZoOrmGHI9qqME
   0=;
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
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27025300"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 21:12:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3988BE020F; Sat, 19 Mar 2022 21:12:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 04A75E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 21:12:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RIThztDeLEmkfYylMYnOTllUG9hauODAoIYQJWHhSwc=;
  b=eJWVHO4DB9EODADiMumHvMEwxLTe3QVH4N+RVHDKSFE64TRQgCiGIqBe
   LhoWyRV0PdSIMHHnkMft42sycCPt+/npmXeEaesihMWn1o7trFm6BKSuU
   cIYsvmlClpN+rphInlCwuUCw04JOr11JW4Y4nFjsN7jCbwCr2rHTJ3L6/
   M=;
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="9038086"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 21:12:50 +0100
Date: Sat, 19 Mar 2022 21:12:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <6a41b56e-84bb-ead8-87c3-6d2d4421df7c@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203192110540.3204@hadrien>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net> <alpine.DEB.2.22.394.2203190922070.3204@hadrien> <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de> <6a41b56e-84bb-ead8-87c3-6d2d4421df7c@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Bug with '*' to display a match on the subsequent rule.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 254
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203192110540.3204%40hadrien>



On Sat, 19 Mar 2022, Eric Wheeler wrote:

> On Sat, 19 Mar 2022, Markus Elfring wrote:
> > > You can't mix * and + in a single semantic patch.  The patch you get would
> > > be strange.  There would be a + for the code that you want to add and a -
> > > for the code that you want to highlight.
> >
> >
> > How do you think to provide a better error message from the Coccinelle software
> > for a questionable mixture of SmPL data processing indicators?
>
> Its true, that would be nice.  I spent 20 minutes trying to figure out
> what I had wrong with my SmPL.  I had added the * for debugging and forgot
> about it.  After reducing it down to nothing it became clear that '*' was
> the issue.
>
> A friendly error like "You can't mix * and + in a single semantic patch.
> The patch you get would be strange" would be useful ;)

This has been fixed.  It resulted from a well intentioned but incorrect
attempt to provide file names and line numbers for this kind of problem,
which resulted in discarding the actual error message.

julia
