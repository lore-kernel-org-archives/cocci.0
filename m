Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF781D13572
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=e7EhxQ7pzxDslAv3SBCicFYK5CZdQbAJ2GzVqvrVzK0=;
  b=hR41JEqBzrg9YeD+paRtinJZIYlx8S7ivklTzYvgmCO1n2lxQPDbe4Yv
   BE+bqciKYOx8afPE+r8RM/7rQi4P5vLtMrZ5gPRT8vXrzeWPQZTMvy8Oi
   ojEjiTkk+5bHRrObV8NlpvEJ7v+pPSkABoG3QPCdCvQALwzZ+OSxWcvEw
   4=;
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190932342"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 18:55:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F6EEE0D1D; Sun, 27 Oct 2024 18:55:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1DC04E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 18:55:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e7EhxQ7pzxDslAv3SBCicFYK5CZdQbAJ2GzVqvrVzK0=;
  b=dEoJ3KWy8ly7Wy2oeOZXE+rTLPSOIic25NXylxoI7MnxnwcCaMz8A11u
   PlLb/emKgiQAB6YqZhdD4O2EqYpK0G9IAoRgWIiZF2Lw5crSfaQIVv+q7
   CbGL2muCv+iPea1jOWoQqCNOdEFlBc0XlNk44b5Q8YXKqFOKkjAhbSILV
   g=;
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190932337"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 18:55:31 +0100
Date: Sun, 27 Oct 2024 18:55:30 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, "Derek M. Jones" <derek@knosof.co.uk>, 
    Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <f63293b2-94a8-4c2e-933c-5b2f94f64bb2@web.de>
Message-ID: <alpine.DEB.2.22.394.2410271855000.3498@hadrien>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk> <alpine.DEB.2.22.394.2410241728210.3352@hadrien> <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien> <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk> <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk> <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de> <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de> <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de> <alpine.DEB.2.22.394.2410271429560.3498@hadrien> <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de> <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
 <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de> <alpine.DEB.2.22.394.2410271833310.3498@hadrien> <f63293b2-94a8-4c2e-933c-5b2f94f64bb2@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-136603424-1730051731=:3498"
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1951
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410271855000.3498%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-136603424-1730051731=:3498
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 27 Oct 2024, Markus Elfring wrote:

> > Coccinelle doesn't report on parse errors unless an option like
> > --verbose-parsing or --parse-c is provided.
>
> How helpful do you find the following information then?
>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> spatch --verbose-parsing …/Projekte/Coccinelle/janitor/list_curly_bracket_positions_for_function_implementations4.cocci arch/sh/drivers/pci/common.c
> …
> HANDLING: arch/sh/drivers/pci/common.c
> ERROR-RECOV: found sync col 0 at line 49
> parsing pass2: try again
> ERROR-RECOV: found sync col 0 at line 49

You can look in your file and see what is on line 49.

julia

> parsing pass3: try again
> Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types: dropping int
> , keeping typeD __init
>
> ; value = ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 34, 4, "arch/sh/drivers/pci/common.c"), (("\n", 983, 41, 0, "arch/sh/drivers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)], [0])
> Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types: dropping int
> , keeping typeD __init
>
> ; value = ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 34, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1014, 42, 30, "arch/sh/drivers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)], [0])
> Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types: dropping int
> , keeping typeD __init
>
> ; value = ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 34, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1046, 43, 31, "arch/sh/drivers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)], [0])
> Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types: dropping int
> , keeping typeD __init
>
> ; value = ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 34, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1079, 44, 32, "arch/sh/drivers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)], [0])
> Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types: dropping int
> , keeping typeD __init
>
> ; value = ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 34, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1109, 45, 29, "arch/sh/drivers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)], [0])
> Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types: dropping int
> , keeping typeD __init
>
> ; value = ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 34, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1140, 46, 30, "arch/sh/drivers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)], [0])
> -> duplicate data
> file:
> arch/sh/drivers/pci/common.c
> function:
> early_read_config_dword
> line:
> 36
> …
>
>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> spatch --parse-c arch/sh/drivers/pci/common.c
> …
> NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
> nb good = 159,  nb passed = 6 =========> 3.64% passed
> nb good = 159,  nb bad = 0 =========> 100.00% good or passed
>
>
> Regards,
> Markus
>
--8323329-136603424-1730051731=:3498--
