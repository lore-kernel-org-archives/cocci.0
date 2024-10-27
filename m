Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E9D11707
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kBNwP+FsDu1+ra5V3fS4iT3ep2P54gwW+tT0a5voQ/I=;
  b=ea+NvqKD34ozUyeM81CDaRDqrFmeHJ+QOmk4WCg0jXIb0xOA9Kj7CPmr
   nMAGThRVEFybcYLl5sznKAZ2zFSVas3rHUEkBdJmBSR9ob0nWBshZpLGV
   vRJBLoXsBIvr+xF6YDYroKX0S+DjiyZXA6qKGTZ9dVv+E3iaa5ZOEVH1P
   0=;
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
   d="scan'208";a="190916060"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 14:31:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF862E0133; Sun, 27 Oct 2024 14:31:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 438F6E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 14:31:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kBNwP+FsDu1+ra5V3fS4iT3ep2P54gwW+tT0a5voQ/I=;
  b=D0WYRbIxR5UxSkaA7e52l9O4iIx0Ut1oh+9k0PJz/WT/iZN6am5L0HTY
   NV8Viqv1dbnZ8xeMMF/EjM00xU/GJy6ILZ7Xe085oED8EwVRnQbiEnPxl
   42u460TADb/k+T6CoVWibT+jjsFmDhLT58b3f/rn6zeVaA+njvXxsbBla
   E=;
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190916048"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 14:31:15 +0100
Date: Sun, 27 Oct 2024 14:31:15 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, "Derek M. Jones" <derek@knosof.co.uk>, 
    Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
Message-ID: <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk> <alpine.DEB.2.22.394.2410241728210.3352@hadrien> <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien> <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk> <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk> <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de> <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de> <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1924391754-1730035875=:3498"
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1941
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410271429560.3498%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1924391754-1730035875=:3498
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 27 Oct 2024, Markus Elfring wrote:

> > * Do you plan to analyse any function implementation sizes (…)?
>
> I got into the mood to try further data processing out also together with
> an SmPL script variant (like the following).
>
>
> @initialize:python@
> @@
> import sys
>
> records = {}
>
> class integrity_error(Exception):
>    pass
>
> def store_data(places):
>     """Add source code positions to an internal table."""
>     for place in places:
>        key = place.file, place.line, int(place.column) + 1
>
>        if key in records:
>           sys.stderr.write("\n".join(["-> duplicate data",
>                                       "file:", key[0],
>                                       "function:", place.current_element,
>                                       "line:", str(place.line)]))
>           sys.stderr.write("\n")
>           raise integrity_error
>        else:
>           records[key] = place.current_element, int(place.current_element_line_end) - int(place.line) - 1
>
> @searching@
> identifier f;
> position p;
> @@
>  f(...)
>  {@p
>  ... when exists
>  }
>
> @script:python collection@
> place << searching.p;
> @@
> store_data(place)
>
> @finalize:python@
> @@
> if len(records) > 0:
>    for key, value in records.items():
>       sys.stdout.write("|".join([value[0],
>                                  str(value[1]),
>                                  key[0],
>                                  key[1],
>                                  str(key[2])
>                                 ]))
>       sys.stdout.write("\n")
> else:
>    sys.stderr.write("No result for this analysis!\n")
>
>
> Unfortunately, I stumbled on a few test results which trigger further development considerations.
>
> Examples:
>
> A) GENERATE_PERMUTATIONS_3_EVENTS(name)
>    https://elixir.bootlin.com/linux/v6.12-rc4/source/lib/locking-selftest.c#L288
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> spatch …/Projekte/Coccinelle/janitor/list_curly_bracket_positions_for_function_implementations4.cocci lib/locking-selftest.c
> …
> -> duplicate data
> file:
> lib/locking-selftest.c
> function:
> W1R2_W2R3_W3R1_123
> line:
> 290
> …
>
> B) CTX_RQ_SEQ_OPS(name, type)
>    https://elixir.bootlin.com/linux/v6.12-rc4/source/block/blk-mq-debugfs.c#L500
> Markus_Elfring@Sonne:…/elfring/Projekte/Linux/next-analyses> spatch …/Projekte/Coccinelle/janitor/list_curly_bracket_positions_for_function_implementations4.cocci block/blk-mq-debugfs.c
> …
> -> duplicate data
> file:
> block/blk-mq-debugfs.c
> function:
> ctx_poll_rq_list_next
> line:
> 512
> …
>
>
> Will the chances grow to handle involved macro code better anyhow?

Derek reported off list something related to macros that Victor is looking
into.

If you could make a semantic patch that doesn't involve 30-some lines of
python code and would provide a minimal test case, then I could try to
understand if you are concerned about the same issue.

julia
--8323329-1924391754-1730035875=:3498--
