Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB0FC10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MgKVUev9Vc2+55NKruPDTBGqsI9ak1hibAhXB7xs2q4=;
  b=p7dT9s4Uo/YH2lQZkg/8l9qC1FPxz9Y1CKgSu61dB4EZyFqj1lqAVemH
   r4atK7zcH0IymMPtomP+7zhB+KS87164UVHl22jaq7UVJ+PcqM/ck5+JP
   z+wTpBggm6ul7gdwlvjbxChCnjFFZPQK98AQlvfuoBReaR0ZCN6+DAySf
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165243218"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 14:53:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3615DE0CCC; Sun, 12 May 2024 14:53:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B95F0E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 14:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MgKVUev9Vc2+55NKruPDTBGqsI9ak1hibAhXB7xs2q4=;
  b=LeKpfYo65Opx3y5kJOunVUDoC5zS0kxenqVJQm0huJcw+BJHwsv8m/2p
   421FFj1f3kk1zncn2LqgikfAIgZ4BNT4fbHQ69dmcEKOcLvK8zNMmPzUy
   DwiKC49HXFGFaKcZi7/bIrJa6FQ4uwFGIDPPxiRaEtyl4NuZDqNcC4Y6a
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165243215"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 14:53:19 +0200
Date: Sun, 12 May 2024 14:53:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ac4b8c84-abb1-496b-9377-4f47c1f7cbb0@web.de>
Message-ID: <alpine.DEB.2.22.394.2405121451530.6747@hadrien>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de> <alpine.DEB.2.22.394.2405111803140.14453@hadrien> <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien> <ac4b8c84-abb1-496b-9377-4f47c1f7cbb0@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1730
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405121451530.6747%40hadrien>



On Sun, 12 May 2024, Markus Elfring wrote:

> > Probably you should start with ... when != my_action(...) to be sure to
> > get the first one.
>
> Should any SmPL search item which is specified at the beginning of
> an SmPL rule be handled by the Coccinelle software as the first source
> code filter also without an extra when constraint?

No.  Surely you don't want that.  If you ask to replace all X's by Y, then
you normally want to replace all of them.

> Can it be checked if such a primary condition is really evaluated
> in the desired order?

No idea what this means.  "desired order" is just something that exists in
the head of the person who wrote the rule.  Coccinelle doesn't know that.

julia
