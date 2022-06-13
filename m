Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428B0C433EF
	for <cocci@archiver.kernel.org>; Mon, 13 Jun 2022 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xbSS6/wiDH/1RkoIqjpuk8UPCrRb3ic63i+lK3L+h/Y=;
  b=VVq5iXq/qtKmlbUVyK1ghyiP6A5qdqasJHNvswIa9zRq3G0D9TH8CYTs
   hujQcgqCvKGDFpAaV7vj9YiarshWvnocuc0DAEMXjn2MJfJ4wGnAOPpPz
   lh3DDUinXoJ/iFI4Nh+ry+mKvim+s1yMhFikZQ2L34ZFfDpiVys/vBK2J
   8=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40717396"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2022 12:12:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35BE1E02A4; Mon, 13 Jun 2022 12:12:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B618E0038
	for <cocci@sympa.inria.fr>; Mon, 13 Jun 2022 12:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xbSS6/wiDH/1RkoIqjpuk8UPCrRb3ic63i+lK3L+h/Y=;
  b=ZQ457tF97m5mn6CMi7t5HVWoScnKbwtSSgkgmV4i8qd6jDKaF1OM4/iY
   XsvbYSJQZSbphS+NqBc22dkJxFafFZ1GaTTCdrWGPb1Chv8UWoz+Lij6E
   bh2lOb+K9jZxdTcO5vt/HCR+w31RcF/r7lAHbovMi5ntPymrWAwBqLIQr
   8=;
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40717374"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 12:12:32 +0200
Date: Mon, 13 Jun 2022 12:12:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Bagas Sanjaya <bagasdotme@gmail.com>
cc: Dongliang Mu <dzm91@hust.edu.cn>, Nicolas Palix <nicolas.palix@imag.fr>, 
    Jonathan Corbet <corbet@lwn.net>, Dongliang Mu <mudongliangabcd@gmail.com>, 
    cocci@inria.fr, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Yqbu8TwmaXdBiIBs@debian.me>
Message-ID: <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
References: <20220613071243.12961-1-dzm91@hust.edu.cn> <Yqbu8TwmaXdBiIBs@debian.me>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] dev-tools: fix one invalid url
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 438
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206131212160.2812%40hadrien>



On Mon, 13 Jun 2022, Bagas Sanjaya wrote:

> On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > Fix the invalid url about Semantic Patch Language
> >
>
> I think what this patch doing is to point SPL reference URL from old
> Coccinelle documentation (doc root) to actual SPL doc entry on new
> Coccinelle page, right? If so, "fix invalid URL" may not be right patch
> description and title.

Agreed, thanks for the suggestion.

julia
