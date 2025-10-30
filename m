Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA0CCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=1hSLunIdVaWodU2Ae6w+modt4yUQMQwIFDiQ1F6doSo=;
  b=vw941vc/ptI9q6iVgpyIevBZME+fnDVUxIPEIBWDOMP2Wiq1qijowlPG
   9NaW09CRQ5X5zl/77pQovD1VtfrOx3bBwcDSLYSCzZb9scE8kwXaQ6pnz
   UL6aA9cCmb7oyV3EtplH5dUGcK3VXUzSrqJ0AHK3VZBDWBH4m1wl7ZPJI
   k=;
X-CSE-ConnectionGUID: Q6/hwlazRK6kEJ9GqIUirQ==
X-CSE-MsgGUID: GkYKFIehTMenHhKflQ6drw==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246872508"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 15:14:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6E09E0BE9; Thu, 30 Oct 2025 15:14:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 34AD3E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 15:14:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1hSLunIdVaWodU2Ae6w+modt4yUQMQwIFDiQ1F6doSo=;
  b=XbtalnorQy10MHy2dT2gwTC2oTrAMtq3sUedxdroKUxOMMgDQsYSUzaK
   Kp4JbmqmnxOVQZXNn3LDbFZfgM4mq+/we9fo3kPMphJLmoP3ZpFKvu59D
   E/yHg8jSZjWqNrFHLd3xsJQlDioh1y/LZ9droHbyA1Tw10eAjRRYaH362
   8=;
X-CSE-ConnectionGUID: XwEYnejbS3GPWiGBT7GnRg==
X-CSE-MsgGUID: 8kwN92JYRf2mG1xE2KFMzA==
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246872493"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:14:49 +0100
Date: Thu, 30 Oct 2025 15:14:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
Message-ID: <2ce668b8-7042-ceab-1ac2-4afd86b6c6a@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3125
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/2ce668b8-7042-ceab-1ac2-4afd86b6c6a%40inria.fr>



On Thu, 30 Oct 2025, Markus Elfring wrote:

> > If you have a concern, you have to say what it is.  It doesn't seem it is
> > about the running time, so why do you include that information?
>
> How will the chances evolve to integrate another coccicheck script for
> the discussed source code transformation approach?

No chance, given Dan's negative feedback.

julia
