Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97D6C61D97
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 21:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mi848veu65HngvHZlnyhFqlChrh30SsnV7xYyS9oDP4=;
  b=el3bWWaWjz/9Ad5iW5oU3o2zjYOrhB8kJCiPqxrDYMQ9GakpCEBEVARO
   5mgpR11iSrBdXoRi9UCJNkelB7C2H5cqO+PNM2v5+wNMQgNwi/OTe5l/k
   ZJ8NgNn/qs+cPPGK8hpLRm3HRpew3kC17qy4Wu00Yae+2GDn4qr2ZofCp
   k=;
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
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137979274"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 22:21:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D121CE0AF1; Wed, 22 Nov 2023 22:21:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5026AE004E
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 22:21:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mi848veu65HngvHZlnyhFqlChrh30SsnV7xYyS9oDP4=;
  b=v0D4VR+xwAP6LfvZ/izg876438QX5Pp+P8at8HgA3CHp6+RRgPeuUXpc
   O7wrXlMbduWju/Ev2mj7V6VmoKiouwnaagArLBPfVPcvLPyYEu8Ea3tHN
   0bzk5SkWiQRcFebNzbIQClAmmvH/ZU8sjkiIGKQOSA/elxAFP2UPcHrkl
   I=;
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="72302938"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:21:29 +0100
Date: Wed, 22 Nov 2023 22:21:27 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d01a8b90-23cd-4058-b400-bc2c7fee1639@web.de>
Message-ID: <alpine.DEB.2.22.394.2311222220380.3262@hadrien>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de> <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr> <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de> <alpine.DEB.2.22.394.2311222131120.3262@hadrien> <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien> <d01a8b90-23cd-4058-b400-bc2c7fee1639@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1392346129-1700688088=:3262"
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1313
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311222220380.3262%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1392346129-1700688088=:3262
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 22 Nov 2023, Markus Elfring wrote:

> >>> If you don't want any subsequent ifs, then you can put ... after th } and put
> >>> when != if (...) S1 else S2
> >>
> >> How do you think about to count involved if statements?
> >
> > You can put a position variable on a matched if (if@p) and then use python
> > code to add the length of p to some variable.
>
> Would you like to explain your development idea a bit more for the usage of “the length”
> from a position variable?

A position variable is an array.  So something like count = count +
length(p), but I don't know the proper way to tak the length of an array
in python.

julia
--8323329-1392346129-1700688088=:3262--
