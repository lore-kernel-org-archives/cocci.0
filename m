Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A18FD0066
	for <cocci@archiver.kernel.org>; Sun,  1 Mar 2026 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xrf4bu7LvNWOLYP7yVlpmdqkq+AF0MD5gBd/z514cSU=;
  b=mKBy53y7+ogDOweBF/Nquxs53iSoBgJXWZtFaZQy3j7y3jkY7wBiT13D
   ambvStNvkstS94UIaH+hQPsRm5S8rmjXpxFY8n3HIUlLrp0hwb/pqWp2t
   sx6+KJ2hHLSgiA9PvUB73Xq4mnhy7t75Wv3i/6WzWc0LeFFtGNhG01H5v
   s=;
X-CSE-ConnectionGUID: okT6YBRlTXWyAoKbyxthHg==
X-CSE-MsgGUID: 6ueEq4ovT4mOSNkIDoWppw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265652584"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2026 14:33:34 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8AD2380EF1; Sun,  1 Mar 2026 14:33:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B820580EE3
	for <cocci@sympa.inria.fr>; Sun,  1 Mar 2026 14:33:29 +0100 (CET)
X-CSE-ConnectionGUID: p4yowPcwQuaDhA1nPRoSUg==
X-CSE-MsgGUID: NwxDxBoFQNmLzOgQhF6cVQ==
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265652572"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 14:33:29 +0100
Date: Sun, 1 Mar 2026 14:33:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <9548ebc2-57ba-4d35-aa07-015c9d2b1e2b@web.de>
Message-ID: <cd2290ba-5099-d55d-a55a-8713568c77f1@inria.fr>
References: <30ca5b1f-1add-4ce2-b01c-495966773a98@web.de> <1d6176db-f59f-9ebf-f96d-87babf92526f@inria.fr> <9548ebc2-57ba-4d35-aa07-015c9d2b1e2b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-292041280-1772372009=:4024"
Subject: Re: [cocci] Separating label from previous key word display
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3316
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/9Mq03WoUh-0MM0aNM7hg6w>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-292041280-1772372009=:4024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 1 Mar 2026, Markus Elfring wrote:

> >> How can it be achieved to separate the mentioned label from a corresponding
> >> key word display?
> >
> > I have no idea what you are asking for.
>
> ???
>
>
> >                                          It would help a lot of you would
> > provide an expected output.
>
> Would you find the shown display improvable anyhow?
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch --parse-cocci test_parse_goto_display.cocci
> …
> -return -rc
>   >>> gotospecial_target
> ;
> …
>
>
> Would the representation be a bit nicer with an additional space character here?

OK.  If you had written something like:

Shouldn't:

>>> gotospecial_target

be

>>> goto special_target

I could have known immediately what you were talking about.

julia

>
> Regards,
> Markus
>
--8323329-292041280-1772372009=:4024--
