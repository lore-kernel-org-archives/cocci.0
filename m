Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E0DC369D9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hHZ4Pl/6n+Medqvlmhkd+++LU/OI6z0cyVEnL5b8Kww=;
  b=vn6VtPqDvVhQDg0Yul+a6rzwLz0E1duC1Lafcx4ben8YWNApIMF2hfyT
   aKg8engd4Ot6M8RJ9eiz+/RjBy521tu9cn0bDu52Ow7Q52wRRlaD/RfnI
   8NzpC7MA//Y41ONS0HcMwbWfWz/UqZMgVpOP6liTNaPy6KZt2+juLQqkL
   s=;
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
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220199051"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 16:23:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA606E0D1D; Wed, 30 Apr 2025 16:23:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 592CEE007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 16:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hHZ4Pl/6n+Medqvlmhkd+++LU/OI6z0cyVEnL5b8Kww=;
  b=uav+XuPevB16kgHGZFIQbTOFr7jZHVKcxsbFATf+iOBQAL9UuA4q5ieF
   rjzDyh6We++f1X8QImzUMAD0P4nKwMuaWy7Ave15jNoDidYt+lHUmc6br
   WCP5677FUIFG//lOFTmJY+cx0/qQhDNNVy4v/txDwYb0QkJIzJYCwN5vP
   8=;
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220199040"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:23:41 +0200
Date: Wed, 30 Apr 2025 16:23:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <168d3944-871e-4a08-9bfa-b1a1f597e93c@web.de>
Message-ID: <97522457-7023-73b1-2e2f-2f5f573e243a@inria.fr>
References: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de> <101ac934-7955-4266-4691-d834aec286c@inria.fr> <9c26bec1-887e-48dd-a72e-20dd13e41a95@stanley.mountain> <825f5062-6790-217c-4c57-d4b5b13c38d5@inria.fr> <168d3944-871e-4a08-9bfa-b1a1f597e93c@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1132658752-1746023021=:3426"
Subject: Re: [cocci] How to delete selected redundant null pointer checks
 with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2731
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/97522457-7023-73b1-2e2f-2f5f573e243a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1132658752-1746023021=:3426
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 30 Apr 2025, Markus Elfring wrote:

> >> Any NULL checks should be removed, I believe?
> >
> > That's not what Markus asked about,
>
> I tried to express something in this direction.
>
>
> > but one could do that similarly.
> >
> > - pointer == NULL ||
> >   ...
> I would prefer to use the operator “&&” (logical AND) for the shown test case.
> Can it eventually work better?

Maybe the function triggers a parse error?

julia
--8323329-1132658752-1746023021=:3426--
