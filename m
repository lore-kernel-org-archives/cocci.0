Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14320CEBF8A
	for <cocci@archiver.kernel.org>; Fri, 27 Sep 2024 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=u1l+twYHB0LCmD32xtoo9xjT7h0f6il+gSzLBWA5kos=;
  b=DGllm+naiCpP4RyWyf/WzCTcjped5eXs6pLS4TxX0RWhv7bn8TPINJrs
   n+dQt1WWIeC6et8NZS5GM7dfM/k8i2RMaxC6biK4qSzG2SW316p48WYg7
   F7MAY3RrSQIsDpNPR5DmYYo3Rm4kpQ76ZmEQ9WoDgSx3XL+1Gx0r+PSB8
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185479855"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2024 11:34:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89DC3E0CD0; Fri, 27 Sep 2024 11:34:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5A3C8E0035
	for <cocci@sympa.inria.fr>; Fri, 27 Sep 2024 11:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u1l+twYHB0LCmD32xtoo9xjT7h0f6il+gSzLBWA5kos=;
  b=dPqoX9lpdGtoP3qHFnN0WVf9EBgSQhdStE/5ejdPlHdifBk5ObM1btzW
   IrFjGtgSJcpon0uhN/b6vvh40PwH6o9Deec9BczB0c3HKBh9+yyDyRTTL
   d5iP0Ds4ylLAsfwvCzJ7L/Kt5EiDCh5dMnyxR+brhbGESdwOtyewDGsUW
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="97575765"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:34:53 +0200
Date: Fri, 27 Sep 2024 11:34:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de>
Message-ID: <ca8a6747-ca52-5a1e-b0ba-df9bb18ac010@inria.fr>
References: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1272196805-1727429693=:3591"
Subject: Re: [cocci] Searching compound statements without
 =?UTF-8?Q?=E2=80=9Cif=E2=80=9D?= filter (by SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1890
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/ca8a6747-ca52-5a1e-b0ba-df9bb18ac010%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1272196805-1727429693=:3591
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 27 Sep 2024, Markus Elfring wrote:

> Hello,
>
> A function implementation like “free_one” was identified as another update candidate.
> https://elixir.bootlin.com/linux/v6.11/source/kernel/bpf/memalloc.c#L253
>
> Questionable source code can be pointed out by a script variant for
> the semantic patch language like the following.
>
>
> @display2@
> expression x;
> @@
>  {
>  <+...
>  if (...)
>  {
>  ...
> *   kfree(x);
> *   return;
>  }
>  ...+>
>  kfree(x);
>  }
>
>
> May I expect that such a search approach should also work without the extra
> SmPL filter “if (...)”?

I don't understand why you want to get rid of the if.

julia

>
> Regards,
> Markus
>
--8323329-1272196805-1727429693=:3591--
