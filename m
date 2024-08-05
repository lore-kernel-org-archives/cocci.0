Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA20C3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Z333r0o/yiRURpEK27lK/O+MizxQKsXd3xNJZOeRRg8=;
  b=RZ9WAeknGg1FOR8yi624uI3DFwfqeofEx1V6WyGSDhQkK5X9LwJuxpOj
   XLMgPvZe3RHzEJuZGap3YuIflPIHthpmLyU/+zcHbVXk2w85J8FGFBwuc
   8U8Bh95vSYcJrXtbeUZGNwPA8F44eKlX6oFCGS87va2hBk0+oN8jBy/dU
   U=;
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
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="178170307"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 18:08:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2BE7E0141; Mon,  5 Aug 2024 18:08:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C80DFE0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 18:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z333r0o/yiRURpEK27lK/O+MizxQKsXd3xNJZOeRRg8=;
  b=JiEeohdOQ9QeVGjNhDgKw2bj+OkErDEbKDkQ+Un+YpAfyT4LeYQPssr+
   6hrb4GYXCuWmz1Tg2+40sllr0gbTDQFxMUoa8Naq09GWyKxDZHvRTuxOZ
   vO+77Gb7133b7wcZdCO7KSbh5LMmv81/nk1M1hBGfbwTRYYBgZZYHLduG
   A=;
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="178170299"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:08:05 +0200
Date: Mon, 5 Aug 2024 18:08:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Ricardo Ribalda <ribalda@chromium.org>
In-Reply-To: <583a6ed8-16db-4a5d-8a07-3f8b7c2c752b@web.de>
Message-ID: <a3eef460-b292-bbac-417e-a8bee451c38b@inria.fr>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com> <98a94966-14c6-45c4-99d8-471f65b292ea@web.de> <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com> <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com> <c05b066f-af9b-49c1-9bdb-9167d24e3d3b@web.de> <c48956e7-f98f-407b-a4c1-29aa417c7474@web.de> <acb79b2d-a040-bdc4-9d5a-faafc3fc7d66@inria.fr> <583a6ed8-16db-4a5d-8a07-3f8b7c2c752b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Questionable run time characteristics for SmPL scripts?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1842
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/a3eef460-b292-bbac-417e-a8bee451c38b%40inria.fr>



On Mon, 5 Aug 2024, Markus Elfring wrote:

> > I don't need any more information.
>
> Are you looking for further helpful data based on advanced software profiling?

No.

>
> Would you like to determine which SmPL scripts contribute the most
> according to observed run times?

It was already clear from the provided information.

I know what the problem is.

julia
