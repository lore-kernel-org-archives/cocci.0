Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED101049522
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
  b=oXHZicoZb2w/X2qbQnIUfU/o6nCK50dh8PvXvqhpguRxfq9Vio1nOKre
   pXHNU8aOFYksRN+6MFd6HLwwDMoqbeJQAyrsgHvctcrsyzVOqGJ6nAtyE
   OAosG+GlravmGOhJPR1HXuhZJkpr9HpkLTCIi8h61bJr+rSQjBC4zayGM
   I=;
X-CSE-ConnectionGUID: mxk3y4A7SfGAP/FWRKFDKQ==
X-CSE-MsgGUID: UgIO2pwcQIeeYblYn4bFkA==
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245528"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:03 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A464D818C9; Wed, 11 Mar 2026 10:46:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A5EDF839B9
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 19:40:53 +0100 (CET)
X-CSE-ConnectionGUID: 82sWn3+JS1i8KdanF+xk8Q==
X-CSE-MsgGUID: gl7O6zOCQuerH1+goNsYdw==
IronPort-SDR: 69b065b4_DvuSo0DUsnF8V0MedoqqFlEGjrO5kIhSNtmJtkSjfn78f2q
 DwzZrBjej7uyUa6ULO8/dvLT3rEhyaklmAH7LSg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GkBQCXZLBpfKrWVdFaHgEBCxIMQIM+U4FmMwRUlCtaA?=
 =?us-ascii?q?QEBBoE+A4t3k2M9Ag8BAwELAQFPAgQBAQMEgUyDNAKNHgUCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABASIZBw4SKYZPDYJbg?=
 =?us-ascii?q?SxhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCL?=
 =?us-ascii?q?F8BAQEDEigGARsdAQMMBgUOCi4QEhEBBQEcBjWFAwEGEAEDNgMBoEyBAkKLO?=
 =?us-ascii?q?4EXBQIWgQGCDQbaZQoZKA1xgWQCBwkBCwGBN4R3KV0BglYBhVoahAB6Jxt9g?=
 =?us-ascii?q?RCBFYMqPoQNhnoEgiKBDokKihkIBzEJCRMGCgJIBwQKEgMEAwQEAQILEwkDA?=
 =?us-ascii?q?wIOAggDAggGGQE/EgQTCg0LBwUfCgIMFAooIgQOKwoDVjABCAYCAgQEAgQCC?=
 =?us-ascii?q?gIJAgIFBwIRAwQBAQgCAgMqAwEDGQgJCAILBREYDAsHMQMQCQMCHRcUBQgBE?=
 =?us-ascii?q?TQIBhYBGgcFBgsBIRYUAQUMFQMCAQMEAwMDAwMCBAIHBwsMBAQEAwUDAwUGA?=
 =?us-ascii?q?wEDBAMIAwoCBAsNBgUCAgIBAgwMAwMKBAQDAgUCBgkDAgMDAQMBAzkcEwQFA?=
 =?us-ascii?q?gUDAwE6Aw4EAwgeAgEBAgYCAQMDCAIDAQMCBwMUBQEGCAIEBAoCAwMHBgUHA?=
 =?us-ascii?q?hEoBAICAgIEAwMDCgcHBAMBBwMDDAICEAIEBAIDEwMDBAMQAwECEhgGAQMHC?=
 =?us-ascii?q?AMCBwQWAwIJGQQCBAMCAgICAS4DBQcCBAEHAQMDBwMCDAICAhIFBAYCAQMMA?=
 =?us-ascii?q?wQDBQULLREHEwoGBAcFAgICFAYCBAELEgMDBAQCAQICAjoEBwECChoKBAQIB?=
 =?us-ascii?q?wMHARgFAgMCBQEDAQcHEgIGBAgCAQ4TAgkCAgQCCQEBCg8CAQEGAgIBAwgYA?=
 =?us-ascii?q?wQfBAMDBwICDAkDBA0CEQEKEhsDAwsDDRIHBAMMChQFFwsOBAIJCAMNAgsLB?=
 =?us-ascii?q?gUKBRoCAgIGAgMDAwIFCQECAQEBAQEBAQIHAwMDAgMDBgMRCgMFBwYDDw8DC?=
 =?us-ascii?q?wkIEz0MBzIENgEUFAcEJYEAjgQ+giILBgJ6CRKCN6YKoRFogz6hcjOXUpMZL?=
 =?us-ascii?q?odVEJBzpCKEdAIKBwcRJBKBSSOBXDMaI4M3TwMZD44hPoNCyUo2NTwCBwsBA?=
 =?us-ascii?q?QMJhUURjEiBSwEB?=
IronPort-PHdr: A9a23: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
 0djMWWdL1q0p7RlfGFvzgTbvMkXccM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:agfLMaH3Ia2czEACpLqE78eALOsnbusQ8zAXPiFKOHhom6Oj+P
 xG8M5rtiMczQxhOk3I+urqBEDjex3hHE5OgbX5VI3KNDUO+lHYSb2KhrGJ/9SPIUzDH5ZmuZ
 tIQuxGDsP9FlR2ye3LiTPUL+od
