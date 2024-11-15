Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73971D68BEB
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ocF2UaqffllWgiGWdH3dEXBRLSQ8zx6v3UTSvYUEWBM=;
  b=iKfIUW7N8sPLZVke7LUmIHuvFl2ed8HDAhypmLUn6XcL61iWKd5U0KBo
   RxlbvMq2ToN8/djDhGnFj4YQV7ycgvz6BX5UWYu8mbVwHcsMKdatHijWG
   fzuIEMT1cpNRhUGp5XjjzH5o7VrgV5KJkLQuo5Qtp0wk4gmw2zhLOw63i
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linutronix.de
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204527"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4FBA9E0D67; Sat, 16 Nov 2024 12:26:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1367BE00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 00:20:47 +0100 (CET)
IronPort-SDR: 6737d74e_1AkN+JS6ci/nSwC67gX5uix3eYR/00cnFgemWggnTwKC49M
 9deJtX/7iZtUOL7pfarfYFtWwI0Tqm7om4QMoRQ==
X-IPAS-Result: =?us-ascii?q?A0FVAAAV1zdnhTcrjsFaHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?gQBAQsBgkOBVjQEC0iUI4IkEYtihluJcoNUDwEDAQ1BAQIEAQEDAQOFAAKKS?=
 =?us-ascii?q?wIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQ?=
 =?us-ascii?q?EmFew2CYgEzghYsDX0BAQEBAgFAAQE3AQQLCw4KCRMSDwFGBgGDE4JCIwexW?=
 =?us-ascii?q?YIsgQGCDAEBBtwfgWQJgUgBiEsBhWkbIINCeicbfYEQhD8+iweCRS2EZiVNi?=
 =?us-ascii?q?DKaEVJ7HANZIREBSwoTFwsHBThxISwDgXtOf4E2gVEBQYIESkqDLoFeBTcKP?=
 =?us-ascii?q?4JKaUs3Ag0CNoIPFV4fgk+FGoELg2FnLwMDAwOCI4EZgWuCFR1AAwttPTUUG?=
 =?us-ascii?q?wahDIUPZYFwlhABjFWjIYI/gWWiEBOXO5MALodkkGUiqQWBfSSBXE0kFIMiT?=
 =?us-ascii?q?wMZD44hGYQUxUlFMjsCBwsBAQMJhUYBAYoPgUsBAQ?=
IronPort-PHdr: A9a23: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
 nO6kw==
IronPort-Data: A9a23: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
 vRALZTz6IRp5X29AIGr9Dg=
IronPort-HdrOrdr: A9a23:KAmAwKF1a35YF4eYpLqE/8eALOsnbusQ8zAXPo5KJiC9E/bo8/
 xG+c5wuCMc5wxhO03I9erqBEDEexLhHP1OkOws1NWZLWvbUQKTRelfBMnZowEIcBeRygcy78
 tdT5Q=
X-Talos-CUID: 9a23:OAi4rGz6sy/tA9IztSVZBgVERp0CKCbhj03LAGi7UEdHaIKKR3a5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AGaihhw8KwYkMW1bmtvUEspCQf8Vr4Zb+Il8Hqp4?=
 =?us-ascii?q?fmOuOOA9KAiWxlB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194172323"
X-MGA-submission: =?us-ascii?q?MDFhs1njCn+Wlzx4Q4Gf+6r5nK7ZTvnyJsn9zh?=
 =?us-ascii?q?qsrvd0xfxUbZxiNtiCcEjB1fWGGEfb+378xqf6LGLNxmQgKJRkjNK4bA?=
 =?us-ascii?q?DRM/gxggajJtDpSfHC6dYwyGcRgt7gVFbJ/mzVyBITC3jw659fW78QUr?=
 =?us-ascii?q?/VUxvEXHxH6ZLf7bkTrUiSyg=3D=3D?=
