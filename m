Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C85C433FE
	for <cocci@archiver.kernel.org>; Mon, 10 Oct 2022 05:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=42MOAxEY9LF8V9FOV5QLyNn1+yNe4gSJ3DH+V2bs4KU=;
  b=ZBG+ourWg0ECsDiaPsGJ5IAVeA5wYKozjPhKNnP/iCQk4mWhRbeLty53
   VugsxVJT0oJ47Q22a18UqZkgP5Pijht2FESVnohzRfgGRv2F5IU1dgCIA
   ZL22b6zlHaKOkgPYKsXrzbDRjDMeRc+NsF5j0sTirlU53Twz4vBHY5gd8
   U=;
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
   d="scan'208";a="56716546"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Oct 2022 07:49:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1432AE028F; Mon, 10 Oct 2022 07:49:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0369CE0121
	for <cocci@sympa.inria.fr>; Mon, 10 Oct 2022 04:16:44 +0200 (CEST)
IronPort-SDR: 6343808c_x+yiB1WqvyP+yT32jCN66BlgBTrW9pQJovJC3Ognvq/8pgZ
 Spc9Jgg8EmFOIv9D/kd6nR5ahAgtsyauTc3hQJg==
X-IPAS-Result: =?us-ascii?q?A0DKAQDjf0NjkNlUsotaHgEBCxIMQIFEC4IkgQFWLgQLR?=
 =?us-ascii?q?YROiH6IGp0VFIFzAQMBDTcLBAEBiXsCHQcBBDIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEBAQEWCR4eBSKFaA2CNSkBg2QBBSMdAQEpD?=
 =?us-ascii?q?gEPCxgCAiYCAhBHBoMQAYMgAwMNrHKBMoEBgggBAQaBQAGBH4QMfgMGgREsi?=
 =?us-ascii?q?1GDZXongimEPz6CYgKBKwESAYN4gmaaNDgDRB1AAwtCNhgDFAMFIQcDGQ8jD?=
 =?us-ascii?q?Q0EFgcMAwMFJQMCAhsHAgIDAgYTBQICTTQIBAgEKyQPBQIHLwUELwIeBAUGE?=
 =?us-ascii?q?QgCFgIGBAQEBBUCEAgCCCYXBxMzGQEFWQ4JIRwOGg0FBhMDIG8FQg8oL2krH?=
 =?us-ascii?q?RsHgQwqKBUDBAQDAgYTAyACDSkxFAQpEg8tBylxCQIDImUFAwMEKCwDCSEfB?=
 =?us-ascii?q?ygkPAdYOgEEAwIQIj0GAwkDAiRZgSgmBQMNGSYIBTcaBAg8AgUGUxMCChIDE?=
 =?us-ascii?q?g8GJ0kPSj49mgaCFGBJEFCBYqNCnmgHA4Neg0qHdJR+MoN2jFGGIZIelxCNQ?=
 =?us-ascii?q?JR1D4UrgWgBMmtwcIM3ThwPjiCDcop9IjQ7AgYLAQEDCYsVAQE?=
IronPort-PHdr: A9a23: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
 BU7zAhze+Ig8HHr+VhlfjL3
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:lvebK66Mn17PkyfjZAPXwM/XdLJyesId70hD6qkQc3FomwKj5q
 OTddAgpGbJYVcqKRcdcLW7VJVoLkmzyXcY2+gs1PKZLXHbUQiTXeZfBOnZsljd8kTFn4Y3v8
 hdmupFebnN5DNB/KTHCWeDc+od/A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56706135"
X-MGA-submission: =?us-ascii?q?MDEGBKNR7XAwaqDTLB6CuQIbpMax7j3lvFsSbC?=
 =?us-ascii?q?O9K1POBlxU3H/d3ptRTm2cZ+pdA28c2joNjnTSHdpzsBKFurRIwMx7OK?=
 =?us-ascii?q?GbS1fcbrG3qcF78hmdc4OoFQS9R8stsLVQTGSq9RVHF4os0tMRzx0MOz?=
 =?us-ascii?q?icqAXpbUAHZlmydebyzOftJw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 04:16:43 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EFFF960C2A;
	Mon, 10 Oct 2022 02:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D434EC433C1;
	Mon, 10 Oct 2022 02:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665368198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42MOAxEY9LF8V9FOV5QLyNn1+yNe4gSJ3DH+V2bs4KU=;
	b=oy9V1NxZ0qtVty4BOnd6XBQLtd8U3T7YKbegU7Tux8uicYVrlBf2c1991oDF/SeQ/oZLa4
	lHqfBLZCuH0DYodwK/BbWTzLwbguH8oOMWqCJ5cvUG+8Z5ZxCJsZcDt57HGlUus0uZJzDA
	whgYHl/BQSKpjFFcVzTRBEL+KtNR0Zk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 12c18c53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Oct 2022 02:16:38 +0000 (UTC)
Date: Sun, 9 Oct 2022 20:16:35 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr
Message-ID: <Y0OAg/Sa8pfNDy33@zx2c4.com>
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
 <202210090808.AFE4016@keescook>
 <202210091035.7D63B5FB@keescook>
 <alpine.DEB.2.22.394.2210092001520.21609@hadrien>
 <202210091116.3CA9AFE@keescook>
 <alpine.DEB.2.22.394.2210092018320.21609@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210092018320.21609@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 642
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/Y0OAg%2FSa8pfNDy33%40zx2c4.com>

On Sun, Oct 09, 2022 at 08:19:36PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 9 Oct 2022, Kees Cook wrote:
> 
> > On Sun, Oct 09, 2022 at 08:02:24PM +0200, Julia Lawall wrote:
> > > Thanks.  I have added a link from the documentation page.
> >
> > Thanks!
> >
> > > > And I've sent a PR for some missing docs in Coccinelle itself:
> > > >
> > > > https://github.com/coccinelle/coccinelle/pull/290
> > >
> > > Could you send it by email please?
> >
> > Done now.
> 
> Thanks
> 
> > Is there a good place for finding this python documentation? I
> > didn't see anything that really showed how to use it, and have mostly
> > gone off of existing examples.
> 
> I'm not really an expert on what is supported in python.  Someone once
> suggested that reflection could be used to find out what functions are
> available.  Normally, they are the same as are supported for OCaml.

The important one I found was `cocci.include_match(False)`.

Jason
