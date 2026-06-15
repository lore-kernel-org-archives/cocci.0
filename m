Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575F9CD98C5
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2026 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=G8UoF/MM8LEQFSHSSSdFYxsTmxzHbKB/+c50HZ8DPQ4=;
  b=gcs8W7ws750mjAbaxTpaOh/x/2A2xC580vUE6E9Cro+na4+11fcAw+AT
   Yi/dLSvgLqkbx3DPlKCwBn9d0d63+60iF1+HpSW6lVLsc70/qFHYxvS/r
   aQiJnOL4yIkcNFuc5zMqNaa4D7G3+Gx/35R2BYzN2oQF9IjfM8rsR9M/s
   Q=;
X-CSE-ConnectionGUID: QEMQ5EwVSwmbk8wFOFkOtQ==
X-CSE-MsgGUID: zT5frmpqRI6s+jUai2sQKA==
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
X-IronPort-AV: E=Sophos;i="6.24,206,1774306800"; 
   d="scan'208";a="281621498"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jun 2026 16:07:09 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4AE7581ED1; Mon, 15 Jun 2026 16:07:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6D47B81EBE
	for <cocci@sympa.inria.fr>; Mon, 15 Jun 2026 16:07:05 +0200 (CEST)
X-CSE-ConnectionGUID: eQP1IrZYRna6IBYlknmznw==
X-CSE-MsgGUID: /gE5ji1rS7+fKP0CiD0rbQ==
X-IronPort-AV: E=Sophos;i="6.24,206,1774306800"; 
   d="scan'208";a="281621473"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 16:07:05 +0200
Date: Mon, 15 Jun 2026 16:07:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <2342f3b4-989f-4a4b-a208-f827a9add0f9@web.de>
Message-ID: <37939c7b-ad18-ab42-20a-4b4bb3be7bad@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <7c8b2f73-224a-6b6-5154-5d913bca7bfb@inria.fr>
 <2342f3b4-989f-4a4b-a208-f827a9add0f9@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-203713418-1781532425=:3490"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3571
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/CyfMjdYRXDRAar6RyTXqtA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-203713418-1781532425=:3490
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 15 Jun 2026, Markus Elfring wrote:

> >> I tried it out also with the source files of the software “Linux next-20260612”.
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --timeout 45 -j4 --chunksize 1 --no-loops -dir . …/Projekte/Coccinelle/janitor/list_selected_duplicate_statements_in_if_branches3.cocci > …/Projekte/Bau/Linux/scripts/Coccinelle/list_selected_duplicate_statements_in_if_branches3-20260612.diff 2> …/Projekte/Bau/Linux/scripts/Coccinelle/list_selected_duplicate_statements_in_if_branches3-errors-20260612.txt
> …
> >> Markus_Elfring@Sonne:…/Projekte/Bau/Linux/scripts/Coccinelle> rg 'info|' list_selected_duplicate_statements_in_if_branches3-20260612.diff|wc -l
> >> 5808
> >>
> >>
> >> Is such a number suspicious together with the information “9620 files match”?
> >
> > I think you mention kfree in your semantic patch, so the number of matched
> > files comes from there.
>
> This is obvious as usual.
>
>
> >                          I have no idea whether the result is suspicious.
> I am trying to determine once more how plausible the mentioned data processing results are.

It would be better to look at them yourself.

julia

> How many development resources do we dare to invest then for more desirable software adjustments?
>
> Regards,
> Markus
>
--8323329-203713418-1781532425=:3490--
