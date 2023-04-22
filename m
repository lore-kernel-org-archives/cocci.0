Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0648CC6FD18
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pXu0l/MlQ1yAZXzb5f5JxVJWJLAbNznhPT1PIGhmTVc=;
  b=EKW5z8O5KC3nu8J/7v03w2xvW2IR/7kqXwSLFGTkPLVsOyYuvY4m7KQY
   GTTKsOMK9umIHU3rW3/63+wxGD+1k/5X6yMTrYu/npATmNnXUTOjHikxl
   ds3wtHVRMsOJ+W3iz9Pxzo36QBPmhLOFAG33Vxy9W7yus6u28mUbAnnVR
   E=;
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
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="104307141"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 21:41:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2AC3FE019F; Sat, 22 Apr 2023 21:41:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 85F78E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 21:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pXu0l/MlQ1yAZXzb5f5JxVJWJLAbNznhPT1PIGhmTVc=;
  b=XrR0C0Pk9GH8MXSoW4R+9sr6BADLepa8kGIvDQQ3xzgZ9Zuy9WgODNO/
   MfRWjt1ONREONqQjnuIriNRq8E5JUvdyekjhdlz8FpcufhVCnb/todkWX
   Z0WK0/qV0wAW3xfWC3vW3npT302YUc7KuEZV7LFpZtZfC6447iFI5El7b
   A=;
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="104307140"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 21:41:38 +0200
Date: Sat, 22 Apr 2023 21:41:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
In-Reply-To: <4285b7fb-00d8-8273-1bc5-bba31b94484a@web.de>
Message-ID: <alpine.DEB.2.22.394.2304222141280.2766@hadrien>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de> <alpine.DEB.2.22.394.2304221031370.2766@hadrien> <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de> <4285b7fb-00d8-8273-1bc5-bba31b94484a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-67512162-1682192498=:2766"
Subject: Re: [cocci] Checking data processing order for SmPL rule
 evaluations
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1122
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304222141280.2766%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-67512162-1682192498=:2766
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Apr 2023, Markus Elfring wrote:

> > Another corresponding source file example:
> > void f(void)
> > {
> > action(x, "X");
> > action(y, "++");
> > }
> >
> >
> > How reasonable do you find the following test result?
> >
> > Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch check_string_literal3-20230422-debug.cocci string_literal_usage4.c
> > …
> > text:   "++"
> > no match
> > text:   "X"
> > no match
>
> I find that another detail will need further clarification.
> The debug output indicates that data were processed in the opposite order
> according to the shown two function calls.
> May I expect that the original control flow order should be preserved?

No.

julia
--8323329-67512162-1682192498=:2766--
