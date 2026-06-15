Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FC4CD98DA
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZKbnevDC9TQX7HcYoNgwqPurXzm675XmGnPcCQ2UMTM=;
  b=iBhbDD3V+Dt6YaHcmxaeYX6qSr4Lvm4nu8ONiJgXxtV+t8No+bm9eocf
   rqX/RPfn146ubTcnvPdnx7uXPvmOc+THP3EjrHu29LzLd/xsp4jZIvDgW
   yxuDFgJIthT6VsL6FUOVj6Lp988Vw4fg8FDJZDLXJyshc05pK9tHmFZQO
   s=;
X-CSE-ConnectionGUID: GvHFydymTtmUtJupOUPmJQ==
X-CSE-MsgGUID: ZEydZ8f9Tg6cepmmHTfPXA==
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
   d="scan'208";a="281680769"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jun 2026 22:38:02 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EEE8A8231A; Mon, 15 Jun 2026 22:38:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AD8E18068D
	for <cocci@sympa.inria.fr>; Mon, 15 Jun 2026 22:37:58 +0200 (CEST)
X-CSE-ConnectionGUID: 2SWlARiYRna9Z7R/XWGj4w==
X-CSE-MsgGUID: 0THSZi9KQYe+2T0C/vuljw==
X-IronPort-AV: E=Sophos;i="6.24,207,1774306800"; 
   d="scan'208";a="149516392"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:37:59 +0200
Date: Mon, 15 Jun 2026 22:37:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
Message-ID: <ab10711d-81ae-9254-215d-3676c361fde@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de>
 <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1059486213-1781555878=:3918"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3575
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/OiwntoXA3jKLA-WCuvFekg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1059486213-1781555878=:3918
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 15 Jun 2026, Markus Elfring wrote:

> > Is such a number suspicious together with the information “9620 files match”?
>
> I adjusted the implementation of the function “display_data” another bit
> so that a questionable condition can be checked and displayed directly.
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --timeout 23 -j4 --chunksize 1 --no-loops -dir . …/Projekte/Coccinelle/janitor/list_selected_duplicate_statements_in_if_branches4.cocci > …/Projekte/Bau/Linux/scripts/Coccinelle/list_selected_duplicate_statements_in_if_branches4-20260612.txt 2> …/Projekte/Bau/Linux/scripts/Coccinelle/list_selected_duplicate_statements_in_if_branches4-errors-20260612.txt
>
> real    10m21,520s
> user    36m21,220s
> sys     0m18,622s
>
>
> Markus_Elfring@Sonne:…/Projekte/Bau/Linux/scripts/Coccinelle> rg 'same position' list_selected_duplicate_statements_in_if_branches4-20260612.txt | wc -l
> 1682
>
>
> Goto chains are probably applied at several source code places.
>
>
>
> Markus_Elfring@Sonne:…/Projekte/Bau/Linux/scripts/Coccinelle> rg 'hit' list_selected_duplicate_statements_in_if_branches4-20260612.txt | wc -l
> 254
>
>
> Such a number looks more promising for possible update candidates,
> doesn't it?

I don't know what your semantic patch does, so I don't know whether the
result is useful or not.

julia
--8323329-1059486213-1781555878=:3918--
