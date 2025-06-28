Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2823BC54ED1
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OfQeq5rMLNYg0YZv7KqHayM4MKkp/9mDzhuo768BvnM=;
  b=pWi887seq5sF68VOo6g2XONsRpNRO7nShmqc6gCwLsotd/YxXwPBx78f
   BUx/3ZM90HtL2l8Us/9qm/Owa6iCgSBJV6z6V93Rt4jiNTf95fO8G0o3E
   3HEFw6JAy/61agSivAaEzIyMgFezYAewmwCVC3DM+rrRw0P/vy8EAVJlY
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229436297"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 23:21:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C45EE01A8; Sat, 28 Jun 2025 23:21:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E6BDE0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 23:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OfQeq5rMLNYg0YZv7KqHayM4MKkp/9mDzhuo768BvnM=;
  b=dIiMvMuJASWicKtYvPwMOpruljCRfbd3C9Wq/Hda/m816ol4YTPN1qiK
   fnAR+ZV7CrJAsBn93ht55/bO7MpdPQIc/6vyGrVnQbhXBsvUXo0pAl/dE
   csCFJcT2Ig+zcRHyL0jaFCXWy6uZenmqMPYeeHkgESzZMDyOnAkYpWRto
   E=;
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229436296"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 23:21:13 +0200
Date: Sat, 28 Jun 2025 23:21:13 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <9e81fa9a-57b5-442a-a3e9-eff1a1a9d63f@web.de>
Message-ID: <alpine.DEB.2.22.394.2506282320450.50494@hadrien>
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de> <alpine.DEB.2.22.394.2506281638300.50494@hadrien> <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de> <alpine.DEB.2.22.394.2506282132040.50494@hadrien> <8737f8dc-a10e-4f2f-8a50-87edc5c2aa78@web.de>
 <alpine.DEB.2.22.394.2506282142200.50494@hadrien> <47efbf70-5b53-4e7f-922f-b6405e240134@web.de> <alpine.DEB.2.22.394.2506282156560.50494@hadrien> <9e81fa9a-57b5-442a-a3e9-eff1a1a9d63f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2807
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506282320450.50494%40hadrien>



On Sat, 28 Jun 2025, Markus Elfring wrote:

> > What is the concern you are getting at?
> Under which circumstances would you put such identifiers into different name spaces?

None.  Doing something like you suggest would reduce the expressiveness of
the language, and doesn't seem at all like a good idea.

julia
