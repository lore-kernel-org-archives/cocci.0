Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4209FEA8537
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SmYZeuaCpcsJLfL90ABgYf1488tsNWQFxHOk4LrTUDo=;
  b=ooCv70LEwic5PrjHqGEa+dVw8B6aUS7BBmJtZE8GjhBFPPfO8K7KFNx9
   0MRo0sHH2T8VJXTJB1i6AacbwP+4GMTF9hZ/Q+xLK8z1kV/ku9rnHVNIY
   lq3SdwEF/xG2WKnDCvZyThxwwGqQVE6kV/p3E4kq8IH6vJyaU49cjUvCH
   4=;
X-CSE-ConnectionGUID: JvRRCv51QYeSs9vIAL/6pA==
X-CSE-MsgGUID: vcZ410YAQ8iulkTNaV1muA==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266751463"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 17:54:06 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AC7A981236; Sun,  8 Mar 2026 17:54:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1E5BB81236
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 17:53:59 +0100 (CET)
X-CSE-ConnectionGUID: 4Oal3RWiR3K3rl+LRzPHAw==
X-CSE-MsgGUID: FzMkou3ST+Wv9t1/Au6epg==
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266751450"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 17:53:59 +0100
Date: Sun, 8 Mar 2026 17:53:58 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
Message-ID: <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de> <f25025ab-4500-4315-b41c-53cd5775c69f@web.de> <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de> <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr> <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr> <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3334
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/m5nDhWMBGjVawTTTSM2fPQ>



On Sun, 8 Mar 2026, Markus Elfring wrote:

> >> Under which circumstances would you dare to acknowledge remaining open issues here?
> >
> > If you can tell me what result you want maybe I can do something.
>
> Can you see concrete change opportunities from my recent test results?
>
> 1. Inappropriate difference output
>    https://lore.kernel.org/cocci/349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de/
>    https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00004.html

There is a problem here.

> 2. Questionable hierarchy level
>    https://lore.kernel.org/cocci/20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de/
>    https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00015.html

This is the message I was referring to.  I have no idea what you expect as
the output.  I don't know why it is so hard to provide that information.

julia

>
>
> > It's not a matter of daring to do something or not.
>
> Will development interests grow anyhow?
>
> Regards,
> Markus
>
