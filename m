Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5FBC4332F
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 06:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=j2yVwA1jMqrwUx5rvKy0cThbqzqK5g9LGlQXkpIwY1M=;
  b=bbrWPYImQA55MdsMWAPZzGhNzlmAy8kDLhmDkbnlcZWHPGKS9L9CXSmu
   RMYUXMZTJSTgFfeJjrOV+k3oYEWgjy0gy3qoZbqKiNm/7NYJylWT3kz12
   YCvZX5oLrC8JNXk7mTWYvXaOXaGfhaKQ+FEdwTwOmjvc/3+VCX7F/M9b1
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,274,1665439200"; 
   d="scan'208";a="85057681"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 07:41:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAD76E0133; Mon, 26 Dec 2022 07:41:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D0EAE0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 07:41:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j2yVwA1jMqrwUx5rvKy0cThbqzqK5g9LGlQXkpIwY1M=;
  b=bU/eWtg5xxnlcBcQEM1lITUWkBc4z/ENznqkXvF/9htGwjRfO3UgmmXV
   w6LDGAGX84h+8NULxrYAYVrm6A2j31Gn2xw/4COlZvtvYu21YijeTFQXw
   01VpzZQT7pMIwJQSLb6JDi9lHKZR/viE/wY8pbrpd+JZfZfJu5q9b+SNl
   k=;
X-IronPort-AV: E=Sophos;i="5.96,274,1665439200"; 
   d="scan'208";a="85057678"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 07:41:52 +0100
Date: Mon, 26 Dec 2022 07:41:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
Message-ID: <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1892725722-1672036911=:2980"
Subject: Re: [cocci] Transforming source code according to the usage of a
 predicate
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 785
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212260740380.2980%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1892725722-1672036911=:2980
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 25 Dec 2022, Markus Elfring wrote:

> Hello,
>
> I noticed a suggestion in another issue tracker.
>
> 2022-11-25
> Detect if/else branches that only differ by condition variable
> https://trac.cppcheck.net/ticket/11402
>
>
> I tried to construct a script variant for the semantic patch language
> (software combination “Coccinelle 1.1.1”) accordingly.
>
>
> @replacement disable neg_if, drop_else@
> bool active;
> expression call;
> @@
>  <+...
> (
> -if (active) {
>     call(active, ...);
> -} else {
> -   call(!active, ...);
> -}
> |
> -if (active) {
>     call(..., active);
> -} else {
> -   call(..., !active);
> -}
> )
>  ...+>
>
>
>
> I hoped that an isomorphism can take care of special compound statements.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15af39865329c2fe23460d/standard.iso#L523
>
> Unfortunately, I stumbled on information like the following.
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci cppcheck-11402-suggestion2-20221225.cocci
> …
> warning: iso braces4 does not match the code below on line 7
> …
>
>
> Will the chances grow to simplify and improve the shown SmPL code any further?

Unlikely.

Your semantic patch also seems strange.  Don't you want something like

expression list e1,e2;

and then call(e1,active,e2)

julia

>
> Regards,
> Markus
>
>
--8323329-1892725722-1672036911=:2980--
