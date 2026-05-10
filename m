Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDA5CD3427
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9EQRVKGpjVvKU6Hkz8QqTN/fUDSHgBtUkq6rsPXIGEM=;
  b=iWtJTXp+X2PTZMdf4G+kDtk/fTjCw8Dr40man3boQdLGfHlHtGEgP/M2
   TBdsBkwKkPENClOPJyhMsHh7So8l/DmkFWDqciHI401mWPb6K2vXYj8oi
   OobFMy6rzwvMLWm16jGRXk3pyTZiEqRsuVvEBg1IjokA/mcZe/vxWDpru
   k=;
X-CSE-ConnectionGUID: yQC0K+ltTDmkSFB0xA567Q==
X-CSE-MsgGUID: pghIJ9UbQEygRJ5WsArVDQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276029928"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 15:00:47 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E15C1814AC; Sun, 10 May 2026 15:00:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C6789805CA
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 15:00:40 +0200 (CEST)
X-CSE-ConnectionGUID: 9jx2PT9zREqXmgMKkiS82Q==
X-CSE-MsgGUID: O2WbHnBeRkqKU4X/R3by4g==
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="146160366"
Received: from 88-188-165-3.subs.proxad.net (HELO hadrien) ([88.188.165.3])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 15:00:40 +0200
Date: Sun, 10 May 2026 15:00:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <80eb8b28-fe71-4d21-b154-646d425fea46@web.de>
Message-ID: <cdebe356-d9a9-36d6-aec-94673979520@inria.fr>
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de> <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr> <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de> <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr> <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr> <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de> <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr> <569a2fa4-d655-4c26-836d-a86aedf4e0b9@web.de> <6614c14-3844-9774-24c3-e891ad57e9a@inria.fr> <f3e6a976-2ab6-428c-ac42-ccd2281774aa@web.de>
 <44e0e8aa-f4f5-be2c-3956-a15d1989eec6@inria.fr> <80eb8b28-fe71-4d21-b154-646d425fea46@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3498
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/JjcEDWXRH9l8_rybU8pnLA>



On Sun, 10 May 2026, Markus Elfring wrote:

> >> Are there any agreements needed for involved technical details
> >> before a better software documentation can be attempted?
> >
> > No.
>
> Will development views evolve further accordingly?

No/.  I see no reason for the default behavior to change.  It works fine,
and Coccinelle has no more information about what the user wants.

julia

>
> How many contributors can achieve more desirable adjustments
> also for the affected documentation?
>
> Regards,
> Markus
>
