Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CB0C4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QgYVtwHpYFw03zFyQCrKiDUNLViSFeX3zTBG3z4JYH4=;
  b=R4UMvm4ACNUYTGP/+2o+bx7tyD43TVga0T90BoAyjw7pfRbyO8JJkZX4
   eDCy+FqdvKcosohQFiL4+VfeKkspbeeVZu0hJzZnZKqN+wIUGEpkQ1SlQ
   S6lQBF7TJ2J3csgr7W45qFbRNy8q1k4JS51lO7fGFtFsEAIYnyZl5WgmV
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="72822429"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 13:57:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0A0CE738A; Thu,  3 Nov 2022 13:57:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40216E7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 13:57:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QgYVtwHpYFw03zFyQCrKiDUNLViSFeX3zTBG3z4JYH4=;
  b=XReocNVr2c+W3z+RNnZIxMY6bPTC+O1WnpPmvD3ZRwfTDXDvNDn2UE2z
   Kh1b9gPMyDCE9dmkkPy8Ib97DUQPjkernn8PonA+F/TEhVoVcomhxzD51
   liRkPSVO9eq5upX6qkl5wh0RHSo6PhT3WCDZxY49YxG8ojU69vhG3CrZt
   g=;
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="36363611"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:57:27 +0100
Date: Thu, 3 Nov 2022 13:57:26 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, 
    linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, 
    masahiroy@kernel.org, gregkh@linuxfoundation.org, 
    andriy.shevchenko@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
Message-ID: <8e7bcf3-2d39-a9f2-f818-ec627e5d5c4e@inria.fr>
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain> <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com> <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com> <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com> <202210201151.ECC19BC97A@keescook> <Y1iSYddi3BpP8gvf@zx2c4.com> <Y1ku+jfRAyezq6Nz@zx2c4.com> <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
 <Y2MGlTwh9aB+4z4l@zx2c4.com> <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr> <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 707
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/8e7bcf3-2d39-a9f2-f818-ec627e5d5c4e%40inria.fr>



On Thu, 3 Nov 2022, Jason A. Donenfeld wrote:

> Hi Julia,
>
> On Thu, Nov 3, 2022 at 1:45 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > It should work now.
>
> Thanks!
>
> > However, without disable optional_qualifier, char is
> > still matching signed char.  If you think that should be changed, I can do
> > that.
>
> Does `optional_qualifier` disable other things that might be
> interesting to have? If so, maybe this is less than ideal? If not,
> maybe it doesn't matter?

Optional qualifier only allows a metavariable declared to have a certain
type to match an expression that has the same type with signed, const, or
verbatim in front of it.  Disabling it forces you to write our signed,
const etc explicitly when you want them.  So rules may becomes more
verbose.

julia

>
> Though, for what it's worth, gcc treats `char` as a separate type,
> even when using `-funsigned-char` or `-fsigned-char`.
>
> Jason
>
