Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B176C43219
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rFg3TXoQvAE5JZJs4RqceEdy9J4w29ijlQhEeAO7+1I=;
  b=aRDEm1sPxrJoQjaOUCaADgRmva7ohIm7TbuBygKA1nL/TC3iz0cX4wOR
   A3fGZ5qo7DIoh7vSnh+aZiSnsdavYI8M+fhpCcEPELCc9zAzwTccG3X83
   QlkSWqxOJfqHq3lwKkq8qoOBAGMlnKNiHtLkIK2dYeudk77VPvQnle92n
   8=;
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
   d="scan'208";a="72854786"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 16:30:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5DD91E738A; Thu,  3 Nov 2022 16:30:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E9D9E7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 15:07:50 +0100 (CET)
IronPort-SDR: 6363cb35_5mUFFFGgnrcbquc4GWKIhf45xurtEReDsTdtALuaajxDWhD
 Y4bjdMehNgu4brduYimqZQi5Kh777ZfuPAxDxjA==
X-IPAS-Result: =?us-ascii?q?A0ByAQAXymNjmNlUsotagQmDfIFXLgQLRYROiH6HfiGfM?=
 =?us-ascii?q?gEDAQ1EBAEBigACHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AQBEwEBAQEBAQEBFAkZBQ8PBSKFaA2CNSkBg2QBBSMdAQE3AQ8LGAICJgICE?=
 =?us-ascii?q?EcGE4J9gyEDA6sdgTKBAYIIAQEGmjF+CYERLJAEeieCKYQ/PogbgmaWYDgDR?=
 =?us-ascii?q?B1AAws7Mg1MG1gOCR8cDhcNBQYSAyBuBUEPKC9nKxwbB4EMKigVAwQEAwIGE?=
 =?us-ascii?q?wMgAg0pMRQEKRMNKwcjcQkCAyJlBQMDBCgsAwkhHwcWESQ8B1c6AQQDAhAiO?=
 =?us-ascii?q?gYDCQMCIhNFgSQmBQMNFyUIBU0ECDoCBQZSEgIKEQMSDwYmRw5KPjkWBidEA?=
 =?us-ascii?q?TQPDhQDYIFwBjWaPgdZgmVzA5U6rGcHA4Nng1GcfjKWbJEngQEtlwKnd4F5I?=
 =?us-ascii?q?4FbcIM3TxwPjleDO4pfQDQ7AgcLAQEDCYo+AQE?=
IronPort-PHdr: A9a23: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
 lg9jQ4sOYwQ
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:KAuxNanzHhKD4mkVqSVegsu3zEjpDfIr3DAbv31ZSRFFG/Fw9/
 rCoB3U726WtN80YgBYpTngAtjnfZq4z/JICOYqU4tKMDOGhILsFvAb0WKA+UyGJ8SdzJ856U
 4IScEXY7eeMbE5t7ef3ODSKadD/DDoysCVuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="36371684"
X-MGA-submission: =?us-ascii?q?MDGcI2uZW6pHV2A+ilW9DX2ZLhYrbEsrjW+kfy?=
 =?us-ascii?q?2SGTzV17am5BWXIXSi/i767Z9aC3QbI0qf/ZPGe1JLqkk959HZ85YVxz?=
 =?us-ascii?q?FKnpKbMni7BLEvQs1Pm5a8c4XDgx/cSpyREQMYno71f1A0s8OmvYNZ+l?=
 =?us-ascii?q?By8b0WBgZgWJK9gi1VvRFz8g=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 15:07:48 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AB8ED61EC7;
	Thu,  3 Nov 2022 14:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F92C433D6;
	Thu,  3 Nov 2022 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1667484461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFg3TXoQvAE5JZJs4RqceEdy9J4w29ijlQhEeAO7+1I=;
	b=plmrmS6mFbWQiE0NyZ0HMok373WIZ3CruzIEfIh8gO0QP3wz/TJCbtjGaQjCrdkraYmURU
	Ra5LTXGZHAKhKST9PeC4htWjqPDOdR+PQNaJw5pYeCZXrFzA/Q4yny4W2ks8HUR4Lul/nO
	650VepRnSG5fgGZOE1H/cNEEw1L6Aok=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7db6b5a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Nov 2022 14:07:40 +0000 (UTC)
Date: Thu, 3 Nov 2022 15:07:37 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
	masahiroy@kernel.org, gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <Y2PLKc1yeUTV4YFL@zx2c4.com>
References: <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <Y1iSYddi3BpP8gvf@zx2c4.com>
 <Y1ku+jfRAyezq6Nz@zx2c4.com>
 <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
 <Y2MGlTwh9aB+4z4l@zx2c4.com>
 <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr>
 <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
 <8e7bcf3-2d39-a9f2-f818-ec627e5d5c4e@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e7bcf3-2d39-a9f2-f818-ec627e5d5c4e@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 712
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/Y2PLKc1yeUTV4YFL%40zx2c4.com>

On Thu, Nov 03, 2022 at 01:57:26PM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 3 Nov 2022, Jason A. Donenfeld wrote:
> 
> > Hi Julia,
> >
> > On Thu, Nov 3, 2022 at 1:45 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > It should work now.
> >
> > Thanks!
> >
> > > However, without disable optional_qualifier, char is
> > > still matching signed char.  If you think that should be changed, I can do
> > > that.
> >
> > Does `optional_qualifier` disable other things that might be
> > interesting to have? If so, maybe this is less than ideal? If not,
> > maybe it doesn't matter?
> 
> Optional qualifier only allows a metavariable declared to have a certain
> type to match an expression that has the same type with signed, const, or
> verbatim in front of it.  Disabling it forces you to write our signed,
> const etc explicitly when you want them.  So rules may becomes more
> verbose.

Oh, huh. Maybe best to treat it as a different type then so that's not
required? I was also thinking that it doesn't totally make sense the way
it is now, in that `char` is *NOT* signed on many platforms, such as
arm. In 6.2, it'll be unsigned everywhere, for kernel code. So in the
general case, for coccinelle, it's a bit of a heisentype and so maybe
should be treated as distinct from `signed char` or `unsigned char`.

Jason
