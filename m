Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054EFCD8C90
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2026 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uakvFSMZK6a9fKEBXEFdixqiVNWILkOi8XgtCwd4PDw=;
  b=HLOcZn1iPOA/tFfLN50N/BdhOj4AlotlIQ2tLynIj7CpSyA7VFMUDXjP
   3iZbeP+J1eU9zlHVF7l/eDF3k9PZxLVhDgMx9h6F8aXJUJsR7zpkg+7+U
   xHFmLliuuZyhnIiIOr1sxF8Boe+zQPR3hxFJ/D8+XgqRwTOu2CVIR3mwx
   8=;
X-CSE-ConnectionGUID: Jic3x4isT+COGH5LU4kPuQ==
X-CSE-MsgGUID: iZwjAEm0QLCjyRacckm8lw==
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
X-IronPort-AV: E=Sophos;i="6.24,193,1774306800"; 
   d="scan'208";a="280194469"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2026 22:26:17 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 050DD806FD; Sun,  7 Jun 2026 22:26:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BC2B3806F3
	for <cocci@sympa.inria.fr>; Sun,  7 Jun 2026 22:26:11 +0200 (CEST)
X-CSE-ConnectionGUID: e0cT/feQRnmwGBvo5giRjw==
X-CSE-MsgGUID: 0jW76KZPQRSTCbVAZxHK8w==
X-IronPort-AV: E=Sophos;i="6.24,193,1774306800"; 
   d="scan'208";a="148658601"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien-11.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 22:26:12 +0200
Date: Sun, 7 Jun 2026 22:26:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Felix Gu <ustc.gu@gmail.com>
In-Reply-To: <37bcc073-cc9c-4586-a271-0d6c7cd59693@web.de>
Message-ID: <d4839425-f9b1-b2d9-f49c-aac22894f225@inria.fr>
References: <37bcc073-cc9c-4586-a271-0d6c7cd59693@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-280001916-1780863971=:56433"
Subject: Re: [cocci] Searching inappropriate readl specifications with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3559
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/BtpJOv3MNyhm40wfiERJwg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-280001916-1780863971=:56433
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 7 Jun 2026, Markus Elfring wrote:

> Hello,
>
> Felix Gu pointed another software correction out.
>
> I assumed that something can be achieved also by the means of the semantic
> patch language accordingly.
>
>
> // See also:
> // [PATCH] spi: rzv2h-rspi: fix incorrect readl() accessor for 8-bit RX path
> // https://lore.kernel.org/linux-spi/20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com/
>
> // https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/spi/spi-rzv2h-rspi.c#L140
> @display@
> identifier action;
> typedef u8;
> @@
> *action(readl, u8)
>
>
> Questionable test result (in combination with the software “Coccinelle 1.3.1”):
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch …/Projekte/Coccinelle/janitor/show_questionable_readl.cocci drivers/spi/spi-rzv2h-rspi.c

Please include a complete example with a semantic patch and a minimal
extract oc C code in which you think the result is not correct.

Maybe Coccinelle was not able to parse the code thta contains what you are
searhing for?

julia

> …
> real    0m0,119s
> user    0m0,103s
> sys     0m0,014s
>
>
> Why is an expected difference display not generated so far?
>
> Regards,
> Markus
>
--8323329-280001916-1780863971=:56433--
