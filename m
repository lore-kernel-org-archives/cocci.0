Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F54CC4828D
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=n8Czy+9w9nTeiqrLi5VhjeZkz0lSpDm35j3+79v5JeU=;
  b=kmcnkHKDEvs+p4AAO0BvSy6SaksfyhxWRJwYK0pfUYzzjdFh+HQYjAA4
   823P108D+vkGSstS/1DUtaA7/o6IY8dgdmGfvVa7i1EgImzjCSnkaN+L5
   9qoEDG+3ISa6WQkgaXEl0Xq3DoGiV0xv0BSgS3ZtmXJZuzVxIohml4Jo0
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150559936"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 14:58:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 95403E0CD6; Tue,  6 Feb 2024 14:58:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0E461E008A
	for <cocci@sympa.inria.fr>; Tue,  6 Feb 2024 14:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n8Czy+9w9nTeiqrLi5VhjeZkz0lSpDm35j3+79v5JeU=;
  b=DVhz3APS22UyiLCQBN9CdxJBF5abgF2av0MgnZHqN+WiQVbAiTLxpQ08
   dMW0o/Zghu9FAwOFKk3TwIQommLkMbcvNFjpKcBXzdufk0SBDtzhUZiy9
   ivt+L5wvIaHPG0+RS++P6H04/FKG326xCHiCTcU0NXLVwVCqdG0oHRJP0
   s=;
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150559918"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 14:58:44 +0100
Date: Tue, 6 Feb 2024 14:58:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jakub Kicinski <kuba@kernel.org>
cc: cocci@inria.fr
In-Reply-To: <20240205095637.54f3f450@kernel.org>
Message-ID: <4524b4f-f0b9-3889-a665-5feaccde3778@inria.fr>
References: <20240205095637.54f3f450@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch --use-patch-diff broken?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1502
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/4524b4f-f0b9-3889-a665-5feaccde3778%40inria.fr>



On Mon, 5 Feb 2024, Jakub Kicinski wrote:

> Hi!
>
> I've been trying to run coccicheck with --use-patch-diff
> to try to limit the number of processed files. I _think_
> it worked when I set it up early last month but recently
> I went back to check and make coccicheck stops after
> the first spatch call, all it prints is "hd"

The problem should be fixed in the github version.

julia

>
> https://netdev-3.bots.linux.dev/cocci/results/452585/new
>
> spatch seems to work fine when run without --use-patch-diff
> cocci version is the latest from git as of $now
>
> FWIW the git hashes are from this tree:
> https://github.com/linux-netdev/testing.git
> (probably best to clone that thing with --depth $number)
>
>
> Example:
>
> /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/err_cast.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h --jobs 48 --chunksize 1 --use-patch-diff b9f2444cd114a7f9c44950dc850aa1753b3edd94..be5bf59888403413619dd74e0d5f5386ffafbc90
> grep: warning: + at start of expression
> grep: warning: + at start of expression
> grep: warning: + at start of expression
> hd
>
