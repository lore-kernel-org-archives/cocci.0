Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C726C61DB9
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2026 13:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wGdauYYeSoLghg8XFSFnJI/mKMIly+AEeT7tYGOO7OI=;
  b=Sajj9TGPE9ugY9gpASgu5hO4BK7okPLXFgFWJ7rLiQ6iQ9ouFLW50jIh
   RuF2H84rAD4Amu4GhjKBTw8zcRDI23JzkMdHLYCRNCVDy6Z4VmboHuy+B
   Ihj6sDxW6s1GDL4opDKEtr3e5Chi/b50WllGgCq7shPlKrkf8FeXvy5dY
   U=;
X-CSE-ConnectionGUID: pZXp8xewSXO5ERzAckdUFA==
X-CSE-MsgGUID: ocIuSym9R8q/HXincSGxQg==
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
X-IronPort-AV: E=Sophos;i="6.25,248,1779141600"; 
   d="scan'208";a="292024490"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Aug 2026 15:10:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1AE608143B; Fri, 28 Aug 2026 15:10:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 49A5F8143B
	for <cocci@sympa.inria.fr>; Fri, 28 Aug 2026 15:10:32 +0200 (CEST)
X-CSE-ConnectionGUID: RsVqu6yaRwiQFQfLhmdhOw==
X-CSE-MsgGUID: DekLxXruS7iuw1puvGCK8A==
X-IronPort-AV: E=Sophos;i="6.25,248,1779141600"; 
   d="scan'208";a="292024478"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 15:10:32 +0200
Date: Fri, 28 Aug 2026 15:10:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org
In-Reply-To: <9e729258-a720-4b8f-b0f0-e84f3a984aef@web.de>
Message-ID: <a0b9259-987b-1c92-2e86-3409ecf87e@inria.fr>
References: <9e729258-a720-4b8f-b0f0-e84f3a984aef@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-753801670-1787922632=:71423"
Subject: Re: [cocci] Improving support for deleting selected macro calls
 with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3720
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/V-DJa-L5qdkEim-WNC0IYg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-753801670-1787922632=:71423
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 28 Aug 2026, Markus Elfring wrote:

> Hello,
>
> The data processing is still improvable also according to the software
> combination “Coccinelle 1.3.2”.
>
> Another SmPL script example:
> @deletion@
> @@
> -READ_ONCE(dev->mtu)
>
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci delete_READ_ONCE_for_mtu.cocci
> …
> invalid minus starting on line 3

You can't simply delete an expression.  The resulting code would not be
valid.  For example if the code was 10 + READ_ONCE(x), you would end up
with 10 +, which is not valid C code.

The problemn has nothing to do with READ_ONCE being a macro.  It occurs
for any expression.

julia

>
>
> Would you like to improve any software components accordingly?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/78ac4072c68190fc929f2e3c7534350a5ef6496a/parsing_cocci/context_neg.ml#L1419-1434
>
> Regards,
> Markus
>
>
--8323329-753801670-1787922632=:71423--
