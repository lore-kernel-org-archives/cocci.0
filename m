Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE21CD11DF
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2024 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IdoyUAz6EBTt33Xei59H1hiirLaoPTvVD4cLAVfYke8=;
  b=P7CD2c4etRZHf8xUtGpDdgi5RvZEKAB+tHZoalrX4veSShYo8izu5wRi
   WgtCDWOVkbmGGaUo3blB0aRtcqvOC6LxHvKPG4OU1BvC4zzA5eRANOC8m
   Yd5p2CPjim7Q7Z5DFluwuQsODzQFaKPqBITJzl/c+kvJAXOMW/P/fSwzf
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="159010691"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2024 22:06:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CB81E01A8; Thu, 28 Mar 2024 22:06:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 41172E0131
	for <cocci@sympa.inria.fr>; Thu, 28 Mar 2024 22:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=IdoyUAz6EBTt33Xei59H1hiirLaoPTvVD4cLAVfYke8=;
  b=cfRuPdu2/eE+phcyx1PhYt62f/oNTqqSB1cBlAMPTV5CiLgoVItpfChz
   +eB37VEl/Uo6bRlQRWFaTsp0WYi23keqiLMeTKcR7fppZtNrDAOi/rE4g
   OQyyuSXqDR3KM73VCslagefIUWXM5iMrX82w5rKZsK/3fVfpXW0+qDaQv
   k=;
X-IronPort-AV: E=Sophos;i="6.07,162,1708383600"; 
   d="scan'208";a="159010686"
Received: from apn-pool1-239-pennnet218.nat.upenn.edu (HELO hnt-346.eduroam.wlan.private.upenn.edu) ([165.123.239.220])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 22:05:56 +0100
Date: Thu, 28 Mar 2024 17:05:54 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: cocci@inria.fr
Message-ID: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] new version 1.2
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1630
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/8056b6c5-9147-6e89-ce97-e1d17e675515%40inria.fr>

Hello,

There is a new version, 1.2.

For the moment, I am unable to update the web page due to a CI issue, but
the new version can be retrieved from github.

julia
