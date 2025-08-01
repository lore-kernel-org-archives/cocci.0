Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B5C87FCA
	for <cocci@archiver.kernel.org>; Fri,  1 Aug 2025 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0xPur3YJrad7TO4HeKZAAAPv2O4uKfbpQ73fDPE+10E=;
  b=d5ICHzj7R6PX/w2w4mCDtDpre1MDwW1IXrfRFiNJ1rHWgSdXOttyHDvA
   VYJvAgBRCK3TbatGJcSYvwNoahyeS2+CfuFSnT5TCD67ZVqC+94S6XT6h
   hPPHbsGppGKDEFrc4HOOADgcLAAYauFaMzv5TkxyDpzWUSEwQjBYceQ0A
   g=;
X-CSE-ConnectionGUID: 5S7m4i5cQwmIsJBiykKyfA==
X-CSE-MsgGUID: fDjE9H9BR6myaOZS4Gvp7Q==
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
X-IronPort-AV: E=Sophos;i="6.17,255,1747692000"; 
   d="scan'208";a="233839990"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2025 10:06:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD88AE0264; Fri,  1 Aug 2025 10:06:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C2CBE0172
	for <cocci@sympa.inria.fr>; Fri,  1 Aug 2025 10:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0xPur3YJrad7TO4HeKZAAAPv2O4uKfbpQ73fDPE+10E=;
  b=KsNaS8STgi4c1LG+/k1XT8Fyjq6XMZQ1t3OXI9SRMsTt4RrcEUvSifu7
   t5IoOY1Tjcy0vPM1JHmWl03o78PT2vQiG9zFTqezpnB4HJr1uByfNkCiI
   DMMK1kWxT1s5NoEA2gnlAin1ksCuhwZZPoB8y2EhSX9pFL5TUV+3t1CrL
   U=;
X-CSE-ConnectionGUID: ySHxekNVTAmqtxDWblJULA==
X-CSE-MsgGUID: E1svAWhkQ+ycJGBNzyzPeA==
X-IronPort-AV: E=Sophos;i="6.17,255,1747692000"; 
   d="scan'208";a="233839966"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:06:18 +0200
Date: Fri, 1 Aug 2025 10:06:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
Message-ID: <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de> <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr> <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2923
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/23a375dc-e768-f2b2-1036-909be61596d4%40inria.fr>



On Fri, 1 Aug 2025, Markus Elfring wrote:

> > Would you like to add any insights why an additional qualification
> > would become relevant for the first SmPL ellipsis in the discussed
> > source code search pattern?
>
> Would you get further development ideas if the source code search approach
> (like the following for example) would be more general?
>
>
> @display@
> expression allocate, release, x, y;
> @@
> *allocate(x);
>  ... when forall
> *allocate(y);
>  <+...
> *release(x);
>  ...
> *release(y);
>  ...+>

What is the goal of using <+... ...+> ?  The only way you should have
multiple releases is if there is a double lock error.  If you want to
search for double lock errors why do it only in the case where there are
two locks involved?

If you want to check for lock(a) lock(b) unlock(a) unlock(b), there is no
need for <+... ...+>.  Furthermore, you need to check that there is no
unlock of a between the lock(a) and lock(b), likewise no unlock(b) between
lock(b) and unlock (a).

julia

>
>
> How do you think about to refine the selection of relevant
> macro/function calls here?
>
> Will any constraints become more interesting for usable call pairs?
>
> Regards,
> Markus
>
