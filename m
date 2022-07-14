Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27A4C43334
	for <cocci@archiver.kernel.org>; Thu, 14 Jul 2022 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=upMDrtue7cwHhgnFts+VbIRtTrE3Sxb/udKfIASTuF8=;
  b=htCNSiNmLgnzYdfMnAGzP9lWvsIVL0vTgxMiXt/hBzQTst558g6KEyTN
   VYlRY2ruaoWlF+W+GmhkXlu47izGBeB4E3F+f0f0nlve8XQVhRj7VTkd0
   ALZHT9vddirFu5Ox5t0DvbNYk1efqdQi/Ej2LbvsFB/59dm7IWOMaECll
   w=;
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
X-IronPort-AV: E=Sophos;i="5.92,271,1650924000"; 
   d="scan'208";a="45588015"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2022 12:47:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 822B1E02E3; Thu, 14 Jul 2022 12:47:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 86564E0260
	for <cocci@sympa.inria.fr>; Thu, 14 Jul 2022 12:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=upMDrtue7cwHhgnFts+VbIRtTrE3Sxb/udKfIASTuF8=;
  b=OBwRFWlQMzGeoCEp6jtT70dKSmWSCLi7N1hUP7wg9v1/wxnN+6kk56KZ
   fz2vPBty+1JuoVySZQigymwXOfp0/GIOMWl9F9oehCt8/72+hlIkBE1rK
   OZxbhUnvD0VejFheZVv+An1mwoilAhrCzPG/US1eq2nxlKJg6qljaz+mr
   s=;
X-IronPort-AV: E=Sophos;i="5.92,271,1650924000"; 
   d="scan'208";a="45588011"
Received: from 150.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.150])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 12:47:48 +0200
Date: Thu, 14 Jul 2022 12:47:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc: Coccinelle ML <cocci@inria.fr>
In-Reply-To: <220714.867d4g2ewo.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2207141246300.3019@hadrien>
References: <220714.86bkts2fz9.gmgdl@evledraar.gmail.com> <alpine.DEB.2.22.394.2207141138450.3019@hadrien> <220714.867d4g2ewo.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do I disable formatting for the "+"-side of a rule?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 493
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207141246300.3019%40hadrien>

> Thanks, no it just changes the spacing of the "=", i.e.:
>
> 	+       struct ref_array array = {
>
> v.s. with --smpl-spacing:
>
> 	+       struct ref_array array<TAB>= {

Strange about the tab.  There was no intent to have alignment.

> (Or similar, I think it's aligning to the "=" above it?)
>
> But the rest is the same, i.e. a \n after the "{", the "0" on its own
> line etc.

Coccinelle now just does what you asked for.  If there is one element in
the initializer, it doesn't add newlines.  So no need for the
--smpl-spacing argument.

julia
