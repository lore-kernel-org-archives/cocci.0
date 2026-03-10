Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E87BFD2D6A
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9nwSoyBFb/J+scDlmZ8YZ+1mFs6NH+0TsiNWJNlzMqA=;
  b=XxXDbZKp6cOHeEVPHj4NB1NGreTtwW2GZsaV03ObzeNA1cfWDxGSUPAm
   t8jh7Pt2sJ2bPWXJFj54VPNQNiLkJgqdesns1pE62IJGSiiIX2glljtE3
   5QKqhPD6jZfWNfkkphm84DcZVGwZqSZ2C/RpZLp4mwqcZekSL6eapeZgW
   w=;
X-CSE-ConnectionGUID: HbyroggcT5ijg2b2xO+0Wg==
X-CSE-MsgGUID: 1XhxWgAzRTGRdvhufhgkeQ==
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
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267090165"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 13:46:10 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5CD4C833D5; Tue, 10 Mar 2026 13:46:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1E22E833B7
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 13:43:35 +0100 (CET)
X-CSE-ConnectionGUID: U3yih4UnThSHiM+3i/U/ew==
X-CSE-MsgGUID: or340wNbRDKL0BK/hesY5Q==
IronPort-SDR: 69b011f8_eymn9XE3IINeueGTBDupdOlUxrQm50gIXEZFDfYmNR90GsV
 3CQqfHpEyhD1JbqDVHGLnABFT/ETY8x0xlS73bA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G/AgAHEbBphQfJy7lagQmDPlOBZzIEC4UhiHuIeQMwn?=
 =?us-ascii?q?BWBaYFrDwEDAQ1PAgQBAYFSAYM0Ao0hAh4HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhlyCW4QIAQEBAyNmCw4KAgImA?=
 =?us-ascii?q?gJWBgGDFIJ0BAOtQIEygQGEfdlBgXAVGXEuiFQBgXCDaho7hD+CC0SBFYMqP?=
 =?us-ascii?q?oQqg3SCaQSCIoEOiQqKFglJeBwDWSwBVRMXCwcFgSMQMwMgCi8tAhQNEBIPB?=
 =?us-ascii?q?BYFLR1wDCcSDx0XFB9YGwcFEiEqgUl4gWYbD4ZqeQMuXhoOIgI6A1lKPgtaB?=
 =?us-ascii?q?YI/AwttPTcGDhuSHAJ6gw1IxhgHgjiBZ6Ilg3EBk26TCy6HZZBzIqQAhR+Bf?=
 =?us-ascii?q?yOBXDMaJIM3TgMZD446kyS5VUNwAgcLAQEDCYVDJhMLAYwWgUsBAQ?=
IronPort-PHdr: A9a23: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
 x6yI0xfpFiIzZ+J/KWVuPXQaRrBi7QJCPCCew==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CPrDu6NwVM5kksBcTiKjsMiBIKoaSvp037BN7TEUdfU1SL38qy
 nAppQmPHPP5gr5HUtQ+uxoW5PwJ080l6QY3WB5B97LN2OKhILrFvAB0WKI+VLd8kPFl9K1mZ
 0QFJRWOZnIMGk/q9377gm+G9Nl+9WM8LmpieDCpk0dNz1CWuVbx0NUGwaeVmdxQw5LD4d8NK
 P03Ls/mxOQPU4+KuirBn1Ae+DCopnlj5TjCCR2fyIP2U21pXeF+b7/VyKT1hAYXz4n+8ZYzV
 T4
X-Talos-CUID: 9a23:GYRlmG7r0K/O1hlKxdssyRUFG8B5T3vhzEzwImr7UmcudfqYVgrF
X-Talos-MUID: 9a23:05X+3wRW0tBrkpyrRXTrnmo+bNhO6Z6CK2RVu7ZBu8SfBHFJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267089442"
X-MGA-submission: =?us-ascii?q?MDF4B+EZML0lO7PYE7xzU5MwyAKJL2AxER8Mps?=
 =?us-ascii?q?Xq5w8A92w4SOnSXuVF25tL9t3KtquZqQFLUkMR6Bv7DsUZY3d39QH2N3?=
 =?us-ascii?q?itdlN1ZUPJAj27gpPdZ5GyGUIoUU+ESQ2IjPnKd1YX01mUQJFJcmRRxl?=
 =?us-ascii?q?Dba3U4A7iNtpGB5J/JbhzORA=3D=3D?=
Received: from metis.whiteo.stw.pengutronix.de ([185.203.201.7])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:43:34 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vzwQv-0006Oq-0m; Tue, 10 Mar 2026 13:43:33 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vzwQr-004hMj-0z;
	Tue, 10 Mar 2026 13:43:30 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vzwQs-0000000081v-2556;
	Tue, 10 Mar 2026 13:43:30 +0100
Message-ID: <ddaacda48df23fb2c009a8727518300ed2b82cb2.camel@pengutronix.de>
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Date: Tue, 10 Mar 2026 13:43:30 +0100
In-Reply-To: <20260310-b4-is_err_or_null-v1-57-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-57-bd63b656022d@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 57/61] reset: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Philipp Zabel <p.zabel@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 3373
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/c0DDaEN0nL5CmwFSgpeNww>

Hi Philipp,

On Di, 2026-03-10 at 12:49 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!

No, rstc =3D=3D NULL is valid (for optional reset controls) and must not
throw a warning.


regards
Philipp
