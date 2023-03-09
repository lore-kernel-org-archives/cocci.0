Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D157DC742A7
	for <cocci@archiver.kernel.org>; Thu,  9 Mar 2023 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ke44NQIrCdapcOudFl0lQ1S7rvaQ2ZFmp9uNWTt7V5Y=;
  b=dLb1KMpNWwgvTpYpOoEfSJZDvBWMg2dAuWLHCasjLYePpfI4BS+yV5WI
   TBnbUZsVv4rnm89MqukclZsdMdzH/VTiioG+27oGfWz0/1h+jaaXBG9PN
   bmjLhM9HhQAkVqc+S2s4AnzeoZvDowZJSb8YN4TIfXeMJ2QshQ04iuuzj
   0=;
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
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="96272782"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2023 11:28:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BAA26E0C9E; Thu,  9 Mar 2023 11:28:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BFB8FE027F
	for <cocci@sympa.inria.fr>; Thu,  9 Mar 2023 11:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ke44NQIrCdapcOudFl0lQ1S7rvaQ2ZFmp9uNWTt7V5Y=;
  b=S+VGpyDcF5bZpeefHqeen6ljvc0ofqAOjkoelhitMAHGxQh160fJyyHg
   EvK89JVrs4NE8gyOxyWH+pIfmnuyi8gcnTOoDjpN1bHjTyENXm9AbtkBC
   N9fqJg/LhJ3BfoFceFCSBIZsfVAeOVt2qHqfYU9SXAFU8os1QQWvR/I4H
   8=;
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="96263642"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 11:23:10 +0100
Date: Thu, 9 Mar 2023 11:23:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <20230309111541.4bd397f5@nbbrfq>
Message-ID: <fff564db-166-1d7d-c2d-5da8afb9e537@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq> <89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr> <ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr> <20230309101001.78c0bc26@nbbrfq> <95103e65-6f5a-ae64-8ab2-7c57e5ca9438@inria.fr> <20230309111541.4bd397f5@nbbrfq>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 884
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/fff564db-166-1d7d-c2d-5da8afb9e537%40inria.fr>



On Thu, 9 Mar 2023, Bernhard Reutner-Fischer wrote:

> On Thu, 9 Mar 2023 10:38:50 +0100 (CET)
> Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > > Now, mere cosmetics, but is there a way to retain the spaces before the
> > > braces in the replacement?
> >
> > Try the argument --smpl-spacing.
>
> That does the trick, thanks!
>
> Is there a way to use regexp captures for the matching and replacement
> part? Think templates for (parts of) the name of the identifiers.
>
> In the specific case of mpz and mpfr, both use a similar API for the
> allocators {mpfr,mpz}_init{,2,3,_set_str} and deallocators
> {mpfr,mpz}_clear{,s}
>
> To avoid duplicating the rules for "mpfr" and "mpz", it would be handy
> to match and replace per the underlying type or, maybe, a part of the
> matched identifier name. Is that something that is readily available?
>
> Just curious, it's not all that important..

You can use regular expressions, but I'm not sure that there would be an
easy way to correlate the added code to the matched variant.

julia
