Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D47C4332F
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=I6oa6NIvqPjiwXTqtEMX+c8wb16sXQfv4CuC9ZZ/nS8=;
  b=Gb+ejgVU1jriv0a1yqBXXNInVNBU6MfIdXcAjuUAIyqqGEBT8jqzVxdq
   HsP8cTCG5Dwh5x8szJpUuqutMJJGPcnCcHetFUIAGXiSovpMd4Q0Kb0nw
   kL49z/r83JXpcBh8EqnxAixQ4+oFXZIjIp33BVwOrV86cAbYAcmW1nNlt
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56680599"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:11:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 082D3E0121; Sun,  9 Oct 2022 17:11:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3909DE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:10:21 +0200 (CEST)
IronPort-SDR: 6342e45c_1NGCGdHysNE/vdtwY9YOplfO1Oh87EEszcxDz62ArDv+uJn
 HFaD5BRTK9r9iBkPslKdpDQIoOOPNiG8Tc+Y65g==
X-IPAS-Result: =?us-ascii?q?A0B9AwB540Jjf7LSVdFaHgEBCxIMQIFEC4IkgVcuBFCNT?=
 =?us-ascii?q?IVygiiRaosrgXwLAQMBCwEBQgQBAYFTgzIChHQCHQcBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQEARMBARgJGQcODgUkhWgNgjUpAYNkAQEBA?=
 =?us-ascii?q?xIoBgEBNwEPCxguNAEFARwGNYV8A58BgQRCizCBNIEBgggBAQaGDoFcCQkBC?=
 =?us-ascii?q?IEri1GDZXonHIFJRIQ/PohTgi6aNDgDRB1AAwtCNhgDFAMFIQcDGQ8jDQ0EF?=
 =?us-ascii?q?gcMAwMFJQMCAhsHAgIDAgYTBQICTTQIBAgEKyQPBQIHLwUELwIeBAUGEQgCF?=
 =?us-ascii?q?gIGBAQEBBUCEAgCCCYXBxMzGQEFWQ4JIRwOGg0FBhMDIG8FQg8oL2krHRsHg?=
 =?us-ascii?q?QwqKBUDBAQDAgYTAyACDSkxFAQpEg8tBylxCQIDImUFAwMEKCwDCSEfBygkP?=
 =?us-ascii?q?AdYOgEEAwIQIj0GAwkDAiRZgSgmBQMNGSYIBTcaBAg8AgUGUxMCChIDEg8GJ?=
 =?us-ascii?q?0kPSj49nBpiglqjcZ5og2iBSQyfGRGDUwGTA5IelxCnRgIKBwYQI4FFCCuBW?=
 =?us-ascii?q?zMaCCgIgyJOAxkPjiCJBoVqITQ7AgYLAQEDCYsVAQE?=
IronPort-PHdr: A9a23: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
 p0LS6JeElsvGaFCYnk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zHC/jaz7ajKoIujG+qqiKrPwAb1zdoMgy1knxilNoNJuA6ilfu
 SV7Y4mPH7P+U0ssRQb8+xoV5PwIk80maQFg7X5eI3SITUO21HYVL2Kj7GSpQEIcheWnoU86U
 4jSdkGNDSZNzlHZK3BkW6F+rgbsby6GWOT6ds2DU0BceinUc5dBs5CZDqmLg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56680513"
X-MGA-submission: =?us-ascii?q?MDEwl5XBRN4EtgV2L/88N9L72csm6z2jnN0cpu?=
 =?us-ascii?q?wV1szdqGM6zI9mLT7GSTkciJ2XHVuD3jp6lAv8rSRJuJ/3cxXu31c9RP?=
 =?us-ascii?q?zk4aMyEoKEH3JjhiJ6Hn9pM25bHxyM5Y3GcJ8fpXdcbIYAsr3zd0uUQe?=
 =?us-ascii?q?0SmocRp6oRFUhXos5KQdLMvg=3D=3D?=
Received: from mail-pf1-f178.google.com ([209.85.210.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:10:20 +0200
Received: by mail-pf1-f178.google.com with SMTP id i3so8823964pfk.9
        for <cocci@inria.fr>; Sun, 09 Oct 2022 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6oa6NIvqPjiwXTqtEMX+c8wb16sXQfv4CuC9ZZ/nS8=;
        b=MMuAzb7l3JkoWraPIlWNSyTHAEGaPDJz59u2ueEDVnRzpDG8FZuUB8Z2Mmex7eRySD
         CuByDf2qUoV2De4of2kVceswhmBnN5qHES8Sn5c3R0jqu8WW9RJx0cHyFc8ipQe2UUKx
         phQbR/WQdZ27+lOcQdIWZDFgv0Z8HJ7Kw53Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6oa6NIvqPjiwXTqtEMX+c8wb16sXQfv4CuC9ZZ/nS8=;
        b=rZp40/p9oJkbpQYp2A8dlQlI4gmLI5DxABN3EvCsJ/ymsp/mnPEr/kJtBTOifbWUyJ
         9fOORy5YdtrfxSj3JsPF3Rp6WuBTdDgxb8LBjD/fE3KdPB/9lvd7TgMy/f5Ftp9bchQM
         tYF8yZYCEGxQhmpcsFPCLGgZDaWikDP67RRtXfJZmIa20+87ei7V/9En7pzPNMYmWPTf
         MFmAxCGmMHYVonhNpCEJivIQdksuuPQT1T5TsD48atJJ/4s5oFsvE/obYZ6pVq3Afc6q
         qc7FVBB10w83Zo+9O/NRCRCznSo94ZJJz85EGztlL0QIb21vbbn7BfFRaTDmetQm/u6X
         VqBA==
X-Gm-Message-State: ACrzQf1VpBlmZC4oPaxcXMwHjEU0QbaGDxVUnY1wZmt3VSL/6rZU0WWg
	hBWtA+29inXHEfLjf1jOy2Q9YqN29VL+Hg==
X-Google-Smtp-Source: AMsMyM553GCIi4Dgk94e8Pr27d+imlpRmc1Lfb5NFIGE+eQxVaGtzYA/4IROKOCxdS8UHknAahuwLQ==
X-Received: by 2002:a63:886:0:b0:45a:6d71:ef2a with SMTP id 128-20020a630886000000b0045a6d71ef2amr13226701pgi.292.1665328218642;
        Sun, 09 Oct 2022 08:10:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f4-20020a655504000000b0045724d09cb4sm4738682pgr.29.2022.10.09.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 08:10:18 -0700 (PDT)
Date: Sun, 9 Oct 2022 08:10:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <202210090808.AFE4016@keescook>
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 625
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/202210090808.AFE4016%40keescook>

On Sat, Oct 08, 2022 at 09:43:52AM +0200, Julia Lawall wrote:
> - x = e;
>   ... when != x
> ? x = e';
> 
> The ? will stop the match if the thing is found, but won't require the
> presence of that thing for the match to be successful.

Thank you! This worked perfectly. :)

I'm starting to realize I should document my set of "with cocci, how do
I ...?" answers somewhere.

-- 
Kees Cook
