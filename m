Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E679606A326
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=dZfgaSXm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=beO2IvzlcTEkpr9TyrCexf/bT5TFy8E4Cm3PHz55W9A=;
  b=dZfgaSXmgXaiEwG5mfNB/z4u8SFm5K7iUasI2okf1zZuvSWpEinQvDAt
   3fB7qs7k2F29Namw6Na1DMWwE2Xj6k94MHBadQfwI//ARiQpGDwua+Z3w
   snwIi9YGhvm0Ly2p0P8OhjWreHHoC5V6PRPb1BDAup8SHraYC+fKVshFI
   s=;
X-CSE-ConnectionGUID: PtxemYJLSvaf9A00KMU44Q==
X-CSE-MsgGUID: 7MZvemN7TUecFmsSidyLkA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323492"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:23 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CD612819E3; Sat,  7 Nov 2026 11:59:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EFE1380E3D
	for <cocci@sympa.inria.fr>; Tue,  3 Nov 2026 02:47:34 +0100 (CET)
X-CSE-ConnectionGUID: 9DuhBTWEQfCcG/VBxX159w==
X-CSE-MsgGUID: yaE3VnL3QJ6Hu1wHEiGEzA==
IronPort-SDR: 6ae93d35_z2kAn9Wu+YH+7g/SWSFqXMKpPkOM9YV2LTg+jBkV0Jn1Xk0
 gfh1CDeq8arhJeBXaCglASw9U2Q6gCQSnmrADsg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GsAgAAO+lqhR/86qxaglkCgj+BC2EzBAtJjVKGWYIkk?=
 =?us-ascii?q?lCFboddAg8BAwENSgcEAQEBAgSEfgKOHQIeBwEEMwYOAQIEAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQFASYZPDUkBiUgBggcBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDX4BAQEDOgYBATcBDwsYLlYGE4MCAYIiB0sDEbxEg?=
 =?us-ascii?q?TSBAYIMAQEG3DWBawMGFYE4hXKCbQGJfHonG4INhEA+gkMeBBiFXIIwgiaBD?=
 =?us-ascii?q?JcSUngcA1ksAUsKExcLBwUzLUVDA4EGI0sFLQoTUhI/IR0PCBEeOQIdGwYFE?=
 =?us-ascii?q?iARGUFDW0ROgQddcDsoXQECH0YtFYF2AoJRgSMHVgIBSUEOB0VTCSVDEkckI?=
 =?us-ascii?q?ggSCQETGiwKgRo1PAkmPxUMDE8LCxoFGkcIAgsCDHQoERATHR4kLwUcJkAQb?=
 =?us-ascii?q?T03FRkEk0CESIF9NaVwoQ+EKYFnijyWBxOBOII5jRSGO5MdLodmkHSOCpVbh?=
 =?us-ascii?q?V+BfiSBXDMaCCgIgyJQAxkPji4NCYhzyUgjNQIBOgIHAgcOAwuHTIpQgUwBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 R0FxfX/N4tBbuUTNGRhZ0N8kYCMHFDfD4klnw==
