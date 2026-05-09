Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D03ACD3447
	for <cocci@archiver.kernel.org>; Sat,  9 May 2026 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cWech0FN+CgX3PS9rP3bVxOzMzZ+LOA+i0iouK15XcY=;
  b=dJ4FO2nrJei4vAX8HHHxjufr11CnQoceNYZ7iX7btKx2cGS3BdGeUyFP
   urgWXpaSxq+GfksA6d3fk4WyqsVbNi5Wi/d/A0ZUGq5jm1H4VyxasQ4Jg
   yTB3wFK2Xo7r28zXgJTbSju0PiQPEk2PRDSIOSzi7VRi3Y4Db9BxZd8eu
   k=;
X-CSE-ConnectionGUID: OFotpLwKRHaB9p9qoje6lA==
X-CSE-MsgGUID: DnpY1Y5HRIe9ScNxVWZxWQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275970100"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2026 11:00:21 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 630998051C; Sat,  9 May 2026 11:00:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 596B48051C
	for <cocci@sympa.inria.fr>; Sat,  9 May 2026 11:00:19 +0200 (CEST)
X-CSE-ConnectionGUID: NENvr8duQYut0fzDN3WuiQ==
X-CSE-MsgGUID: tDp3I2e9TBaHoaWj3r1hiw==
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275970086"
Received: from 88-188-165-3.subs.proxad.net (HELO hadrien) ([88.188.165.3])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 11:00:19 +0200
Date: Sat, 9 May 2026 11:00:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
Message-ID: <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3489
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/3hjCykCvHpf8WE-rK-jyrA>



On Sat, 9 May 2026, Markus Elfring wrote:

> Hello,
>
> A programming interface is used by the Coccinelle software for parallel data processing.
> https://gitlab.inria.fr/search?search=Parmap.parfold&nav_source=navbar&project_id=18465&group_id=10912&search_code=true&repository_ref=master
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/enter.ml#L1283-1299
>
> Corresponding results are concatenated so far.
> I would appreciate if data can occasionally be combined by other algorithms.
>
> I imagine that unique constraints can be taken better into account accordingly.
> Some information would be usable as key data on demand then, wouldn't it?

I don't know exactly what you are reffing to, but you can for example,
concatenation the set of hash tables into a list of hash tables and then
reprocess the data however you want.  I don't think that Coccinelle can
anticipate what structure the user will want.  Making a list preserves all
the information.

julia
