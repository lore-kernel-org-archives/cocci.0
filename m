Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BC1C7EE39
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Llox9LUP6BXsHDhac+BT4SfHyctLGQlyQ0nCJckihrY=;
  b=i23SEUqqNp774G77k7x3y/S8fGOntKhNvyxP/eSU57OfmrycwH6QlomE
   t4RPwiKTCTwxZ96xEpy3EKrAAVlvpauhiqsABE+JSxH9oxnzvMxI4yUuk
   GTiu37EfAk7sUq04mc1TOk/mNVYlWauGvoA4rJZOmV9KVO4ZDWuM36jMh
   w=;
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
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229425308"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 16:39:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BD4E1E0157; Sat, 28 Jun 2025 16:39:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0BDD2E0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 16:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Llox9LUP6BXsHDhac+BT4SfHyctLGQlyQ0nCJckihrY=;
  b=qr3lgU069OwINF1oXNTYxsPB44HFo/BlRxhqANdy7F1GFEJ4h3IV7kg6
   Vzv+b5nuyECxZcR895Pn1FcJpxRkcF6WOHb1P6962ByxRG6W5qSxUS8Np
   /oXnYjWce6ow/ikqWXRwz4wPafT8FdzklC7dIM/O2Rcw1jMZqmKKYSSK5
   g=;
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229425306"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 16:39:02 +0200
Date: Sat, 28 Jun 2025 16:39:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
Message-ID: <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2798
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506281638300.50494%40hadrien>



On Sat, 28 Jun 2025, Markus Elfring wrote:

> Hello,
>
> I imagine that a known function definition can be converted into a source code
> transformation like the following.
> https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/cec.h#L84-L90
>
> Another SmPL script example:
> @replacement@
> @@
> -msg -> msg [ 0 ] & 0xf
> +cec_msg_destination(msg)
>
>
> Now I wonder which metavariable selections would be appropriate for such
> an use case.

I'm not sure what the concern is.  If you want a metavariable that can
match both occurrences of msg, then that would be an identifier.

julia
