Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E2BC433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=iW38mI+xmBdCV0QJ0H77203miIxOJ0IoOdV3SwwwFgI=;
  b=axsqZwTGWun22U92NSGlwVBYMUP+eJfQ49+gpwBPcIdIKnXJA4kEqe2z
   /qNR/ITNmCpvhW5Oik9D/yDWOPqD+4I64HcLtXkhW9ExeCBwTOcry4LLP
   Bz6lCpZlT0/SEL9T+CE+Ty1muAQWLz91YPvGuct2L9RaChx2DOTFws/Wk
   g=;
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
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56688665"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 20:17:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A216E0121; Sun,  9 Oct 2022 20:17:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 74D77E0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 20:17:03 +0200 (CEST)
IronPort-SDR: 6343101d_ErThmI3ke/EZfvyEUpwx55HGRLEQbPXYZXXjhN7L6cywHH2
 eIHmRKbIBJU9tTu9tq7vJDLjvrm8QY+dt01qXug==
X-IPAS-Result: =?us-ascii?q?A0B+AwADD0Njfy3YVdFaHgEBCxIMQIFEC4IkgQFWLgRQj?=
 =?us-ascii?q?UyIGpFqiysUgWgLAQMBCwEBNwsEAQGBU4MyAoR0Ah0HAQQxCA4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEYCRkHDg4FJIVoDYI1KQGDYwEBA?=
 =?us-ascii?q?QECARIoBgEBNwEPCxguNAEFARwGNYJcgn0jAxCfA4EEQoo4eIE0gQGCCAEBB?=
 =?us-ascii?q?oFAAYRNgVwDBgkBCIEri1GDZXonHIFJRIQ/PoJiAoErARIBhDCCLpo0OANEH?=
 =?us-ascii?q?UADC0I2GAMUAwUhBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNAgEC?=
 =?us-ascii?q?AQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHEzMZAQVZDgkhH?=
 =?us-ascii?q?A4aDQUGEwMgbwVCDygvaSsdGweBDCooFQMEBAMCBhMDIAINKTEUBCkSDy0HK?=
 =?us-ascii?q?XEJAgMiZQUDAwQoLAMJIR8HKCQ8B1g6AQQDAhAiPQYDCQMCJFmBKCYFAw0ZJ?=
 =?us-ascii?q?ggFNxoECDwCBQZTEwIKEgMSDwYnSQ9KPj2aBoIUYEkQUIFio0KLOZMvg2iBS?=
 =?us-ascii?q?QyJaZUwEYNTEoxRhiGSHpcQjUCVBIUCAgoHBhAjgUACNmtwMxoIKAiDIk4DG?=
 =?us-ascii?q?Q+OIINyhRSFaiE0OwIGCwEBAwmLFQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:5wlZgqzkgrMFVOjr2CglKrPwAb1zdoMgy1knxilNoNJuA6ilfu
 SV7Y4mPH7P+U0ssRQb8+xoV5PwIk80maQFg7X5eI3SITUO21HYVL2Kj7GSpQEIcheWnoU86U
 4jSdkGNDSZNzlHZK3BkW6F+rgbsby6GWOT6ds2DU0BceinUc5dBs5CZDqmLg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56688621"
X-MGA-submission: =?us-ascii?q?MDGNv59V3UUwE6pOgz9WBi9EqctdIf1QwSUEx2?=
 =?us-ascii?q?NAaqIbZvE9wwOb7og36QlA5XTctpRhqvSE/7qynmdhSCUl5JYVxL4NUr?=
 =?us-ascii?q?MRm0nVzOmbHtg69TKMBSH06Pa1KBeQbK+87SOWu2yg59nMR+E8l92puB?=
 =?us-ascii?q?kyEMGtiV5rpSApJwA5A5H8aA=3D=3D?=
Received: from mail-pj1-f45.google.com ([209.85.216.45])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 20:17:01 +0200
Received: by mail-pj1-f45.google.com with SMTP id b15so8219846pje.1
        for <cocci@inria.fr>; Sun, 09 Oct 2022 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iW38mI+xmBdCV0QJ0H77203miIxOJ0IoOdV3SwwwFgI=;
        b=UDMjRHh34QMHQFq6kVqrSr/sTwTtZOEFanK4Uufj7FLf74Brvqed+djGp86A2Jnh2H
         DwedGiK3VDt1hKuefbc9ktVrYpG1xJtx/lnMsWqKf5RJ/w/JLRTDK4lBkAsJTo362VGm
         m5EG+Vszm4OZUCWutcwMVJ4HAoyd+tjHPftss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iW38mI+xmBdCV0QJ0H77203miIxOJ0IoOdV3SwwwFgI=;
        b=g/ieuCOeoMTOCrA+QdmQGzNvTo5bU+kkX9lj+aYUQbvtlqMHMBC74B1TmFcE7II2Of
         n3pHwQjDlGOrh+RFhU+/KrsMkX/Vb7kSM9dEz5Q6h2nvaTc3c/cH9iQvXVyoFMsJitCq
         gnkynJCq6eLXGtffey6R8z9gXciMiEeHpuf/WZdX1Qvb6d5XziuMWiCfWjBR+UNmm9Os
         /tfkR0jv+nXLlXhduC/11SAk4l2+BnxmlEp2ajMt8WG2tZ+vJxXjphUZj+DNgEyOIMOK
         eDpEgJrh3fMmrntvNZR+XaUdtrKeg4/xdZDBwewF5ghe5nLVQKf3t5Da6FxoI774dJ6E
         LM6Q==
X-Gm-Message-State: ACrzQf3rJ/ZHl/H0sfTXQ9s0K+f91VfyLgzuJPr2mK/ZFXYocuJ1FQnY
	dxXsE9wnF8aUy/bl/cuxkSqSLuLkmlu/TQ==
X-Google-Smtp-Source: AMsMyM4SfiUQVM8YPvXDISQql20fWVtjGBbL6lax2SbdoSMmOlTNXegRoOP+esIUbud+LNWhQM0RYQ==
X-Received: by 2002:a17:902:b589:b0:17f:5756:b3f9 with SMTP id a9-20020a170902b58900b0017f5756b3f9mr15225249pls.14.1665339419499;
        Sun, 09 Oct 2022 11:16:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6-20020a623606000000b0053e6eae9665sm5447187pfa.140.2022.10.09.11.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:16:58 -0700 (PDT)
Date: Sun, 9 Oct 2022 11:16:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <202210091116.3CA9AFE@keescook>
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
 <202210090808.AFE4016@keescook>
 <202210091035.7D63B5FB@keescook>
 <alpine.DEB.2.22.394.2210092001520.21609@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210092001520.21609@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 638
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/202210091116.3CA9AFE%40keescook>

On Sun, Oct 09, 2022 at 08:02:24PM +0200, Julia Lawall wrote:
> Thanks.  I have added a link from the documentation page.

Thanks!

> > And I've sent a PR for some missing docs in Coccinelle itself:
> >
> > https://github.com/coccinelle/coccinelle/pull/290
> 
> Could you send it by email please?

Done now. Is there a good place for finding this python documentation? I
didn't see anything that really showed how to use it, and have mostly
gone off of existing examples.

-- 
Kees Cook
