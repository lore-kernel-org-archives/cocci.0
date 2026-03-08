Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B31EEA853E
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DDWuIvaWL7nwr2U02I/b9b755yuecUqNRu4PFKMz9FI=;
  b=QCcjk+0ZctxWyjC/marsoci5dq+Qt0mtQOtY4a0A4gXYYBu3iW6r1/L1
   YFjEOTpOGp4OcECezC7+cEdegv5x5/1PHhQvtyQQHWw9jZSDpOSVgLt9A
   0RkJnyL25MRVmh/YWARfd1TMzMmkqyeGoWSwo6y5vuC8NCIgJ3z3XjGu+
   k=;
X-CSE-ConnectionGUID: fQYIAa/ARXOm9n+S9RvedQ==
X-CSE-MsgGUID: gIIByV1TRNmCS+V+kKcbUA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266754897"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 19:20:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B197D81236; Sun,  8 Mar 2026 19:20:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3C07881236
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 19:20:34 +0100 (CET)
X-CSE-ConnectionGUID: ZL+hXdhUS3Wmsr0sEtrCvg==
X-CSE-MsgGUID: Wzf/p18FRA2xpB7yPRWIRA==
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266754884"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 19:20:34 +0100
Date: Sun, 8 Mar 2026 19:20:34 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <f12f438e-a89f-462a-b166-d6af025cdc28@web.de>
Message-ID: <aa67fc7a-62b7-b6fd-d860-fd73623e6b77@inria.fr>
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de> <f25025ab-4500-4315-b41c-53cd5775c69f@web.de> <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de> <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr> <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr> <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de> <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr> <cd1bbe8e-ef35-408f-8754-173678bf3204@web.de> <f715289c-54d3-2c0-43fd-e6669973c5e1@inria.fr>
 <8ceb30ad-1143-4086-afeb-45b639c87e49@web.de> <1265ed1c-65e4-318e-8186-618346a4802d@inria.fr> <f12f438e-a89f-462a-b166-d6af025cdc28@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1319872754-1772994034=:3947"
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3340
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/TQrRjt9zaeLuGl67NdUYsw>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1319872754-1772994034=:3947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 8 Mar 2026, Markus Elfring wrote:

> >> @display2@
> >> declaration d;
> >> statement list sl;
> >> @@
> >>  {
> >>  d
> >> *sl
> >>  }
> >>
> >>
> >> Another questionable test result:
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch test-item_assignments.c ../janitor/show_compound_statements2.cocci
> >
> > And I should know what test-item_assignments.c is?
>
> Reminder:
> This can be possible.
> https://lore.kernel.org/cocci/f25025ab-4500-4315-b41c-53cd5775c69f@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00014.html
>
>
> void my_test(void)
> {
>  int item;
>
>  if (1)
>  {
>     item = 1;
>  }
>
>  item = 2;
> }

A statement list metavariable only matches the code starting right after a
{.  It can't start in random places.  Nothing is going to chenge here.

julia

>
>
> Regards,
> Markus
>
--8323329-1319872754-1772994034=:3947--
