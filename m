Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8001AC35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=A1sCs7Tie9eZdUGp/zL1qLhbdIj0AH+h81uj86kXueg=;
  b=ElwXnWZgcwAawkIVkM8suOxe/LGdqbmNa1zNx66DwbVhOsssyZmUkNsM
   82Fcyl4WarzpIt1qxM6Cmi3e/bmJO7gOqIqtVr8EciFom1GiN9xqeLB5u
   hjYEq4WisHt3pIhB3XkMfBfrOTXY5/Ad3CRT8pJxhiIKPWv/i/+KvLphc
   w=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213709617"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 14:22:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5069E0D1E; Wed, 19 Mar 2025 14:22:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BCF42E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 14:21:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A1sCs7Tie9eZdUGp/zL1qLhbdIj0AH+h81uj86kXueg=;
  b=q2O/2WBiaOf9y34ywLx04aVIS9wDPxtaDHJIXVWTSSayqjEbIAB56U26
   2X7JGqVjQnKjjCb098ET+Zd09ar5tSei+zYGX0aWbv1/XyGfpDg5LfHi4
   DDxM7rTAttZnQDvaC4N5d6CAqlA+03qZwmNCZJVrfecOoWNc4LNYG4OFU
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213709604"
Received: from pd9ef1166.dip0.t-ipconnect.de (HELO hadrien) ([217.239.17.102])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:21:58 +0100
Date: Wed, 19 Mar 2025 14:21:56 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Olaf Hering <olaf@aepfle.de>
cc: Jacob Keller <jacob.e.keller@intel.com>, cocci@inria.fr
In-Reply-To: <20250319134816.3b7d026c.olaf@aepfle.de>
Message-ID: <c443f310-8cce-b9c1-6162-ec875a43af14@inria.fr>
References: <20250318111305.281abcca.olaf@aepfle.de> <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr> <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com> <20250319134816.3b7d026c.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2652
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/c443f310-8cce-b9c1-6162-ec875a43af14%40inria.fr>



On Wed, 19 Mar 2025, Olaf Hering wrote:

> Tue, 18 Mar 2025 14:52:42 -0700 Jacob Keller <jacob.e.keller@intel.com>:
>
> > Why not go the other route and optionally use the bundles?
>
> What is there actual purpose, what does (any) bundle actually fix?
>
> As you said, every bundle becomes stale. The way it is implemented
> means one can not even test them because the one from the environment
> takes precedence.
>
> If one wants coccinelle, use the package manager to install it.
> In case it is unavailable there, get a copy of opam and install it.
> In case one has to actually work on coccinelle.git for whatever reason,
> there can not be any convenience, except 'opam install coccinelle'
> which will install all required development packages.
>
> In the context of Packman I had to deal with way too many packages
> that bundle something which has to be provided by the system.
> Every single one was and is a mess to work with. Today my first reaction
> when I see any bundle is: purge that repo from disk and do something else.
> Which is what I'm going to do now.

OK. Thank you for your contribution.

julia
