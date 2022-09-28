Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6228C54EE9
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 05:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nNIu9MOBq5hXpqXGFXeNQOwTfuesFp67Vbi5mmPF+QI=;
  b=qxT5Vc8ybuaU8hocxygutsFpR8uZu7zTD6NvoKEXybLVRCWYkA5KPLNX
   tTnyX01Hh3OLcfOlnIkvUxYIJoiDHvq3C39GpPtkAHV1+M28avJw7nfcS
   NOmW2DcO/K+e3Vni9ebnygLPalLjq+DsF+NqH1Ezs3a7pdQktBcUqa0G6
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="54847834"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 07:22:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 709F8E0076; Wed, 28 Sep 2022 07:22:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5651AE0076
	for <cocci@sympa.inria.fr>; Wed, 28 Sep 2022 02:06:40 +0200 (CEST)
IronPort-SDR: 6333900e_VyBcbpvA+lrtn+04yeFLfH3g6lqMLwdvLkhsPBZYnLt2Ljt
 4soKv3fDxsp0yYotoHv+gPObuoZ+hvervwcmsuQ==
X-IPAS-Result: =?us-ascii?q?A0AyAADRjjNj/y/YVdFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIjB4FQLgRQjG1fhXGCJQORaYsqgXwLAQMBCwEBQgQBAYFTgzIChGwCHQcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAYEIE4VoDYI1KQGDZ?=
 =?us-ascii?q?AEBAQMSKAYBATcBDwsYLjQBBQEcBjWFfAOeeIEEQoswgTSBAYIIAQEGhg2BX?=
 =?us-ascii?q?AkJAQiBKwGPLnonHIFJRIQ/PohSgi6ZOjgDRB1BAwtyGAMUAwUkBwMZDyMND?=
 =?us-ascii?q?QQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRC?=
 =?us-ascii?q?AIWAgYEBAQEFQIQCAIIJhcHEzMZAQVZEAkhHA4aDQUGEwMgbwVEDygxaysdG?=
 =?us-ascii?q?wqBDCooFQMEBAMCBhMDAyICECoxFAQpExItBytzCQIDImcFAwMEKCwDCSEfB?=
 =?us-ascii?q?ygmPAdYOgEEAwIQIj0GAwkDAiJagS4oBQMNGSYIBSMXHQQIPAIFBlcTAgoSA?=
 =?us-ascii?q?xMPBi6bCIEWgRwnLVqjTJ5fg2SBSQyfFBGWVpIdlwuiNAuFAQIKBwYQI4E+P?=
 =?us-ascii?q?IFZMxoIKAiDIk4DGQ+OIIkGhWohNDsCBgsBAQMJijMBAQ?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 AzwgKAe5ekRkNiKndgQIDguY+tHOtEzBw==
IronPort-HdrOrdr: A9a23:YmYOJ6hZIMKIbhzCk9odT2o1YnBQXvcji2hC6mlwRA09TyVXrb
 HLoB0+726PtN9xYgBapTnkAsO9qBznhP1ICOUqTNWftUzdyRaVxeJZnPPfKl/bakvDH4dmvM
 8KE5SWSueAdGSS5fya3ODSKadG/DDoytHMuQ4c9RtQpMNRBp2IIz0XNu9TKCNLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,350,1654552800"; 
   d="scan'208";a="54833239"
X-MGA-submission: =?us-ascii?q?MDEzO5pfC6oYyCsR3DZ/SKNe66lFT7IUOXFcqM?=
 =?us-ascii?q?iVFaDyYJGozh/WoXUN7jseb11cIatoP2Bea7k3rxEH85omrIACTYLxkW?=
 =?us-ascii?q?PuA0oYxfAf2poWa7fw5tUKpv824DOru6qajpSp9Jpq9WI81QckvZPx4v?=
 =?us-ascii?q?TrpwjCgSCuGi1uVp2gGAKjgw=3D=3D?=
