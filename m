Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097CDCEBF8F
	for <cocci@archiver.kernel.org>; Fri, 27 Sep 2024 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HeKbuudfw9PnlJxTWO92l3wIalNKEEdidMAMU8b0KkQ=;
  b=MgeSLx/TuBcDUT00nzZO2sjASIJP0S2K/7THPZ43sLlfjxi72UHElwg5
   Js5O0PUgI5/l448RfWHqgZG2uDhjq9hUWVTvKQa++wK+kQJkauGcnLzpc
   Yt6BPFQ92ay4qF1dQx3BlZATQfZMekvt0FXg1paOaio9QxrDP5+9W+k7F
   0=;
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
   d="scan'208";a="185496383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2024 12:45:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6F8A7E0141; Fri, 27 Sep 2024 12:45:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A548E0035
	for <cocci@sympa.inria.fr>; Fri, 27 Sep 2024 12:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HeKbuudfw9PnlJxTWO92l3wIalNKEEdidMAMU8b0KkQ=;
  b=HhIUXztcxWV/GJ867Sm9KqkHP5oRelOq05r8c9a9C/VWiLp1e6p3NxUp
   9xtXBYdtz+lYx4+oR3kA93mrZ3ZOLIuCsa04mEwEhw4xFt/4GPLJFF3k5
   T9+wPnthZHpzhtNI6D3B2IQ7w4+An5xCTEzmboimykjFxOeA2jn2tGdXW
   w=;
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185496381"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 12:45:06 +0200
Date: Fri, 27 Sep 2024 12:45:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <4ec353d5-9771-4db3-83ed-7571b35eadce@web.de>
Message-ID: <f2835a9f-425-211e-2d91-e6ff92903dd2@inria.fr>
References: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de> <ca8a6747-ca52-5a1e-b0ba-df9bb18ac010@inria.fr> <4ec353d5-9771-4db3-83ed-7571b35eadce@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-863971565-1727433906=:3591"
Subject: Re: [cocci] Searching compound statements without
 =?UTF-8?Q?=E2=80=9Cif=E2=80=9D?= filter (by SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1892
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/f2835a9f-425-211e-2d91-e6ff92903dd2%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-863971565-1727433906=:3591
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 27 Sep 2024, Markus Elfring wrote:

> >> May I expect that such a search approach should also work without the extra
> >> SmPL filter “if (...)”?
> >
> > I don't understand why you want to get rid of the if.
>
> There are more control flow variations possible which do not begin
> with such a key word before compound statements (source code blocks with
> curly brackets).
> Will the support grow for this general use case?

What is a real semantic patch that fais, or a real example of C code that
you are not able to match?

julia
--8323329-863971565-1727433906=:3591--
