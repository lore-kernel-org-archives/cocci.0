Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0A2C3DA6E
	for <cocci@archiver.kernel.org>; Mon,  8 Jan 2024 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=JfUNOgTQU6F4dJOA3aGmidWCLSejoqCRXC4v4MqLn2E=;
  b=U6HEz5eOboDvhKYAI9m/BjmNpUbbvqgeYCfqyG6h469oXzgvfSn6SoaC
   rQCKlz6e8Rs5UBXfsfhIzTDlI4VzLd0+0e2C/zhyghJjJ539ymoFv4p7p
   1KoufcFGVKXWEn/p2W3oz8G8zCi9U3rZjJ1jrOnRPHcH032VjsTUETwzh
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.04,340,1695679200"; 
   d="scan'208";a="145295233"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jan 2024 07:37:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5DDD4E0CCC; Mon,  8 Jan 2024 07:37:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A7BD6E004E
	for <cocci@sympa.inria.fr>; Mon,  8 Jan 2024 07:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JfUNOgTQU6F4dJOA3aGmidWCLSejoqCRXC4v4MqLn2E=;
  b=bwPFkv+mCJ/rijeeCsbMsrGXRn0so+p0tnsLmKhsOBY3h+YQkH+3yOjj
   5GU5grNFqcm3BXKuOD/zgdR5UoO85/RDi6JNnOpE7qoMGO+X9m+8ZmUAG
   3eYWYEUlBuVXLwtCVF8GkXpbszbh9plIE2PDZSmEQd9Ur/HIlOs5ORc7v
   8=;
X-IronPort-AV: E=Sophos;i="6.04,340,1695679200"; 
   d="scan'208";a="145295230"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 07:37:55 +0100
Date: Mon, 8 Jan 2024 07:37:54 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
In-Reply-To: <20240107144227.273e0233@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2401080736450.3630@hadrien>
References: <20240107103536.5719ce30@kernel.org> <alpine.DEB.2.22.394.2401072115050.55089@hadrien> <20240107144227.273e0233@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] EXN: Coccinelle_modules.Common.Timeout
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1440
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401080736450.3630%40hadrien>



On Sun, 7 Jan 2024, Jakub Kicinski wrote:

> On Sun, 7 Jan 2024 21:15:54 +0100 (CET) Julia Lawall wrote:
> > > I couldn't google out any meaningful info about this. Is the timeout
> > > something I can increase locally? Is something wrong?
> >
> > Perhaps if you pull from github it will work better now, ie keep going
> > after the timeouts.
>
> Thank you! I fetched from github, and after an hour it's still making
> progress, previously it error'ed out after 10 minutes or so!

Great.

> Next issue.. :) when I run with --use-patch-diff commit1..commit2
> I get these three lines for every spatch run:
>
> grep: warning: + at start of expression
> grep: warning: + at start of expression
> grep: warning: + at start of expression

OK, will look into it.  I think this comes from coccicheck, not from
Coccinelle.

julia
