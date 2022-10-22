Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4583FA373D
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7WvwzbtgB+dHc4melF4O329Vx4mtaqbn91A9J2onu1M=;
  b=AaAwq8DajYDnrx3GdyucSDjMhJ+FPIYFoGeE64zbIDsOOsPPhyp3wkit
   zu+PRg7kyLRxMf7AiocQ39/R/yMx1AcxAE0jG3STkewQpyK3XKH1P/G8L
   lC+dXY4f4KKgyszdeJCRX1Gxhwa2qOzSJA4qWQ1Nlvpck7ilLcT1XwDOl
   c=;
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
   d="scan'208";a="67870464"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 14:46:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA504E01D1; Sat, 22 Oct 2022 14:46:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7E75DE004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 14:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7WvwzbtgB+dHc4melF4O329Vx4mtaqbn91A9J2onu1M=;
  b=Uphn7OHbacVHb6H4VrSJhnV69rxSIu1m9+1HxcVIMDl61gc8Feeeb8qC
   3oX72AS9WQ8/SRaGg6j7NJcvmT5GpWd3dXKsIfwLY9zb2FktUoNHLq27c
   X79C/8RVWsUVsdZN5SCDai3TLsSdrDHN3UttfzkfU5DynHQYJ5aNAra0U
   4=;
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67870463"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 14:46:18 +0200
Date: Sat, 22 Oct 2022 14:46:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <7691aca779054e7e2145d01bd95ff02a00a9da0a.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210221445570.2783@hadrien>
References: <7691aca779054e7e2145d01bd95ff02a00a9da0a.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 2/2] Distinguish script-based fresh ids with
 differing args
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 669
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210221445570.2783%40hadrien>



On Sat, 22 Oct 2022, Jan Tojnar wrote:

> Hi Julia,
>
> Could you please review the above patch, when you have time? It fixes
> the regression in `fresh identifiers` in conjunction with scripts from
> master.

Yes, I will take care of it.  Thanks for the contribution, and sorry for
the delay.

julia
