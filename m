Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA6DCDE000
	for <cocci@archiver.kernel.org>; Thu, 25 Jun 2026 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IjzRTUg0P1xFQaaPY7JYjypT5FZoUnsWKjqlEagzae8=;
  b=KqEoC3qODQ/vBm8oWRfD87jsZj2xFQ7lxjLzFlNcpgoyH4ECAyVli5tl
   0l3CkscX4uNLiA0R/hvRKeoNyfqT9dwRIfht+naqzgWWMPNb8aMdYhK6/
   zeu/7nCiNu5tDBzbk2MfnkP4xd5+8lBL0Ypzn95OCneYA2oJWuny2Mm/G
   Q=;
X-CSE-ConnectionGUID: dTVppduAS860eLpkuM8lSg==
X-CSE-MsgGUID: lbugGPBKQnazwa25kY/lXQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,224,1774306800"; 
   d="scan'208";a="283379921"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2026 14:26:57 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CF1D681EA1; Thu, 25 Jun 2026 14:26:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8972A81C58
	for <cocci@sympa.inria.fr>; Wed, 24 Jun 2026 19:52:18 +0200 (CEST)
X-CSE-ConnectionGUID: ZD8s4yfYQWaZ1L8khnNZQA==
X-CSE-MsgGUID: 7g2SlswIQHOPQMBUTCcAqQ==
IronPort-SDR: 6a3c1952_pio+LHDykg+939LLNBbtqO0nuu+aqzyXaJEQoj+bTo9iPJx
 FA0IsNue1Ln9OtIxOUKXVkwld9pq6w+e7+7FeCw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FpAgC+FzxqexEsKNhahRqBaDQHCIUhiHuIfJg9h1wPA?=
 =?us-ascii?q?QMBDVEEAQEBhQUCjUwgBgEENBMBAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBA?=
 =?us-ascii?q?gEBAgQDAQEBAQIQAQFCDjuGXIJiAYQAAQEBAyNWEAsYAgImAgJWBoYJAwW4E?=
 =?us-ascii?q?YEygQGEftlFgXIVgQouhXGCagGBcIkCQj+BToRAPoRDg1uCagSDLpEDCUl4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0PCBYeWBsHBRIgKkFFIwMCKFk/O?=
 =?us-ascii?q?AtDBYFcAoIOTiMfAzl/gUCBJGRmFTA1gQEBER4KbEMDC209NxQbBJBvPlKCK?=
 =?us-ascii?q?KYloQ+EJ4FmoEKqbC6HZpB0o2SFXgGBfiOBXE0jFYMjTwMZD+AbJ28CBwIHD?=
 =?us-ascii?q?gMLkhyBSwEB?=
IronPort-PHdr: A9a23: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
 56rtG5N1w9mZd8xY6fXIfgQpmU=
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:CjWYjKEOXNXvWg6cpLqE+8eALOsnbusQ8zAXPiFKOH5om6mj/P
 xG885rsSMc5AxxZJhCo6HiBED/ewK4yXcd2+B4V9qftW/d2FdAR7sM0WKN+VHd8lXFmNJg6Q
 ==
X-Talos-CUID: 9a23:KZfYs2B3oG7HIS76ExtLpFVIC84US0LU/i70c0y4D0BbcZTAHA==
X-Talos-MUID: 9a23:eO1OFAXCTiibFnrq/GDj3gpmL9hJ2oSJMHkou6g6kMKtLBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,222,1774306800"; 
   d="scan'208";a="150361115"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGoHoa3EjKCIexThifRC9rC/bXYwn6A33OmS1?=
 =?us-ascii?q?p7ByE+BBw9OV8ApKuBbEXzsD03S1V/y1Xc6yiESPgFndQVuqhPVU/oZy?=
 =?us-ascii?q?ZsA+fw0L6ewsJgCNXIDwa+komR+qou2OUHDgO4Yjtxb6NM/BwulrC3io?=
 =?us-ascii?q?LCmFf4AEEA7GlYlsM8r/vpZQ=3D=3D?=
Received: from smtprelay0017.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 19:52:18 +0200
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 59CB98DD74;
	Wed, 24 Jun 2026 17:52:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 16BA32002F;
	Wed, 24 Jun 2026 17:52:12 +0000 (UTC)
Message-ID: <a1f52c93e39c5bb66ab6cbb4ae778513ea6b3c9c.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Kees
 Cook <kees@kernel.org>, driver-core@lists.linux.dev, Nicolas Palix
 <nicolas.palix@imag.fr>, 	cocci@inria.fr
Date: Wed, 24 Jun 2026 10:52:12 -0700
In-Reply-To: <dc6cfcc-4ec4-8b87-19c3-974818448b8c@inria.fr>
References: 
	<eed0c57a2c897e34d411229c3de41c5402791894.1781575297.git.joe@perches.com>
		 <50755b746bb30bea3989db9c1f262d5257e8ee1e.camel@perches.com>
	 <dc6cfcc-4ec4-8b87-19c3-974818448b8c@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 16BA32002F
X-Stat-Signature: n7aqfjrp57rsuqppezkyz87tggre9nyz
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TAHcngrvTA1oeAB1bRg0ISyqcUTeffx4=
X-HE-Tag: 1782323532-769865
X-HE-Meta: U2FsdGVkX18VaSv3AagFJuYcb4tt/d+jcmeWDJy+uZaDYsQocT/f5nm2fNbPEknhh/tVwBd9k2WYGJ4aTdPOT1bmTmXb651QSXW6rjcgSpdMTeAXCyhkm1YMPLzXk3BzJXTTRc9vgfyr2kar+ZVBXghHzQKRMUjk9DF/cR0mPaRqgA+MLDW2HrbRr48lWcOKAPhS90rfD6N/scNKlRpxaUUWDw4/frw/3EByjZGsSfkOXY8l1keAMfWZMFGgZNQYOsurWnRLLdWTcfDplhIhVM2qEFB+uZVKWWpsu8it31/sLjz+NSgxeVSF0cYqtfsn
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: Add devm_kmalloc_objs conversion
 script
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 3589
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/q4osp1Q5J0m2VNUbWS1Auw>

On Wed, 2026-06-24 at 19:25 +0200, Julia Lawall wrote:
> On Wed, 24 Jun 2026, Joe Perches wrote:
> > On Mon, 2026-06-15 at 19:10 -0700, Joe Perches wrote:
> > > Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion sc=
ript")
> > > with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GF=
P_KERNEL arg")
> > >=20
> > > Finds and converts sized devm_kmalloc-family of allocations into the =
typed
> > > devm_kmalloc_obj-family of allocations.
> >=20
> > Its been a bit.
> > Any comments or negatives about using or running this script?
> >=20
> > This script would change more than 8000 instances in more than
> > 5000 files in Linus' current master.
>=20
> I was going to try it this evening.  Are you concerned that it is too
> much?

Not really.
There were no comments and it might have been overlooked.
