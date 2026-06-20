Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A848CD98E4
	for <cocci@archiver.kernel.org>; Sat, 20 Jun 2026 05:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BA8r2HM1jwo/32eKqvwdxBdJLTCCWLfkKGGMhZNlDAk=;
  b=O9V9pCTlw2pSaJYoVEkv8yFXt/HHT+EIxFhPNVtz2Ku5qyGI5sCQrkKB
   oVDqKlzomcEQPP3igEdBcpfLnM1DzACGG2kTyuPpvpRQjxLoJcFT9BzeR
   gXkeawsxLvSiCKX2QIGZzpR/BdRCVX0OVb6BkIOLODaQELQpkwoOoBb8p
   k=;
X-CSE-ConnectionGUID: cnkbe4nBTUCTE0c+BMZC/w==
X-CSE-MsgGUID: m2yjpXKERSaeRg3Ah/ug4g==
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
X-IronPort-AV: E=Sophos;i="6.24,214,1774306800"; 
   d="scan'208";a="282521344"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2026 07:34:18 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3AE9D815A2; Sat, 20 Jun 2026 07:34:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D6B6C815E5
	for <cocci@sympa.inria.fr>; Sat, 20 Jun 2026 07:34:13 +0200 (CEST)
X-CSE-ConnectionGUID: /gmj6xTZRoqBtXDSoCYWVw==
X-CSE-MsgGUID: i4fpPXydQx+A1J+6ambwtQ==
X-IronPort-AV: E=Sophos;i="6.24,214,1774306800"; 
   d="scan'208";a="282521323"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 07:34:13 +0200
Date: Sat, 20 Jun 2026 07:34:13 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5e5cc7cf-357b-4d4e-85a3-f10de75694a0@web.de>
Message-ID: <657a967-dd94-d2ed-c22f-25eceb44abe0@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
 <ab10711d-81ae-9254-215d-3676c361fde@inria.fr> <180730f8-bf12-4898-97d3-d209aac45e32@web.de> <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr> <e0f44b96-0509-4094-817a-7c28ac57db3c@web.de> <42bf9713-9c39-4163-98e5-bf92a4d97ef6@web.de>
 <d6f13137-9943-4177-8895-7f6ff5bc606c@web.de> <d0d84e61-741d-64a8-e4a8-db1bfdba3d@inria.fr> <5e5cc7cf-357b-4d4e-85a3-f10de75694a0@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-69992295-1781933653=:4048"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3582
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/-DV9ZBA8OedvwMBexgmNXg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-69992295-1781933653=:4048
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 19 Jun 2026, Markus Elfring wrote:

> …
> >> sys.stderr.write(f"{convert_to_seconds(init_time)}: Initialisation was finished.\n")
> >>
> >> @searching exists@
> >> expression e, x;
> >> identifier item, rc;
> >> position p1, p2;
> >> @@
> >>  if (...)
> >>  {
> >>  ... when != rc = e
> >>      when != item = x
> >>  kfree@p1(item);
> >>  return rc;
> >>  }
> >>  ... when any
> >>  if (...)
> >>  {
> >>  ... when != rc = e
> >>      when != item = x
> >
> > Do you really require that e and x bind to the same things at the two
> > occurrences?
>
> I would expect more that mentioned identifier variables should usually match
> distinct things.

What you expect doesn't matter.  The semantics of Coccinelle is that if
there are two occurrences of a metavariable and they are not in different
branches of a disjunction, they have to match the same thing.

julia


>
>
> >               If the running time is slow, that is probably why?
>
> I got the impression that other factors should be also reconsidered.
>
> How much can you follow presented execution duration measurements
> for corresponding test reproductions?
>
> Regards,
> Markus
>
--8323329-69992295-1781933653=:4048--
