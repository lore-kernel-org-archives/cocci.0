Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280BEC7618D
	for <cocci@archiver.kernel.org>; Tue,  4 Apr 2023 06:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nR+33zgPnaDNVj9WRNC6/NE0pMpnhGcy65HMo1/6oVE=;
  b=DRmKW/BMKVtW+DySmmESZ1R/8vu9W+SdryW0SB01I4HCfv8XOx3ZbcOZ
   giKusQ91LMIF3/nprk/K88KlT1MkNFQ7NkTE3HHd9rrHRjBTATUdRAEB9
   cORWg4qqAEFvqPz/e78A5m6AX1BeEY41Vux/qfQCaRddvYjdgbl5yzoah
   g=;
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
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="100560453"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Apr 2023 08:29:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF1EBE019F; Tue,  4 Apr 2023 08:29:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 32FF2E00CE
	for <cocci@sympa.inria.fr>; Tue,  4 Apr 2023 08:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nR+33zgPnaDNVj9WRNC6/NE0pMpnhGcy65HMo1/6oVE=;
  b=BXu5qBrimEqxyfX2e3g8m2GOeDNmlacgKtIF01LoAlgqSsTisl1HD7W1
   i6oGtCbOIyrMUCO24QDZPWNfxABUJ/QBr6hnFqDYKqjq4yfQIxb7Gu+wB
   qm053bkC1LGHWBh2SPKcRPa55pw2FKeBmShXiQNl7eO6jtllzrpt9pT8B
   4=;
X-IronPort-AV: E=Sophos;i="5.98,317,1673910000"; 
   d="scan'208";a="100560446"
Received: from unknown (HELO hadrien) ([145.94.122.99])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 08:29:15 +0200
Date: Tue, 4 Apr 2023 08:29:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <58d22807-63f2-da0d-e1a6-84210cb81e66@web.de>
Message-ID: <30f398f2-1394-b67a-4ca4-ab6118c549e4@inria.fr>
References: <4bd84094-5838-c630-d1ec-d2d6bd0380ea@web.de> <b59a8472-95df-b592-78d6-9543aef463ac@inria.fr> <58d22807-63f2-da0d-e1a6-84210cb81e66@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Completing support for fork-join work flows
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1000
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/30f398f2-1394-b67a-4ca4-ab6118c549e4%40inria.fr>



On Tue, 4 Apr 2023, Markus Elfring wrote:

> >> Complete support for fork-join work flows
> >> https://github.com/coccinelle/coccinelle/issues/50
> >>
> >> Will the chances grow to benefit any more from parallel data processing
> >> also by the means of ordinary output into different files of tasks
> >> (or background processes)?
> >
> > It has been possible to have initialize and finalize code for many years now.
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e910982fe0830c9dccc9a8d3a4639484947a7559/docs/manual/cocci_syntax.tex#L658
>
> Would you ever like to distinguish the scope for such actions?

Why are you referring to the section about metavariables?

julia
