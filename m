Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9799BC04FFE
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oS25u8/jHv2uMu12HsGZ5KRHV4BaZb730jSAi/b2Mps=;
  b=iVHzqpyX7hV+slx9J1styxB+67B/EZWPE1G2u7uIyW6/Z9Y1wYzo3LGX
   +j3HuAf/MEfVJ9EMAhiQ8Xg9x0AS6b2fJmQh5C66zF1Soh2ua9byWECRb
   21TeU0gGWMCp4pQribQAZaxgNFUmPloJq+oGpKukTsmIoi3G0cdxxruPm
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165202695"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 19:34:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 002ADE0CCC; Sat, 11 May 2024 19:33:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 19511E004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 19:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oS25u8/jHv2uMu12HsGZ5KRHV4BaZb730jSAi/b2Mps=;
  b=TjRZTs4HgEnwZ9Lryi8hOqgB9mWtNuY4BAeG/XJzE3vaIu3nAiCyvO/u
   SUvZw+2w0awFx3xvpVat67MvRcVqP6KzctPId9Ooj+lNfpWBagadWwytW
   y3o6bG5y8ppugR63VRxLXk8dl7qrLVSfaNHSJzbUp6K1hIA78c9/9YYk6
   8=;
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="86776186"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 19:33:57 +0200
Date: Sat, 11 May 2024 19:33:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <2103e6f9-1790-4bf5-a880-86926e8ff43e@web.de>
Message-ID: <alpine.DEB.2.22.394.2405111933510.14453@hadrien>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de> <alpine.DEB.2.22.394.2405111803140.14453@hadrien> <3c953d7c-561d-4ba8-ae23-ffeb12840d02@web.de>
 <alpine.DEB.2.22.394.2405111836340.14453@hadrien> <5b96b1f7-9bc3-41d3-b2fa-a377086702d0@web.de> <alpine.DEB.2.22.394.2405111912230.14453@hadrien> <2103e6f9-1790-4bf5-a880-86926e8ff43e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1123150898-1715448837=:14453"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1720
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405111933510.14453%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1123150898-1715448837=:14453
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 11 May 2024, Markus Elfring wrote:

> >> Which SmPL constructs can indicate a minimum occurrence number (≥ 2) accordingly?
> >
> > There is no dedicated construct for that purpose.
>
> Will chances grow to extend involved software components?

No.
--8323329-1123150898-1715448837=:14453--
