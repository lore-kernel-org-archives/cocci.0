Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE49CD98C5
	for <cocci@archiver.kernel.org>; Sat, 13 Jun 2026 17:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GQmBmMpddrxybhISqfcPuxhItZoI+FY0N9u30Uuo1rU=;
  b=YL4MnOLAcEdbIMcmcXoEZRcNTcx//D+eStCJ+eZX1VGOZfvIKgsj9siG
   g65lavPrVE3tbMdvrrVi3zxiOdseF8SmA+3bwe8PZ7syC7/cjkaiNto2n
   Bnk/i3si2UWu1cUv91BAYbd274UefeM/rrdqaHK6/CNkV0Xd7+LZdP2pv
   g=;
X-CSE-ConnectionGUID: 3Oatv7V6RYOdcg61PzVklg==
X-CSE-MsgGUID: aAVxttmATbuqoqD2z/jjLQ==
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
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="281386737"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2026 19:06:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 44B5F8067A; Sat, 13 Jun 2026 19:06:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id ECC108067A
	for <cocci@sympa.inria.fr>; Sat, 13 Jun 2026 19:06:54 +0200 (CEST)
X-CSE-ConnectionGUID: 8rc5bT8WTRKzclCGkCW5oQ==
X-CSE-MsgGUID: S/SL0r1XSduq99+DmyxmhA==
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="281386730"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 19:06:55 +0200
Date: Sat, 13 Jun 2026 19:06:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <355d9d84-f6fe-4cb1-b764-3705ef16b6ea@web.de>
Message-ID: <a2e72ff4-53e-7ff5-ddf1-9356d9b6bae1@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <355d9d84-f6fe-4cb1-b764-3705ef16b6ea@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3563
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/WBVzg9TLhpFe62dA0RTYOw>



On Sat, 13 Jun 2026, Markus Elfring wrote:

> >> Can you benefit any more from a data representation like the following?
> >
> > No.
>
> I hope that such a view can be adjusted.
>
>
> >      I have no idea what output you expect,
>
> Can you get the impression that I occasionally prefer to work with
> tabular data output?
>
>
> >                                             so I don't know what the
> > problem is.
>
> I guess that several technical difficulties can trigger further collateral evolution.
> I am looking for corresponding solutions.
>
>
> > Could you please make something that doesn't involve a database?
>
> Which programming interfaces do support counting and grouping of data items
> in convenient and efficient ways?
>
>
> > Or just explain what you expected as the output and how that relates to
> > the source code.
>
> I would like to detect duplicate statements somehow.
> How would you prefer to point repeated source code elements out accordingly?
>
> Is there a field or column like incidence desirable?

Do you agree that my semantic patch finds what you expect to find?

If you agree on that, it would seem that the problem is in your python
code.

julia
