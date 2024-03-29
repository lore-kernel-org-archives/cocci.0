Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3344FC6FD1F
	for <cocci@archiver.kernel.org>; Fri, 29 Mar 2024 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8oN2IHjtbc+VDlwPQO+GyE2W1U19jZkjvBviq1N713E=;
  b=FVKera1QU32IyOqnMlostlYcVVyzDSZZ486oic1vstlLoVnaayT8I8vV
   g0+bM1DextANHI6ialxS7A0MaCREH3Mv1XvxGpujfSaN2LM41NHqwV+Yc
   f9pPSLJb0RqITUumA1Co2gRxeQf9ZRMmu4NQqNXjH/WcXZQ4k7MliQM4k
   g=;
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
X-IronPort-AV: E=Sophos;i="6.07,164,1708383600"; 
   d="scan'208";a="159096683"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2024 11:33:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B1655E02E4; Fri, 29 Mar 2024 11:33:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 85A0EE0157
	for <cocci@sympa.inria.fr>; Fri, 29 Mar 2024 11:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8oN2IHjtbc+VDlwPQO+GyE2W1U19jZkjvBviq1N713E=;
  b=mNurXVE+1OCt7DOD1O6s/08MP/+vFe4XkKPV1CMkSX0s5HGEnO0ZnJCU
   2BiLJAy/JXeWaWovPbMQQTiEICHZn38mfO6ENkVXv2s3j52n02yNm1yj+
   i+rodt9r6boNtqOgOGxhp4z4qB8DWaW1oN6f8RujUPxxnT8J4uRJ2cQN9
   8=;
X-IronPort-AV: E=Sophos;i="6.07,164,1708383600"; 
   d="scan'208";a="83428694"
Received: from apn-pool1-239-pennnet022.nat.upenn.edu (HELO hnt-346.eduroam.wlan.private.upenn.edu) ([165.123.239.24])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:33:12 +0100
Date: Fri, 29 Mar 2024 06:33:11 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <8f03f7f8-3248-4e21-b725-1ff767f0fc1b@web.de>
Message-ID: <b66676f4-b04a-1dab-1450-ae26662ff658@inria.fr>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr> <8f03f7f8-3248-4e21-b725-1ff767f0fc1b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Version 1.2 released
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1634
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/b66676f4-b04a-1dab-1450-ae26662ff658%40inria.fr>



On Fri, 29 Mar 2024, Markus Elfring wrote:

> > There is a new version, 1.2.
>
> Will it become helpful to extend such information?
>
> How many changes did lead to the release of this software revision?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/969cb12e9e9b7d4f42c2ff15296fd927f1ba63af

Many.  Look at the git logs.  More support for C++.  Bug fixes.

julia
