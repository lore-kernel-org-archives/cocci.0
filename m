Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE9BC02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/uPRjNk+k2lYqvrDO7rvrzk1jr06ey7tDeYblPWMzHw=;
  b=LeybcrdK8JO8P0SdpNaQN702dEc4/HE3hquMC6vd+vTPeNAJqpgfRryA
   ulyp313vgcaZYKs3x5VA8zdf68BiUOfkpLTf7IE8L/DyEp7klGw6Gm1lW
   Lbz8vbFaEJFzVmWlwUELMOm7AzDjDcIleb5U866JlUnCV7c+8G5mDDgeO
   k=;
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
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206883186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 10:53:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3D94E0D1D; Thu,  6 Feb 2025 10:53:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 64251E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 10:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/uPRjNk+k2lYqvrDO7rvrzk1jr06ey7tDeYblPWMzHw=;
  b=O0cRbajmhtICKB7vqLAJBwVk51jvTWce8wANtKqcf4TTaa1IOITcnai0
   EUHNdMXd+iFETRGnekpuFPEEW1/NKn/eMQBcpmF86ueid6IIUA00z9YlD
   M9pKBTpiEztYJREi6kWrQRjq7zgoAis1hONMpC6qYK3vHi4FywM/yZWKj
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108362534"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:53:16 +0100
Message-ID: <4ed80c12-f83f-4d4f-aac9-166218943535@inria.fr>
Date: Thu, 6 Feb 2025 10:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>, cocci <cocci@inria.fr>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2353
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/4ed80c12-f83f-4d4f-aac9-166218943535%40inria.fr>

Hi,

Thanks for the report!

> With "spatch version 1.1.1 compiled with OCaml version 4.14.2" this
> works just fine; however, we're trying to upgrade our dependencies and
> now with "spatch version 1.2 compiled with OCaml version 5.2.0" it
> doesn't match anything any more? I can't seem to figure out why, I
> thought maybe the types didn't match - not sure why we had added type u8
> to that, but pretty sure it was needed - but adding more types didn't
> really help either.
We don't officially support OCaml 5.2.0. Could you let me know how you 
installed/built Coccinelle?

> I stand corrected, I wasn't patient enough. On a machine _much_ faster
> than my laptop (server CPU), it finished (with warnings about
> inconsistent modifications) after a bit more than 10 minutes.

Glad to hear! We know there's been a performance regression in 1.2 and 
we are looking into it. It's a little faster in 1.3.0, but still slower 
than 1.1.1. It's unclear at the moment to what extent the performance 
has been degraded because of necessary fixes that perform unavoidable 
additional work.

Victor

