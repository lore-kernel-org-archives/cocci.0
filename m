Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A3C5AD4C
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8WuCWbkd4FRO4eVWPssJRmxOCfnHVP/bTwF8W89x9ts=;
  b=Aq49rb8ByUwiu8Dk7rBNes3d2GX6WEs9e90vJLaFGbNyJG6x/Jg95pez
   0xP/1XsZ5DvtfHZmv+FP7pXpjCzSFuhSpOs/baYivtytGOj6W2PbGlDy/
   YVl1Bcxpdaa5n6uafBbvR6joncT29zZHK1IunK6j7IALYakoI8z7U4uhM
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138193785"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 18:57:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CDAE3E0CCE; Thu, 23 Nov 2023 18:57:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6050BE004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 18:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8WuCWbkd4FRO4eVWPssJRmxOCfnHVP/bTwF8W89x9ts=;
  b=LGZmSPPBhHlPFV9r2u8N3AAxTP/x7qTLNVw7sHERQ7PIuGttdgowNOr4
   MC2ifgUnboWSWKdaavQvq9/4eprRb10sDW4cwvIe6H1Nm+/WNQvunb/XP
   q421U3i4+rMCXQUFuxaFro1n3BNfk1GNwN7FsaMJamavx4rnk3Ry6wtGr
   A=;
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138193782"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 18:57:57 +0100
Date: Thu, 23 Nov 2023 18:57:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5f1930b8-8249-4158-b76c-c888d36387f2@web.de>
Message-ID: <alpine.DEB.2.22.394.2311231857030.3125@hadrien>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de> <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr> <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de> <alpine.DEB.2.22.394.2311222131120.3262@hadrien> <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien> <09a9b132-5cbc-44df-b445-d8adcac7571e@web.de> <alpine.DEB.2.22.394.2311231845210.3125@hadrien> <5f1930b8-8249-4158-b76c-c888d36387f2@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1320
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311231857030.3125%40hadrien>



On Thu, 23 Nov 2023, Markus Elfring wrote:

> > Script rules are executed once per unique match.
>
> Does such an information mean also that each script rule can not know
> that it would be executed several times because of repeatedly matched source code?

I said once per unique match.  If all of the values of the metavariables
imported by the scrip are repeated by a second match, the script code is
not executed again.

julia
