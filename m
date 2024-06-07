Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A83C27C53
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2024 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=1XtAVpu9xsa7LVD+ZsUycFjXRJCZQ525/U/2NN6TixM=;
  b=pcL0D4ZR9+b8lpSR+lZCWOzcO4LmV431zljveAB7rlcyjlyLD+F57HjK
   gEr12b/pp0dcb5OcwrnyN5D+7mrLca5rAz6v6FhP8jxKXKv7RW9K6skC8
   yy/+9ChOdhKtj8hyA5grLriPlD3tndm8NSPAaIUBXFD6kl3rT3HIylG5F
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="169507996"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2024 11:31:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABAE1E0141; Fri,  7 Jun 2024 11:31:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 68DBBE0035
	for <cocci@sympa.inria.fr>; Fri,  7 Jun 2024 11:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1XtAVpu9xsa7LVD+ZsUycFjXRJCZQ525/U/2NN6TixM=;
  b=E2RyW84ntlgvB2ZuzUy1zcpnDBuJOv5JpuWdT0JQdFDko4FKjUOLvSIe
   emqz4rCz8VIWinRUd9WVhwIjgTIKJZJSVJRWmiCBYNHkWBjp8eCH2BLnb
   g5vBzssUZPK6Yz946Dw4MoYpYvejVZtJ8gT4l9ycj05CMd73bX96BSnGT
   c=;
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="89091338"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 11:31:00 +0200
Date: Fri, 7 Jun 2024 11:30:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org
In-Reply-To: <9d79a2de-10fa-479c-b720-1c4a2f51782d@web.de>
Message-ID: <4bad748-afee-713a-a2d7-30b6e5c1cb28@inria.fr>
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de> <alpine.DEB.2.22.394.2405261847380.16852@hadrien> <9d79a2de-10fa-479c-b720-1c4a2f51782d@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1745173528-1717752659=:3380"
Subject: Re: [cocci] Increasing usage of spinlock guards (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1779
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/4bad748-afee-713a-a2d7-30b6e5c1cb28%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1745173528-1717752659=:3380
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 7 Jun 2024, Markus Elfring wrote:

> > I'm not the one to decide whether we should use cleanup for mutex locks.
>
> Would you become interested to support the conversion of another tiny script
> (like the following) for the semantic patch language into a corresponding
> SmPL script variant which can be used together with the tool “coccicheck”
> any more?
>
> @replacement@
> expression e;
> @@
> -raw_spin_lock
> +guard(raw_spinlock_irq)
>               (&e);
>  ... when != e
>      when any
> -raw_spin_unlock(&e);

What exactly is the problem?  I tried this rule and it worked fine.  There
were a few issues of inconsistent control-flow paths, but it made 325
changes.

julia
--8323329-1745173528-1717752659=:3380--
