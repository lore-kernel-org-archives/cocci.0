Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B0C04A95
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 05:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Rl1xQBhNZqPJ9x7NgVwyxJTTSOFJ5wPBi0fz5ZO9fEE=;
  b=OhRwLw4P89cWRGYWHU4hVUxhPy2OaNjt8dXQlZvUosXJKlFYpxY4Hikq
   xoD+idMmb33VSNtC0HmFquxZoauv5COL0HDgF89fqcP9P8Hz8iX3qa304
   6JOOIT4cOZULSetbYJC+We3E2SDvVdsmWgFPn3v4zpsSR1mSzFhGyTH4Q
   0=;
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
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="54847818"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 07:22:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81F10E0241; Wed, 28 Sep 2022 07:22:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E9682E0091
	for <cocci@sympa.inria.fr>; Tue, 27 Sep 2022 00:10:01 +0200 (CEST)
IronPort-SDR: 63322339_7lvlieXRFHD88J44mj0LDJNEiIONYHzx4NLu12Cx++QY+Dn
 X5sixtbRCzP+enTK4E2qrgJwtxM0I5xAUXYsM0Q==
X-IPAS-Result: =?us-ascii?q?A0AzAABNIjJjf7PWVdFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIjgVcuBFCMbV+FcYIokWiLKoF8CwEDAQsBAUIEAQGBU4MyAoRsAh0HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEYCRkHDg4FJIVoD?=
 =?us-ascii?q?YI1KQGDYwEBAQECARIoBgEBNwEECwsYLjQBBQEcBjWFWSMDnhmBBEKKOHiBN?=
 =?us-ascii?q?IEBgggBAQaGDYFcCQkBCIErAY8ueiccgUlEhD8+iFKCLpkpOANEHUEDC0I1G?=
 =?us-ascii?q?AMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FA?=
 =?us-ascii?q?gcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHEzMZAQVZEAkhHA4aDQUGE?=
 =?us-ascii?q?wMgbwVEDygxaysdGwqBDCooFQMEBAMCBhMDAyICECoxFAQpExItBytzCQIDI?=
 =?us-ascii?q?mcFAwMEKCwDCSEfBygmPAdYOgEEAwIQIj0GAwkDAiRbgS8oBQMNGSYIBSMXH?=
 =?us-ascii?q?gQIPAIFBlcTAgoSAxMPmnCBFQEngQSBMaM6nl+DY4FJDJdSCYc5EZZWkh2XC?=
 =?us-ascii?q?6I/hQECCgcGECOBPjqBWzMaCCgIO4JnTgMZD1iNSIkGhWohNDsCBgsBAQMJi?=
 =?us-ascii?q?lABAQ?=
IronPort-PHdr: A9a23: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
 IAJT75GURoyDPxIUyxY
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CwVcYK9fQIioA2VxzNFuk+DPI+orL9Y04lQ7vn2ZKCY0TiX2ra
 qTdZgguCMc6wxxZJhDo7+90cC7KBu2yXcf2+cs1MKZLWzbURyTXeVfBOXZrwEIYxeOlNK1gp
 0QEJRDNA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,347,1654552800"; 
   d="scan'208";a="54620575"
X-MGA-submission: =?us-ascii?q?MDFCh3QTKHKJ4r0DvCE1ZbjhjM2DLfogwd00hp?=
 =?us-ascii?q?JhYsTO5ljintnBR7cnVgAwLThLSc3KUfkxWOcCdNUxsd9vwD6p5LVPUr?=
 =?us-ascii?q?fl20/7qQ1br3L5ZdhaBGqZdq7O3hnbtVEEnruA2TpF3BJMGL8NjvJk2c?=
 =?us-ascii?q?bypJ574Gh4QyrpLlYyjW5tYQ=3D=3D?=
