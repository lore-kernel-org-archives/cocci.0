Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C11FCD98D8
	for <cocci@archiver.kernel.org>; Sat, 13 Jun 2026 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CC/nL5yI5lYGuvrAXuWOJGmcYnesZj8vy6L3dDHw0n0=;
  b=hguWghK9ZEcnTZzIw+vpwiLX1LLFp+irg3g0eo2N54Du0NPdbcA3zsm8
   n5Nuk7ZOg1W8dgouvZ3Z4upLxwH8hAHucTLwDRhQ7tbYSkXpv/J1ZuPHr
   ZpuKulgZOEdAdREdkt+hSJNO3W1S05+PGSpZwasSbR7C0O0vHrnCKlzJs
   o=;
X-CSE-ConnectionGUID: mItmSVrLQUiuI+gUwPoeoA==
X-CSE-MsgGUID: fqRQ0+BTTUqiMVU81ReKsA==
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
X-IronPort-AV: E=Sophos;i="6.24,203,1774306800"; 
   d="scan'208";a="281388102"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2026 19:42:31 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8B23980625; Sat, 13 Jun 2026 19:42:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 00A9F80625
	for <cocci@sympa.inria.fr>; Sat, 13 Jun 2026 19:42:28 +0200 (CEST)
X-CSE-ConnectionGUID: uyIuBhszQw+vrUYZEzS51w==
X-CSE-MsgGUID: QmSETSGWRHeT9mbartCTYQ==
X-IronPort-AV: E=Sophos;i="6.24,203,1774306800"; 
   d="scan'208";a="281388087"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 19:42:28 +0200
Date: Sat, 13 Jun 2026 19:42:27 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ebb2718d-2b6b-4149-9320-0d6378c0b2bd@web.de>
Message-ID: <6f3b8c65-9843-d0be-24c0-86ecde43b93b@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <355d9d84-f6fe-4cb1-b764-3705ef16b6ea@web.de> <a2e72ff4-53e-7ff5-ddf1-9356d9b6bae1@inria.fr> <ebb2718d-2b6b-4149-9320-0d6378c0b2bd@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1308786606-1781372547=:28904"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3564
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/bSZGIiuqkfQmL803pCJgFg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1308786606-1781372547=:28904
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 13 Jun 2026, Markus Elfring wrote:

> >> Is there a field or column like incidence desirable?
> > Do you agree that my semantic patch finds what you expect to find?
>
> Your SmPL script variant looks promising.
>
> // See also:
> // https://lore.kernel.org/cocci/c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr/
> // https://sympa.inria.fr/sympa/arc/cocci/2026-06/msg00005.html
> @searching_for_OCaml@
> expression e, x;
> identifier item, rc;
> position p1, p2;
> @@
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
>
> @script:ocaml@
> p1 << searching_for_OCaml.p1;
> p2 << searching_for_OCaml.p2;
> @@
> Printf.eprintf "duplicate on lines %d and %d\n" (List.hd p1).line (List.hd p2).line
>
>
> Questionable test result on my development system:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> /usr/bin/spatch …/Projekte/Coccinelle/janitor/show_duplicate_statements_in_if_branches3.cocci sound/core/seq/seq_fifo.c
> …
> Using native version of ocamlc/ocamlopt/ocamldep
> ocamlopt.opt -shared -o /tmp/ocaml_cocci_ad6bde.cmxs -g -I /usr/lib64/coccinelle/ocaml  -I /home/Markus_Elfring/.opam/5.3.0/lib64 -for-pack Coccinelle_modules /tmp/ocaml_cocci_ad6bde.ml
> File "/tmp/ocaml_cocci_ad6bde.ml", line 1:
> Error: /usr/lib64/coccinelle/ocaml/coccilib.cmi
>        is not a compiled interface for this version of OCaml.
> It seems to be for an older version of OCaml.
> Fatal error: exception Coccinelle_modules.Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_ad6bde.ml")

OK, so write the codein python.  It should be clear in any case what it
does.

> > If you agree on that,
>
> I would appreciate if an intended data output can be reproduced finally.
>
> But which software functionality would perform counting of repeated items
> in your data processing approach?

I did't count anything.  Since I don't know what you code does, nor what
it is intended to do, I didn't bother trying to reproduce it.

Can't you just explain what you hoped would happen and whythe result is
not what you expected?

julia


>
>
> > it would seem that the problem is in your python code.
>
> Some communication challenges were presented.
>
> Regards,
> Markus
>
--8323329-1308786606-1781372547=:28904--
