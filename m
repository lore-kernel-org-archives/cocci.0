Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F7BC433F5
	for <cocci@archiver.kernel.org>; Thu, 10 Mar 2022 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qFq9CN4zSYyaQbHnLH+WKLPs9BEI9DPYg0AYa4mEryM=;
  b=EcPanuYidFIF0Fx9cI+GlFpEZ+U/qZjCWG3B4cfUXgBWPQ8B2yi2Uutb
   KzR+Ovi65ECKmxsL4Vb1OrlIERPDHFv1q6JIbLxerHIa+54IcDfazKMmp
   Ne9W1a3Xh4UWBGffgMLQ0KHOHje0jOBvuINNRSBf/Ln0NYTWbwdMPuBtp
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,169,1643670000"; 
   d="scan'208";a="25350857"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2022 07:12:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57B9FE2FBA; Thu, 10 Mar 2022 07:12:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 02083E2FB8
	for <cocci@sympa.inria.fr>; Thu, 10 Mar 2022 07:12:32 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,169,1643670000"; 
   d="scan'208";a="8115974"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:12:32 +0100
Date: Thu, 10 Mar 2022 07:12:32 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203100709100.2925@hadrien>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <alpine.DEB.2.22.394.2203090654100.4094@hadrien> <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net> <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
 <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 200
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203100709100.2925%40hadrien>

> I'm not sure how common of a use-case this was, but if OCaml already
> supports regex groups then perhaps it is trivial to create a "group"
> notation in SmPL for metavariables using regex's.  (Or perhaps not, I
> really haven't used OCaml so I can't comment on how easy that would be!)

The problem is how to refer to the groups in the semantic patch.

I guess that the @n notation is possible, but I'm not enthusiastic.  But
on the ihter hand I never use regular expressions either.  There is still
the option of script code, as in demos/pythontococci.

julia
