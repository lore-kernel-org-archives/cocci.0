Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFBDCD5BB1
	for <cocci@archiver.kernel.org>; Sun, 24 May 2026 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OrLdCCV2pKvFx/7maV2DaFoO94mlRHvLCmItFySKqqU=;
  b=ahOwleuIQKKLcfpegEbOjDwrcnyhRlAQ1y+Liezri0aRM4i+dH+urhlz
   jlxWvKI1ckLNCFpmSdcEPLH51oM3sbjdOHyyu4NojGmUfQRnPYYezKOqd
   jNcpN0++fpnfUEjj7/YrX3sPMnC0h5akg3+2CeNDo770TcKJNs2INV8T6
   Y=;
X-CSE-ConnectionGUID: 84pkTM1QQBKdpGRl4NpeBg==
X-CSE-MsgGUID: YgrSk7a+SwelzVGBkyAKAQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,165,1774306800"; 
   d="scan'208";a="278007756"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 May 2026 13:03:22 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9AAE1812D2; Sun, 24 May 2026 13:03:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A4DB081307
	for <cocci@sympa.inria.fr>; Sun, 24 May 2026 13:03:16 +0200 (CEST)
X-CSE-ConnectionGUID: tYZ4TVY4RCylRSGLyVI/7A==
X-CSE-MsgGUID: ywTCyPDWTfyccKDwbVWO3Q==
X-IronPort-AV: E=Sophos;i="6.24,165,1774306800"; 
   d="scan'208";a="147440225"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 13:03:17 +0200
Date: Sun, 24 May 2026 13:03:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <eb4b825e-b849-40fd-ab79-dce3852ccfce@web.de>
Message-ID: <4222b953-360-6e52-9952-14b4ce9e613@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de> <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr> <25fb88dd-4573-4897-98ae-f5904a2324cd@web.de> <85a837b7-8a6-5fb8-eeb-1e70c5f77b2e@inria.fr> <1da11354-3d73-4158-aa0b-98a143471a3b@web.de>
 <dac0391-4aa-f02-f8fc-2168c118e3ef@inria.fr> <dd4fa876-fe40-43ec-8184-05da70579973@web.de> <7cd8b09f-eb9a-c4f7-81a-6a2968c1c02@inria.fr> <c9941a16-38e8-ccb5-c07c-54ac1718a398@inria.fr> <f68596ce-db2c-40a7-9e79-e9448ad460e5@web.de> <84111447-1b1b-98e4-afb2-fae89bc79d5b@inria.fr>
 <eb4b825e-b849-40fd-ab79-dce3852ccfce@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2056379767-1779620596=:33802"
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3511
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/mQP1Z1Cr2ugnv2G0zOzkxA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2056379767-1779620596=:33802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 24 May 2026, Markus Elfring wrote:

> >>> For the case of --no-loops, backward jumps are detected as loops for other pruposes.
> >>
> >> Which purposes do you imagine here?
> >
> > Loops require the use of the CTL operator AW, not AU.
>
> Thanks for such background information on computation tree logic.
>
>
> >>> --no-loops for for, while etc loops does consider a subset of meaningful paths.
> >> How will software design approaches evolve accordingly?
> >
> > As I said, I don't know what is the best thing to do.  If you have an
> > actual proposal., propose it.  If you don't have a proposal, plase stop
> > the discussion, because nothing is going to change.
> Will another clarification approach become helpful?
>
> Do you find it easier to clarify a reduced test case?
>
> Source file example:
> // See also:
> // * CWE-416: Use After Free
> //   https://cwe.mitre.org/data/definitions/416.html
> //
> // * MEM30-C: Do not access freed memory
> //   https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-standard/rules/memory-management-mem/mem30-c/
>
> #include <stdlib.h>
>
> struct my_point
> {
>  int x, y;
> };
>
> void my_test(void)
> {
>  // A few variables
>  size_t s = 0;
>  struct my_point * mp;
>
> allocation:
>  mp = malloc(sizeof(*mp));
>  if (mp)
>  {
>   free(mp);
>   // Demonstration of a programming mistake
>   mp->x = 2;
>
>   // Trigger a repetition eventually
>   if (++s < 5)
>     goto allocation;
>  }
> }
>
>
> SmPL script:
> @display@
> identifier i;
> expression e;
> @@
> *i = malloc(...);
>  ... when != i = e
> *i->x = e
>
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> time /usr/bin/spatch --no-loops show_UAF_2.cocci ../Probe/demo-UAF2.c
> …
> @@ -19,12 +19,10 @@ void my_test(void)
>   struct my_point * mp;
>
>  allocation:
> - mp = malloc(sizeof(*mp));
>   if (mp)
>   {
>    free(mp);
>    // Demonstration of a programming mistake
> -  mp->x = 2;
>
>    // Trigger a repetition eventually
>    if (++s < 5)
>
> real    0m0,078s
> user    0m0,053s
> sys     0m0,022s
>
>
>
> How will development ideas evolve accordingly?

I don't know what the above is supposed to do.  The semantic patch looks
completely wrong to detect a use after free.  One would expect thta a
detection of use after free would mention free somewhere.  But the
obtained result looks completely correct for the provided semantic patch
(as well as a hypothetical semantic patch that would check for use after
free).

julia
--8323329-2056379767-1779620596=:33802--
