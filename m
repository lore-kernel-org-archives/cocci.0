Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C154C369CB
	for <cocci@archiver.kernel.org>; Sat, 26 Apr 2025 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2tUf1FSIurzafrT1RbhiTHikhStVyszcPXfOTfMzLSU=;
  b=Fc2nFYWvVsIPXYAFNYyaVRh9bL2R9aD9lttUO67cO862HupOooER423+
   FPTskvf566UqR7J8iDlIXXfsvT7a/80d5xSNDUqQd+DHvFamHSiypiYtG
   R4YxWBbSvSbZAIS4bAhthm/zzEEkfm7eifCBrNcD3gujsj5DYQwpR9dmO
   I=;
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
X-IronPort-AV: E=Sophos;i="6.15,242,1739833200"; 
   d="scan'208";a="219574459"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Apr 2025 23:00:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6E26E0264; Sat, 26 Apr 2025 23:00:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 27BA9E007A
	for <cocci@sympa.inria.fr>; Sat, 26 Apr 2025 23:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2tUf1FSIurzafrT1RbhiTHikhStVyszcPXfOTfMzLSU=;
  b=g/lPU4h1mraLguHcKnHGe6YJW02rY8fMWZkri84kVhsvPzFz/xZ/cXJq
   a4VfxrEuSX017B7OZ0QfsRCQpoEkcvjw0k+euf7PcsjPedTCI+58y2N2V
   vk24kXD8eDBWCtoaB8Ey1k107qjZF/GGUZ0GWBoEt1p5cVumUiNwV30G1
   E=;
X-IronPort-AV: E=Sophos;i="6.15,242,1739833200"; 
   d="scan'208";a="219574458"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:00:39 +0200
Date: Sat, 26 Apr 2025 23:00:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Michael Stefaniuc <mstefani@mykolab.com>
cc: cocci@inria.fr
In-Reply-To: <160e1382-a7d2-4204-a6e1-09e6e4035b82@mykolab.com>
Message-ID: <alpine.DEB.2.22.394.2504262300230.3375@hadrien>
References: <160e1382-a7d2-4204-a6e1-09e6e4035b82@mykolab.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Missing annotated tag for version 1.3
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2725
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/alpine.DEB.2.22.394.2504262300230.3375%40hadrien>



On Thu, 24 Apr 2025, Michael Stefaniuc wrote:

> Hello,
>
> it looks like the annotated tag for coccinelle version 1.3 is missing from git:
> eris:~/work/coccinelle$ git pull
> Already up to date.
> eris:~/work/coccinelle$ git describe
> warning: tag '1.2.0' is externally known as '1.2'
> 1.2-195-g4093aad2d
>
> The lightweight tag for 1.3.0 is there though:
> eris:~/work/coccinelle$ git describe --tags
> 1.3.0-83-g4093aad2d

Thanks for the report.  Will look into it.

julia
