Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8ACD116EA
	for <cocci@archiver.kernel.org>; Fri, 28 Nov 2025 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wv/F4/rKTlpkdV/VzUVDDLsIsH+HsvbWTpGK8NQkURg=;
  b=fCZce1n21mS+qp7I46PvYOpbVah1s2F+Uf0XcbkNwarBnCzMbrcKvjcC
   qOzf2ydCBw/n3jTbFEgFSoMKXOrwgIq7Tb0F9KsaVPhXWcxpYStteEFtN
   ogQwrvg87ZXkyrKxtHTTpyncRiH4awBudtygb0VKHKbSD4bQZRdwMgclO
   A=;
X-CSE-ConnectionGUID: xMbRP//MQQGiloUtIdPGcA==
X-CSE-MsgGUID: GppecocCRsy/FqRG1rL+PQ==
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
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251734873"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Nov 2025 11:12:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0FF27E02E4; Fri, 28 Nov 2025 11:12:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E368BE0157
	for <cocci@sympa.inria.fr>; Fri, 28 Nov 2025 11:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wv/F4/rKTlpkdV/VzUVDDLsIsH+HsvbWTpGK8NQkURg=;
  b=W8jeeJnDjidT94Smc4HG0q0zoAOHG1TlhTYCjVlsviz9X3BMwn0lzZmp
   mN4yywW1XjAOWTqpmmi+INDm7/EYyz/hZOZe5a/t53T7ZL/kMRMyhSAYe
   e6vJ73/QGTMsaJpMnNrjaOPkQDS3pqBqnMSOYDe3GezeKGX50gULNH8mQ
   U=;
X-CSE-ConnectionGUID: RXOunDnjQcCi6558OoSVxA==
X-CSE-MsgGUID: 0jQaWqI6QeOTgnoXHmjOJQ==
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251734861"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 11:12:19 +0100
Date: Fri, 28 Nov 2025 11:12:18 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <aa45d63e-bce0-47a7-b34f-434311ecd9ed@web.de>
Message-ID: <6ab5b7b8-9655-67f2-4acd-e78c81e94ed@inria.fr>
References: <d08dc115-5c88-4545-8a77-b588382db1e7@web.de> <aa45d63e-bce0-47a7-b34f-434311ecd9ed@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1409129251-1764324738=:3739"
Subject: Re: [cocci] Data processing challenges with usage of not operators
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3199
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/6ab5b7b8-9655-67f2-4acd-e78c81e94ed%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1409129251-1764324738=:3739
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 28 Nov 2025, Markus Elfring wrote:

> > How reasonable do you find the conversion of such a simple test expression
> > into an SmPL disjunction with 15 branches by isomorphism rules?
>
> How does the generated SmPL disjunction look after the software adjustment
> “avoid duplicates in disjunctions” (from 2025-11-23)?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/5bf4aac3af21712638005c0f4e225fb37c2fd70f
> https://github.com/coccinelle/coccinelle/commit/5bf4aac3af21712638005c0f4e225fb37c2fd70f
>
> How long will I wait until I can see a corresponding data processing result myself?

I have no idea what you are asking about.  Can't you write --parse-cocci?
Does it take too long to run?  There is no way I can debug a problem with
that without having your code.

julia

>
> Regards,
> Markus
>
--8323329-1409129251-1764324738=:3739--
