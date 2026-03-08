Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24879EA8529
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TOtwcRO5JMQjASrmqB7Xh394x5gCt/Jzqjtjg4MZmFM=;
  b=cgSswL68pEvMHvqK+MQVMK3b2HW4AKvJQvgqhQsgfOfjIIvm6J1vqcmd
   9VDJI+EvqZX01uApAsqmzEpsNyCeRbQ4bPRn0k5TP/R6OVtTYsxfmLPlM
   faGRrfrTvlltWzDoPh8OB5dfmpYVCJqhSi5TGdm/qj8g0pZefIkxpguCc
   U=;
X-CSE-ConnectionGUID: mbOXktIyTRuzG076QoHdOg==
X-CSE-MsgGUID: AUV+Q77RRnmTohkn1vRZtA==
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
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266748218"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 16:24:10 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9CCB881598; Sun,  8 Mar 2026 16:24:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A583980ED3
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 16:24:04 +0100 (CET)
X-CSE-ConnectionGUID: pEOxjfbYRYi/sCxkV7SxAw==
X-CSE-MsgGUID: ET8Gg482TdShABzd92NmNw==
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="140720921"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 16:24:04 +0100
Date: Sun, 8 Mar 2026 16:24:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
Message-ID: <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de> <f25025ab-4500-4315-b41c-53cd5775c69f@web.de> <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de> <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr> <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3332
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/UiiSyZX_olFLOXLsG1U79g>



On Sun, 8 Mar 2026, Markus Elfring wrote:

> > I have no idea what result you would like to see.
>
> Under which circumstances would you dare to acknowledge remaining open issues here?

If you can tell me what result you want maybe I can do something.  It's
not a matter of daring to do something or not.

julia
