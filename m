Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836FDCD98C5
	for <cocci@archiver.kernel.org>; Sat, 13 Jun 2026 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xG2b2/mT1qdzeXKgW8mG3rtXn8Hmusrclq2dLAwC9N4=;
  b=QAFjtfP0mFkO+Bbowo9+Kc3uWGsWBhTimQxjxL6Fmar4WBul9IF5gOK2
   nny+YODlCKKMHU1nyM8IKtO5/s+BnIUQl1FSfj3DLpbRAijbVzvHxBuzG
   CmSnzW09c2TryUXhirExxekPTcMv3zWCj6Eu9SEtKIeDSpQkh0Ap5EK4C
   8=;
X-CSE-ConnectionGUID: fI9EVp9OSu2eHpLr2amlDQ==
X-CSE-MsgGUID: SFSjOvljQrOiHUd9r6WZMA==
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
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="281385685"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2026 18:41:43 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6356280EA5; Sat, 13 Jun 2026 18:41:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B17548062C
	for <cocci@sympa.inria.fr>; Sat, 13 Jun 2026 18:41:41 +0200 (CEST)
X-CSE-ConnectionGUID: 9jZNbyQaQNS7vLrCiDIJYA==
X-CSE-MsgGUID: yMT7hz1cQuey7NnPkXHEMA==
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="281385676"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 18:41:41 +0200
Date: Sat, 13 Jun 2026 18:41:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de>
Message-ID: <eb219668-8de8-a61-f852-4f16328e1832@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-675991979-1781368901=:28904"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3562
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/WUMvTrheVdRoVHkwBVNV_g>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-675991979-1781368901=:28904
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 13 Jun 2026, Markus Elfring wrote:

> > As usual, I have not idea what all your python code is supposed to do.
>
> I hope that a better common understanding can be achieved by another bit of clarification.
>
>
> > Is it something other than the following:
>
> I guess that the initial source code search pattern can be clear to some degree.
>
>
> …
> >> Questionable test results:
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> git checkout next-20260608 && time /usr/bin/spatch …/Projekte/Coccinelle/janitor/list_selected_duplicate_statements_in_if_branches.cocci sound/core/seq/seq_fifo.c…
>
> Can you benefit any more from a data representation like the following?

No.  I have no idea what output you expect, so I don't know what the
problem is.

Could you please make something that doesn't involve a database?

Or just explain what you expected as the output and how that relates to
the source code.

julia


>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch …/Projekte/Coccinelle/janitor/list_selected_duplicate_statements_in_if_branches2.cocci sound/core/seq/seq_fifo.c
> …
> Using SQLAlchemy version:
> 2.0.49
> …
> value1|value2|"function name"|"source file"|incidence
> f|NULL|snd_seq_fifo_new|sound/core/seq/seq_fifo.c|1
>
> real    0m0,799s
> user    0m0,664s
> sys     0m0,135s
>
>
> Regards,
> Markus
>
--8323329-675991979-1781368901=:28904--
