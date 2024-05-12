Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9E8C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 07:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Jb79Kk2JgCvYqwih6v5ckVkELZu7NEDaRfs8RTJV6qU=;
  b=Gdlw9iP8+U0gk3xePeYL8w/YXfd8K2YqI9ar8h7yzoFSFP9xzEIi2xQr
   oOolwXbDEq0dACGBKKeVl1MgbSsVKAUCFFPJyMtilbZjUA8aInNL4aYTh
   NJRX7lppTWbWvMoc28tZtaPVUjnUWLDa1OvFIjiC43uCd2fVCtm7FAQ/2
   k=;
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
   d="scan'208";a="165229138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 09:34:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17D66E0AF1; Sun, 12 May 2024 09:34:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E82F2E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 09:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Jb79Kk2JgCvYqwih6v5ckVkELZu7NEDaRfs8RTJV6qU=;
  b=fEnDLkqZbndNon9S4hZbY2+TGxQ1/3syYSUUm9lW50bxZzm5SCBvE63a
   9Er4G4sA+yCNlH3fVIul8cPqPeeNc3Qc9puU/+uvJz1FqQ8murMlYMOl6
   fw62tQX0qSHTS/27CYHSJHpp5+H+37VqdFPlErzt/efr43B/4GjW6n8g1
   w=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="86792853"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 09:34:29 +0200
Date: Sun, 12 May 2024 09:34:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
Message-ID: <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de> <alpine.DEB.2.22.394.2405111803140.14453@hadrien> <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1382812557-1715499269=:6747"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1723
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405120932360.6747%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1382812557-1715499269=:6747
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 12 May 2024, Markus Elfring wrote:

> > Your semantic patch needs to be:
> >
> > @display@
> > @@
> >  my_action(...);
> >  <+... when any
> > *my_action(...);
> >  ...+>
> >
> > Without that, a call to my_action is forbidden in the region matched by
> > the <+... ...+>.  Because any kind of dot thing matches the shortest path
> > between what comes before and what comes after (here the end of the function).
>
> Can the Coccinelle software inform better about the case that the shortest
> path constraint was “accidentally overlooked” in a SmPL script?
>
>
> There are further development challenges to consider.
> See also a corresponding transformation approach by the means of
> another tiny script for the semantic patch language:
>
> @adjustment@
> @@
>  my_action(
> -          ...
> +          0
>           );
>  <+... when any
> -my_action(...);
>  ...+>
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch use_one_test_call.cocci repeated_three_calls.c
> …
> previous modification:
>
>   <<< 0
> CONTEXT
>
> According to environment 0:
>
>
> current modification:
> MINUS
>
> According to environment 0:
>
>
> adjustment: already tagged token:
> C code context
> File "repeated_three_calls.c", line 4, column 12, charpos = 48
>   around = ')',
>   whole content =  my_action(2);
>
>
> Can the data processing be improved anyhow?

The current semantic pach allows the first my_action to match anywhere,
including the second my_action, third, etc.  So if you have changes in
both, then there will be contradictory changes to the code.

Probably you should start with ... when != my_action(...) to be sure to
get the first one.

julia
--8323329-1382812557-1715499269=:6747--