Received: from mail-pj1-f47.google.com ([209.85.216.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 02:06:37 +0200
Received: by mail-pj1-f47.google.com with SMTP id cv6so996302pjb.5
        for <cocci@inria.fr>; Tue, 27 Sep 2022 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nNIu9MOBq5hXpqXGFXeNQOwTfuesFp67Vbi5mmPF+QI=;
        b=kUwqWtNdY2Mx+kov5RP9qUMeaw9c0wV/DbWRtl6+wKMW67Md/xEb8If18qATSTY2ID
         e+Ax3xY4AQZK6N+imYuOmXYh//oDf5MNsqX5aTYbRlJV93tHwARlNLEuufspzFwCCJH+
         2BPdFfciME/AAhJE1tzapdjZStaFl9NVHIDGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nNIu9MOBq5hXpqXGFXeNQOwTfuesFp67Vbi5mmPF+QI=;
        b=PkgGUZsf7SPt0ahQLARJAhIbNUPPtfvrfgppw0NZ7eEPXAmOOVvkUpUZTTgLz7Y/GU
         JruzdKNg6SfIQmOqBkOGCzi+wlHOd0PE6qUsnLMQRHWJtzPRrXP7rQTup9OiHw2/T7mC
         8vSB4WzEtv/xpECRJwYk3jW8k4iy3MjLBV+HtdkXz81IrhOiZIAaZMf2TNvdBnnfxN3B
         /KFNXnU0pX0U1CoMN8Wmyd95yehO5YErTX5LzwSawOUbJxZSopzmp4EWKWLGYrJm5OUr
         38GjryZ5CG1Z2XWfZ319q37ZsgB1WrmAMtgRa4BmqN6gtwLyLVosJPEPlg1tgWHdySEJ
         t+Rg==
X-Gm-Message-State: ACrzQf1JXQJ7rUSsrTmDVwFGCJJya5QBLSIFFskOWPrYFwwi7+C09Lbe
	bXRj0WsgAXXQwVdL6QtI7U6/gv2dwxi4WQ==
X-Google-Smtp-Source: AMsMyM5lBc6cgMPxALJU5BgfuW4pY/gvxhlTJwS9euToRkedOuI3DRtl5bdU+XtVB97UJZQrTxd5Dw==
X-Received: by 2002:a17:902:b415:b0:178:2835:29e7 with SMTP id x21-20020a170902b41500b00178283529e7mr29921888plr.86.1664323595769;
        Tue, 27 Sep 2022 17:06:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f22-20020a63f116000000b0042a713dd68csm2226542pgi.53.2022.09.27.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:06:34 -0700 (PDT)
Date: Tue, 27 Sep 2022 17:06:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <202209271425.50502D365C@keescook>
References: <202209260912.8DCCD70@keescook>
 <alpine.DEB.2.22.394.2209262259030.2915@hadrien>
 <202209261505.9AE38B8@keescook>
 <alpine.DEB.2.22.394.2209272235060.2842@hadrien>
 <alpine.DEB.2.22.394.2209272304030.2842@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209272304030.2842@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch --jobs N missing matches?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 595
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/202209271425.50502D365C%40keescook>


On Tue, Sep 27, 2022 at 11:09:35PM +0200, Julia Lawall wrote:
> The problem is fixed in github.  Coccinelle was doing some caching of
> header files, that was not desirable in the case where one actually wants
> to match the code, and not just get type information.

Thank you for the fix! I can confirm things appear to be working
correctly now. (And took 124 minutes to run.)

> [...]
> Actually, there are not that many memcpys in the considered code.  Then
> there are not that many that refer to the last element of a structure.  If
> level2 produces nothing, then level 1 should not be applied.
> 
> In the original rule order, all of the pairs of a flexible structure and
> any structure are considered, regardless of whether any memcpys are
> present.

Ah! Yes, I keep forgetting to start with the narrowest part first. :P

I also forget that I can do a "depends" on something that has no other
matches, but if it's built on prior rules that I use in later rules,
then it limits that rule directly. I haven't quite managed to think
sideways hard enough. :)

-- 
Kees Cook
