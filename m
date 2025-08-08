Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F20C87FD3
	for <cocci@archiver.kernel.org>; Fri,  8 Aug 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XI/7bGjJqndfdsUT4fFbwQnolqpAsIjRrqWrToXIeyc=;
  b=CgGuyzPXn/aAK96ANLTvcyLvuAFvgLZzMRdZX3fpcuiAVrIN2Hjb+9YO
   hr4aiLLmHzava72fRyyBYxBvwA8faqsTvWHoG+8qDY7uPWDVTQGbYrEHy
   ra9uugSqsJm6xNC38SKY2L3dwirkX3MyVcVnnr7aoDO8XOpm7Q9/+8OMa
   c=;
X-CSE-ConnectionGUID: 8yeXC5W6Tca8ZFv3SJYhTQ==
X-CSE-MsgGUID: BMaWAPc0Sp6UkJfDGuhL3A==
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
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234521866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2025 10:04:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 67CDBE0B0D; Fri,  8 Aug 2025 10:04:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7829BE0171
	for <cocci@sympa.inria.fr>; Fri,  8 Aug 2025 10:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XI/7bGjJqndfdsUT4fFbwQnolqpAsIjRrqWrToXIeyc=;
  b=sxAcp/GYhv6J2rluJwEVvlAPg+CXs5POj9b21F6MpQTL+4HSju9LJeLB
   +fgYdin2Lu20Q88Ohfj/wp9yb8VRGCDY9/e5RrMa8XZc0G7CPkhPFPJaR
   YIchz/iWi/dERboi3+oaaIz3fnhuGMsSBCypfxygd6TbENxZbgx9dUHI4
   k=;
X-CSE-ConnectionGUID: +0F3IW9FT264O4w51LZumA==
X-CSE-MsgGUID: ZCsw7SvSR+K0p1IdBDftYQ==
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234521857"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:04:15 +0200
Date: Fri, 8 Aug 2025 10:04:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Michele Martone <michelemartone@users.sourceforge.net>
In-Reply-To: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de>
Message-ID: <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr>
References: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1632729438-1754640255=:3519"
Subject: Re: [cocci] Searching for C++ delete expressions (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2968
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/3a88b6dc-cdca-79d1-9a4-72ca8c465c5%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1632729438-1754640255=:3519
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 8 Aug 2025, Markus Elfring wrote:

> Hello,
>
> Another SmPL script example:
> #spatch --c++
> @display@
> expression e;
> @@
>  delete
> ?[]
> *e
>
>
> Questionable test result (by the software combination “Coccinelle 1.3.0” for example):
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> /usr/bin/spatch --parse-cocci show_delete_expressions.cocci
> …
> warning: incompatible arity found on line 5
> …
> delete [] *e
> …
>
>
> How will clarification interests evolve further for this issue?

In general, I don't think you can put ? on random subterms.  You could do
what you want with a disjunction.

julia
--8323329-1632729438-1754640255=:3519--
