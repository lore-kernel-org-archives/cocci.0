Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2527105F793
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VQ4I1//oujMg/wMbvtHZ1fNg62i5rEhIWcPKRohhj4U=;
  b=Py1IZa05OoSUzosCDubJ054tVyoDnEOkE07KNBPct+UDtWrRZBIupwxB
   4mQUW6MTuDsPnwk4L/xPaMfI7PtHlexmlhRZ2I2D3dA9aXg79NBdsUt6q
   UYH0rpvttzFojdYgmFXpgqM830TrEwLVEw8QbMWkyg+2kpxchS/RqakKn
   k=;
X-CSE-ConnectionGUID: 5XEGmzSYT52JQWlhnrnuRg==
X-CSE-MsgGUID: 3ue2bGG2TSei5iQ1n6kCNw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267642960"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 11:19:52 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 489ED81D0F; Fri, 13 Mar 2026 11:19:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0A00281A5B
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 20:33:48 +0100 (CET)
X-CSE-ConnectionGUID: DCQMziwKQPuixtqv+CJjKQ==
X-CSE-MsgGUID: +Yq1heyCRv+5N1jt6ioRfg==
IronPort-SDR: 69b3151a_KoFpMU8qbNYTRsFIj5z1DC1mzmRVZkrmbJPZohgpVGIL1rj
 w7mZf+Cgc0A69fZG1/+7C4Q30weZHOStnGSdqpA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GQAwCJFLNp/5iny3RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VCCQYFnMgQLSR0BAYQ5iHuJDaAIDwEDAQ1OAQIEAQGFBwKNJB8JAzQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAoEKE4ZcgmIBhAACAQMjB?=
 =?us-ascii?q?FIQAgEIDgwCDRkCAlYCBBOFdgIFsQt/M4EB3j6BcBWBCi6Fb4JlAYVaGhuEX?=
 =?us-ascii?q?0KCDYEVMoJ4PoQhAQGDe4JpBIIigQ6TJUgKeBwDWSwBVRMNCgsHBYEjQwM1E?=
 =?us-ascii?q?ioVI0sFLR2BIyEdFxQfWBsHBRIhKoFEeIIBD4ZoeQMuXhoOIgI5XEo+C1IFg?=
 =?us-ascii?q?i0CIAMLGA1IESw3FBsEPm4HjXM9gjWCEZg3sB+CP4FngWSgEi+BS4ImARKNE?=
 =?us-ascii?q?4ZHkw0uh2WQc6lBJYEePCaBWYEFgyJPAxcCD9sYQzQ8AgcBCgEBAwmFRgEBI?=
 =?us-ascii?q?Yw1LgGBHAEB?=
IronPort-PHdr: A9a23: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
 W7Jstd05Vi6wLHnItVPVh1C7D9X1tzjgA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:di4TRazJ0RAUJQlPO2wvKrPwG71zdoMgy1knxilNoNJuA6+lfq
 eV7YwmPH7P+U8ssR4b9+xoVJPgfZqYz+8R3WBzB8bFYOCFghrLEGgK1+KLqFeMd0LDH6xmpM
 NdmsNFebrN5C1B/LrHCX6DYqsdKbe8kJxA/d2utUuFGjsaEJ1d0w==
X-Talos-CUID: 9a23:H8nmP2y4t8zWEL8LXZjPBgU4MfkAYHzC707oPk6oFX93C5a3S3yprfY=
X-Talos-MUID: 9a23:c07cFAVnb8rZwy7q/HzdnWhiOdZD2brtVWZUk4lYus6+OyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208";a="141191581"
X-MGA-submission: =?us-ascii?q?MDGe3VbxUGC1ROsoJX8LfQVSfflXJdqumqAo+V?=
 =?us-ascii?q?5BniZg1riXMUEUXbWPROQZEx2W2euEOTdAUSmf1VZlj5eNxvSYfPrKnF?=
 =?us-ascii?q?G5H04nCU4+4iF3IuSv0MD279AT3xks32VBw/806j3Nhj2dhvXyPuZ6lW?=
 =?us-ascii?q?i85wSMezPTY2SCV5/a8knM7g=3D=3D?=
Received: from mailout.nod.at (HELO lithops.sigma-star.at) ([116.203.167.152])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 20:33:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4DE582C14A8;
	Thu, 12 Mar 2026 20:33:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yCwNT8mwVvHB; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8A34D2C14AA;
	Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3HN7guaAFMsE; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ABF4A2C14A6;
	Thu, 12 Mar 2026 20:33:42 +0100 (CET)
Date: Thu, 12 Mar 2026 20:33:42 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>, 
	apparmor <apparmor@lists.ubuntu.com>, bpf <bpf@vger.kernel.org>, 
	ceph-devel <ceph-devel@vger.kernel.org>, cocci <cocci@inria.fr>, 
	dm-devel@lists.linux.dev, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, 
	gfs2 <gfs2@lists.linux.dev>, 
	intel-gfx <intel-gfx@lists.freedesktop.org>, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, 
	linux-bluetooth@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-cifs <linux-cifs@vger.kernel.org>, linux-clk@vger.kernel.org, 
	linux-erofs <linux-erofs@lists.ozlabs.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-gpio@vger.kernel.org, 
	linux-hyperv <linux-hyperv@vger.kernel.org>, 
	linux-input@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-leds@vger.kernel.org, 
	linux-media <linux-media@vger.kernel.org>, 
	linux-mips <linux-mips@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	linux-omap <linux-omap@vger.kernel.org>, 
	linux-phy@lists.infradead.org, linux-pm <linux-pm@vger.kernel.org>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	linux-scsi <linux-scsi@vger.kernel.org>, linux-sctp@vger.kernel.org, 
	LSM <linux-security-module@vger.kernel.org>, 
	linux-sh <linux-sh@vger.kernel.org>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-usb@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, ntfs3 <ntfs3@lists.linux.dev>, 
	samba-technical <samba-technical@lists.samba.org>, 
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, v9fs <v9fs@lists.linux.dev>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1584421372.26258.1773344022512.JavaMail.zimbra@nod.at>
In-Reply-To: <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF148 (Linux)/8.8.12_GA_3809)
Thread-Topic: Prefer IS_ERR_OR_NULL over manual NULL check
Thread-Index: 0l8CyewQmrWlgaG6N3QgQFfukutRbA==
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 48/61] mtd: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Richard Weinberger <richard@nod.at>
X-Loop: cocci@inria.fr
X-Sequence: 3423
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/icwM7qX7C282epk0LpK1pg>

----- Urspr=C3=BCngliche Mail -----
> Von: "Philipp Hahn" <phahn-oss@avm.de>
> -=09if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +=09if (!IS_ERR_OR_NULL(gpiomtd->nwp))

No, please don't.

This makes reading the code not easier.

Thanks,
//richard
