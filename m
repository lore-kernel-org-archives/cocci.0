Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF0CC3DA49
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=juYQyrwDMxvEZ5NBzYyi19cUY5VWkXihlG3ntqZsUTw=;
  b=S0+B4w5/fmXjFvbUHOVCEX+Z8d/fBInNgkTLLXqE9sbi73NeSatZfEJl
   FwdHDapYJi9PQdX5Ei+qLBeNCc/JPGE2cIWxXkD6T4XUCwygwBAOGDsQd
   GHEvmP2O1wJ+dXKk/3d5v7DOsmmoXG7EF0CkKXwrNoQUc36C/8baRiWwI
   8=;
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
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177110968"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 15:42:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 067AFE0138; Fri, 26 Jul 2024 15:42:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8CD52E0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 15:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=juYQyrwDMxvEZ5NBzYyi19cUY5VWkXihlG3ntqZsUTw=;
  b=UpmiH78xxpI/6V3Yc2wsHVmt7ads2fskbXJULJ77QIFUwGxvkG89x7OZ
   7fF7tYfnmAoCm7R+pnFD4ZgizXnW8ZBbzR/r4OmSIAHiWVh9qehg2nM99
   Nh9WDW55jjDoonEcH/nrPWyhGfmy5s5jGHMnLrkKtJI0SW/YT4hErNYGv
   k=;
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="93029442"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 15:42:07 +0200
Date: Fri, 26 Jul 2024 15:42:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <f7cb87e7-3a17-44b7-87a1-8fec22e649ea@web.de>
Message-ID: <fea78c48-494a-ee18-97ee-fc6930fce7d@inria.fr>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de> <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr> <d3f11294-5751-442e-b7d4-616c3bd217b9@web.de> <bea5cf4d-0e4-d141-1365-4d5f76bcf513@inria.fr> <f7cb87e7-3a17-44b7-87a1-8fec22e649ea@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-553200484-1722001327=:3356"
Subject: Re: [cocci] Data processing challenges according to the comma
 operator
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1819
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/fea78c48-494a-ee18-97ee-fc6930fce7d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-553200484-1722001327=:3356
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 26 Jul 2024, Markus Elfring wrote:

> >> Please reconsider such a view once more.
> >> https://en.cppreference.com/w/c/language/operator_other#Comma_operator
> >
> > The link you cite says:
> >
> > The comma operator expression has the form
> > lhs , rhs
> >
> > That doesn't end in a comma.  There is no rhs within the <+... ...+>
>
> Can subexpressions be supported by the semantic patch language
> for such a “binary” operator?

A subexpression is also an expression.  There is nothing specific about
this operator.  The rule in Coccinelle is that when you write <+... ...+>,
the term in the middle has to be a complete expression or statement.

julia
--8323329-553200484-1722001327=:3356--
