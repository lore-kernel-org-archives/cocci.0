Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394F7D5B172
	for <cocci@archiver.kernel.org>; Mon, 15 Dec 2025 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LsG7bFS2PsYigWIS6oU2kfkKGDZYdXKFe6ynjCBf4Mo=;
  b=vpsg6NQc6iqKo7JTI4CJXYdCnbc7cp6AMohWr/3wimh0hfQyRScQ8UtK
   m2mJTXSYR7CIe1N2WmVwCkuMDhmCJ5b7GKtnDfIwbnk/pom9w+04MQ4zY
   T/8MSp1DBoTVCcGW6AaI70BQbjmqUTOZZ3VJq6PCc8lxWtyoP5zPXnlsy
   U=;
X-CSE-ConnectionGUID: 4724kxELSgCR6Wme+wWtvQ==
X-CSE-MsgGUID: /q3JDS5aRIaI5i11QTaXxQ==
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
X-IronPort-AV: E=Sophos;i="6.21,151,1763420400"; 
   d="scan'208";a="254515023"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Dec 2025 15:43:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 96E4A81A56; Mon, 15 Dec 2025 15:43:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A9BCD81A59
	for <cocci@sympa.inria.fr>; Mon, 15 Dec 2025 15:43:21 +0100 (CET)
X-CSE-ConnectionGUID: CX/bWxO7Sl6PPwdqVtey6g==
X-CSE-MsgGUID: yIDZSFdGQ6mcgRP4wsnP6w==
IronPort-SDR: 69401e89_bCkCow5JNq/vPs/QUlfKbJ2i2+0TKS8rdbZa+yP8ZwFvryD
 YoHnfmVG/XYFlyFTke2KMaQShvtB7zaAgsqnOBQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G7AQDrHUBphSaV4rlaglmCQIEGXjQHCEmNUIksnWqBV?=
 =?us-ascii?q?iEIDwEDAQ0uFg0EAQEDAQIBhDqNMAIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CWztxgSUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDQIxKwEhBT8BATg7N?=
 =?us-ascii?q?AEXg0oBgiRPBw0GsTcaN4IsgQGCDAEBBoJo2T+BZAMGgUuIOBsBc4lzJ4Iog?=
 =?us-ascii?q?RWCeYF0AYFbAQICgiqFd4ImgQ6ZbIFKHANZLAFVExcLBwWBZgOBC24yHYEjP?=
 =?us-ascii?q?hdzgRSDSR5oDwaBEYNPiRgPiWxSAwttPTcUGwaVSCklg2oCIpVUsziCP4Fnj?=
 =?us-ascii?q?B6NPYgWM4Nxk3WTBZkGjgiVYIVYgWg6gVxNg1pPAxkPjjgCgh6DB4NVvnZFM?=
 =?us-ascii?q?gIBATgCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:IWzax6MdfgKDn8BcTt6jsMiBIKoaSvp037BL7TEUdfUxSKalfq
 +V7ZcmPHPP5wr5O0tQ/OxoWpPwI080nKQdieJ9UYtKNzOGhILHFu9fBMfZowHdJw==
X-Talos-CUID: =?us-ascii?q?9a23=3An2LkIGpVLp5ClLD8VY82BG/mUesVNXfi3FCPGEv?=
 =?us-ascii?q?mMV52RKSrVVKBpqwxxg=3D=3D?=
X-Talos-MUID: 9a23:0WhfrQbxCvQzf+BTph7AtgpMOOhRvaGlB3o1zYodvfHaKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,151,1763420400"; 
   d="scan'208";a="254514979"
X-MGA-submission: =?us-ascii?q?MDHYp9cpTOtaV1/oKctqea+EuK3kAANaQYDXL6?=
 =?us-ascii?q?lj+925MY4kVzlrXCEI7YivjSUYQnRSr8akg0Of+iNZlQXnwgRYWuV844?=
 =?us-ascii?q?8dnh7EsOWh8VjkUGqhqvPuLEI4sNa30dzqIraIkI0oUeaAQXo3RBlFSC?=
 =?us-ascii?q?KdiaLuV73GlFKHf+URjmbbzQ=3D=3D?=
Received: from mailtransmit05.runbox.com ([185.226.149.38])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 15:43:20 +0100
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <m@mmap.at>)
	id 1vV9nC-007A9p-Sl
	for cocci@inria.fr; Mon, 15 Dec 2025 15:43:18 +0100
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <m@mmap.at>)
	id 1vV9nC-0000ya-Am
	for cocci@inria.fr; Mon, 15 Dec 2025 15:43:18 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (962690)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vV9my-009Dlf-2w
	for cocci@inria.fr; Mon, 15 Dec 2025 15:43:04 +0100
From: Manuel Wiesinger <m@mmap.at>
To: cocci@inria.fr
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Mon, 15 Dec 2025 15:43:02 +0100
Message-ID: <87v7i7g615.fsf@mmap.at>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [cocci] Pre-compiled spatch links against EOL PCRE version
Reply-To: Manuel Wiesinger <m@mmap.at>
X-Loop: cocci@inria.fr
X-Sequence: 3263
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/T1OPOFACTCrnkgplQ-Yhtg>

Hello everyone,

The pre-compiled binary provided on the Download page [1] links against
libpcre.so.3. This library is unmaintained by upstream [2] and not
available on recent distributions, including Debian 13 [3], RHEL 10 and
Arch Linux.

I have been using spatch linked against PCRE2 (/usr/lib/libpcre.so.1)
extensively for days without any issues on Arch Linux.

[1] https://coccinelle.gitlabpages.inria.fr/website/distrib/coccinelle-1.3.1-bin-x86.tar.gz
[2] https://www.pcre.org/ (See Versions)
[3] https://lists.debian.org/debian-devel/2021/11/msg00176.html

Take care,
Manuel
