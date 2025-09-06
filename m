Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559FBCA1002
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=90Ry3cr3DU5xQLMNXK0opJuccbbAUWym2pBPEWM3M3I=;
  b=eirL7babQuT+rDtOelpk/PbkNOpdqg47Mv731p8w2PO0ho1CCf0e8Nr1
   XZMjPPkp1d2VBfv/whYSVb7MkaoHxmukUPC5Qq/W1x4dFjVxSEvZYLlWL
   K87A3zT29yzlNS218Fmr03YxohmggoKlaT18lufR52S2uVxWErKTgy/tV
   k=;
X-CSE-ConnectionGUID: qC3Uq268SdWRDktT2Y9Hsg==
X-CSE-MsgGUID: uCz2RJG9RkG1e2FGWQGkQw==
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
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237811653"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 13:12:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 650C5E0B0D; Sat,  6 Sep 2025 13:12:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A939E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 13:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=90Ry3cr3DU5xQLMNXK0opJuccbbAUWym2pBPEWM3M3I=;
  b=V7rPOWSSgqPca9B7DdJTZ525ImrhtuDAnwUn3HrGseKYhCi8zQDqMgM7
   wtuP5unwE42Tp50QoT8kMzuAqJj2o38wGFCi2Lm4Iz/69Ef6Qi4Ntex/p
   bZHeycCGa8KU0OZ9Q9u1yRogaHezEkZ9mXCWIj+X4CN2VAptj4vM4rLRy
   4=;
X-CSE-ConnectionGUID: 2EENkPXnRsG9rzynf8c9/A==
X-CSE-MsgGUID: HsCOWR0/QoiDNMaj6MIRbw==
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="124820629"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 13:12:52 +0200
Date: Sat, 6 Sep 2025 13:12:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de>
Message-ID: <4959806f-e03e-9a59-63eb-f71b6bf6f954@inria.fr>
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de> <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de> <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr> <b0221946-43a5-43c0-8573-32c12e149681@web.de> <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de> <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr> <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de> <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-756290130-1757157172=:4008"
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3004
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/4959806f-e03e-9a59-63eb-f71b6bf6f954%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-756290130-1757157172=:4008
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 6 Sep 2025, Markus Elfring wrote:

> > We might not be able to continue a search directly after a known source code position.
> > But I assume that it would be possible to direct a search repetition to the place
> > which was determined before (according to a semicolon for example).
>
> The initially mentioned SmPL script pointed the implementation of the function “arm_dt_init_cpu_maps”
> (besides others) for further development considerations.
> https://elixir.bootlin.com/linux/v6.17-rc4/source/arch/arm/kernel/devtree.c#L59-L165
>
> I tried also the following SmPL script variant out.
>
>
> @find@
> expression e;
> position place;
> type t;
> t * pointer;
> @@
>  pointer = e(...);@place
>
> @display@
> position find.place;
> statement s;
> type find.t;
> t * find.pointer;
> @@
> *;@place
>  if (!pointer)
>     s
>  ... when != pointer

how about:

pointer = e(...);
if (!pointer) s
... when != pointer
? pointer = ...;

julia



>
>
> Unfortunately, it does not present the known implementation details.
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_unused_addresses_from_variable_assignments.cocci arch/arm/kernel/devtree.c
> …
> [no diff output]
>
>
> I would appreciate corresponding software improvements.
>
> Regards,
> Markus
>
--8323329-756290130-1757157172=:4008--
