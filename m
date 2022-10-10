Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6919C433F5
	for <cocci@archiver.kernel.org>; Mon, 10 Oct 2022 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HAGzbiCmkwJeoXfiWKNhKJGPra0cTjIpBv0t4F0RiiM=;
  b=ga1BTUEIQ4IP2hEJUbHjYCahjksQUQg8JThpy02fr47s1day4pA5Wdf3
   lt44SDoevoa5sNDKNZxic/0rt45lkvkzP6GKaGpHcenA0lY8seh3Ha28U
   eN1qGTjyvBZrPmhERRSdcCdMDtOQzOhv/et/XN50wLdz626rIlDORZaqh
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
X-IronPort-AV: E=Sophos;i="5.95,173,1661810400"; 
   d="scan'208";a="56897556"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Oct 2022 18:20:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5FB77E02CA; Mon, 10 Oct 2022 18:20:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D11E3E0121
	for <cocci@sympa.inria.fr>; Mon, 10 Oct 2022 18:18:35 +0200 (CEST)
IronPort-SDR: 634445db_HwfgcINZEQudfOTA5zxKemMca+4Yv9ZOsNrv0+2GU4qjWJC
 DvQ2wMKUxaReakMX3V4Qmm3T4XxbqA7Jfk0Zuug==
X-IPAS-Result: =?us-ascii?q?A0AXAADRRERjkEtEKJFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIjgVcuBAtFhE6IH1+IGp0VggcBAwENQgQBAYl7Ah0HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQEBFgkeEA4FIoVoDYI1KQGDZ?=
 =?us-ascii?q?AEFIx0BATcBDwsLDQICJgICIhMFHQYTgn2CbgMwBgGtWIEygQGCCAEBBoUZI?=
 =?us-ascii?q?oExfgmBESwBiFCGZXongimBS4I9BzA+iBuCZpojCgMEBgU4AQIBQx1AAwtCM?=
 =?us-ascii?q?AUYAxQDBSEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk00CAQIBCskD?=
 =?us-ascii?q?wUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkOCSEcDhoNB?=
 =?us-ascii?q?QYTAyBvBUIPKC9pKx0bBzhUKigVAwQEAwIGEwMgAg0pMRQEKRMPLQcpcQkCA?=
 =?us-ascii?q?yJlBQMDBCgsAwlABygkPAdYOgEEAwIQIjwGAwkDAiRZgSQOGAUDDRcmCAU3G?=
 =?us-ascii?q?wQIPAIFBlITAgoSAxIPBidJD0o+OxcInleBf6J6izmTLwcDg16DSpxyMpZok?=
 =?us-ascii?q?h6XEKJRhR6BYTqBW3CBAQaCME4cD44gg3KKfSI0OwIGCwEBAwmLFQEB?=
IronPort-PHdr: A9a23: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
 pVcEtdm
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vEjGvKMGv+tcMcBcTtSjsMiBIKoaSvp037BZ7S9MoHtuA6mlfq
 GV7ZYmPHDP4gr5NEtApTniAsS9qBHnnqKdMbNhXotKNTOO0FdAR7sD0WKN+VPd8mHFmtJg6Q
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,173,1661810400"; 
   d="scan'208";a="25993398"
X-MGA-submission: =?us-ascii?q?MDHY4Uulw79BHCrCpLrjh3fsHhrqzxrS+L0Zzq?=
 =?us-ascii?q?6/EBsranIpLXjF177ZYfHXHSypzmED12qvWc42QjnBGuwuEWTSQfKmyc?=
 =?us-ascii?q?wtuyKU/NMTePjBCWvw2Y8drb2Si1Eepf0496AezR88lv71xTHf0ZLm6V?=
 =?us-ascii?q?o15vTfku1qPY4uf6UMoA38JA=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 18:18:34 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 78765B8104A
	for <cocci@inria.fr>; Mon, 10 Oct 2022 16:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF28C433D6
	for <cocci@inria.fr>; Mon, 10 Oct 2022 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665418710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAGzbiCmkwJeoXfiWKNhKJGPra0cTjIpBv0t4F0RiiM=;
	b=EwX5g5hsSo8wsCF9MYendr03Mg9TH912HG31yKXErSts9YNpOgwoBov1YZNBXa7R6LeI8v
	pf/itDU4bRBVZwruWvTzmV6jaGHsb446jnnYxXudGNEFrhdxpGJSk0VOeZSKHN9VSL/GkJ
	Z+c9RidPMrCwjD8xNtk5F/4HS9Th7Ok=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7fe7fdf8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <cocci@inria.fr>;
	Mon, 10 Oct 2022 16:18:30 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id k6so11698936vsc.8
        for <cocci@inria.fr>; Mon, 10 Oct 2022 09:18:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf2d4Yzsw66io0kxWfLW7KoEhIcBe2DEzxCN51DZFjAzwdacZvZN
	DwUvVowZPzlDjLWQWubT0DphBm3FtGWXhnFoNpw=
X-Google-Smtp-Source: AMsMyM6dXu1FuxIx2fTDz7o4ypAC0tKzpkobYoXyB65w7JO7jWwWc1JfNgzf17E4r/o/dyq/WZhNvt7iUrijXTsPBHg=
X-Received: by 2002:a67:ed9a:0:b0:3a7:718a:7321 with SMTP id
 d26-20020a67ed9a000000b003a7718a7321mr3202929vsp.55.1665418709111; Mon, 10
 Oct 2022 09:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com> <9c2e72af-e465-aa35-a631-c4f9762143f9@web.de>
In-Reply-To: <9c2e72af-e465-aa35-a631-c4f9762143f9@web.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 10 Oct 2022 10:18:18 -0600
X-Gmail-Original-Message-ID: <CAHmME9qUWo2=fpyGdRjO0n4wvm2z=Y2sR8hi57vp8eDrJ4VV_Q@mail.gmail.com>
Message-ID: <CAHmME9qUWo2=fpyGdRjO0n4wvm2z=Y2sR8hi57vp8eDrJ4VV_Q@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Replacement of random functions for Linux
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 643
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAHmME9qUWo2%3DfpyGdRjO0n4wvm2z%3DY2sR8hi57vp8eDrJ4VV_Q%40mail.gmail.com>

Hi Markus,

On Sun, Oct 9, 2022 at 11:00 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> Your clarification request triggered that Julia Lawall pointed another
> possibility out for such metavariable declarations an hour ago.

Thanks for the pointers.

> @replacement1@
> identifier to_be_replaced =~ "^(?:get_random_(?:int|u32)|prandom_u32)$";
> u16 target;
> @@
>  target =
> -         to_be_replaced
> +         get_random_u16
>           ()

Any reason why you leave the () on the next line?

>
>
> @replacement2@
> u16 target;
> @@
>  target =
> (
> -         get_random_int
> |
> -         get_random_u32
> |
> -         prandom_u32
> )
> +         get_random_u16
>           ()

Comparing the two, the regex one is definitely easier to write
multiple rules for. Is there a difference in speed? Will the regex one
filter --dir, or do I have to use the latter one for that?

Jason
