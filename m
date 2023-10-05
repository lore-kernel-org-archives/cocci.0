Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770A7E8FDC6
	for <cocci@archiver.kernel.org>; Thu,  5 Oct 2023 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VMJe6COrLXg2Sh9s/BjyeC5V2AIw/8UnrpjDE9VxpiY=;
  b=jHEnLun7UEJZ8SL7BiyFBwh1+Lyw3I4IHQrHk29YHYdFy7yeJ29drugZ
   1tHy+t871CiU421a9ES3LokCI/h5QvF2jFmMeWxBMJi51RwhVt82ILwjm
   9vBCCjgj2Jg+Tf370EHA6IiH56c8JHtfPRVCTfpdZpthaI5FxabiMvzVq
   o=;
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
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129628219"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2023 12:02:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF3D1E0CD6; Thu,  5 Oct 2023 12:02:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1710AE00B7
	for <cocci@sympa.inria.fr>; Thu,  5 Oct 2023 12:02:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VMJe6COrLXg2Sh9s/BjyeC5V2AIw/8UnrpjDE9VxpiY=;
  b=tCO/M0ZwffmyHBuc3+KfGcBfCP0FB1nOg3IA5nvXIdiLLkgWwNEtt2bD
   0HH9X3fsXTQyo0ZAjeGKdmIXAJMjlMOB8o7qz/vHVKGTz3QKy4PnRPOzr
   NKH1DOX2BwtxR9WJvSVx9C75i1YjjXQAUmMp2UZ3oPAdwYErTq6DFwNip
   Y=;
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129628198"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:02:41 +0200
Date: Thu, 5 Oct 2023 12:02:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d71be555-d569-4ccd-9f06-4b33d8095e6f@web.de>
Message-ID: <alpine.DEB.2.22.394.2310051159410.3375@hadrien>
References: <d71be555-d569-4ccd-9f06-4b33d8095e6f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for variable definitions in C++ source files
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1245
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/alpine.DEB.2.22.394.2310051159410.3375%40hadrien>



On Thu, 5 Oct 2023, Markus Elfring wrote:

> Hello,
>
> Will the Coccinelle software become able to find variable definitions
> also within C++ source code by the following script variant for
> the semantic patch language?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/22
>
> SmPL script:
> @display@
> identifier x;
> @@
> *RPC x(...);

Some dy we will be able to parse more of C++.  This will not happen
immediately.

julia

>
>
> C++ source file excerpt:
> // deleted part
> // See also:
> // https://github.com/BOINC/boinc/blob/44295c1a50d84e44992d97b9e949700d3b9af2d1/lib/gui_rpc_client.cpp#L262
> int RPC_CLIENT::authorize(const char* passwd) {
>     bool found=false, authorized;
>     int retval, n;
>     char nonce[256], nonce_hash[256], buf[1024];
>     RPC rpc(this);
>     XML_PARSER xp(&rpc.fin);
> // deleted part
>     return ERR_AUTHENTICATOR;
> }
> // deleted part
>
>
> Regards,
> Markus
>
