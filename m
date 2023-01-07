Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B5C54EBC
	for <cocci@archiver.kernel.org>; Sat,  7 Jan 2023 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=31Pyaqlnkd0uTzyT5Bl6VYAdqpi25hkILx9RrFxzvkw=;
  b=LID7aWl8dxO1aa5tayWKA/9HZOWqOCPXz7MSK0xP3s9ndVh22A8b6euK
   jm8T2aZZi23OvhjZo7hxEM2GHCmIyp0wvrOkzi7botyCagaMGJb9R1se0
   AoIALWBBn4Q3ZkHBd3bOtxmMnv8/2XYQQ+Cg5uOEq3lB59GbU7LHYXxTN
   Q=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="86416466"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2023 14:45:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BA923E5A72; Sat,  7 Jan 2023 14:45:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A7CBE5A70
	for <cocci@sympa.inria.fr>; Sat,  7 Jan 2023 14:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=31Pyaqlnkd0uTzyT5Bl6VYAdqpi25hkILx9RrFxzvkw=;
  b=lmZMVQJI4emuiZvm16X08LxtT565YodFyBgU4J/VPX2DyOtRCtE8h29S
   /MoRsYi3U3Al7qMtfJg5Oj35CRneO08D1IubuqlHmV1QAViOM6rq38vi6
   wcF+dq67/xczYva1peLokrj9wfxCz7f3JhSdyYvY4U+aiEDeCd5+33lX6
   I=;
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="44405705"
Received: from 186.120.68.85.rev.sfr.net (HELO hadrien) ([85.68.120.186])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 14:45:14 +0100
Date: Sat, 7 Jan 2023 14:45:12 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <38da3db5-0aea-e05b-b105-d4943b64ffc5@web.de>
Message-ID: <alpine.DEB.2.22.394.2301071444420.2774@hadrien>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de> <alpine.DEB.2.22.394.2212260740380.2980@hadrien> <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de> <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr> <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
 <alpine.DEB.2.22.394.2301071354000.2795@hadrien> <cfa05a5d-1835-c58b-dc28-4b017cebe2f2@web.de> <alpine.DEB.2.22.394.2301071423590.2774@hadrien> <38da3db5-0aea-e05b-b105-d4943b64ffc5@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1959174516-1673099112=:2774"
Subject: Re: [cocci] Working with filled data structures
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 811
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301071444420.2774%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1959174516-1673099112=:2774
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 7 Jan 2023, Markus Elfring wrote:

> >>> or make a pattern that contains one element followed by a list.
> >> Would this design variant need pairs of metavariables?
> >>
> >>
> >> How do you think about the possibility to add a corresponding metavariable
> >> type like “array”?
> > Array does not suggest to me anything like what you are asking for.
>
> Which data type name would you find more appropriate for the ordered storage
> of a varying number of items?

We already have list for that.  With constraints, as illustrated in the
previous message, that is sufficient.

julia
--8323329-1959174516-1673099112=:2774--
