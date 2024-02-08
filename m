Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2832C4828F
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mb2bXe/aJPIvr/zfTu7Bsu1qnbWp+XdUpoKY2ZjIVF8=;
  b=DltKs7kP6t8YDxwsT5AtzDKtrOfqyFVNB8mpzhGMivt2w2ts4ZhG+QMt
   BYDS0MQDNE2UNl8XbcCXUMl2xYVB/lQTNT2+pKL/ByeYfYDPc1icf53Yb
   n87fg/HBiqaM3eItvrOlFFbbIJgVEuffwNHVEuk6y0/m4xs5CNbO5PZv+
   w=;
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
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="151038541"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 19:09:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BE7D3E0CD5; Thu,  8 Feb 2024 19:09:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F1775E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 19:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mb2bXe/aJPIvr/zfTu7Bsu1qnbWp+XdUpoKY2ZjIVF8=;
  b=C3G6JxfFAW5Lq50DZ+aw++DPL7m40STsLSET+/ErWpXN48krhieAwF3f
   yDcfoVTLXquSDICUl9/2/JV2IIvwuU3okEVLaQjtjNr0aoe0rM/Qai/Og
   GUmhFQH2+SH56yjS6GBMjIyPxhltHTEJq08vLVzZv7Jz7KjIUPN39Oskq
   E=;
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="151038531"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:09:23 +0100
Date: Thu, 8 Feb 2024 19:09:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
Message-ID: <eb10beb1-c8b-47e5-ab28-5c1bba502d2a@inria.fr>
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de> <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de> <alpine.DEB.2.22.394.2402072108500.3138@hadrien> <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de> <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1525
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/eb10beb1-c8b-47e5-ab28-5c1bba502d2a%40inria.fr>



On Thu, 8 Feb 2024, Markus Elfring wrote:

> > Will the understanding improve also together with a script variant
> > (like the following) for the semantic patch language?
> @selection disable decl_init@
> expression action;
> identifier var;
> position call_pos, declaration_pos;
> type t;
> @@
> (t * var@declaration_pos;
>  ... when != var
>      when any
>  action@call_pos(..., &var, ...)
>  ... when exists
>  var
> |
> *t * var@declaration_pos;
>  ... when != var
>      when any
> *action@call_pos(..., &var, ...)
> )
>
>
> Are there any opportunities left over to increase the avoidance of duplicate
> data processing also together with the application of SmPL disjunctions?

I think you would want the disjunction to start with the call to action.

julia
