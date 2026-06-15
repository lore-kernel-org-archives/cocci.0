Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404A4CD98C7
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2026 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Gp/J1/8BAjktgdSJGHfyrxVihXqTXzj3Asz/8PBsgng=;
  b=N/py/wMeV3i7j+qtW0AtLHBst1GZXtshMp4W+ZM+RSkGFY0GUeaKcppS
   YMP/DCIBierbiE9DMRN50E4ayDmKMnuVeI3MFYu26bGrp8Nkx2FoRuBh1
   cRAgHChODwCTWkFHNgf1WzxVUclU2IG0dsIKvOau/6AAkcTkR7SlXPjbU
   s=;
X-CSE-ConnectionGUID: hHGaHagpRlSPwmKXsUCuSw==
X-CSE-MsgGUID: 61X5GQuKQOmg6xH+ZnBhYg==
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
   d="scan'208";a="281569322"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jun 2026 12:48:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1128B817F4; Mon, 15 Jun 2026 12:48:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8CCD0817F4
	for <cocci@sympa.inria.fr>; Mon, 15 Jun 2026 12:48:29 +0200 (CEST)
X-CSE-ConnectionGUID: l29yemGrQES2vkPVWHeq4A==
X-CSE-MsgGUID: /ci6E774S7aZ078uaZgehg==
X-IronPort-AV: E=Sophos;i="6.24,206,1774306800"; 
   d="scan'208";a="281569310"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 12:48:29 +0200
Date: Mon, 15 Jun 2026 12:48:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5ef12353-a641-4861-a16f-750c490e3054@web.de>
Message-ID: <3e6cfbaa-8268-5854-f410-c4d2d0e9f56@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <5ef12353-a641-4861-a16f-750c490e3054@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3569
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/zJPGnhEqrWHVpxSB2DeKAg>



On Mon, 15 Jun 2026, Markus Elfring wrote:

> > Thank you for making a complete example.
>
> Is there a need to port it to OCaml programming interfaces
> so that any difficulties with the interpretation of a bit of Python code
> can be avoided?

No.

>
>
> Which software components do decide how often an SmPL rule should be evaluated
> for the supported scripting languages?

The number of times is dependent on the size of the set of tuples of
argument values.  Each distinct tuple of values triggers exactly one
execution.

julia

>
> Regards,
> Markus
>
