Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD84C54EAA
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8fv5Gbx9VAECwyfRII0rBv1/J1IaV/8To+U/HlpdnxI=;
  b=TAQTRAuxfPT5RiomTj16xhQjHyYl4w0l8utP5EmaMpQP9g3D406txnDh
   fb5sH6m++Dwhf12aup/iIEHny8lKxLsCyKtWr8hxfJ1zusNXweuyLTt6J
   EAX2ECTqOWVHq3uerCS3uzBKX1XjZmZeaXc6fQcY3dCLp7tccWdYJPFEc
   U=;
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
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90031592"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 10:56:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4A6A0E7441; Mon, 30 Jan 2023 10:56:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 28315E743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 10:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8fv5Gbx9VAECwyfRII0rBv1/J1IaV/8To+U/HlpdnxI=;
  b=nf5RKRfkHQfSBCQ9jEKKqFUc2rREnI0/yrCS+VGuzB3+VODHd6KBVOk9
   zj36bLJD69aPzdKEg/mqJ27F9cHKYz2FJeDa/WhgWMD0yEB+0ycd6zzGv
   CbTUmurPSHq7fmj9xP/94ekY4S0LS6USbyRQZmIBiRrzvK1yotVLFDCRd
   c=;
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="46335792"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:55:58 +0100
Date: Mon, 30 Jan 2023 10:55:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
Message-ID: <bed7a8f8-3a83-68f-bc7f-ac1b3e85228@inria.fr>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>  <808cd549-f96d-872d-a4db-30ea33095207@web.de>  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
  <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>  <alpine.DEB.2.22.394.2301281432120.2822@hadrien>  <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>  <alpine.DEB.2.22.394.2301291826510.2852@hadrien>  <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
  <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>  <alpine.DEB.2.22.394.2301292109320.2852@hadrien>  <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>  <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>  <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
  <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>  <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>  <079efecb-91da-e111-1a28-2c883b69af7b@web.de> <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 851
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/bed7a8f8-3a83-68f-bc7f-ac1b3e85228%40inria.fr>



On Mon, 30 Jan 2023, Luca Coelho wrote:

> On Mon, 2023-01-30 at 10:50 +0100, Markus Elfring wrote:
> > > I don't think the problem is in the rule, since this works on an
> > > isolated version of the function and macro definitions.
> >
> >
> > Would update candidates be found by using the SmPL asterisk
> > functionality?
>
> Sorry, I don't think I'm aware of this functionality.

It's for searching.  It only requires the existence of an execution path
that matches the pattern, rather than requiring that all execution paths
match the pattern.

julia
