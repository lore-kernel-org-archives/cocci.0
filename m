Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EC9C433EF
	for <cocci@archiver.kernel.org>; Fri, 25 Mar 2022 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Myfc21NaW6aK0sB440kKl8rYWVFqiDZQBH08dPbZ3tk=;
  b=rlgJpP1qUDRq6wJhVsb5aNos33S66HAcbGh8Hagv7nl+bXzmsclvEUpx
   FOBxhaTOUOSMI2bQRNPuOrm6Lr62HKOlPX84nzlXRoTCn2shyQFJDGa3r
   Avvw4Vjxxqc9HTBiTLOHNzgZ3HsCLE9y8CGdu3LAp5/HdqXxAi7WyNeSb
   k=;
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
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28207138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2022 22:23:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CDD8AE4371; Fri, 25 Mar 2022 22:23:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E25A4E436E
	for <cocci@sympa.inria.fr>; Fri, 25 Mar 2022 22:23:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Myfc21NaW6aK0sB440kKl8rYWVFqiDZQBH08dPbZ3tk=;
  b=T2ZYRQIdBGLf+Pe5X2Nps+wVDJDrPFJApgBT9txc1v4bC6MCsVqUL/Nf
   b0WoQzOZ6useGoruIoWTs75kz6qWcVAhcFFwuwTsxpQAlKx1d20elY+hg
   ZND5q7REKwfDKYq5VKSThq/6U/4YMYTK8O+eyzrobKHp656JKSSyUuFQR
   Q=;
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28207137"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 22:23:43 +0100
Date: Fri, 25 Mar 2022 22:23:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
Message-ID: <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-171795588-1648243423=:4442"
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 288
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203252223110.4442%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-171795588-1648243423=:4442
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 25 Mar 2022, Markus Elfring wrote:

> Hello,
>
> The metavariable type “constant” is supported by the semantic patch language.
> Thus some data processing can be performed for literals.
>
> I would appreciate the support for metavariable types which will match only
> string literals.
> https://en.cppreference.com/w/c/language/string_literal

constant char[] x; ?

julia


>
> I guess that such a kind of metavariable would include also the enclosing
> quotation characters.
> But if captured data should be passed for further processing to another
> scripting language, it would occasionally be more helpful to omit the double
> quotes there.
> Additional programming interfaces can also help to handle data parts better,
> can't they?
>
> Would you like to work with another metavariable variant for this purpose?
>
> How will the chances evolve to extend the Coccinelle software accordingly?
>
> Regards,
> Markus
>
>
--8323329-171795588-1648243423=:4442--