X-Talos-CUID: 9a23:OnfzyW4moi30qQakcdsspBQPJcZ+MV/mlXaAAEOxD0gqWL7FcArF
X-Talos-MUID: =?us-ascii?q?9a23=3A37Kuvg+vgld9c+euNpKKFLiQf8hsvIPwGmcmqIg?=
 =?us-ascii?q?LoenddiN3HSysgCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140965463"
X-MGA-submission: =?us-ascii?q?MDHOk7Jh0qT5S+Pff6NDJJSON+EmMUpBiX9UdO?=
 =?us-ascii?q?RkjViPRfsw7jj2w1Sit0TpnZ43fMHWV/hGOJP/OpXqTYZm4XxbB9fcra?=
 =?us-ascii?q?RNJT2aX1y5gGNSYbV/tRj1sIlUSXUUy4pmlIt4GiqJ/SiEUSxPW/KfW1?=
 =?us-ascii?q?NueNL7S9YtNNO/yZw16I/C7g=3D=3D?=
Received: from mail-pl1-f170.google.com ([209.85.214.170])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:40:52 +0100
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a9296b3926so102507475ad.1
        for <cocci@inria.fr>; Tue, 10 Mar 2026 11:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168050; x=1773772850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=aZe5TQ8KGQM7MGqUi9UlPIlKprCw7yR3X/DJiyjnIRkls40T7dYcX2aExryWaoCicc
         6xQlIMc+EdjTmJeoTDlBOyL0xDKWYN1J2NzH6wTzy1KKl7g91VhUWTN/esZYJzA70Yet
         nbeuvTzp7EYdKsYmawKU5DLjpF1j5odMnJraMr3TVH5K5TKff127PGRevp0NMi4da0du
         XP8r6EobVXboB2r7dl4RSPnRd+HKGQKiYRcw3GDB70Zw6ULkZUUECrC/Mc/hTNrJ8zlC
         rw++7XxKU3DcE42/Kk/upx8vxWbEqOtP4YYqMuP0ZkuYYXgZCaRNpbCwA17J0UiE5kJJ
         xxsA==
X-Forwarded-Encrypted: i=1; AJvYcCXNLsRVM/jcHaySPLxoQdtKX/REXYU4vEENRFgE5+21QQHxz/xEfO5SP2pw0sNt5vDvp4rl2Q==@inria.fr
X-Gm-Message-State: AOJu0YzGM47zPJdEsWhmHqUmoFyKxxzQTZn2MH5be8OTHqw1v5LPqNHA
	Vl6lqIZOg4zu5m3XEyeZ0frQ/evN6maQ9ToO3F4N0pzAR/8Lnaq27o9u
X-Gm-Gg: ATEYQzyzeiZp9SsapFd3wazH4+77LaghyESDz+M/vUnei7E6JEoh39xDcHTXy9RO/6J
	jKo6Yj3jUNk6jlnk4XAo+1gcj61ajmoLIH/E8q6Xgo5bprQUu1LJMlksJLrGI1ByuDS2XVCJWm9
	71llI2E1VkakadvR5Q8S6Cb1HGkNR4rPXh5Ec+e3vKzmmQC2dFQx7QF+iz95SmcM/Yn4xITD2rD
	06RGw8xE0RtwiaXmFUVqpwP4mCPCvF0WWFkIbVmei3JtZ7gyg20slprMZ+bUfPHsRG76dzzwBsh
	dq1+5Q0+qI9vFZSfvPvZxeu5isj+KmtwJwgpjVb2TZxmQ4O9dZ9NxoZQjvV6FYYNJT4sJgFCVjm
	vr5Z8O8r55M2G1Ek5kNiqr/S9JYB3vBYB+jj7vmK4owzY2xGfrBp4UZzgEv3kN9Hrmpucz0IAAC
	7ECJBWn2iIHimwRcaNWU0VHoKynWnqmVK0QXImbW11pUS6YQ==
X-Received: by 2002:a17:903:28c8:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae8252cf0fmr96662285ad.43.1773168050081;
        Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:2953:97d3:b283:95c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e58592sm220535625ad.14.2026.03.10.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:40:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:40:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
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
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Message-ID: <abBlpGKO842B3yl9@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: Kuan-Wei Chiu <visitorckw@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3388
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/9Z_sgctst15VOwxloBqtaA>

Hi Philipp,

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.
> 
> Patches 55-58 may be dropped as they have a (minor?) semantic change:
> They use WARN_ON() or WARN_ON_ONCE(), but only in the IS_ERR() path, not
> for the NULL check. Iff it is okay to print the warning also for NULL,
> then the patches can be applied.
> 
> While generating the patch set `checkpatch` complained about mixing
> [un]likely() with IS_ERR_OR_NULL(), which already uses likely()
> internally. I found and fixed several locations, where that combination
> has been used.

Thanks for the patchset. However, I think we need a explanation for why
switching to IS_ERR_OR_NULL() is an improvement over the existing code.

IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
flawed API design. It usually implies that the caller is unsure whether
a failure results in an error pointer or a NULL pointer. Rather than
doing a treewide conversion of this pattern, I believe it would be much
more meaningful to review these instances case-by-case and fix the
underlying APIs or caller logic instead.

Additionally, a treewide refactoring like this has the practical
drawback of creating unnecessary merge conflicts when backporting to
stable trees.

Regards,
Kuan-Wei
