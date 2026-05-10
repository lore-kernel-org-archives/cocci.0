Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F967CD3427
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2W69ScR9CEKNqeBxej3IFCzslfgPGKhwcUZT6ew8qF8=;
  b=FistSBpTl0SkMppZuruL+vrnhSxsbPBUmHXL6niGTIP2evwjZ98mCtjY
   SMaxmsKeiwWYZ4/DKbEyPj6KYXea2pktsPANC/pHSguRh0dAq9m5DClxb
   ZswmWzFUm+uo7lcwpzCTSUASTdIpnJChA38nV6ChPHkqXePcPVXNtYEfR
   A=;
X-CSE-ConnectionGUID: 7XMRZ4A4SwGvllpbvjGPcw==
X-CSE-MsgGUID: 8YtHrkxUS1GW+Tg6E64MRQ==
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
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276017874"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 11:07:59 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3CBBB804C0; Sun, 10 May 2026 11:07:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DE773804C0
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 11:07:50 +0200 (CEST)
X-CSE-ConnectionGUID: nfB0akGHRAeMg44Z3hecAQ==
X-CSE-MsgGUID: mQLq2AmaSOSJba18ZCceXw==
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="146153414"
Received: from 88-188-165-3.subs.proxad.net (HELO hadrien) ([88.188.165.3])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:07:50 +0200
Date: Sun, 10 May 2026 11:07:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
Message-ID: <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de> <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr> <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de> <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr> <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr> <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1543262641-1778404070=:3349"
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3493
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/9ndKlgatyTA8KPTd6rn5ow>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1543262641-1778404070=:3349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 10 May 2026, Markus Elfring wrote:

> >> How do you think about to point the circumstances out under which this one
> >> would be applied?
> >
> > When the semantic patch requests it.  Please see tests/merge_vars.cocci or
> > merco_vars_python.cocci
>
> Thanks for another hint.
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/tests/merge_vars.cocci
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/tests/merge_vars_python.cocci

No idea what is the point of these links.

> Do you distinguish “merging” from data concatenation in such code?

No idea what this question means.

You can declare variable in OCaml or Python to be the result of
concatenating the results from the different threads.  There is nothing
more to discuss about it.

It's true that the above tests are overly simplistic.  Maybe
tests/names.cocci would be a better example.  But it doesn't have a python
counterpart.

>
> >> Would you become more interested in the clarification of corresponding case distinctions?
> >
> > There are no case distinctions.
>
> How will such a view evolve further according to the use case “parallel data processing”?

No idea what this means.

>
> >> Do you care for the ordering of generated data anyhow?
> >
> > No.
> I find this feedback strange.
> Data users tend to prefer some information ordering, don't they?

You look at the data and order it however you want.  The user has no
control over what files get handled by what tasks, so it doesn't make
sense for Coccinelle to provide any ordering guarantees.

julia
--8323329-1543262641-1778404070=:3349--
