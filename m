Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC25C4345F
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2024 06:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=O2LZtpZjeT+UnV7dkcWIj9Tr0MMH0VpOVu2aULiM1xE=;
  b=uIlQw+82j1gz4wgjxPQmOE34gq5q2S0dlRMVu0HIKlNzG5DauaplGjkc
   0v39ZdWFQHLUTKkQGJnLFhDBq07ohMKrRsqErC5ahyijsK6pgr42MmUmU
   7iko9ryUHFcZfW13v6ReeyDc1oagKIiPYqhL5lVjjyoMNluHBFWk7xfgD
   c=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="scan'208";a="161187035"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Apr 2024 08:33:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CAC2AE0CCA; Fri, 12 Apr 2024 08:33:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 80B8FE004E
	for <cocci@sympa.inria.fr>; Fri, 12 Apr 2024 08:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O2LZtpZjeT+UnV7dkcWIj9Tr0MMH0VpOVu2aULiM1xE=;
  b=lcJAzvQnqqI2gKzLbgC63k7rcgS4oPcixo04T2taW+MlIKOQTa+NbXj8
   V3uPro6UlnWU8GQ2BLuGoJNSGUjsXO5HNlcxz/7CBpYVqD9xOa5vQd8aI
   Qv6c0/ClNOxGRf1wgmLCpvroUOYiyrHrkGG2BtA9sKVnecYEEy1o3CWsy
   M=;
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="scan'208";a="161187024"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:33:46 +0200
Date: Fri, 12 Apr 2024 08:33:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
In-Reply-To: <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
Message-ID: <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr> <ZhhO29XtBmBkyuQo@shikoro> <alpine.DEB.2.22.394.2404112304250.3048@hadrien> <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] new version 1.2
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1644
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/alpine.DEB.2.22.394.2404120831160.3229%40hadrien>



On Fri, 12 Apr 2024, Wolfram Sang wrote:

>
> > I tried spatch test1.cocci test1.c --in-place and it worked...
>
> Thank you, Julia. I'll try to debug...

In a commit in the past, someone suggested that spatch should do nothing
if any error occurred in the treatment of any file.  I applied the patch
proposed, but in the end it became too constraining, and I got rid of it.
But maybe I overlooked something.

julia
