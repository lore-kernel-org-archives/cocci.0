Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A662C3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dj+t9f/3IqEf0oS6JlzEg+geurbw24EjUV4U/f9vNCM=;
  b=uO1hFgZJzxPfhrQHltfYj0NWtf+1QRVJo7QhI/Cj3AAY/O8yhBlEJNs2
   /1M8LIhsMnCt+xJLyFffauJyw4gxvlN1fk5ThcfMTPDFTkSyRLRnDjx11
   mtmgd5onLwIFb8Xye8KjSnGZbkmXWYvWaual4PunGZONi3buIw/iOK+tt
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178140662"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 14:07:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 138DBE0141; Mon,  5 Aug 2024 14:07:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CF653E0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 14:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dj+t9f/3IqEf0oS6JlzEg+geurbw24EjUV4U/f9vNCM=;
  b=ofaH0BJNjJE7brHbEdwqmGVhj+BuB9W9ImoNEVL3dMME5ByZskAe0Fnf
   GhXQKlgvmnchfWEGkjOJ0UYB5Sb8mccGEdUT3itybCk8ndQzYxcPVI5zA
   UIU/g04JsPHl/ZyujYLz0clEF27tEzkA05tlvcSLcOd3uPIw3rjWO1oos
   g=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="93594276"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 14:07:19 +0200
Date: Mon, 5 Aug 2024 14:07:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
Message-ID: <d2797a7e-bf30-4fc5-214e-4865174189a@inria.fr>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com> <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1836
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/d2797a7e-bf30-4fc5-214e-4865174189a%40inria.fr>

> root@a361d9092793:/workdir# time make coccicheck M=drivers/media/
> MODE=report V=1  > 1.2.txt

If you could share 1.2.txt, that would be perfect.  Thanks!

julia
