Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFF2EF36E6
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 06:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VofF7CXeEZ8NkJcXDLZFe9m/mZO73mKunrM9X69cCC8=;
  b=UCTW0kV6Q2CUG096bKhUAc+UeA70w0HhDAfve06/PqbnLcMPDyVCvBjJ
   /ctsmeirdDhOrt/n8aNeGwGMxb8rTJ/4bpU5n3rNsHUMq8d5L19OhScHz
   of4kL6JVBh9Apa7cOpAh7WkTgVYxB10lxMKYw8PWgx6P/QX0bSTNixDLU
   M=;
X-CSE-ConnectionGUID: BtlKE2TEQpClQCyyp9MAOQ==
X-CSE-MsgGUID: R7gwyoQTQ9m0szDRzr6a1w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266781622"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 07:52:26 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BF85D80618; Mon,  9 Mar 2026 07:52:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B78C680540
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 07:52:24 +0100 (CET)
X-CSE-ConnectionGUID: BcfXYF8DSLS2Ry5Hxtsg/Q==
X-CSE-MsgGUID: JgZxz5rnRMKlxOsN1LbZsw==
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="140745251"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:52:25 +0100
Date: Mon, 9 Mar 2026 07:52:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sam Tygier <samtygier@mailo.com>
cc: cocci@inria.fr
In-Reply-To: <155c7bec-41ef-4985-bb06-f8315d91e42a@mailo.com>
Message-ID: <1ff9ae47-1c3a-7133-24f8-11164b40e2d6@inria.fr>
References: <fc5aa4f0-0134-475a-9220-dedc71955fe7@mailo.com> <6b795826-177a-4bef-81cd-1b783815114@inria.fr> <155c7bec-41ef-4985-bb06-f8315d91e42a@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] c++ scope resolution operator
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3348
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Ls9t9T6YHvU6kqK-UzkkMw>



On Sun, 8 Mar 2026, Sam Tygier wrote:

>
>
> On 08/03/2026 21:43, Julia Lawall wrote:
>
> On Sun, 8 Mar 2026, Sam Tygier wrote:
>
> Hi,
>
> I am having trouble using Coccinelle with C++ around scope operators, e.g.
> std::cout.
>
> Sorry, but the support for :: is still work in progress.
>
> julia
>
> Thanks, I'll keep an eye out for updates. Is there a github issue for this that I could subscribe to?

No, it's part of an ongoing attempt to support c++.
