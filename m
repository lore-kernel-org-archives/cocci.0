Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA83DCF9C6C
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=IvUeUVJbdNKmLwa41lZkuFuia3YPt5Ce92vRrEwkXQE=;
  b=HCvIi1qcd+PcQWkjHVS16cuO3eRe8O3uFRgea5N9gO7cQXfxSt7hiwIY
   kFquuq4EfCB4ICygMuVNMiE0K9IeSSbGpTnrUcnI4JskVsqEPO4AWyfAi
   ry595PjB8Mq3+4Dw95iWHXLMqasfW2BY9k3RDFdOKvIKDy8B5gRgF8q6+
   I=;
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
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184415359"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 13:23:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 431CEE0145; Sun, 22 Sep 2024 13:23:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98CFAE00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 13:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IvUeUVJbdNKmLwa41lZkuFuia3YPt5Ce92vRrEwkXQE=;
  b=jLc6/7tYI8ZE8w9Lv75BIbJXbYGLWJlBsvq/fHBQG9XeOYacIpeGSROa
   +X8kI4nx1VMxwlrXw45siodciGhEar9n7fQdgvwzgyWdxcFgSGX5oKRZy
   EZZsratfnJswyGJYLJUjNhyigeEbss4Dw/lovVbcHIdj1f0w7mBht5TdH
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184415358"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 13:23:18 +0200
Date: Sun, 22 Sep 2024 13:23:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de>
Message-ID: <alpine.DEB.2.22.394.2409221321131.3517@hadrien>
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de> <alpine.DEB.2.22.394.2409212209470.3471@hadrien> <b1872e36-154b-477f-907a-7fc98b301931@web.de> <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de> <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
 <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1312436480-1727004198=:3517"
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1879
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/alpine.DEB.2.22.394.2409221321131.3517%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1312436480-1727004198=:3517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 22 Sep 2024, Markus Elfring wrote:

> > How do you expect Coccinelle to figure out what is the right value for rc2?
>
> One variable should usually store the desired return values.
>
>
> > The only match is in the declaration, but any int variable
> > declaration satisfies that.
>
> I would like to increase case distinctions accordingly.
> Variables like “i” and “j” are obviously used in some for loops (for example).
> How should such control flow properties be restricted by the means of
> the semantic patch language?

You can use other rules, inheritance, position variables, etc to
disqualify a variable that is not used in the way you like, or that is
used in a way that you dont like.

julia
--8323329-1312436480-1727004198=:3517--
