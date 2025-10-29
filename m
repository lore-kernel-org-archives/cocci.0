Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0449CCCF9EB
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GW5JfX3QBMOHPTucfcg6McfzsaX2iUcJ+WJkFYkpThI=;
  b=ZZTvwc0bL6p1A12M8Y/reI8ow+nQnigCRUlhoklru97pWr5u3WZGZWKl
   DysqsedjgHSlwgfBAewmFXvXUZz6/upF2ttcsGifX606oQwY7Hcoe9uRX
   /S//opBBy4QsUPe8NSadaxgDhcYGv+UEs5m7OlD019zKC+1JOeYIjv+s5
   A=;
X-CSE-ConnectionGUID: J2a/BfbnQVW/fVWpFdxtLQ==
X-CSE-MsgGUID: F/Ek4ptYTRyJsUH0MvGaxQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246692490"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 15:04:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22C0FE0CD7; Wed, 29 Oct 2025 15:04:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D16F3E0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 15:04:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GW5JfX3QBMOHPTucfcg6McfzsaX2iUcJ+WJkFYkpThI=;
  b=V1QDIcxV1OpOgdIrAhAvJ3axda4B03iobbmS4Cxbaosfow98RWEcwPR+
   iKyyNiIW3oJqdI1Kulr1KZiinVJ8rrbeW+2YLZoDGxWTx0k5hyUKiKFB6
   +9I2hW4/AeoyXH6Aev2kVoK/lnzRHNq9Qr6dIXGvA1ezcZMtR328mkeQR
   k=;
X-CSE-ConnectionGUID: 59zTktmgQ8+Fk5Ugd4Ez+A==
X-CSE-MsgGUID: bu7tKIpsRhqROUrqIztnFQ==
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246692466"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:04:36 +0100
Date: Wed, 29 Oct 2025 15:04:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Gal Pressman <gal@nvidia.com>
cc: Johan Hovold <johan@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>, 
    Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
    Simon Horman <horms@kernel.org>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
Message-ID: <47ef2f61-85c1-92fa-12dc-e5918d90488@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org> <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3106
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/47ef2f61-85c1-92fa-12dc-e5918d90488%40inria.fr>



On Wed, 29 Oct 2025, Gal Pressman wrote:

> Hi Johan,
>
> On 29/10/2025 15:29, Johan Hovold wrote:
> > This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
> >
> > Using "%pe" to print errnos is in no way mandated and a driver authors
> > may chose not to use it, for example, for consistency reasons.
> >
> > Drop the recently added cocci script that has gotten the build bots to
> > send warning emails about perfectly valid code and which will likely
> > only result in churn and inconsistency.
> >
> > Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>
> The test by no means mandates authors to use %pe, as the output says:
> WARNING: Consider using %pe to print PTR_ERR()
>
> "Consider" :).
>
> I would consider it best practice to use it, and a few drivers were
> converted thanks to this test.
>
> If the issue is with automatic build bots, then maybe this test should
> be excluded from them, rather than deleted?

This is easy to do.  Or I can discard them when they come to me for
approval.

julia
