Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8977CDB466
	for <cocci@archiver.kernel.org>; Sun, 21 Jun 2026 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=KKjyPtnSVGdxqseUR66sZUL/VHWbNOvxpyx6x8z+l1c=;
  b=ZxC82OuPVvhNTDbBp0gRxzllQHa9IPvkizqHHcB19HgVWhxs4fpepYkg
   Ra9wqZxvCliHLmOAkIhpsu8KntmQt/tl2fD7qT0QSmIk8oSrrr8zU9PQp
   9nE5nEHAvObHybkorcCEnVGqhaVz/414BfVYjHigLBk78MwIoclPye+qR
   I=;
X-CSE-ConnectionGUID: VAnj6djsTzefk7e8+fFI8w==
X-CSE-MsgGUID: HiWdQ1Q7TxS5Ft3nL/WECw==
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
X-IronPort-AV: E=Sophos;i="6.24,216,1774306800"; 
   d="scan'208";a="282602617"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jun 2026 09:11:02 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9E4E581626; Sun, 21 Jun 2026 09:11:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C3C9280E20
	for <cocci@sympa.inria.fr>; Sun, 21 Jun 2026 09:10:57 +0200 (CEST)
X-CSE-ConnectionGUID: vcBV6J3pSVmZ3uNY+5M00g==
X-CSE-MsgGUID: tozkCr2vRPynBuJsBijoig==
X-IronPort-AV: E=Sophos;i="6.24,216,1774306800"; 
   d="scan'208";a="150016027"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 09:10:57 +0200
Date: Sun, 21 Jun 2026 09:10:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <94ae57f9-ed91-42c3-b10c-753061276552@web.de>
Message-ID: <dde6758-b236-fc5f-ebc2-e2a1323814@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
 <ab10711d-81ae-9254-215d-3676c361fde@inria.fr> <180730f8-bf12-4898-97d3-d209aac45e32@web.de> <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr> <e0f44b96-0509-4094-817a-7c28ac57db3c@web.de> <42bf9713-9c39-4163-98e5-bf92a4d97ef6@web.de>
 <d6f13137-9943-4177-8895-7f6ff5bc606c@web.de> <94ae57f9-ed91-42c3-b10c-753061276552@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2095889798-1782025857=:3925"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3583
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/730t8ihWUPVZKzfyE-Zpqg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2095889798-1782025857=:3925
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 21 Jun 2026, Markus Elfring wrote:

> > Can such measurements influence any development approaches?
>
> I suggest to take also information from another SmPL script variant
> better into account.
>
>
> @initialize:python@
> @@
> import sys, time
> records = []
>
> def convert_to_seconds(x):
>     return x / (10 ** 9)
>
> def store_data(source):
>     """Add data to the list."""
>     x = time.monotonic_ns()
>     sys.stderr.write(f"store_data() was called after {x - init_time} ns from initialisation.\n")
>
>     for place in source:
>        records.append(1)
>
>     sys.stderr.write(f"store_data() was finished after {time.monotonic_ns() - x} ns.\n")
>
> init_time = time.monotonic_ns()
> sys.stderr.write(f"{convert_to_seconds(init_time)}: Initialisation was finished.\n")
>
> @searching exists@
> expression e, x;
> identifier item, rc;
> position p;
> @@
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p(item);
>  return rc;
>  }
>
> @script:python collection@
> p << searching.p;
> @@
> store_data(p)
>
> @finalize:python@
> @@
> if records:
>    sys.stdout.write(f"{len(records)} selected statement combinations were found after {time.monotonic_ns() - init_time} ns from initialisation.\n")
> else:
>    sys.stderr.write("No result for this analysis!\n")
>
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time echo $(grep -E 'kfree\(name2\);' map_fnode_dirent-excerpt-20260618.c | wc -l)
> 9
>
> real    0m0,007s
> user    0m0,002s
> sys     0m0,005s
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time /usr/bin/spatch --no-loops ../janitor/count_selected_if_branches.cocci map_fnode_dirent-excerpt-20260618.c
> …
> 5647.095966535: Initialisation was finished.
> HANDLING: map_fnode_dirent-excerpt-20260618.c
> store_data() was called after 365741113 ns from initialisation.
> store_data() was finished after 46703 ns.
> …
> store_data() was called after 366355893 ns from initialisation.
> store_data() was finished after 13051 ns.
> 9 selected statement combinations were found after 366512248 ns from initialisation.
>
> real    0m0,602s
> user    0m0,517s
> sys     0m0,081s
>
>
> The last kfree() call is counted here despite of the implementation detail
> that it is actually not explicitly specified within a known if branch.
>
> How would you determine the incidence distribution for discussed if branches
> from all Linux source files then?

As now mentioned numerous times, you have to prevent the ... from matching
a goto.

julia

>
> Regards,
> Markus
>
--8323329-2095889798-1782025857=:3925--