Received: from mail-pl1-f179.google.com ([209.85.214.179])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:10:01 +0200
Received: by mail-pl1-f179.google.com with SMTP id c24so7488956plo.3
        for <cocci@inria.fr>; Mon, 26 Sep 2022 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Rl1xQBhNZqPJ9x7NgVwyxJTTSOFJ5wPBi0fz5ZO9fEE=;
        b=NY5ImQrA3eL5OnR13lQmD2CEBFTVYUg//19AwwNq3NZYP46/ZDkwCCiSGCXHGt013f
         xXLXjSaWCzg2sgHvj0WOgs3fOD5H5R5eDhD3zw/we/jm30/DDuvFWoULjtJTkLlAZ6vA
         X5J6i46/LkH0M3IkP2BYUaZHxvq/XVpCcdXcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Rl1xQBhNZqPJ9x7NgVwyxJTTSOFJ5wPBi0fz5ZO9fEE=;
        b=p1BOE1MB53rV7w4FHuHr0Q/3pva4/2bP/6P0OBM+FPhbqRiOJ3V1nBMYaUUOkJ/wni
         85L3MiacVz2m92Gbe4t85NMUvWeGQdy3bctCCm62vweYXad4iWGO9trkVwV2mbfwmt/Y
         cVgAugo8nIrI1rUUHKShUeiZloa45u1UjS7eiawtHYw2FMOGXg6K7hwd43fInBWpighe
         Zurx8/MD1jwJPIQLFWZSrHrLcJY0XDjfGwErp7cJpfXbTy1HJeJ3h80eSkTVtAkX8TmI
         57EZzEYhigTJhrEE8Z9TYoVPvRtXpuVJUC1LZlHskP7oG8lElLtx4jGApyda+kTWFg9P
         nc7A==
X-Gm-Message-State: ACrzQf0wjn9yzIMqJn3olbfMYgLxu5/egAWBmGPoRoa/3y/7AdNKb7tu
	p8PjmS2WmnK3r5Jw4jbDHUDf7sBzcJtiEg==
X-Google-Smtp-Source: AMsMyM45TiqCd7pKDz3WObezUM/Nyb9CaN2s8Y7iSObN6IPwiXSr0K8+VapX6dpCA6OOmOOwuLFqrA==
X-Received: by 2002:a17:90a:4e8a:b0:203:9556:1b7d with SMTP id o10-20020a17090a4e8a00b0020395561b7dmr973209pjh.0.1664230198949;
        Mon, 26 Sep 2022 15:09:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b0017691eb7e17sm3510994plk.239.2022.09.26.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:09:58 -0700 (PDT)
Date: Mon, 26 Sep 2022 15:09:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, linux-hardening@vger.kernle.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <202209261505.9AE38B8@keescook>
References: <202209260912.8DCCD70@keescook>
 <alpine.DEB.2.22.394.2209262259030.2915@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209262259030.2915@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch --jobs N missing matches?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 594
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/202209261505.9AE38B8%40keescook>

On Mon, Sep 26, 2022 at 11:14:55PM +0200, Julia Lawall wrote:
> I likewise see the following puzzling behavior:

Okay, that's a relief -- I'm usually holding it wrong. :P

> [...]
> So it worked when I tried only one .c file, but not when I tried the whole
> directory.  When I put some tracing (--debug --show-trying) it seems to be
> considering only the .c file in the full directory case, not the header
> file.  I will look into it.

Thank you! If you end up with patches, I'm happy to try them out. I've
got a fresh build of the latest cocci git tree building, so I can easily
test changes.

> In the short term, you could try using the option --selected-only to get a
> list of files considered to be relevant, and then run Coccinelle on each
> of them individually.

Ah-ha! I hadn't noticed --selected-only, that's nicer than my
sorta-by-hand version of just using "git grep memcpy | filter...", but
yes, that's what I ran a while ago. I see it just finished after two
hours. :) But it found (what I hope is) the full set!

--- ./drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
--- ./drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
--- ./drivers/platform/surface/surface_acpi_notify.c
--- ./drivers/s390/net/qeth_l2_main.c
--- ./drivers/w1/w1_netlink.c
--- ./fs/dlm/requestqueue.c
--- ./net/sched/cls_u32.c
--- ./net/wireless/nl80211.c

real    111m15.762s

Thanks for taking a look at this!

-- 
Kees Cook
