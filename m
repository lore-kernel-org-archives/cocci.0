Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8323AC4332F
	for <cocci@archiver.kernel.org>; Wed,  2 Nov 2022 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nCEjyF4eeUdu2SGiHo/u6gxWDuuFvR0oywxSo4xTaE4=;
  b=TrTEUxVDGtY29J+MU4iCbF0v9JpdTcytn1CUP5lPXPM4Zn3eBvjt4L3b
   JkoIlU6EJSpgQlBAc7bRE58lXDs2LuzjM0gAmAuvVKBg/0IM/hAHQUgq3
   mFV+hPAH/Fx0cTnaMGvL0OPaEyzVEG4KCKrXO7QMrLmknOYU6FCPlL/H3
   E=;
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
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72700795"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2022 18:11:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5AB41E0307; Wed,  2 Nov 2022 18:11:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5CF17E01CB
	for <cocci@sympa.inria.fr>; Wed, 26 Oct 2022 14:58:45 +0200 (CEST)
IronPort-SDR: 63592f04_d2EnNO9LRuAd2fGNBadtkYHS2WA9GbscyR/7mHiz0riHN6u
 CxjSIcINZ2QJkmFLjRnUze3WjZjEfsAzcC7SB4g==
X-IPAS-Result: =?us-ascii?q?A0AnAgACLlljkNlUsotQCh4BAQsSDECDfIEBVi4EC0WET?=
 =?us-ascii?q?oh+iBsDnysBAwENOQsEAQGEQIU/Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEBAQEWCR4QDgUihWgNgjUpAYNkAQUjHQEBNwEPC?=
 =?us-ascii?q?xgCAiYCAhBHBgGDDwGDIAMDDapEgTKBAYIIAQEGgUABCwGFIH4DBoERLIw5g?=
 =?us-ascii?q?zR6J4IphD8+glaBQYQEgmaVfzgDRB1AAws7MgMKUBxYDgkfHA4XDQUGEgMgb?=
 =?us-ascii?q?gVBDygvZyscGweBDCooFQMEBAMCBhMDIAINKTEUBCkTDy0HI3EJAgMhZQUDA?=
 =?us-ascii?q?wQoLAMJIR8HJSQ8B1g6AQQDAhAiPAYDCQMCIhNGgSQmBQMNFyUIBU4ECDoCB?=
 =?us-ascii?q?QZTEgIKEQMSDwYmRw5KPjkWBidEATQPDhYDYpd5ghE0fQgIgUWBMpU7rFUHA?=
 =?us-ascii?q?4Njg06Hd5UCMpZrkictlncgjSGaM4F5I4FbcIMDATNOHA+OIDeDO4RZhgc/N?=
 =?us-ascii?q?DsCBgsBAQMJilsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RLFbBK9y7tiJHPxZ78Buk+DfI+orL9Y04lQ7vn2ZKSY5TiVXrb
 HMoB0+726MtN9xYgBHpTnkAsW9qBznm6KdjbNxAV7mZnifhILKFvAE0WKB+UyEJ8SWzIc0vs
 0OT0E9MqyVMbEQt7eZ3ODXKbYd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,214,1661810400"; 
   d="scan'208";a="35622152"
X-MGA-submission: =?us-ascii?q?MDFctE5WJtMISIE2fPLNBGixTiPzUt4RfUzN8d?=
 =?us-ascii?q?E5umqkgxWR79JpWrhlPmS0bTHdaOIEvw27v1NhngUjpIjpecnyEwSObZ?=
 =?us-ascii?q?nmBdm+9UkGrQGuNviVWg0f28EgmVH2Hf0rd1pa0ve1e0471P5EOtzicV?=
 =?us-ascii?q?fg5MFFPPxfsywqfm9uetis7g=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 14:58:44 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA9161EC2;
	Wed, 26 Oct 2022 12:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CFFC433C1;
	Wed, 26 Oct 2022 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1666789117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nCEjyF4eeUdu2SGiHo/u6gxWDuuFvR0oywxSo4xTaE4=;
	b=Gkw7X8XFs5wZwIyVAA/OlHPNfvcvma8qpkZTuOrtLdOtLXEREYRyEbP7TT4Oe8qi1TT5s1
	DyaTa94c8ILXgCb40n4ePKMo5zfm+BoHmDM7CbTubM/SBhoFGTI+8uUQ40dJ6DDtUSxUpV
	/MU/yosRl5pfdP0cTO20yH1XVE9BOTE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6ebb8279 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Oct 2022 12:58:37 +0000 (UTC)
Date: Wed, 26 Oct 2022 14:58:34 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Kees Cook <keescook@chromium.org>, cocci@inria.fr
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
	masahiroy@kernel.org, gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <Y1ku+jfRAyezq6Nz@zx2c4.com>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <Y1iSYddi3BpP8gvf@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1iSYddi3BpP8gvf@zx2c4.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 695
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/Y1ku%2BjfRAyezq6Nz%40zx2c4.com>

On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> The traditional objdump comparison does work, though. It produces a good

Another thing that appears to work well is just using Coccinelle
scripts. I've had some success just scrolling through the results of:

    @@
    char c;
    expression E;
    @@
    (
    * E > c
    |
    * E >= c
    |
    * E < c
    |
    * E <= c
    )

That also triggers on explicitly signed chars, and examining those
reveals that quite a bit of code in the tree already does do the right
thing, which is good.

From looking at this and objdump output, it looks like most naked-char
usage that isn't for strings is actually already assuming it's unsigned,
using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
things here and there, but all and all, I don't think this is looking as
terrible as I initially feared.

I'm CC'ing the Coccinelle people to see if they have any nice ideas on
improvements. Specifically, the thing we're trying to identify is:

  - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
    where:
  - It's not being used for characters; and
  - It's doing something that assumes it is signed, such as various
    types of comparisons or decrements.

LWN wrote a summary of the general problem, in case that helps describe
what would be useful: https://lwn.net/SubscriberLink/911914/f90c2ed1af23cbc4/

Any nice Cocci tricks for this?

Jason
