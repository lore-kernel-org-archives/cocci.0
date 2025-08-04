Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13061C87FCF
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=r+sFWZsYp3owZfeTAxKfIpJrMKc9GV8YM3WJhCJkKiY=;
  b=oPhvdH3juH1HQCbB5VLcIiqZ9cdh/uNRGSBSBsQfN/qdykDn19p5la/x
   4D7AjjRX9j3h/f6V8PXvBDsc4maepLkzOdcLU3Z5pkJ46bzCyvOyqajeE
   v+s+CK63L9CGj6AdQpC5rDQcH7oeeH7jhlMwmlqReuUkK9HN1U5rIp+wY
   k=;
X-CSE-ConnectionGUID: ZSG0wgbGS0m+dSoquB44Yg==
X-CSE-MsgGUID: 7WqKuQF8SW2/I0rrjtge/A==
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
   d="scan'208";a="234106099"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 14:10:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F033E0C55; Mon,  4 Aug 2025 14:10:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AB1C3E0171
	for <cocci@sympa.inria.fr>; Mon,  4 Aug 2025 14:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r+sFWZsYp3owZfeTAxKfIpJrMKc9GV8YM3WJhCJkKiY=;
  b=JTWZJXoXcBi8Sxht9tS03XL6m0k1Kz5NiBp6IYO6BlFe42Zfsb9CF6hF
   vSNRs6XxY9auBooSV4TempgWPbtZsO3t4SoPe0wilRRLKuXJGkXDsePtQ
   sQb81BI5Eht6EJurhuUa9r+AInLetw/cyvG+PcMheRESvjBU/cm8e4/mS
   s=;
X-CSE-ConnectionGUID: FCqmenQoSmuYigrwtWF8Lg==
X-CSE-MsgGUID: WQWXpB40QBCjo9Ax58RjoQ==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234106081"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 14:10:15 +0200
Date: Mon, 4 Aug 2025 14:10:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jakub Kicinski <kuba@kernel.org>
cc: MD Danish Anwar <danishanwar@ti.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    Mengyuan Lou <mengyuanlou@net-swift.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, Fan Gong <gongfan1@huawei.com>, 
    Lee Trager <lee@trager.us>, Lorenzo Bianconi <lorenzo@kernel.org>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
    Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
    netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <20250723064901.0b7ec997@kernel.org>
Message-ID: <1bf7c9-d394-7519-795b-c8d455ee9d0@inria.fr>
References: <20250723080322.3047826-1-danishanwar@ti.com> <20250723080322.3047826-2-danishanwar@ti.com> <20250723064901.0b7ec997@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation
 for RPMSG-ETH Driver
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2962
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/1bf7c9-d394-7519-795b-c8d455ee9d0%40inria.fr>



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

Perhaps not.  I can adjust it.

julia
