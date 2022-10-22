Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20422C3A59D
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 10:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Uf8U4RxCDxTbVBruDsHetOOgT6fNBDxFG9diLXIlA4g=;
  b=j4qIUx9h7EapRnyjc23wOhuz3mNQFpdARIKaFpoRpV1AN34ogmtaDVo/
   Q0CKTn3JIXpKVCpCxuLhE1fz4wS/k/DekfKUjz72YeemjHcOB0+BoxjnK
   XDEVBFP4j4cUGkkGgLJobj2epNRwR2jY/EXrVTmbSA8tFcCFS4ZFJQQ3j
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67864428"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 12:26:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1B79EE013D; Sat, 22 Oct 2022 12:26:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98D26E004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 12:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uf8U4RxCDxTbVBruDsHetOOgT6fNBDxFG9diLXIlA4g=;
  b=sEV+PRWzctfaAkU3gGGYdJd9WA8KMMDqfHs5SMjKetKabO4SezmR/8yB
   +35fEtJ1iFEtAKA3WapXY7cMsrS253CY7t6ldyvLZoj3xDM0mTL5GPTlP
   m0veUdC8XSqjHFLobrMQ7nPTuaWeUIzC1eHchYlP1o/n4tZRpO05JM0aC
   E=;
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67864427"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 12:26:21 +0200
Date: Sat, 22 Oct 2022 12:26:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr, Thierry.Martinez@inria.fr
In-Reply-To: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210221223320.2783@hadrien>
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] No longer possible to build with system dependencies?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 665
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210221223320.2783%40hadrien>



On Sat, 22 Oct 2022, Jan Tojnar wrote:

> Hi,
>
> I tried building Coccinelle from the latest commit from master but it
> appears it is no longer possible to do so without relying on bundles.
>
> I like to use libraries from my Linux distribution since then I do not
> have to build them over and over again every time I nuke the repo.
> Additionally, since distros tend to use sandboxed environment for
> building packages, building dependencies independently reduces
> excessively long rebuild time when failure occurs higher in the
> dependency tree.
>
> Looking at the commit history, the last change to `configure.ac` file
> from the following commit is responsible:
>
> https://github.com/coccinelle/coccinelle/commit/1d0733a27006b06eef712f541000a8bf10246804
>
> in addition to:
>
> https://github.com/coccinelle/coccinelle/commit/3f54340c8ac907e528dbe1475a4a7141e77b9cdd
>
> If this was done to prevent people from using old versions of the
> libraries, would it be possible to add a minimum version check instead?
> Or at least add an option to force the use of system libraries,
> so that distros do not have to patch the limitation out to comply with
> their policies on packaging vendored dependencies?

Thanks for the feedback.  There was definitely no intention to restrict
builds in anyway.

julia
