Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC59C46467
	for <cocci@archiver.kernel.org>; Sat,  7 Jan 2023 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bi+t4ahCo6dRmDFfHPwckDJwo6YAppoodNfTRo2q2s8=;
  b=Pulin1W2WtxPmCIxbXnJl6LNC6YKoW+UnvWTmDd+4wj9++1cKBmAHGO+
   h3QZXwLOMiWvv6Xca5bfMbKefcq6XEfHBXssyPwocyFW1yHBzpIxanlZe
   5uRIPcLm6gPbw7KRjwsz9TNGojDTeSxobCeytmUVAy+gmJEVY8+ZxmXif
   Q=;
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
   d="scan'208";a="86414513"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2023 13:55:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06AEAE5A73; Sat,  7 Jan 2023 13:55:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 22278E5A70
	for <cocci@sympa.inria.fr>; Sat,  7 Jan 2023 13:55:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bi+t4ahCo6dRmDFfHPwckDJwo6YAppoodNfTRo2q2s8=;
  b=HicSCA+d/VHRZaWvzljqtadZEGjwHuTLGUOafHqx48+kz4KptlTwx+uk
   Ob8ruZDgaJxBacyzQVhEjGRUV2ahdy/ERpCV5AL19XVZNH4vBUmeRW1Gc
   glSkhXcEivGwUtk7eloh67aWRXiyTNfNUplCB0i5LmEESLJMiO4l8MOUz
   M=;
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="44404283"
Received: from 186.120.68.85.rev.sfr.net (HELO hadrien) ([85.68.120.186])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 13:55:07 +0100
Date: Sat, 7 Jan 2023 13:55:07 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
Message-ID: <alpine.DEB.2.22.394.2301071354000.2795@hadrien>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de> <alpine.DEB.2.22.394.2212260740380.2980@hadrien> <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de> <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr> <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Working with filled data structures
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 807
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301071354000.2795%40hadrien>



On Sat, 7 Jan 2023, Markus Elfring wrote:

> >> Does the specification of this metavariable type indicate the expectation
> >> that the applied metavariables will receive contents?
> > No, it should not.  Lists can be empty.
>
> How would you call a related data structure which must not be empty?
>
> Is there a need to express special constraints?

If you want to be sure that the list is not empty, you can either use
python to put a constraint on the length or make a pattern that contains
one element followed by a list.

julia
