Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90088C001DB
	for <cocci@archiver.kernel.org>; Sat,  2 Sep 2023 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sU+Uo9J9Ur6a4PpR5uRtMrOrXC3P9ExpfqvhZ4qjSxU=;
  b=vebfIxEIhq3RQBOTN9iLodbzimmWaWKw12g4xxxzAWCGh3Q89LlilOro
   OlOrng4ilMSi9PRNRmAn0M2xmkDDTx9ekBm05eXPstRcNyLFsJEonQZIN
   2p61wML4MuE9JnF3uxLbr6eBqelu44CCVKoEMUZ1Lo2ZzjtjNWGEj39Zy
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="124031369"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Sep 2023 20:09:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81E2CE0AF1; Sat,  2 Sep 2023 20:09:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D28FFE004E
	for <cocci@sympa.inria.fr>; Sat,  2 Sep 2023 20:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sU+Uo9J9Ur6a4PpR5uRtMrOrXC3P9ExpfqvhZ4qjSxU=;
  b=OVyAO9TH1bvupyS9ZlGXUwYnQkGIeBZ/M8ykv7tN66STrKWrWLe4/CQE
   zRvmSNBmjeESgZSKjbZQXCTDG/YBJ6F5Y4alEn4DsWvmoKSf/LlvgMd7b
   RxLQeQM/pTT9Bu5nbLcfVYDD3zC0P69DYIJq/xS7ehHBrvfcIZZJ2feeV
   Q=;
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="64932984"
Received: from 228.66.136.77.rev.sfr.net (HELO hadrien) ([77.136.66.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 20:09:00 +0200
Date: Sat, 2 Sep 2023 20:08:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Thomas Adam <thomas@fvwm.org>
In-Reply-To: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
Message-ID: <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-774821119-1693678139=:3175"
Subject: Re: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1230
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/alpine.DEB.2.22.394.2309022008310.3175%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-774821119-1693678139=:3175
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Sep 2023, Markus Elfring wrote:

> Hello,
>
> The analysis tool “Cppcheck 2.10.3-3.2” pointed a source code place out
> for further development considerations.
>
> https://github.com/fvwmorg/fvwm3/blob/c9d00184ac3ab534e0f0ba5683106879a35857f6/fvwm/colorset.c#L965
>
> (style) Condition 'tint==NULL' is always true [knownConditionTrueFalse]
>
> See also a change suggestion:
> Simplify data processing for tint colour in parse_colorset()
> https://github.com/fvwmorg/fvwm3/issues/897
>
>
> I constructed another SmPL script variant for a desirable transformation.
>
>
> @replacement@
> statement s1, s2, s3;
> @@
> -if (tint != NULL)
> -{
> - s1
> - s2
> - cs->tint = GetColor(tint);
> - s3
> -}
> -else if (tint == NULL)
> -{
> - s1
> - s2
> - cs->tint = GetColor(black);
> - s3
> -}
> +s1
> +s2
> +cs->tint = GetColor(tint ? tint : black);
> +s3
>
>
> Now I wonder why a corresponding patch is not generated by the software
> “Coccinelle 1.1.1-00478-g0afff7fa” (OCaml 5.0) at the moment.
> I would appreciate further advices.

Probably because in each branch, the first line is a declaration, not a
statement.

julia
--8323329-774821119-1693678139=:3175--
