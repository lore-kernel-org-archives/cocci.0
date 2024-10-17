Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0727FD3C526
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+w9uY6lzhzydW1t03z4vyXS9hzWBKJiYt/eXSmkqu5o=;
  b=vk88YS+UIQ+EdIc9gwwsX6bnoP3N3fW7z3rRAVA1rfnk4qOyqXF7wbeZ
   cvRW47CURwuw4HMCfbUMPkjTpr3yw2l7vGWBzZGg5SkD7WjGu5npe0S16
   R0qU+3l5h7CAp6Xk6MsmdYKJRfC51D3llsl50nlk/ld5Rzokt7UCdA5kG
   k=;
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
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189465066"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 20:23:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8213EE0145; Thu, 17 Oct 2024 20:23:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7C1F5E004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 20:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+w9uY6lzhzydW1t03z4vyXS9hzWBKJiYt/eXSmkqu5o=;
  b=HwxGD3oHaKIGaEQCQs48BDo5sF4+wAgkHDb7dYq0LkPXbCYqM4xsSbaT
   McEpntvvcFtJ84ijJFULR7XZoUauuWSpAvZFb7uZIocHnOgbcBnc761/Z
   WdR+ZmVnsPUo7b57064WbkMiAwRgAoGN+ITtnAUd1+KfA0Aa8MCAjh8AI
   A=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="99403983"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:23:10 +0200
Date: Thu, 17 Oct 2024 20:23:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <a89dfb58-621a-4c0b-a0a1-ba01d5df51ce@web.de>
Message-ID: <alpine.DEB.2.22.394.2410172022320.3480@hadrien>
References: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de> <ced9a857-0da6-4cfc-ad35-9095ea20771d@web.de> <d69dc642-7a57-449b-170-a67c3a9fc1c@inria.fr> <a89dfb58-621a-4c0b-a0a1-ba01d5df51ce@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Challenges with selection of an SmPL Python version?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1916
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410172022320.3480%40hadrien>



On Thu, 17 Oct 2024, Markus Elfring wrote:

> > I can't test this because you use libraries that I don't have.
>
> Would you dare to install any of the mentioned software libraries (on demand)?

I tried, but it was not obvious to me how to do that, so I gave up.  If
you want me to look at it, mke the code simpler in some way.  I don't use
python.

julia
