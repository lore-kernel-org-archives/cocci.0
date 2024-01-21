Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62004C47422
	for <cocci@archiver.kernel.org>; Sun, 21 Jan 2024 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=h2WPn6Ego06GRxcMe6RmIAum7jBpuI3hvgZ5Ctv8lLk=;
  b=RBZLZKSPsJHr04AELEO5rL0xh0+uNsgfJ4jlF13zHG39ObgFG68CLbPW
   0aHJbMPArMx4ZjY3GVN2ztLoeOFty2JLWJlgYcrw090+3HRPw7dx8N9qT
   4N8ZAuSrp/Qpr+HoWtYKM7pTt9b9HadO13aztKtmWrcTB/7RyaKlF29Fo
   8=;
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
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147778076"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2024 12:21:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C6AFE0CD6; Sun, 21 Jan 2024 12:21:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0703AE0035
	for <cocci@sympa.inria.fr>; Sun, 21 Jan 2024 12:21:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h2WPn6Ego06GRxcMe6RmIAum7jBpuI3hvgZ5Ctv8lLk=;
  b=BZZe9MvGBm/CybP4VqEyEz4a/w2mz8R8ev0qJQ9qy1AXWkdOJBVhox7Q
   rcWlD11pNGUDmmMVuyXpUo6zBWbAadnFGIxb9Etu6M/pyU286AtPnTOZZ
   +GYY8ZuA9hrlaFm2tpPp5GdSLaEfFfM/5MpA1V/KsWeNfa1RsFmS9J99K
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147778071"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 12:21:19 +0100
Date: Sun, 21 Jan 2024 12:21:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Li Zhijian <lizhijian@fujitsu.com>, cocci@inria.fr, 
    LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
Message-ID: <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com> <alpine.DEB.2.22.394.2401202217550.3267@hadrien> <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de> <alpine.DEB.2.22.394.2401211159350.3743@hadrien> <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1463
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/alpine.DEB.2.22.394.2401211220480.3743%40hadrien>



On Sun, 21 Jan 2024, Markus Elfring wrote:

> >> Would you like to consider the application of the following SmPL code variant?
> >>
> >> -snprintf
> >> +sysfs_emit
> >>          (BUF,
> >> -         SZ,
> >>           FORMAT,
> >>           ...
> >>          );
> >
> > It's ok too.
>
> Are you going to integrate such a transformation approach?

No.  I already pushed the commit for Linux v6.8, and I don't think the
change has any practical impact.

julia
