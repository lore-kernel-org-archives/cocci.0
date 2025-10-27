Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29C4CCF9E5
	for <cocci@archiver.kernel.org>; Mon, 27 Oct 2025 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wv6tIww5ajzZMdPpxLeMJD3eKsbiTpco+oxlxyLyYjo=;
  b=vM0+Wz/pZvUHITSKw69bAHN4AmYRNX7rrbKZ8sfLIpoEug2fT+WLXOMs
   UcY5yJ+LyBBb1/LGi/9+PXVXrR7Fp8XgEPQyiQ2wEw9zZyufnyiISKGNW
   yQpdzQtGO7YGNPw3WLCKD/4kaeGASYGTDXtTmqKcxjYc6o0DmF6OhA+rP
   c=;
X-CSE-ConnectionGUID: 7jJ3jbryQWWRUhs18J1oWg==
X-CSE-MsgGUID: HYuqjA/XTfWrAp/V80cW5A==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="246306556"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2025 13:16:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 214EEE0172; Mon, 27 Oct 2025 13:16:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BC904E0171
	for <cocci@sympa.inria.fr>; Mon, 27 Oct 2025 13:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wv6tIww5ajzZMdPpxLeMJD3eKsbiTpco+oxlxyLyYjo=;
  b=Bfodt9qf1nrju4PXVJp1rjvi/dEmKJpa414ySeieJE+c/m03lxyVcw3s
   PpfVkNXrGKeFiBRv1KUA4eLcPpwrV1i6+RbZlEnM5TDIRc55WgYz6d6ee
   L5jKDlHgMDnC3uzwX1wzX/jtJPdaoDXjO76dn9YtRSFrDsmdBaOwnAG/G
   M=;
X-CSE-ConnectionGUID: pMInITGPSAyUG3eTQQWC9Q==
X-CSE-MsgGUID: iKk3m20MQOSjsSM0VGLP9Q==
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; 
   d="scan'208";a="129213487"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:16:50 +0100
Date: Mon, 27 Oct 2025 13:16:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d0112ed2-0cb9-4fb2-a8e6-0f94e8424d0e@web.de>
Message-ID: <577d971e-60c7-d790-ea26-fd9862745a68@inria.fr>
References: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de> <ade38bd-6997-b95-cce1-74944218af1e@inria.fr> <d0112ed2-0cb9-4fb2-a8e6-0f94e8424d0e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for selected function declarations with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3102
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/577d971e-60c7-d790-ea26-fd9862745a68%40inria.fr>



On Mon, 27 Oct 2025, Markus Elfring wrote:

> >> @display@
> >> identifier i;
> >> @@
> >>  my_type
> >> *i(...)
> >>  ;
> > It would work properly if my_type were declared as a typedef.
>
> Can such a source code search pattern become supported also with an indicated fixed information
> (without moving it to a constraint for an extra metavariable)?

I don't understand the question.

Currently, the code is being parsed as a variable declaration, not as a
function prototype, but I am not completely sure to understand why.

julia
