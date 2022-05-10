Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2B1C433F5
	for <cocci@archiver.kernel.org>; Tue, 10 May 2022 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HN+mp/dxZIUCRS2xee1rDX9S8zWhjbKAht2Kh2IW+SY=;
  b=Vw7YwFr6BzYns+VhTCGdBePAvCDRG/4Ac67BWtvohPiPaD1V1ggw9yXT
   Q5Cf9df/0f9nYXMen37Rz5YudQe8+5W4YEqxqhUAPcUgP8OxUek8QG6Nc
   lSuLfHCG+BIYltJzzNvJiKLFbaFBx82/zbS6hO5FLoW9X7vGOE6JHhOLi
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
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="35527630"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2022 11:24:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9699CE027B; Tue, 10 May 2022 11:24:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7D696E0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 11:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HN+mp/dxZIUCRS2xee1rDX9S8zWhjbKAht2Kh2IW+SY=;
  b=NhTOpOkNKiFfP6rT22UXckZ5VQwUTMZGsqc4GVxl04MycqiI+aT2PSXU
   qx2qK1JJh8jVqNLaVxcC7PtoBkQZSs5yrlKDasHwlm2ox9+jQHZ5vYxfC
   rSWzHD4pEHRG2VSaXIDc5tjlAmcKIJcrAmbVmF2ROXv9rceeE4jMHvc/f
   I=;
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="35527619"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:24:22 +0200
Date: Tue, 10 May 2022 11:24:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com> <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com> <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com> <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 374
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205101123120.2667%40hadrien>

> There are also problems with some "__randomize_layout" statements, but I've not yet isolated the minimal statement that can report "__randomize_layout" as the global variable name.
> My assumption is that I can add defines as done in the init_defs_builtins: /usr/local/lib/coccinelle/standard.h, but using the -define argument with a file containing these defines does not solve the
> problem.
> Sorry for keeping this thread long, but your advice would be very appreciated.

-define is to indicate that a configuration variable is true.  You want
--macro-file <file>

julia
