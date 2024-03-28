Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFD4C54E67
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 09:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pWIHnmOhIyVhSx8qQI0Xn0NQbKNEAZVsRyRh1RqDLCM=;
  b=KSoIU3BXasZBWFYK7iQyv91wmaJnQctnuylfJBZKk6PNtuT17njWDkMq
   j64INxCuqjoynAhozBK0sXJlsknF21n0FapTJW7AGJ8qEpD0vHVfZF5fw
   /hES3JAYWFzAgq5YKWRO4HOmOdP/usdFIx5dL9UpqVaXkgq5+a9J7OsOo
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
X-IronPort-AV: E=Sophos;i="6.07,161,1708383600"; 
   d="scan'208";a="158869878"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 10:08:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3F1E7E0BE9; Thu, 28 Mar 2024 10:08:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AA9F0E0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 10:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pWIHnmOhIyVhSx8qQI0Xn0NQbKNEAZVsRyRh1RqDLCM=;
  b=hDLe1gFPGqEs2AHvFMSwFzrUB35zXCZjllZEuKR8wnccaT7j5iRV1EAN
   YCaBV558UKeg6T0f7pA/1azOeU6pgdO56b8lJOvE28+cWvP2K09Qbd9qZ
   whF9KCpELTRH698ZmY8bD5hlIiGFhjID3XvQaFudQkPY1042ZKBvE/kf2
   4=;
X-IronPort-AV: E=Sophos;i="6.07,161,1708383600"; 
   d="scan'208";a="158869839"
Received: from apn-pool1-239-pennnet009.nat.upenn.edu (HELO hnt-238.eduroam.wlan.private.upenn.edu) ([165.123.239.11])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:08:01 +0100
Date: Thu, 28 Mar 2024 05:07:59 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Peter Senna Tschudin <peter.senna@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CA+MoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow@mail.gmail.com>
Message-ID: <ffb475dd-496c-2ae-6329-86d6163b2bb6@inria.fr>
References: <CA+MoWDqtRxQQ08k53_bP6L96FReUx8AxV2BU7dHWC-hfEr_kow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Returning statically allocated nested structs
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1624
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/ffb475dd-496c-2ae-6329-86d6163b2bb6%40inria.fr>



On Thu, 28 Mar 2024, Peter Senna Tschudin wrote:

> Dear list,
>
> I am trying to come up with a semantic patch to detect uses of nested
> structs, more specifically:
>  - the nested struct is statically allocated
>  - the statically allocated nested struct is returned by a function.
>
> Here is an example:
>
> struct inner {
>
>     /* some inner struct stuff*/
>
> } inner;
>
> struct outer  {
>
>     /* some outer struct stuff*/
>
>     struct inner i; // The kind of nesting I care about
>     struct inner is[SOME_MAGIC_NUMBER]; // The kind of nesting I care about too
>
>     struct inner *ip; // Nah, this is boring. I don't care about boring
> } outer;
>
> void sillyfu() {
>     struct outer ou = { }; // initialization does not matter.
>     struct outer *oup = NULL; // Nah, this is boring. I don't care about boring
>
>     /* some serious silly stuff */
>
>     return ou;

Not sure to understand.  The return type of the function is void.  Was
that a typo?

Returning a structure in general seems like something to be concerned
about.  Does it matter that another structure is nested inside?

julia

> }
>
> I remember that there are some details for detecting structs
> effectively, and as I am investigating a code base with over 1.2M
> lines of code, I would like to ask for pointers of where to start.
>
> Thank you!
>
> Peter
>
> --
>                          Peter
>