IronPort-Data: A9a23:1uhvsa+6KwX3nlhyFz5SDrUDu3qTJUtcMsCJ2f8bNWPcYEJGY0x3x
 mIZCmDVOf+OY2PxKIh0YdjnpxsFuZfVm9UwQAU9qXoxFiIbosfsO4ilIxarNUt+DOWTFRM9t
 512hvrodZ1vECeE/n9BFpC78BGQAInRHuKU5NbsY343HUk4Dnx503qPosZh6qZwm9+1HgiRj
 t37pszbKTeN1iV9Wo4uw/vrRChH4rKo51v0gnRkPaoV5QaGzSFPZH4iDfjZw0XQEtE88tGSH
 L6rIIGRpgvx4xorA9W5pbf3GmViaqLSJwWHlk1NUKGkhBVYzgRqukrsHKd0he9/0l1lrvgpo
 Dl/ncXYpTQBZ8UgrN8gvyxwT0mSC4UWoe6deSDXXfu7lCUqe1O0qxln4dpf0Ycwoo6bCkkXn
 RAUxaxkgrluSItazZriItSAiPjPI+G6EJ4fkE1f4AjXJv0JBq7pU5WTuI5HiWJYasBmRZ4yZ
 uICZDMpdxPdeRZCfFQaEpQzmKGvnHaXnz9w8Q3P4/Bsvy6JkVY3i+GF3Nn9IrRmQe1Wk0uDj
 mHL5WL0BlcdLtP3JT+tqyz127KexXKqMG4UPKyx26VUhnnI/05NKABPSnuWoNaUmGfrDrqzL
 GRPpnVy/PlpnKCxdfH2WBazoVafrxsEUpxRFfc74UeD0ML85w+GD2wAZixAbdY8vYk3QyYr3
 xmHhbvU6SdHq7CcD2ma662foHWxNDITIGtEYjULJecY3zX9iNAfkxLlculOKaCehfKyJxvg8
 2nX/Tdr0t3/kvU3O7OHEUcrag9AS7DSQwdz/QLKRGmoqAB0foioY8qv81ezARd8wGSxEQXpU
 JsswZP2AAUy4XelyHzlrAIlQOzB2hp9GGeA6WOD5rF4n9hXx5JcQWygyGoiexs4Y51slc7Ba
 UzavApQrINeN3usaqtwbIO8EIwry6OmfenYugTvRoMWOPBZLVbXlAkwPhT49z62zyARfVQXY
 szznTCEVi1CUfwPIfvfb7t17ILHMQhkmj6LFcigkkz7uVdcDVbMIYo43JK1RrhRxMu5TM/9q
 r6z7uPbmkkNY/60eSTN748YIHYDKHVxV9i8qNVaeqTHakBqEX0oQa2Zi74wWZ1Xr4IMnMfx/
 1a5RhB5znj7jib5MgmkUC1oR47uepddlkgFGxIQE2ym4FUZWrb33pwjL8M2WZIF6N1cyeVFS
 qhZWseYXdVKZDf12xUcSpjftr5dSgaSqh6KNC/4ZDIUIoBrQgfI3vTGfQLf0jYEIQTqlMk5o
 ob66AfQULAvTV4zFufQMOmOyXHot1cjuetCZWn6CfgNR1fNqa9EczfQiN0zKOEycSTz/COQj
 VuqME1JtNvzrJ8Q2/iXo6K99qOCMfZ0R2heFEnltYeGDzHQpDef8NURQdSzXG7vUU3v8/+ff
 sRT9fb3NcMHkHtss4ZRF7VKz7o01+Dwpo11nxhVI3HWU2uFUr9QAGGK/c1qhJ1/wrV0vQiXW
 EXW3vJ4Pb6PGt3uEX9PBQ4DQ9mA68opmWjp3axoGHn52S55x6rYcENwOxLXtjdRAoEoO6wYw
 MAgmvUs1SqBtjQQPOy70x9kr1a3EiRYUoEMlI0rP4vwuw96lnBAecP9DwH10rGuavJNEFMYH
 QGGvYXeg79Zm07IWCctHn3G3M52p5cHiDZVxnAsenWLndvkgKcs/RtzqD4YcCVc/i9l4clSZ
 Fd5FhRSC/2V3jFKgMNjYTidKztZDkfExn2rmko7qmLJamKJCErPFTQZEsSQ9hk792l8QGBqz
 IuAwjy4bQewLdDD5Qpsa0tLsPe5cMdQ8DfFk8WZH8ioOZk2TD7mo622b1oztBrVLpIttXLDu
 NVV0r58WY/jOQ4Uhp8LOY2Q+LATaRKDfUhpY/Vq+oEXFmD9JhC2/xWzKH6KR8AcHMySrHeEC
 PFvKPlfCDW49iKF9Q4ACYA2frRbof8O5fg5QI3NG1IoibWkgwRMjIPx7Qn73W8ifMVvm50yK
 6TXbDOzLVaTjnp1xU7Lis11ATeqa4I6dTym4f28qtsYHZc9q8VpIFAAw5qvnnCvKAA81Qmlj
 ADCQK73zuJZ1oVnmbX3IJhDHwmZLdDSVvyC1QKO7+R1ctLENPnRuzMvqlXIOxpcOZ0TUY9Vk
 YuhncHW3kSfmpoLSEHcxoe8EpdW6fWIXOZ4Ntz9KF9Yl3CgXO7u+x4yxHCqG6dWkd9y5tiVe
 CXgUZGeLeUqYtZ6wGFZTwN8EBxHUqT+UfrGlBOH9v+JDkAQ7BzDINaZ7kTWVGB8dBITGpjAG
 wTx6ueP5NdZkdx2PyU6JcpaWr12HFyyfpEdVYzBhWHNRC3gyFaPoaDrmhcc+CnGQCvMWtrz5
 ZXeAAPyblKusaXP18tUqJF2ogZRNntmnO0sZQgIzraaUdxh4LIudozx8KnqC624VgTp2Zi+f
 zbQdmAvTybwRzJJdVP7+tuLssJzwAAREo+RG9Dr1xr8h+SK6EeoA7Z78CpkpXBsdVMPCcm5f
 MoG9CSY0geZm/lUqCV62hB/qeRq3PXXwjQP40+VfwkexfoBKe1i6UGN1zahmcAK/w8hWakLy
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:yNHdIq0Vqr+jVkl7Eu1W3QqjBIIkLtp133Aq2lEZdPU1SL3gqy
 nKpp8mPHDP6Qr4JBob6LK90cW7LU80jKQFgrX5ZI3DYOCEghrPEGgd1+bfKlTbckXDH4Zmv5
 uIGJIRNDSfNzdHZInBkWyF+01K+qjizEgz7t2uqEtQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AXXU8QmobrgTPFtGKWLfZtR/mUZEJb3338Ej9GkG?=
 =?us-ascii?q?TAkkudpeFeQbNqbwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AVQ0x6w3WGM+OqAg3eb0C84c0GjUj8q2DU34Ltc4?=
 =?us-ascii?q?/mZekKHVvGxqcoxmla9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,192,1787004000"; 
   d="scan'208";a="161559099"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFhuitVZyhi7+0F9pdpKslYheAblUiU1YpwXh?=
 =?us-ascii?q?GZgp4EVP8Semh9AwNOhqLQrRwQvmmKTGiJ4Y33AkKGGmEKyXWTwUpkeU?=
 =?us-ascii?q?3CsIAZSzm6i0bf4JIm4fF56tcYbGQCODtcdp0YMGugwqpFynRKkc72br?=
 =?us-ascii?q?C89DSzRl6TzOloAC+K1mWhaA=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:47:33 +0100
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D83B340AD6;
	Tue,  3 Nov 2026 01:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5EE1F00919;
	Tue,  3 Nov 2026 01:47:30 +0000 (UTC)
