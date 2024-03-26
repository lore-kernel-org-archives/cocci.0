Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27842C6FD1F
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2024 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UQ8/oRjsQzICMkI6DHWCYORk9cd/ct+TrJW+UsMe6k8=;
  b=Nfk1QwzyCbfX4l50rioV6fWTG94MYCAOzTdK2ul2C/rcyTAJ5LY7Et+9
   kKo9sg1g81VVoaCUiYMYw7VW2D0mmd8Z350zVE7e7NqH7dByOXidqMmYL
   1nbKGXiVr6LKA2dU4ZGGgZ1qycl5ab/pEiLXjILeiXlifv7smnHGnR/Gg
   4=;
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
X-IronPort-AV: E=Sophos;i="6.07,156,1708383600"; 
   d="scan'208";a="158565564"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2024 15:54:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1D03E0147; Tue, 26 Mar 2024 15:54:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E8C4E008A
	for <cocci@sympa.inria.fr>; Tue, 26 Mar 2024 15:54:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UQ8/oRjsQzICMkI6DHWCYORk9cd/ct+TrJW+UsMe6k8=;
  b=i+5NwdOZFiJOiaTj8RzJ0VBMJyHngnAB/PIHHBAl3hvgF4SveqpXBB4M
   k9f2VjzA3ghnObP7i8EWnxrQniVnsKV9pYpIioq+N2FFT2kkPSDlVV+4h
   cg4TjaDV4/WD0X9bFP6K8z0fBJ5efoWADN0qr/y+u+HgGdGTYK3ircR/c
   k=;
X-IronPort-AV: E=Sophos;i="6.07,156,1708383600"; 
   d="scan'208";a="158565556"
Received: from n2-77-65.dhcp.drexel.edu (HELO n3-88-209.dhcp.drexel.edu) ([144.118.77.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 15:54:57 +0100
Date: Tue, 26 Mar 2024 10:54:56 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <0264b7c7-99bc-42bb-a8cc-1cd247f34d96@web.de>
Message-ID: <d6eba12-db3c-c2e-5f77-b5c59776be2@inria.fr>
References: <0264b7c7-99bc-42bb-a8cc-1cd247f34d96@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-921831941-1711464897=:3487"
Subject: Re: [cocci] Improving support for return macro variants with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1621
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/d6eba12-db3c-c2e-5f77-b5c59776be2%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-921831941-1711464897=:3487
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 26 Mar 2024, Markus Elfring wrote:

> Hello,
>
> The semantic patch language provides special support for “Linux iterators”.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/0011af1760e37caada1f9d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L471
> https://github.com/coccinelle/coccinelle/blob/0011af1760e37caada1f9d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L471
>
> Will a need evolve to extend data processing support in similar ways
> for macro variants (like “return_ptr(p)”) which indicate return statements?
> https://elixir.bootlin.com/linux/v6.8.1/source/include/linux/cleanup.h#L78

I don't have any plan to do that.

julia
--8323329-921831941-1711464897=:3487--
