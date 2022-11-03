Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362CEC4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gEafQTxAuW0C4fSx/Iqx7gKDvE8FeF6q8xGkkUzlxAQ=;
  b=FIPwuxTTxZzD2VIfvJAyf0a+1jktsv1UmcjQwIiRkBTMbuRBqWLN/dkr
   VITKDaCVmxGOfEdyq+2CCHHLdghatA2Oj0mg6SbD4hW6FQd+PiayNCnDV
   PZnjSIw4zPIUMpIwPsZ2L+4FezBPMtaqxpS9fDuG5sSOB79/aO6h3Zdbk
   s=;
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
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="72822489"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 13:57:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 51A41E7388; Thu,  3 Nov 2022 13:57:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 92060E7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 13:47:35 +0100 (CET)
IronPort-SDR: 6363b866_nhaGZEA3szJTk5/zyEbV72SeFe9serep6ryjAoV5mGIF76b
 CrSlueD/7rWs0ovtqaQK8k7dnZ9JJU6ziaD9QZA==
X-IPAS-Result: =?us-ascii?q?A0A0AQC0t2NjmNlUsotaHQEBAQEJARIBBQUBQIFPgi2BV?=
 =?us-ascii?q?y4EC0WEToh+iB+fMgEDAQ1EBAEBigACHQcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBEwEBAQEBAQEBFAkZBQ8PBSKFaA2CNSkBg2MBAQICA?=
 =?us-ascii?q?SMdAQE3AQQLCwsNAgImAgIiEwUdBhOCfYJ+IwMDqhh6gTKBAYIIAQEGmjF+C?=
 =?us-ascii?q?YERLIhxhxN6J4IpgUuCdD6IG4JmlkQKAwQGBTgBAgFDHUADCzsvAw1MG1gOC?=
 =?us-ascii?q?R8cDhcNBQYSAyBuBUEPKC9nKxwbBzhUKigVAwQEAwIGEwMgAg0pMRQEKRMNK?=
 =?us-ascii?q?wcjcQkCAyJlBQMDBCgsAwlABxYRJDwHVzoBBAMCECI6BgMJAwIiE0WBJA4YB?=
 =?us-ascii?q?QMNFyUIBU0ECDoCBQZSEgIKEQMSDwYmRw5KPjkWBidEATQPDhQDYIFwBjWaR?=
 =?us-ascii?q?VmDWJU9mQqTXQcDg2eDUZx+MoNlkweSKC2XAqd3gXkjgVtwgQEGgjBPHA+OI?=
 =?us-ascii?q?DeDO4pfQDQ7AgcLAQEDCYo+AQE?=
IronPort-PHdr: A9a23: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
 wQwhw84Zv4ipm+E3g==
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:4JMlgKnqh1MnSz+KzyF9hxfPqLLpDfL63DAbv31ZSRFFG/Fw9/
 rCoB3U726ItN9xYgBdpTnkAsW9qBznhPhICOUqTNCftUzdyQ+VxeJZnOnfKl/balXDH4dmvM
 8KGccRNDSzNykesS+Q2njCLz9P+qj8zElqv4bj5kYoYwVja6QlyRx4BAadGkgzYAVdH5I2GN
 69y6N81kOdkLgsDvhTz0N1PNT+mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72820932"
X-MGA-submission: =?us-ascii?q?MDGHbyxikiyQmrRmZrOm1k4MF5ovCag904qJQ/?=
 =?us-ascii?q?n+Je40hxJ/kNVwMETmzI15WJjOuCqpWRGvV4eHeNT/xSOTxIKr+dEaOm?=
 =?us-ascii?q?1caD5XlfSBEAiDp9njfRNdk9NYirR9jl1m96DKhdXt6YwGDiXbWtfWif?=
 =?us-ascii?q?Hvpy6FDeiNOya0IGJ25ujoaA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:47:34 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EF62C61E91;
	Thu,  3 Nov 2022 12:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5C7C433D6;
	Thu,  3 Nov 2022 12:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1667479649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gEafQTxAuW0C4fSx/Iqx7gKDvE8FeF6q8xGkkUzlxAQ=;
	b=Smh8FGbQysyPMnlAH5nxL3SJq3YZXL39spy870v39JxOQZfwzi7MrbddktJNMunEFrU8eC
	OynhrAK3EcIB1RHvciDoO2wkGCCpmMTMk8INhQwH3n0KFH/YQZtpGj0zqSORV3qf0zA/1/
	07o443KW0UGOU+9UERHtcQQ1W1lUulg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 68fb12c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Nov 2022 12:47:28 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id p4so1725958vsa.11;
        Thu, 03 Nov 2022 05:47:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf3D0RdudKDEGpLSXCDbCF4wwZNwMw/e817DjuAPbtgut53qvv+s
	+BgO2EC6Woxd4J/J5hd2GD378HbnDqd8dTH/urQ=
X-Google-Smtp-Source: AMsMyM7/RXkbrCjYnWkyhHkbTsSOAEyVJ72RQIBH6pFt1o/bKzLMGprYdKpvYo/RZOrLoVNVk+ndwxTwU4khg0wyfhY=
X-Received: by 2002:a05:6102:f9a:b0:3aa:1a11:2702 with SMTP id
 e26-20020a0561020f9a00b003aa1a112702mr17019626vsv.73.1667479646250; Thu, 03
 Nov 2022 05:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook> <Y1iSYddi3BpP8gvf@zx2c4.com>
 <Y1ku+jfRAyezq6Nz@zx2c4.com> <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
 <Y2MGlTwh9aB+4z4l@zx2c4.com> <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr>
In-Reply-To: <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 3 Nov 2022 13:47:14 +0100
X-Gmail-Original-Message-ID: <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
Message-ID: <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	mm-commits@vger.kernel.org, masahiroy@kernel.org, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 708
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/CAHmME9o3BDe%2Bs2QaT4X8jg%2B9cc9A-3iHWnL0WnFyqKcGuhahXQ%40mail.gmail.com>

Hi Julia,

On Thu, Nov 3, 2022 at 1:45 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> It should work now.

Thanks!

> However, without disable optional_qualifier, char is
> still matching signed char.  If you think that should be changed, I can do
> that.

Does `optional_qualifier` disable other things that might be
interesting to have? If so, maybe this is less than ideal? If not,
maybe it doesn't matter?

Though, for what it's worth, gcc treats `char` as a separate type,
even when using `-funsigned-char` or `-fsigned-char`.

Jason
