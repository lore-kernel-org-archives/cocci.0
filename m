Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB331C433EF
	for <cocci@archiver.kernel.org>; Fri, 25 Mar 2022 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UucVwRueSm2LkyzwwgXzUiIgrC6XNC799cxGQljBW2E=;
  b=qjJAGkvizC5ONr11HDNGBmQCs6jt5jYQ5wSZpE8fW6L9n+jIHBVsNx3S
   DsbUc6oVKnQ/RF51EUZIM8lynhRw3N25iJ58yD9K0kyxM7pfJqaeKgvtg
   oeZ2z7ZWlctUCyOtAGvRi66dBC1WXEtYvapVv7mlZMgzWPS7BeJwa5dZA
   8=;
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
   d="scan'208";a="28207699"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2022 22:36:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D624E436F; Fri, 25 Mar 2022 22:36:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DBCCE436E
	for <cocci@sympa.inria.fr>; Fri, 25 Mar 2022 22:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UucVwRueSm2LkyzwwgXzUiIgrC6XNC799cxGQljBW2E=;
  b=Ius2/svov6fD7geYtYEeJPSP8reqao08+kfNnbceBa6eirjexjiMzrc7
   oZ2fo+qiaGOjRRIY1s8pXby7sRh3QRpPE3FunrtWUnfGBJN+zg9rv1aNk
   8Easyt0pmyDuMn3dQ9EsPnf+gxM/qnK+uaqxg5d7bZfp2QPFwR8thkbhH
   I=;
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28207690"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 22:36:53 +0100
Date: Fri, 25 Mar 2022 22:36:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ce21e395-344a-e58a-4213-69f62a96cb6a@web.de>
Message-ID: <alpine.DEB.2.22.394.2203252236300.4442@hadrien>
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de> <alpine.DEB.2.22.394.2203252223110.4442@hadrien> <ce21e395-344a-e58a-4213-69f62a96cb6a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 290
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203252236300.4442%40hadrien>



On Fri, 25 Mar 2022, Markus Elfring wrote:

> >> https://en.cppreference.com/w/c/language/string_literal
> > constant char[] x; ?
>
> Does this SmPL source code search approach include also the enclosing quotation characters?

If you say

- x
+ x

the quotes will still be there.

julia


>
> How do you think about to improve the data processing for captured parts
> (together with supported scripting languages)?
>
> Should it be avoided to repeat any data format checks according to string literals
> by SmPL script rules?
>
> Regards,
> Markus
>
