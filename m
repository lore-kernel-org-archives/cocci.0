Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C72CD98D2
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2026 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AS1y3yhPecvOa3TlsHH+wUOqsK670rOKK1A4+IUKCRk=;
  b=rpulN0bTjbtRypjpccLbm1/IO0F1MKNLiGKEmMfBx//HcDFWYBb8olQ6
   naV5iNNy0B6styof/nmhaVoxAe8pcEWekWfQ2NFKffQnmHg4W+di9Ec8a
   MfC606iGL49PZjoAEzalMYtXDJuCivz9x+5aNPj4CLWZb3Kz7wLDNrGtJ
   I=;
X-CSE-ConnectionGUID: G//dH/rCS16nkKeJXc3JNw==
X-CSE-MsgGUID: 96VGhBiYQCufDAAzNEfDuA==
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
X-IronPort-AV: E=Sophos;i="6.24,207,1774306800"; 
   d="scan'208";a="281728492"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2026 09:19:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 00FCF8264F; Tue, 16 Jun 2026 09:19:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 35FE88263A
	for <cocci@sympa.inria.fr>; Tue, 16 Jun 2026 09:19:54 +0200 (CEST)
X-CSE-ConnectionGUID: mmCKWVLERf2Uv/15vrdfcw==
X-CSE-MsgGUID: E4URj3QfTZ6a4OOG+gMbAw==
X-IronPort-AV: E=Sophos;i="6.24,207,1774306800"; 
   d="scan'208";a="281728473"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 09:19:54 +0200
Date: Tue, 16 Jun 2026 09:19:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <180730f8-bf12-4898-97d3-d209aac45e32@web.de>
Message-ID: <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
 <ab10711d-81ae-9254-215d-3676c361fde@inria.fr> <180730f8-bf12-4898-97d3-d209aac45e32@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-441025157-1781594394=:3706"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3576
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/uwW8ptZ8F3eVzuLLX5velA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-441025157-1781594394=:3706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 16 Jun 2026, Markus Elfring wrote:

> >>> Is such a number suspicious together with the information “9620 files match”?
> >>
> >> I adjusted the implementation of the function “display_data” another bit
> >> so that a questionable condition can be checked and displayed directly.
> …
> >> Markus_Elfring@Sonne:…/Projekte/Bau/Linux/scripts/Coccinelle> rg 'hit' list_selected_duplicate_statements_in_if_branches4-20260612.txt | wc -l
> >> 254
> >>
> >>
> >> Such a number looks more promising for possible update candidates,
> >> doesn't it?
> >
> > I don't know what your semantic patch does,
>
> Why did you not forward original background information to the mailing list
> for Coccinelle so far?
>
> 2026-06-14
> https://lore.kernel.org/cocci/bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr/
> https://sympa.inria.fr/sympa/arc/cocci/2026-06/msg00010.html
>
>
> >                                             so I don't know whether the
> > result is useful or not.
> So I hope also again that the following SmPL script variant can influence development ideas
> in desirable directions.
>
>
> @initialize:python@
> @@
> import sys
> delimiter = "|"
>
> def display_data(fun, source1, source2, x, y):
>     sys.stdout.write(delimiter.join(("info", fun, x, y))
>                         + "\n")
>     place1 = source1[0]
>     place2 = source2[0]
> #    if place1 == place2:
>     if (place1.line == place2.line) and (place1.column == place2.column):
>        sys.stdout.write(delimiter.join(("error",
>                                         "same position",
>                                         place1.file,
>                                         place1.line,
>                                         str(int(place1.column) + 1)))
>                         + "\n")
>
>     else:
>        sys.stdout.write(delimiter.join(("hit",
>                                         place1.file,
>                                         place1.line,
>                                         str(int(place1.column) + 1),
>                                         place2.line,
>                                         str(int(place2.column) + 1)))
>                         + "\n")
>
> @searching exists@
> expression e, x;
> identifier item, rc, work;
> position p1, p2;
> type t;
> @@
>  t work(...)
>  {
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p1(item);
>  return rc;
>  }
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p2(item);
>  return rc;
>  }
>  ... when any
>  }

So why do you think that the number of relevant files diminshed?
Coccinelle informs you of what tokens it has considered, but I don't think
you included that.

Furthermore, it seems strange that you declare rc to be an identifier.
-ENOMEM, for example, is not an identifier.  It is an expression.

And you still have no checks for gotos, so you will still get cases where
both kfrees are on the same line.  Another approach is to just adjust your
python code to discard such cases.  I see that you do that already.  But
why not just ignore such results instead of complaining about them?

Is there really nothing like printf in python?
sys.stdout.write(delimiter.join looks very primitive.

julia


>
> @script:python collection@
> fun << searching.work;
> x << searching.item;
> y << searching.rc;
> p1 << searching.p1;
> p2 << searching.p2;
> @@
> display_data(fun, p1, p2, x, y)
>
>
>
> Test result examples:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch ../janitor/list_selected_duplicate_statements_in_if_branches4.cocci snd_seq_fifo_new-excerpt-20260608.c
> …
> info|snd_seq_fifo_new|f|NULL
> hit|snd_seq_fifo_new-excerpt-20260608.c|13|3|18|3
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch ../janitor/list_selected_duplicate_statements_in_if_branches4.cocci test-insufficient_goto_chain_usage.c
> …
> info|my_test|md1|rc
> hit|test-insufficient_goto_chain_usage.c|12|5|36|2
> info|my_test|md1|rc
> error|same position|test-insufficient_goto_chain_usage.c|36|2
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> /usr/bin/spatch arch/arm/xen/enlighten.c /home/altes_Heim2/elfring/Projekte/Coccinelle/janitor/list_selected_duplicate_statements_in_if_branches4.cocci
> …
> info|arch_xen_unpopulated_init|regs|rc
> error|same position|arch/arm/xen/enlighten.c|410|2
>
>
> Regards,
> Markus
>
--8323329-441025157-1781594394=:3706--
