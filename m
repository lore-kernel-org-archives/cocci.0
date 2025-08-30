Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AA3CA0FFD
	for <cocci@archiver.kernel.org>; Sat, 30 Aug 2025 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0Qr4vw7bAiVOedEkdQDH47aKkI/uIFeIKhA5Ubhp4M0=;
  b=FMgQjl0nCxrOrADZBDv7yRMcykoqXYnQ89tW5iQZe7mbBCrzB5S5UAmp
   YNwIwzd6zsJLSKoRO7oryppf5E3RItbiwerrLloMeCLSTm3lM/cPSa9RX
   hoCr96vD4OY8/qZNL4VrSRRljR+HQGi/vksFVwQyDBfYJvnzpNIGqmFVb
   U=;
X-CSE-ConnectionGUID: 5lGkf9KOT8i33bX0VjZtaw==
X-CSE-MsgGUID: a+CqBIATQO2V1+Dz4X98Og==
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
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="236734282"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Aug 2025 14:01:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3F8B6E0BE9; Sat, 30 Aug 2025 14:01:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E4C46E0172
	for <cocci@sympa.inria.fr>; Sat, 30 Aug 2025 14:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0Qr4vw7bAiVOedEkdQDH47aKkI/uIFeIKhA5Ubhp4M0=;
  b=QffaCyxJuNG/yS8eucRL7N9W/dKd3ylsvxiDVTIA6VMxnj3ClH08W/vr
   zqfKgZt5NqnG15c2ril+ykgbLUs7UItGNMoIBh2DknIMzF1PMTwrNDFmu
   gGdHjxnkCxPkwvbvB6Id0np9J1JlutGrjz+Hx98rYjR4WAzZrGNsSbNJE
   Y=;
X-CSE-ConnectionGUID: KoRHqkFLSOK3GzH0xT753A==
X-CSE-MsgGUID: SGw5Kg/QQECfmWZobDeDHA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="236734280"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 14:01:37 +0200
Date: Sat, 30 Aug 2025 14:01:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, =?ISO-8859-15?Q?=A6erif_Rami?= <ramiserifpersia@gmail.com>
In-Reply-To: <fa82455f-6294-4200-ad6e-c31add12b303@web.de>
Message-ID: <alpine.DEB.2.22.394.2508301400410.26590@hadrien>
References: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de> <ba58f313-5edb-4ff1-91fc-1682321e4d61@web.de> <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de> <fa82455f-6294-4200-ad6e-c31add12b303@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2986
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508301400410.26590%40hadrien>



On Sat, 30 Aug 2025, Markus Elfring wrote:

> > I guess that another SmPL script example will influence corresponding development ideas.
>
> // See also:
> // [PATCH v6 1/7] ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
> // https://lore.kernel.org/linux-sound/20250814172222.9448-2-ramiserifpersia@gmail.com/
> //
> // tascam_probe()
> //
> // https://wiki.sei.cmu.edu/confluence/display/c/DCL19-C.+Minimize+the+scope+of+variables+and+functions
> @adjustment@
> attribute name __free;
> identifier i;
> type t;
> @@
> -t *handshake_buf __free(i) = NULL;
>  ... when != handshake_buf
>      when exists
> +t *
>  handshake_buf
> +__free(i)
>  = kmalloc(...);

This is not correct.  There may exist some path where there is no
reference to handshake_buf, but that doesn't mean that that is the
property of all paths.

julia