Date: Mon, 2 Nov 2026 17:47:30 -0800
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Joe Perches <joe@perches.com>, Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	driver-core@lists.linux.dev, Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Message-ID: <202611021747.3BD1EB4D@keescook>
References: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com>
 <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr>
 <E7A57F75-AB90-4B41-B942-55D65F2B65D8@kernel.org>
 <c47392bc-e522-19b6-a653-1e85b44cefba@inria.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47392bc-e522-19b6-a653-1e85b44cefba@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs
 conversion script
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3775
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/rwEgomJqIEc-bxZ7KNSi2Q>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 10:09:21AM +0100, Julia Lawall wrote:
> On Mon, 2 Nov 2026, Kees Cook wrote:
> > On November 1, 2026 3:51:53 PM PST, Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >On Sun, 1 Nov 2026, Joe Perches wrote:
> > >
> > >> Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script")
> > >> with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KERNEL arg")
> > >>
> > >> Finds and converts sized devm_kmalloc-family of allocations into the typed
> > >> devm_kmalloc_obj-family of allocations.
> > >
> > >Applied
> >
> > Please don't send this. I already did this. See the PR I sent for rc1:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-linus/v7.4-rc1/devm_kmalloc_obj
> 
> Too late.

I don't want the rules duplicated, though. It should be a single set...

-- 
Kees Cook
