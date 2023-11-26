Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369FDC4167B
	for <cocci@archiver.kernel.org>; Sun, 26 Nov 2023 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ToyXHKv8bHXDwrRZh3GkTWRIZftd/pSR4YAHweCrcFI=;
  b=mS58JgG9LPi0w+mOCjfKvCwemZ99bo99kYfpwlrPJ6troXjT2SGQq4wP
   6FmFwjFjiv+iKj8WQui7YrmIwO3Ja/4soSuLHtXoHyhDYO/1vYeXmA7Gd
   YixuTqLK4uABa+hrplax9Tm7uVP8jvxyY2yOjGpNk9ls/HRPCMcf8oiYp
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.04,229,1695679200"; 
   d="scan'208";a="138599027"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2023 21:36:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1204EE0CCE; Sun, 26 Nov 2023 21:36:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 75FA6E004E
	for <cocci@sympa.inria.fr>; Sun, 26 Nov 2023 21:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ToyXHKv8bHXDwrRZh3GkTWRIZftd/pSR4YAHweCrcFI=;
  b=Q6UL3S5LIoSOUcRaaj98IdwS2Nl6Gdoijj1FscQQ1QJcByEMa/4M63+k
   oNNkbEw062V3yViIb22df9QU8OU2RsJYP9ZRy9SMj28YzDNZhAEVfBPgT
   mztrlOaseBdVGHwCU4SKQPpPTQxZ0vUu+KsHCwTl9TlUzsuNUTtoBdadE
   U=;
X-IronPort-AV: E=Sophos;i="6.04,229,1695679200"; 
   d="scan'208";a="72621765"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 21:36:22 +0100
Date: Sun, 26 Nov 2023 21:36:21 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
In-Reply-To: <1d511f1f-4cab-433f-90dc-a6f4e9d3fa7f@web.de>
Message-ID: <alpine.DEB.2.22.394.2311262136020.3149@hadrien>
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de> <alpine.DEB.2.22.394.2311240807170.3349@hadrien> <1d511f1f-4cab-433f-90dc-a6f4e9d3fa7f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1506408556-1701030982=:3149"
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1337
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311262136020.3149%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1506408556-1701030982=:3149
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 26 Nov 2023, Markus Elfring wrote:

> >> Test result:
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch display_position_information_for_one_return.cocci only_return_from_main.c
> >> …
> >> (<coccilib.elems.Location instance at 0x7f8fc4fcefa0>,)
> >
> > The type of a position variable in python is an array.  In OCaml it is
> > a list.  This is completely independent of the number of element involved.
>
> The terms differ for the applied data structures with the involved
> programming languages.
>
> Another SmPL script example:
> @initialize:python@
> @@
> import inspect, pprint, sys
>
> def display_members(item):
>    sys.stdout.write("\n===\n\n")
>
>    for member in inspect.getmembers(item):
>       pprint.pprint(member)
>
> @find@
> position pos;
> @@
>  return@pos ...;
>
> @script:python display@
> places << find.pos;
> @@
> pprint.pprint(places)
>
> for place in places:
>    display_members(place)
>
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch display_position_information_for_one_return2.cocci only_return_from_main.c
> …
> (<coccilib.elems.Location instance at 0x7f6c9a2fefa0>,)
>
> ===
>
> ('__doc__', None)
> ('__init__',
>  <bound method Location.__init__ of <coccilib.elems.Location instance at 0x7f6c9a2fefa0>>)
> ('__module__', 'coccilib.elems')
> ('column', '1')
> ('column_end', '7')
> ('current_element', 'main')
> ('current_element_column', '0')
> ('current_element_column_end', '1')
> ('current_element_line', '1')
> ('current_element_line_end', '4')
> ('file', 'only_return_from_main.c')
> ('line', '3')
> ('line_end', '3')
>
>
>
> Would you like to reconsider the representation of shown number attributes
> as text strings (instead of integers)?
>
> How do you think about to enable the usage of an integral data type here?

I odn't want to change the interface.  If you want numbers, use OCaml.

julia
--8323329-1506408556-1701030982=:3149--
