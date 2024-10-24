Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616E8CE8E8A
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YoA41zTz/CeNH+v/1Ydp7keBktUa1VW3eLaOVkc/U1g=;
  b=QvLXEm4Fi8+deh85tjGYyouWHcjahdAW2m3R1eDjAtCaZM6J2fHqxbHM
   pCAqzhNL7Fq1jiUiMTP1BZyqHE26wY0kNqr0eG4FzWiN6qOKXvjZl441n
   BgRG6OcYN0WECQtWxZ48bxYIocic7PFmbzGOhE8/YRXEgzmPX7HDrY75J
   E=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190594591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 17:29:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B98CE0D1F; Thu, 24 Oct 2024 17:29:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 964B0E0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 17:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YoA41zTz/CeNH+v/1Ydp7keBktUa1VW3eLaOVkc/U1g=;
  b=k6Y/khR5ciEG3rqqTv1fanjUrLBuyOphIc3nb89gMSg0k8JoKctvZlfO
   puO+8wy1nM7ELfC1Ikl8a1TWKey0Ba7TMlNfrtKZo1AF5fIue3fvf/38h
   ZFhaIwNTHFYeXD+SsJkPHgwS3bNev6AEqIoMyf4XOTnIq5TBNjVVfsJhZ
   s=;
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190594578"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:29:00 +0200
Date: Thu, 24 Oct 2024 17:29:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
Message-ID: <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1922
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410241728210.3352%40hadrien>



On Thu, 24 Oct 2024, Derek M Jones wrote:

> Julia,
>
> > > Is here a way of improving performance, given that I am
> > > not interested in the returns?
> >
> > I don't think it's multiple returns, just multiple code paths.
>
> Ok.
>
> Is there an option that reduces the overhead, or perhaps
> an alternative way of writing the pattern?

Maybe using when exists on the ....

But the solution I proposed was created for precisely this problem.

julia


>
> --
> Derek M. Jones           Evidence-based software engineering
> blog:https://shape-of-code.com
>
>
