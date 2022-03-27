Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A151FC433EF
	for <cocci@archiver.kernel.org>; Sun, 27 Mar 2022 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mpp1MqMgFpdEf5S841mNbSGduA980+id4msgCkbI8YE=;
  b=Rhi4LUVPCIg/86dKsISt4whqHRvbKIPQ7s85ZM1yUkNJgzQEeO+cGG8k
   O+7PFmDa0p19FOpeKwfduaV2ZIclmXVlYQFwYj8ZPwtgIEhACBqKZlW9T
   RRxZxkmCUNiLXGdKzCNDgX0z+GGIA0/ixITnAbMCUKsAEBCyrk2z4R8/e
   c=;
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
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="28498805"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2022 14:51:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C182AE4372; Sun, 27 Mar 2022 14:51:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AA31E436E
	for <cocci@sympa.inria.fr>; Sun, 27 Mar 2022 14:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mpp1MqMgFpdEf5S841mNbSGduA980+id4msgCkbI8YE=;
  b=jRDd3HOexOV98GqUQhxgtTk6RBXMNN+cGCR1u8GaO1jcOpxUy0wAPTej
   WafQTF7sSX7Zg6AYBCN5HtFa3McbIm0g29delIt4XeO/KInbiYELsFUDA
   JUmMD9JUBzAH1nEWhGr1RTv+y2DO60KlAIVkvQFy1SGS5cyw/Aa7c9sKR
   g=;
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="9722656"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 14:51:12 +0200
Date: Sun, 27 Mar 2022 14:51:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <46702ad9-17f2-9be2-d985-c89e207786d6@web.de>
Message-ID: <alpine.DEB.2.22.394.2203271450370.3119@hadrien>
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de> <alpine.DEB.2.22.394.2203252223110.4442@hadrien> <243b180b-6fc3-1003-a592-1fc01bb198ad@web.de> <alpine.DEB.2.22.394.2203271352240.3119@hadrien> <46702ad9-17f2-9be2-d985-c89e207786d6@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1864533303-1648385471=:3119"
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 297
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203271450370.3119%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1864533303-1648385471=:3119
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 27 Mar 2022, Markus Elfring wrote:

> >> @display@
> >> constant char[] text1, text2;
> >> @@
> >> *text1 text2
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci show_string_literal_usage3.cocci
> > SmPL doesn't support that.
>
>
> I hope that the affected software can be improved further somehow.
>
>
>
> > If you just match text1, it will match the whole thing,
>
>
> I would occasionally like to match only a single string literal
> so that subsequent string literals can be handled separately.
>
>
>
> > and you can use python to extract the pieces.
>
>
> I am still looking for ways to avoid undesirable side effects
> in this data processing area.

OK, but as compard to situations where there is no solution at all, this
is not a priority.

julia
--8323329-1864533303-1648385471=:3119--
