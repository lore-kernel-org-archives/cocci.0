Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE0FD2D95
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:message-id:date:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BJ66tlRJGWcr6zQKUuqut9b4VgLqQ75FULJQ++XQI3c=;
  b=s0xEoHHGz/6LF6jJlT/YA7epkmd6z8tKADQV4zruUWb0xXHIfIiloouJ
   oEJrXAsk4uP4NhbnUB2tihIIMS++Rn/f+LcFWeCqOx8Mxcn+PApYIiN2S
   DKorOIQPKOTnyaZfUpTJQD5/t6xn0XGe6kkLTkFH4Ned9N0dO+L0St4xR
   A=;
X-CSE-ConnectionGUID: H2WoXsxvThCtgnTEJVjgFg==
X-CSE-MsgGUID: AWIEoWh7T62X6K8xp5Vxxw==
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
   d="scan'208";a="267107340"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 14:48:37 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4813C8342C; Tue, 10 Mar 2026 14:48:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0D9DD833F8
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 14:34:04 +0100 (CET)
X-CSE-ConnectionGUID: 0tda0leoRbGoQ4FcZGohRg==
X-CSE-MsgGUID: gRnxdRyAQ4aeEwGA6G9YbA==
IronPort-SDR: 69b01dcb_+ONK5qitF5rKqo3fXi6Cna0mgWvyOxidBoYXHMyTBWrzkjf
 cdTem/FoExGUCrdza4tGRzlaNv7SOeodRZ35Iug==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GLAgDqHLBphf4EaaxaHgEBCxIMQIQRgWYzBAtJhFiIe?=
 =?us-ascii?q?4h8k0mIfINSAg8BAwENUQQBAQMEhHwCAgKNIQIeBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYZPDYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg1+AQEBAyMPAQ0BATcBDwkCGAICJgICRhAGAYMUgiMHSgORD?=
 =?us-ascii?q?Jw+gTKBAYIMAQEG3CqBZwkVgQouhW+CZQGBcINqGjuDRXonG4INgRUygng+h?=
 =?us-ascii?q?FiDRoJpgiaBDokKihYJPwp4HANZLAFVEw0KCwcFXgNCEDMDIAoLEhIUBBUCF?=
 =?us-ascii?q?A0QEg8EFgUtHXAMJxIPHRcUH1gbBwUSISqBSXiBZhsPhmp5Ay5eGg4iAjoDM?=
 =?us-ascii?q?gQjSj4LWgWCPwMLGA1IESw3Bg4bBD0BbgeNdD6CMwKbEa9WhCaBZKAOBC+Dc?=
 =?us-ascii?q?QGTYJMZLodlkHMiqR+BfyOBXE0wCIMiTwMZD44hGYh6iiq5b0M1PAIHAQoBA?=
 =?us-ascii?q?QMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:5990V6OuiM2n/cBcTsSjsMiBIKoaSvp037Dk7S5MoHtuA6qlfq
 GV7ZMmPHrP5Qr5N0tQ/OxoVJPtfZqYz/9ICOoqTNOftXfdyQmVxehZhOOIqQEIWRefygc379
 YCT0ERMrLN5CBB/L/H3DU=
X-Talos-CUID: 9a23:j4SToWy9EsrTrPa09CpUBgVMBswsKnnQy03aDEiBVUhiepKSSWWfrfY=
X-Talos-MUID: 9a23:OyYHgAqSjZAEZZcG7YMezz5YMtdk2bWHMRwEnLgZlODaGn1BMR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267103249"
X-MGA-submission: =?us-ascii?q?MDFLuwmQTRvO63G1TdTEAZ3DdiatgF3/6YCpjE?=
 =?us-ascii?q?ihWU5I4vjP9Agh1papJxmit30f2n6l8Tro3ilkhV8ELhf8yHliEioZze?=
 =?us-ascii?q?dXbvpZGU2uXosaRFmulSqC1D/BTwigB6yvuZjT4EjDkOC0AEegIQEBnc?=
 =?us-ascii?q?SHt2++e3PEmT0aCyryI8v2Cw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:34:02 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DBB2D60054;
	Tue, 10 Mar 2026 13:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1338AC19423;
	Tue, 10 Mar 2026 13:33:50 +0000 (UTC)
From: Lee Jones <lee@kernel.org>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
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
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
In-Reply-To: <20260310-b4-is_err_or_null-v1-51-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-51-bd63b656022d@avm.de>
Message-Id: <177314963081.2226692.3105447886678957300.b4-ty@kernel.org>
Date: Tue, 10 Mar 2026 13:33:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] (subset) [PATCH 51/61] leds: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Lee Jones <lee@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3377
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/n2WylbqpqidiSJUScHAoUQ>

On Tue, 10 Mar 2026 12:49:17 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> 

Applied, thanks!

[51/61] leds: Prefer IS_ERR_OR_NULL over manual NULL check
        commit: e68f95a51d1a8c1594b536c4d495cbea38d47561

--
Lee Jones [李琼斯]

