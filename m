Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431BBF46421
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:reply-to:references:
   mime-version:in-reply-to:subject:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lEZDbFbdaiqtR0DORmYiMySif6us6CTI89GNtF8koIU=;
  b=F3ZOYt57kjjcsoFHFGH7UtuRgcPR0xSmnw4fJt2tWZZOcJV7SL0rILjN
   F35WNXblDGxvwagJMkhD3qEvrVbVfM++jARrAZGO8LxWcVSP4PUOf5AiQ
   0vuojYipWDTd5uZq/DwaNM6ExSY8IVka0YPDKPOwNEBvtmPSzMTeM9Qqp
   0=;
X-CSE-ConnectionGUID: OmyW5niITmmNVkbAoqsxew==
X-CSE-MsgGUID: v17EadrXRViYNKsx0TIOrA==
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
X-IronPort-AV: E=Sophos;i="6.23,123,1770591600"; 
   d="scan'208";a="267915484"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 10:29:26 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A82E881F64; Mon, 16 Mar 2026 10:29:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0295381F00
	for <cocci@sympa.inria.fr>; Fri, 13 Mar 2026 20:22:26 +0100 (CET)
X-CSE-ConnectionGUID: wHhBROEZQyaDJFg1nbA6JA==
X-CSE-MsgGUID: 7+0Uqav4RaO0/gn6ugZT7A==
IronPort-SDR: 69b463f2_TEdUwQgV7w4p6naPRI3Qoy3iNbd+mlo+tOmBPxWBUyaVcYe
 dSw7Y2bsKIWk3Vh6B4k4rsREtQodkZFuB14txjw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HbAQCLYrRpj4Lfh8NaHgEBCxIMQIM+U0EBgSQzBAtJj?=
 =?us-ascii?q?VOGWIIkoBkPAQMBDVEEAQEDAQOFAAKNIwIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYZPDYJbO4IWLA1+AQEBA?=
 =?us-ascii?q?zoGAQE3AQ8LDgouFEgTgwKCIwVMBAOyEIE0gQGCDAEBBoJQ2TsfgWcJFYE4i?=
 =?us-ascii?q?FQBhVoahSEbgUlEgRU1gnU+iweDNIkHiiMHB0QdWxwDWSwBVRMXCwcFgSNDA?=
 =?us-ascii?q?4EGI0sFLR03bCEdFxQfWBsHBRIhKoFEeIIBD4JUhBZ5Ay5eGg4iAjlcgQYLU?=
 =?us-ascii?q?gWCLQIdCQMLbT03CAwbSUIdEo14PYIzAoM2xzGEJoROnQoaM5dSDpMLLodlk?=
 =?us-ascii?q?HOkIoUfgX8jgVwzGggwgyJPAxkPjiEZhA/IOEI1PAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Jqs7ug=
IronPort-HdrOrdr: A9a23:7zC3ZKGLNtsRpgEbpLqEE8eALOsnbusQ8zAXPiBKJSC9vPbo8/
 xGuM5rqCMc6QxhIk3I/OrrVcbvfZqyz+8X3WB8B8bBYOCighrVEGgA1/qY/9SDIVyZygc178
 4JGMkfNDSzNykDsS+d2njALz9K+qjhzEnHv5a6854gd3AUV0iM1XYLNu+AKDwGeCB2QaAhHJ
 7Z3MBAvDbIQwVoUu2LQkMdV+zP4+bGjo7ifHc9dm4a1DU=
X-Talos-CUID: =?us-ascii?q?9a23=3AD0NSeWimorPeqiZmcI7mllwbrTJubV3d5k33Dn2?=
 =?us-ascii?q?BGG9FapOaEFma0f1Gup87?=
X-Talos-MUID: 9a23:OiDX2gsJDTcPHf9Iqs2n23I6Cd5h/fiUAWdV1poA5dSLBxAvEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267739859"
X-MGA-submission: =?us-ascii?q?MDETP0MeNaLA1LuFiMmpANyXAH/O0yJ4cdqal6?=
 =?us-ascii?q?xp/nAFwY34hgLpPQUuiGIDqUe0yX/XWkE8M5Bb/nB4GNg20ahBQvZVmt?=
 =?us-ascii?q?wqctGKv0e/FIC/6ez06r1eRGUGnPlyPNwz393+ExY144oYU3FchBus0V?=
 =?us-ascii?q?ENidEbqRPSdOgQHBQ/T7EnNg=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.223.130])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 20:22:26 +0100
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B208C4D943;
	Fri, 13 Mar 2026 19:22:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F14A406AC;
	Fri, 13 Mar 2026 19:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6cTyGvBjtGnfZAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 13 Mar 2026 19:22:24 +0000
Date: Fri, 13 Mar 2026 20:22:15 +0100
From: David Sterba <dsterba@suse.cz>
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
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Message-ID: <20260313192215.GH5735@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-2-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-2-bd63b656022d@avm.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLk9qejt5hbtemdgupcccnrijf)];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_GT_50(0.00)[56];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 02/61] btrfs: Prefer IS_ERR_OR_NULL over manual
 NULL check
X-Loop: cocci@inria.fr
X-Sequence: 3433
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/avNQbHExAwtDppWNcX1Lkg>

On Tue, Mar 10, 2026 at 12:48:28PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
> not like nesting it:
> > WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> > unlikely() internally
> Remove the explicit use of likely().
> 
> Change generated with coccinelle.
> 
> To: Chris Mason <clm@fb.com>
> To: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Added to for-next, we seem to be using IS_ERR_OR_NULL() already in a
few other places so this is makes sense for consistency. Thanks.