Received: from galois.linutronix.de ([193.142.43.55])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 00:20:46 +0100
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731712844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocF2UaqffllWgiGWdH3dEXBRLSQ8zx6v3UTSvYUEWBM=;
	b=rxecPtMj8SFS1ScmARhLmyTl2vQ/a67nGr99wU1k14aHFyfyXzur8xA8clL0cWb4PcNRcq
	+sYoP5fpTr+y7DWR/q6WJrAYAEOeZ7/gwoP0DaAJL7AtzoWMFfBIjSP684idD4sEp8YP3R
	d2yZdOPuA5jiajWYtbJzUl/D+fTiEAFzfMjQ1aUtJ6sXDWrHC8g6x3qDDDviOMd7PoQxyB
	FuhbpZgFXXnx5u2iujt++63vLqS4pHXJOdpVMcZMr3jFjq1eCMNKGNRgvHfWdMAILNCjSR
	XSZAEEr53uoRdfQKKO8dT7kvmHnPPzOyjLc5f+BvgUFM6BQEiPyiwmOFczQTXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731712844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocF2UaqffllWgiGWdH3dEXBRLSQ8zx6v3UTSvYUEWBM=;
	b=fiO2WA00o2QkwsyNJnAD2pKkCCi6P8G8G+oRGwZulr/mmPMjPpZ4aXQHkTU9J/RoBhyhLz
	qJLqDSLijDi1gcAA==
To: Easwar Hariharan <eahariha@linux.microsoft.com>, Jeff Johnson
 <quic_jjohnson@quicinc.com>
Cc: eahariha@linux.microsoft.com, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cocci@inria.fr,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-mm@kvack.org,
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org,
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org,
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com,
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Naveen N Rao <naveen@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Louis Peens <louis.peens@corigine.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Russell King <linux+etnaviv@armlinux.org.uk>, Lucas Stach
 <l.stach@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela
 <perex@perex.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
 <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Jiri Kosina
 <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Ilya Dryomov
 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, Jens
 Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>, Jack
 Wang <jinpu.wang@cloud.ionos.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, James
 Smart <james.smart@broadcom.com>, Dick Kennedy
 <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Jeroen de Borst <jeroendb@google.com>, Shailend Chand
 <shailend@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>, Ofir Bitton
 <obitton@habana.ai>, Sven Schnelle <svens@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Russell King <linux@armlinux.org.uk>, Robert
 Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Nicolas Palix
 <nicolas.palix@imag.fr>, Julia Lawall <Julia.Lawall@inria.fr>, Simon
 Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, Pablo
 Neira Ayuso <pablo@netfilter.org>
In-Reply-To: <8127a2e6-fa62-4c85-b7ed-24748cc9e285@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <10ee4e8f-d8b4-4502-a5e2-0657802aeb11@linux.microsoft.com>
 <3ac480f5-549b-4449-baa9-f766e074c409@quicinc.com>
 <8127a2e6-fa62-4c85-b7ed-24748cc9e285@linux.microsoft.com>
Date: Sat, 16 Nov 2024 00:20:50 +0100
Message-ID: <87plmwytgt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Thomas Gleixner <tglx@linutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 2059
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/87plmwytgt.ffs%40tglx>

On Fri, Nov 15 2024 at 14:15, Easwar Hariharan wrote:
> On 11/15/2024 1:41 PM, Jeff Johnson wrote:
>> 
>> How do you expect this series to land since it overlaps a large number of
>> maintainer trees? Do you have a maintainer who has volunteered to take the
>> series and the maintainers should just ack? Or do you want the maintainers to
>> take the individual patches that are applicable to them?
>> 
>> /jeff
>
> I am hoping for tglx to take it through his tree since the patch
> introducing secs_to_jiffies() is in his tree, so sequencing of
> dependencies would not be an issue.

Right, but it's two days before the merge window opens, so no.

> But if tglx won't, we could push it out another cycle and individual
> maintainers can take the patches that are applicable to their tree for
> the series.

That's the easiest way forward as it does not create conflicts and all
maintainers will have the base patch in their trees after rc1.

Thanks,

        tglx
