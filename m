Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F063C27C5E
	for <cocci@archiver.kernel.org>; Mon, 10 Jun 2024 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=t9PssG1034ZFYz1tP8LQXCEkzPGTTIdxfYBH2yO7h/k=;
  b=B/3ttkAy8/CZ4gyS5kQm9bxM/08bgsGfUxLhnt0st4f0s2JbVNARm5jk
   ZSDS1KDzUZ16aRhS36UoYeNhaSb28/LeHhu/cYbq6c+Mm28bIG+pwrRlt
   CB/EOOkSJHpd9r7kUFzTqGTmvgzJtuQ026la59AuXRWBhPoK5B3DHiVyz
   A=;
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
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="169774276"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2024 09:04:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4C9FE0141; Mon, 10 Jun 2024 09:04:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1F7E9E0035
	for <cocci@sympa.inria.fr>; Mon, 10 Jun 2024 09:04:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t9PssG1034ZFYz1tP8LQXCEkzPGTTIdxfYBH2yO7h/k=;
  b=UFgxi5RxQ3JrG6kyoEy1QXrT1p+Mq0q/Q6sQQqGCmXtJBkTc/KnnZ6lM
   AqXkTHHcObKyAI98qAb9goWWeb+c+j3Vj0pW76iENE5L/VnnwK3b7sXx7
   UpYQZgn/SYoTWw0w3mCZIK+Q4F6xXycvhDk+POLqdNRxOzY+axcbsbMa6
   w=;
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="89235889"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 09:04:54 +0200
Date: Mon, 10 Jun 2024 09:04:53 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci <cocci@inria.fr>
In-Reply-To: <a01e8d2f2f5d90373fa094a8514ea2f5736db8dd.camel@sipsolutions.net>
Message-ID: <aebf2712-a3cb-1b53-c173-1a6fcc821f51@inria.fr>
References: <9c981025522250c68c8cca83a2fa3e32097bae3b.camel@sipsolutions.net>  <f0ad5ab5-d3ea-ac6-3c6e-dd1be07f4e41@inria.fr> <a01e8d2f2f5d90373fa094a8514ea2f5736db8dd.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] strange braces behaviour
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1787
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/aebf2712-a3cb-1b53-c173-1a6fcc821f51%40inria.fr>



On Mon, 10 Jun 2024, Johannes Berg wrote:

> On Mon, 2024-06-10 at 08:49 +0200, Julia Lawall wrote:
> > >
> > > void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)
> > > {
> > > }
> > > }
> >
> > This problem is fixed.
>
> Cool, thanks a lot! :-)
>
> Do you have a pointer to the code or something by any chance? We might
> be building spatch anyway (need to check, but at least have an easy
> option to with nix packages), so I might be tempted to pick that fix up
> before release for our internal automations.

commit 7eded3b97dadb1f0f4ed29d6c56856647c04b656
Author: Julia Lawall <Julia.Lawall@inria.fr>
Date:   Sun Jun 9 16:07:57 2024 +0200

    should use the non fake end node when after is attached to it; that is
part of the code


> Also, I'd like to check against the similar issue I had with removing a
> whole switch statement ("-switch(...) {...}")

Maybe it will indeed fix this as well.

>
> > Even though it's just one extra brace, it was a
> > serious problem.
>
> This was also the more simple test case - in other functions I could
> actually make it leave more closing braces, I think if you had multiple
> inside the function.

Whenever you had { { { { return; } } } }, it would leave all of those
closing braces.

julia
