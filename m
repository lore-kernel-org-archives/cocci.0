Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2484AC5AC82
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2026 06:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=64I2sy1dW9w9ftDf3f6K4/E7F9KthV/TOil0If0YQkg=;
  b=r60VLnEwlIOXiFymnfN6P+3Ax4mT84LouR22debmOeJ056QUEpFaij1h
   yKkcKLWwjlmf2ayytihwCM2ZwlK5dL/z60sKErDv3fyKcb8tn2HIG7r6i
   VqDvQdFcfvDw05R1zME836+ObIluyki+p+j1aCUUYv91P42tOCA1ycU1W
   w=;
X-CSE-ConnectionGUID: cV3mjbcaShGgHLiKNxvG6Q==
X-CSE-MsgGUID: c5W8CeZJR+i8oCfvU4fQLA==
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
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="289638797"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Aug 2026 08:48:46 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F08FE80F57; Mon, 10 Aug 2026 08:48:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6EA6480385
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 08:48:43 +0200 (CEST)
X-CSE-ConnectionGUID: /e/A4jIVR/KSY7Thx9/j7A==
X-CSE-MsgGUID: UvIU+1WFRtq5Gd+QH8WBng==
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="153947834"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:48:44 +0200
Date: Mon, 10 Aug 2026 08:48:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    Ricardo Ribalda <ribalda@chromium.org>
In-Reply-To: <ef5b5f36-a1a2-4723-bc34-4ec7a5350ef2@web.de>
Message-ID: <27fd1773-a8ba-afe3-1cb6-51e4bc94d641@inria.fr>
References: <20260809165340.1719736-1-Julia.Lawall@inria.fr> <ef5b5f36-a1a2-4723-bc34-4ec7a5350ef2@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1551342331-1786344523=:38388"
Subject: Re: [cocci] [PATCH] coccinelle: scripts: coccinelle: devm_free:
 reduce false positives
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3671
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/9mvF7UBbF5FfdwpvCHaQBQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1551342331-1786344523=:38388
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 10 Aug 2026, Markus Elfring wrote:

> > False positives could be introduced due to allocations using the new
> > _obj functions.  Add these to the "safe" rule accordingly.
>
> Can the SmPL disjunction specification be refined another bit?

As usual, a random comment with no context that makes the reader have to
go look up some other information to have any idea what you are talking
about.

Anyway, since I did take several minutes to go find the file and look at
it, I guess you want the disjunctions to be ordered by frequency in the
code base.  But I'm not going to do that.

> …
> > name has two possible types.  Incorporate type informationt to avoid
> …
>                                                  information?

Thanks.  Fixed.

julia

>
> Regards,
> Markus
>
--8323329-1551342331-1786344523=:38388--
