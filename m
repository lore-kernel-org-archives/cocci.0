Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35756C433F5
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zWH1/ZC+yWYeOOYA356Xx4E6DSKrPNvTa42j4J7z6y8=;
  b=uxaUfVuvFUgtlbpZUn+MD+Js3yJANGezxFv4HIivnh90Zbq4I2Fx6X0u
   VR3of/KvDLAyoDuZ8GSjuR9RKBYTn2vuRYJPawkoK+ojqmSyOVZ/cD5Gr
   ahIhBZdI749jA26RyJWwfeT++x3jXcsj/yaYOUR8itwWKUY8LL1a9XBGw
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56681841"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:31:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 522D8E028F; Sun,  9 Oct 2022 17:31:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 026D3E0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:22:35 +0200 (CEST)
IronPort-SDR: 6342e73b_rmv3HnexfIKK8y+VObpdDWCwrswZITzqAB3RJ4jkO6TXMIR
 tyyDyiebx1Od7eYBD4GKxH6zqkbjVymqRiX8Xog==
X-IPAS-Result: =?us-ascii?q?A0BYBQAW5kJjkEtEKJFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U8CgiKBVy4EC0WEToh+hXKCKJ0WggYBAwENEjAEAQGJewIdBwEENwMNAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEBARYJHhAOBSKFaA2CN?=
 =?us-ascii?q?SkBg2QBBSMdAQE3AQ8LCw0CAiYCAiITBR0GE4J9gyEGAat5gTKBAYIIAQEGh?=
 =?us-ascii?q?mx+CYERLAGIUIZleieCKYFLgnQ+iBuCZpoYCgMEBgU4AQIBQx1AAwtCMQUYA?=
 =?us-ascii?q?xQDBSEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk00CAQIBCskDwUCB?=
 =?us-ascii?q?y8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkOCSEcDhoNBQYTA?=
 =?us-ascii?q?yBvBUIPKC9pKx0bBzhUKigVAwQEAwIGEwMgAg0pMRQEKRIPLQcpcQkCAyJlB?=
 =?us-ascii?q?QMDBCgsAwlABygkPAdYOgEEAwIQIj0GAwkDAiRZgSgOGAUDDRkmCAU3GgQIP?=
 =?us-ascii?q?AIFBlMTAgoSAxIPBidJD0o+PZwZgzejd55oBwODXoNKnHIyg2STBJIelxCiK?=
 =?us-ascii?q?keEfoILAg6BW3CBAQaCME4cD44gg3KKfSI0OwIGCwEBAwmLFQEB?=
IronPort-PHdr: A9a23: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
 RgF27X1KcIULIKpgyRf
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:+POvEah3LsJG6Cx1Or9v0iHq9HBQXgwji2hC6mlwRA09TyX5ra
 2TdTogpGLJYVcqKQ0dcLW7VJVoLkmsk6KdjbNhWotKGTOW3FdAT7sSj7cKoQeQYxEWn9Q1vc
 wLHMZD4Z/LfD1HZK3BkXKF+rgbsaO6GWOT5Nv2/jNCSQlrbuVH9Ad2CgGSFwlTSBNdDZQ0UL
 qwj/A33gZItU52Ui1zPAhnY9T+
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="25890417"
X-MGA-submission: =?us-ascii?q?MDELOudxKo0Rj5DCvW4wMGCCtru7B2DS3xx4dm?=
 =?us-ascii?q?OqsICY3q8ysyK/N775Ga+iBg9y0oD5lUU9h/DZeM3fWRISKa0WwVBxbV?=
 =?us-ascii?q?IOoyoYglnIhUxEx3dhkW4tpKdCXOShLw9TY7DlC5yfrBBFWfSXq4qgVe?=
 =?us-ascii?q?7ZkXsLVJQov/brOj81ySn11w=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:22:35 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 411A2B80C70;
	Sun,  9 Oct 2022 15:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4563C433D6;
	Sun,  9 Oct 2022 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665328951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWH1/ZC+yWYeOOYA356Xx4E6DSKrPNvTa42j4J7z6y8=;
	b=CYMTFjpE2Wmas5lASqLrrxuFUZqvsddY7U/1ACf7KXQIfF5NJEZbO9IqXQmD8aWJUQV7uR
	1fCFzybJt5/5CU6BzTne+D3SOXYcX54GH+Ex4wTG4cwkriac7h/sg5nFQ5QhagTEi+lXFH
	GaOlWa6x2RFr4x7wcLYhQWsZcmPdbfA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bce665ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Oct 2022 15:22:31 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id i17so3182926uaq.9;
        Sun, 09 Oct 2022 08:22:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf1GdZNdR/LRTuW8z2u/1Ay29dXRAc1ANOYPi/sQxSD27i+nV5sg
	Uwpk7g7h1BWJYumG0Ot7UDEGii1qgpawE74JvNQ=
X-Google-Smtp-Source: AMsMyM7Dui+qNnbk/kzcy/QZW6EFboHNsuy/R15vFDHp8b+gmFgyIsmGoOe9Ip4s9yRXwVTt1QmR4aes25S9wW+CH00=
X-Received: by 2002:ab0:6cb0:0:b0:3d7:1184:847f with SMTP id
 j16-20020ab06cb0000000b003d71184847fmr7090744uaa.49.1665328950302; Sun, 09
 Oct 2022 08:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com> <alpine.DEB.2.22.394.2210091713270.3091@hadrien>
 <CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F=y3=+rh2Gw@mail.gmail.com>
In-Reply-To: <CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F=y3=+rh2Gw@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 9 Oct 2022 09:22:19 -0600
X-Gmail-Original-Message-ID: <CAHmME9pzRtsEBFNBvX=j25D8ANUjLHoVxn0fLnFERgr6FR+VfA@mail.gmail.com>
Message-ID: <CAHmME9pzRtsEBFNBvX=j25D8ANUjLHoVxn0fLnFERgr6FR+VfA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] "reachable by inconsistent control-flow paths"
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 630
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAHmME9pzRtsEBFNBvX%3Dj25D8ANUjLHoVxn0fLnFERgr6FR%2BVfA%40mail.gmail.com>

On Sun, Oct 9, 2022 at 9:17 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Julia,
>
> On Sun, Oct 9, 2022 at 9:15 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> > The meaning of the message is that Coccinelle thinks that it is possible
> > to get to the call that you have changed without going through the u16 v
> > declaration.
>
> Huh, okay. That seems like a bug then?

If I remove the `#if IS_ENABLED(CONFIG_NF_CT_PROTO_GRE)` and the
`#endif`, then it works!

Jason
