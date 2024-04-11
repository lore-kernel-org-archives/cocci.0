Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0436FC4345F
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2024 21:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dYjICHuNW5p8lW2bqyzuinBQrhBhaEh66HfB+PvDqn8=;
  b=q5+EbIGWhP/qMJ5k1lGGhPc8IgyNiFy/HGXC7tqLHlmpzM1DMTqYKjtd
   fst8Ho8bQ3HvO2ZtCWPWum8m1cOPpwLusHBWgQVw+jCYTRyThRzfKp78t
   qg+t6BIlyOJUqo9xV2iVJ0f9H61LBMlfy7b8Y+vNrbLk3fYOOEWjG9f6U
   k=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,194,1708383600"; 
   d="scan'208";a="161153278"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2024 23:05:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8324AE0AF6; Thu, 11 Apr 2024 23:05:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7A9B0E0131
	for <cocci@sympa.inria.fr>; Thu, 11 Apr 2024 23:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dYjICHuNW5p8lW2bqyzuinBQrhBhaEh66HfB+PvDqn8=;
  b=HShKJOIla1qYqYO8SNgywlIZQmqD/tFwb2DtQKCjHYeH9g4NN/Hr4Da8
   FYJ5yr6z50XaT0358dFt9XOZc3wLOluRH1DeqEblvHayLGC742yDA5D0D
   sYWPhecqC0JVXHTBDGx6oFkEVXCOSJMYWbuI0zbacsKQoCofcH/WEd51p
   g=;
X-IronPort-AV: E=Sophos;i="6.07,194,1708383600"; 
   d="scan'208";a="84522132"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:05:10 +0200
Date: Thu, 11 Apr 2024 23:05:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Wolfram Sang <wsa@kernel.org>
cc: cocci@inria.fr
In-Reply-To: <ZhhO29XtBmBkyuQo@shikoro>
Message-ID: <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr> <ZhhO29XtBmBkyuQo@shikoro>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] new version 1.2
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1641
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/alpine.DEB.2.22.394.2404112304250.3048%40hadrien>



On Thu, 11 Apr 2024, Wolfram Sang wrote:

> Hi Julia,
>
> > There is a new version, 1.2.
>
> I compiled it but the "--in-place" option does not work for me. Can you
> reproduce that? "-in_place" worked fine with the 1.1.1 version from
> Debian.

I tried spatch test1.cocci test1.c --in-place and it worked...

julia
