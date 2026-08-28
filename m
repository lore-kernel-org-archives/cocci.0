Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72812C61DBD
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2026 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VTHvxHk58Hy9yWVXIJFZsnvlgi5O/jd00ePVFdBnr0M=;
  b=ucFzNwmWciTLnWREY2POm6bqRlBDvImVtzq9VA5+0JG/QKwzg5NdE6ys
   jpaXzJOFngsmrt6uEiEN0rwqJ00VlK54FSuRPnJXykYpWfmaK1eHiDeLo
   BErvMp/18FJYgb2epxMuvc/X2h0PDckW2R3CzpnxghvM/nbhOWF6IJrmf
   8=;
X-CSE-ConnectionGUID: X7VZ8WtySdCY0BYjI5FB5A==
X-CSE-MsgGUID: IGS4rd1hQs+lZmSl+kM7Ag==
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
   d="scan'208";a="292056094"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Aug 2026 18:09:38 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3049781AFB; Fri, 28 Aug 2026 18:09:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2689D802FC
	for <cocci@sympa.inria.fr>; Fri, 28 Aug 2026 18:09:37 +0200 (CEST)
X-CSE-ConnectionGUID: FDz94qMtSJ6RQ0L/wZIqaA==
X-CSE-MsgGUID: AXz4ZtmBQbOUCGb7Eb4Mnw==
X-IronPort-AV: E=Sophos;i="6.25,248,1779141600"; 
   d="scan'208";a="292056086"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 18:09:37 +0200
Date: Fri, 28 Aug 2026 18:09:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, 
    kernel-janitors@vger.kernel.org
In-Reply-To: <3e20eaeb-797e-47e9-8dee-a6c97f360a46@web.de>
Message-ID: <1adbaba0-d3be-a8f7-54ef-933a4fe02250@inria.fr>
References: <9e729258-a720-4b8f-b0f0-e84f3a984aef@web.de> <a0b9259-987b-1c92-2e86-3409ecf87e@inria.fr> <b2fd77fe-fc97-412e-a5d1-69b88e27f61b@web.de> <47b6b35-2cfc-b5e-f96-8ec6548cd9@inria.fr> <3e20eaeb-797e-47e9-8dee-a6c97f360a46@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1769865536-1787933377=:104528"
Subject: Re: [cocci] Improving support for replacing expression parts by
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3722
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/T2alrrHPVJ1iwhC89FYsqQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1769865536-1787933377=:104528
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 28 Aug 2026, Markus Elfring wrote:

> >> I got the impression that some expression parts would be replaceable.
> > If you expected it to be replaced, you have to specify with what.
>
> I would like to achieve something also for another more detailed SmPL script.
>
> See also:
> https://elixir.bootlin.com/linux/v7.2/source/include/net/pkt_sched.h#L128-L134
>
>
> SmPL code sketch:
> @replacements@
> expression …, dev, …;
> @@
> (
> -container_of ( link , struct tcx_link , link )
> +tcx_link(link)
> |
> - READ_ONCE ( dev -> mtu ) + dev -> hard_header_len
> +psched_mtu(dev)
> |
> …
> |
> -refcount_inc_not_zero ( & r -> refcount )
> +p9_req_try_get(r)
> )
>
>
> Markus_Elfring@Sonne:~> spatch --parse-cocci /home/altes_Heim2/elfring/Projekte/Bau/Linux/scripts/Coccinelle/list_inline_non-void_functions5-net-20251114-adjusted.cocci
> …
> minus: parse error:
>   File "/home/altes_Heim2/elfring/Projekte/Bau/Linux/scripts/Coccinelle/list_inline_non-void_functions5-net-20251114-adjusted.cocci", line 8, column 21, charpos = 2685
>   around = 'mtu',
>   whole content = - READ_ONCE ( dev -> mtu ) + dev -> hard_header_len

Well, it seems that you have not provided a complete semantic patch, since
there are ...s in the list of metavariables, so I can't answer the
question.

julia

>
>
> Regards,
> Markus
>
--8323329-1769865536-1787933377=:104528--
