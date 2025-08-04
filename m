Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A14CC87FCF
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nSuJmibvgEvGtTLLBRats2Iep+nTvSIJgAzPMsgEIrM=;
  b=aIapjH7nH9N86/25XIfGU00gzSRQbereHwFccbzl+AEIuhUAHwTIiB+M
   elgQ1RH4GTskTyGgQEb6J0YwPnh9B/XFY23GmJcwlTbcbXv/WCFbI0Pz6
   DJ/7Je/5FXzRBa+kmPWP60oIriZlWTEzDVHNkAW6rtlmggkit+O83kFPa
   k=;
X-CSE-ConnectionGUID: Q4HthCS4SY6BR09sUSlacw==
X-CSE-MsgGUID: XRiVlRBlQ7mwsiEwlZALww==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234141878"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 18:45:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8330E0171; Mon,  4 Aug 2025 18:45:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D20CBE0171
	for <cocci@sympa.inria.fr>; Mon,  4 Aug 2025 18:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nSuJmibvgEvGtTLLBRats2Iep+nTvSIJgAzPMsgEIrM=;
  b=D1hAOxhYx9K6D5fP0PS+wY7tUHdwz69YiHTY3Q/pZ4IIGWbVobtekUpm
   g+4JaA41/DeFvBtlWZqi6sMPxTS2d8CBXobly3f/eLuKr3CPEYAqg7+gf
   /A6H9x9T+1/oRA2RT59JEdh3h4o+W8wp8nhFbQWT/YrR2mC9xga4MoZle
   8=;
X-CSE-ConnectionGUID: L7Nnpm22QYiekcNtRQWPnQ==
X-CSE-MsgGUID: EN5rdfA/R/aaYgU3rwBRqg==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234141869"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:45:50 +0200
Date: Mon, 4 Aug 2025 18:45:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jakub Kicinski <kuba@kernel.org>
cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <20250723064901.0b7ec997@kernel.org>
Message-ID: <74e230ef-1e9c-94fb-6dbe-5f4d24add50@inria.fr>
References: <20250723080322.3047826-1-danishanwar@ti.com> <20250723080322.3047826-2-danishanwar@ti.com> <20250723064901.0b7ec997@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation
 for RPMSG-ETH Driver
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2964
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/74e230ef-1e9c-94fb-6dbe-5f4d24add50%40inria.fr>



On Wed, 23 Jul 2025, Jakub Kicinski wrote:

> On Wed, 23 Jul 2025 13:33:18 +0530 MD Danish Anwar wrote:
> > +   - Vendors must ensure the magic number matches the value expected by the
> > +     Linux driver (see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
> > +     source).
>
> For some reason this trips up make coccicheck:
>
> EXN: Failure("unexpected paren order") in /home/cocci/testing/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
>
> If I replace the brackets with a comma it works:
>
>    - Vendors must ensure the magic number matches the value expected by the
>      Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
>      source.
>
> Could you make that change in the next revision to avoid the problem?
>
> Julia, is there an easy way to make coccinelle ignore files which
> don't end with .c or .h when using --use-patch-diff ?

This will be the default shortly.

julia
