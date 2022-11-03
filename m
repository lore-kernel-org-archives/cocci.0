Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9EEC4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Ss+0UcaTi7dI1wdBpT9CwV3xqKbtQHsvn2bTvMdYCP0=;
  b=kNSSYJc9i43fI9GWouMMbLCylOM9PzuCvbMXOSEvpPgfYEa5kZjH6VtL
   K9AOmGy5taXSH2NI9kzDoy9GXEN9wpVuLBmpolB11/fqeN2M9AIKL4hnd
   vyf0gCf2yjUJ8eOKcHBmJNog0yt4JpClVfifLjiliQhnw8dKF/ZHNoOsv
   M=;
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
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72751903"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 08:42:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B316BE7387; Thu,  3 Nov 2022 08:42:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 891EAE7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 01:09:25 +0100 (CET)
IronPort-SDR: 636306a4_1ZFC3iqB9+q8IfcdnPrid9uNlvWGuQtHN4y6OelZ2lx130i
 9nKJ2lr1BC8W3DAQEFj+eZyyP81/1nCK1PIdtVA==
X-IPAS-Result: =?us-ascii?q?A0CAAQAdBmNjmEtEKJFQCoEJg1QogVcuBAtFhE6IfoV3g?=
 =?us-ascii?q?iUDnzIBAwENRAQBAYoAAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEARMBAQEBAQEBARQJGQUOEAUihWgNgjUpAYNkAQUjHQEBNwEPCxgCA?=
 =?us-ascii?q?iYCAhBHBoMQgyEGAa0MgTKBAYIIAQEGmjF+CYERLIxXgy16J4IpglGBbj6EF?=
 =?us-ascii?q?4QEgmaMPookOANEHUADCzsyDUsbWA4JHxwOFw0FBhIDIG4FQQ8oL2crHBsHg?=
 =?us-ascii?q?QwqKBUDBAQDAgYTAyICDSkxFAQpEw0rByNxCQIDImUFAwMEKCwDCSEfBxYRJ?=
 =?us-ascii?q?DwHVzoBBAMCECI6BgMJAwIiE0WBJSYFAw0XJQgFTwQIOgIFBlISAgoRAxIPB?=
 =?us-ascii?q?iZIDko+ORYGJ0QBNA8OFgNggXAGNZpDNCxRgweRfiSDG6sxgTUHA4Nng1Gcf?=
 =?us-ascii?q?jKWbJInLZcAokCFN4F5I4FbcIM3TxwPjldvAQiCQ4pfQDQ7AgcLAQEDCYo+A?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:gg36pa1xDUeLAKJYzZ8VGwqjBLUkLtp133Aq2lEZdPU0SKGlfg
 6V7ZcmPDvP+U8ssRAb6La90cy7LU80mqQa3WB8B9aftUzdyROVxeJZnOzfKl/bakjDH4dmvM
 8KGcdD4Z/LfDxHZK3BkWuF+rgboOW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72727570"
X-MGA-submission: =?us-ascii?q?MDGKg6mHEY6WLqmUPdAGsUdiwv+WpDx15kSRFf?=
 =?us-ascii?q?WyazBVOPsFMcPk5QnmlzwARrgoj6jde88Ad+bUx9cHEX6UIelfC74uq2?=
 =?us-ascii?q?4RfF/B3gPTKmuFspTnkSIyvQxMNMmM/1fDi2rYqonAaqANu9v98SK1ve?=
 =?us-ascii?q?2GtroNxuhWbjgnmyUNUwD2+g=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 01:09:08 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E59CCB8257D;
	Thu,  3 Nov 2022 00:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5CBC433C1;
	Thu,  3 Nov 2022 00:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1667434142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ss+0UcaTi7dI1wdBpT9CwV3xqKbtQHsvn2bTvMdYCP0=;
	b=jaKDOqOsj/DStmNwdcX2gNqr1/GhYThy6Bvl8kXjWExekVntgasP+YDqgK4auFtBM4erc/
	3i0K+miw/+Lu6ZjdAF2NH5u2d0z1x2pAPZncc96XLS3Rsbs272vyr4Shokn4+igoBPxkCo
	4g+G7+eHRqxxwRB0LiiBWh3K0YdXlj8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c1601152 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Nov 2022 00:09:02 +0000 (UTC)
Date: Thu, 3 Nov 2022 01:08:53 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
	masahiroy@kernel.org, gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <Y2MGlTwh9aB+4z4l@zx2c4.com>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <Y1iSYddi3BpP8gvf@zx2c4.com>
 <Y1ku+jfRAyezq6Nz@zx2c4.com>
 <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 703
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/Y2MGlTwh9aB%2B4z4l%40zx2c4.com>

On Wed, Nov 02, 2022 at 06:17:04PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 26 Oct 2022, Jason A. Donenfeld wrote:
> 
> > On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> > > The traditional objdump comparison does work, though. It produces a good
> >
> > Another thing that appears to work well is just using Coccinelle
> > scripts. I've had some success just scrolling through the results of:
> >
> >     @@
> >     char c;
> >     expression E;
> >     @@
> >     (
> >     * E > c
> >     |
> >     * E >= c
> >     |
> >     * E < c
> >     |
> >     * E <= c
> >     )
> >
> > That also triggers on explicitly signed chars, and examining those
> > reveals that quite a bit of code in the tree already does do the right
> > thing, which is good.
> >
> > From looking at this and objdump output, it looks like most naked-char
> > usage that isn't for strings is actually already assuming it's unsigned,
> > using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
> > things here and there, but all and all, I don't think this is looking as
> > terrible as I initially feared.
> >
> > I'm CC'ing the Coccinelle people to see if they have any nice ideas on
> > improvements. Specifically, the thing we're trying to identify is:
> >
> >   - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
> >     where:
> 
> Try putting
> 
> disable optional_qualifier
> 
> between the initial @@, to avoid the implicit matching of signed and
> unsigned.

Hmm, this doesn't quite work. Here are my rules:

    @disable optional_qualifier@
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
    
    @disable optional_qualifier@
    char c;
    @@
    * c == -1
    
    @disable optional_qualifier@
    char c;
    @@
    * c = -1

This produces, for example:

diff -u -p ./sound/firewire/bebob/bebob_focusrite.c /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
--- ./sound/firewire/bebob/bebob_focusrite.c
+++ /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
@@ -192,7 +192,6 @@ saffirepro_both_clk_src_get(struct snd_b

        /* In a case that this driver cannot handle the value of register. */
        value &= SAFFIREPRO_CLOCK_SOURCE_SELECT_MASK;
-       if (value >= SAFFIREPRO_CLOCK_SOURCE_COUNT || map[value] < 0) {
                err = -EIO;
                goto end;
        }

Except map is defined as:

    const signed char *map;

So this would be one of those cases that I had hoped `disable
optional_qualifier` would exclude. (I think internally coccinelle might
be assuming `char` is signed, by the way.)

> >   - It's not being used for characters; and
> >   - It's doing something that assumes it is signed, such as various
> >     types of comparisons or decrements.
> 
> I took a quick look at the article, but I'm not completely sure what you
> are getting at here.  Could you give some examples of what you do and
> don't want to find?
> 
> You don't want the case where c is 'x', for some x?

Something I would want to find is `if (c < 0)`. Something I wouldn't
want to find is `if (c < '9')`. IOW, I'm looking for code that assumes
`c` is signed, and would become incorrect if `c` suddenly became
unsigned. Most things involving actual characters are fine. But most
things involving signed arithmetic or comparisons with numbers isn't
find.

Jason
