Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0EBC433F5
	for <cocci@archiver.kernel.org>; Wed, 16 Mar 2022 20:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FfrdgEcjpaOS8p0AdE/MxXxdbeP+/6pQXhdmKkS3OkI=;
  b=gYi0QVI+e8rYxUjJx/hUzbz27Xg+iK8V1Ndy0l5HyCgirba6mB/mxcni
   ng62sLK/K60ir78nEDU8eIngtzMOT5BP12IdHLm8cVYpkX9Lg8bwW51CB
   7ODsLCuifsGeVzvGtWoMBdXwLR1JeO9qTCTzLY352nHNCMTYaUE4+a9M4
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
X-IronPort-AV: E=Sophos;i="5.90,187,1643670000"; 
   d="scan'208";a="26538041"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2022 21:52:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B2767E0044; Wed, 16 Mar 2022 21:52:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4AFB6E0030
	for <cocci@sympa.inria.fr>; Wed, 16 Mar 2022 21:52:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FfrdgEcjpaOS8p0AdE/MxXxdbeP+/6pQXhdmKkS3OkI=;
  b=dF8TJyot5X2HoEO/4DwX1bBTNQUNQqDB1S6DWSbF4IEET0OZi9cTCyNU
   zTVB4DKjH1kOGpHzzcKgy6h/oWR+7xiUcnzkDIpezCYfh6odb9VYV5OfL
   Q6FCWEgVz7ja4JZZbRs5VxtCqz3CgkVwxNds8hujdwrcb3NlgMna+tELk
   Q=;
X-IronPort-AV: E=Sophos;i="5.90,187,1643670000"; 
   d="scan'208";a="26538035"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 21:52:56 +0100
Date: Wed, 16 Mar 2022 21:52:56 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <2ae57eac-cef9-c3e9-4ec5-5330884e7bdc@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203162152370.3177@hadrien>
References: <2ae57eac-cef9-c3e9-4ec5-5330884e7bdc@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can coccinelle match when an identifier exists anywhere
 in an expression?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 228
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203162152370.3177%40hadrien>



On Wed, 16 Mar 2022, Eric Wheeler wrote:

> Hello all,
>
> If I have a function like this:
>
> 	int length; // global
> 	void f(int i)
> 	{
> 		return 10 * i * length + 1;
> 	}
>
> Then how can I write an SmPL to match when  `length` exists anywhere
> within an expression?  The expression format varies.
>
> This doesn't seem to match:
>
> @ r @
> expression E =~ "length"
> @@
> *E

return <+...length...+>;

julia
