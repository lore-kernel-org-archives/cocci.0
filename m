Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19217C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lEO3v75/wkxsYM56ZVngRMl8nEXirJlt13DmqczziBY=;
  b=pAeT+QF1sFR7BttW5WB9TATGog70Nv1f4p3L1Ax7ERPeAQFUK82sHARb
   Bnf/jub4lL287gllatu/tqA+BxQ6DGwhpqB8pMeSJ3tKp31XDegqtmbYQ
   BeALTsWV/JlAiNrBvO5KZLpwT9ttdun1sHnl2MdDjq6wOvtCjT7EkgdmL
   A=;
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
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="29688759"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 17:58:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B66FE033A; Sat,  2 Apr 2022 17:58:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 94158E00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 17:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lEO3v75/wkxsYM56ZVngRMl8nEXirJlt13DmqczziBY=;
  b=d+LXZ6LTT/CXO7V+YA6+4ipKo2Tm69oVsnVauAv4At9/j4SgN1rKfxfw
   Zhdc+gXzS8HUuHS/WbfDn0c6Vs5NZMxnCrgwKcSBKD3Cs4E7uvjy4JwEv
   8B85E54qI1ljof8AGCYlMmIvxAdUBCc8V9/aaA7Hj4ordBKN/Dh/8ZyGQ
   M=;
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="10374908"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 17:58:20 +0200
Date: Sat, 2 Apr 2022 17:58:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
cc: cocci@inria.fr
In-Reply-To: <604dee67-dbd0-2994-f6a3-b06675c931b6@linux.com>
Message-ID: <alpine.DEB.2.22.394.2204021757290.3208@hadrien>
References: <604dee67-dbd0-2994-f6a3-b06675c931b6@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] coccinelle match fail
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 333
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204021757290.3208%40hadrien>



On Sat, 2 Apr 2022, Denis Efremov wrote:

> Hi,
>
> for some reason this pattern doesn't match.
>
> /// git checkout 96518518cc417bb0a8c80b9fb736202e28acdf96
> /// spatch test.cocci net/netfilter/nf_tables_core.c
>
> @err exists@
> identifier data, expr;
> @@
>
> nft_do_chain(...)
> {
> 	...
> *	struct nft_data data[NFT_REG_MAX + 1];
> 	...
> *	expr->ops->eval(..., &data, ...);
> 	...
> }
>
> These 2 lines doesn't match simultaneously. If you comment out one
> of them the pattern will match. Could you help me to understand
> what could be the problem here?

I think there is just a typo in your rule.  As far as I can see in the
code, there is no & in front of data.  If I remove that, then all is fine.

julia
