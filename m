Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302D6C61D98
	for <cocci@archiver.kernel.org>; Tue, 21 Nov 2023 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zodcmik8z2f3wyslOc5WWsdibbpdRu7cBj945+/+Mck=;
  b=IwR1nIXPALxJi5/L4rcg+VjU6J673uM/ae9pDnGvuGIGcy96HWeCnM6I
   jF0nek1B6C78dKgxHPDcqrP3iWvpGs8DTLg3ioXUKhJe0o3y+LMnM5/oo
   5nOetBxsFfR3IGqC3haTkeCd1vLd4sjsw1M+aaGQ3VagEm2AQRhheu0Od
   4=;
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
X-IronPort-AV: E=Sophos;i="6.04,217,1695679200"; 
   d="scan'208";a="137713303"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Nov 2023 23:58:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C3F7DE0CCA; Tue, 21 Nov 2023 23:58:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 22E70E004E
	for <cocci@sympa.inria.fr>; Tue, 21 Nov 2023 23:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zodcmik8z2f3wyslOc5WWsdibbpdRu7cBj945+/+Mck=;
  b=eb4pvucrBEysAvvXZirLdwOpd6wd1frY5Bu8EA+QCOvnzecGUhMi43uB
   xafnRefniXn/YgBHaHwhxuLT4n50bFbiWtgGTM3bAa22SBwzgc/UsmHU5
   3mbwPOLNOgL147XGc5feLANkzw81ja+xqPBqUY58KoBnauIpEzXRjCEDm
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,217,1695679200"; 
   d="scan'208";a="137713298"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 23:57:57 +0100
Date: Tue, 21 Nov 2023 23:57:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, cocci@inria.fr, 
    Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2311212333280.3253@hadrien>
Message-ID: <alpine.DEB.2.22.394.2311212357270.3253@hadrien>
References: <20231109161846.148524-1-przemyslaw.kitszel@intel.com> <e7263df7-be7d-47a4-b708-e04393f7887a@intel.com> <alpine.DEB.2.22.394.2311212333280.3253@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [BUG] exponentially slow spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1304
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311212357270.3253%40hadrien>

The problem should now be fixed in github.

julia
