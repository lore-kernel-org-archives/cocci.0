Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E89C02190
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:reply-to:references:
   mime-version:in-reply-to:subject:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
  b=QoNtuz9Bao4VB2ZhyfXx1ayYcJYKBi8aX6h00BCmsqKxuo5lObe/ug4h
   U5gESBjlk0aPSqsxP6QZ1xSXAfYi+AlcrEA9zhYKyqXQE5frJ5+WmPmf8
   bDdST8lSd2Ltg4KU4vP49cFO+BV/6BC487PWkFIY+0n+osd3nkiN/AYy5
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@suse.cz
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205455260"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 20:28:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 019DAE0D1E; Tue, 28 Jan 2025 20:28:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B7BEE00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 20:28:19 +0100 (CET)
IronPort-SDR: 67992fd2_yLaevXjiQOvWmzh4weWly/LRGUlMvj0wPlM/kI74nwgIHLn
 4iC8LEke2sDMESn0zwqAGeoyPzro+Mdtfck2EMg==
X-IPAS-Result: =?us-ascii?q?A0EMAAD8Lplnj4Lfh8NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYFxUoFYMgQLSIxzX4ZTgiSeGIF+DwEDAQ1EBAEBAwEDgUyDNAKKd?=
 =?us-ascii?q?QIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBA?=
 =?us-ascii?q?QE5BUmFew2CYgEzghYsDX4BAQEDOgYBATcBDwsOCi4USBODAoJlBAO1A4E0g?=
 =?us-ascii?q?QGCDAEBBoJQ2TAfgWQJgUgBiE0BhWtEhFobgUlEhD8+iweCM4F0g0ChHwcHR?=
 =?us-ascii?q?B1eHANZLAFVExcLBwWBKUgDgRIjgSYFNQo3OoINaUk3Ag0CNYIefIIrgiGCO?=
 =?us-ascii?q?4MlgSBgLwMDAwODOIVdghSBZQMDFhABgyd5HA4CAoF6HTcJAwttPTcIDBsGR?=
 =?us-ascii?q?UIdEpxhPIY4lDyDTwGwAIQlhE2ceRozg3GTUw6TAS6HZJBqqS2BZzqBXDMaC?=
 =?us-ascii?q?DCDIk8DGQ+IAIYhGYQJyTlDNDwCBwsBAQMJkBmBSwEB?=
IronPort-PHdr: A9a23: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
 wAV2r6+JpZBbuXG
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tGp7oK5iQplnNIE0egPXwHTXdLJyesId70hD6qkQc3BomwKj5q
 STddAgpGLJYVcqKQsdcLW7UsTuL080mqQFgrX5UY3SPjUO/VHYUL2KjrGSuAEIeReOkNK1vJ
 0IG8MeaOEYT2IK9foShjPIaurIq+P3l5xA692uqkuFATsaFJ1I3kNDEB+SFkAzbANaBZw/fa
 DslvZvln6aY20easn+PmUIQ+SGh9CjruOZXTc2QyU88QGLgHeT5KXkHwPw5GZtb9qj+8ZWzY
 HeqX2M2oyT98ujwhuZ7WXU9Jg+oqqR9vJzQPaUgswZbg7hkBqsee1aKs6/gAw=
X-Talos-CUID: 9a23:N6/vxW2LMmAtP3+sjQ1WuLxfKOs4fn2DyVTrAF6dFm1zGKKVQ3/X0fYx
X-Talos-MUID: 9a23:6uysLAhLnik56dLLYVqxR8MpDNhk4ueeC2wxoYwhl/GrGDcgNTiNpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205455252"
X-MGA-submission: =?us-ascii?q?MDE7kPi+j+XBc8v9+d8sVvLe2uKUN2toZ/Ced3?=
 =?us-ascii?q?SkP2VsLy1f1mtds9g03SIAzyWAFo4sM7uLS9gDYQ040slIkfLKLHhH/w?=
 =?us-ascii?q?Q5u2j5QwLoXSpGsHN/umNGU7dYaGPbCVE1KZscWYODsCVteCFgmF7dyi?=
 =?us-ascii?q?aDAgkF2bbcm0ffgnp9RUFzYg=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.223.130])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 20:28:18 +0100
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31F44210F8;
	Tue, 28 Jan 2025 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738092497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=X7DzgIEIos5paB261Thz8Qi51sOVFwb5dSUTRRMycQLt/5T7754KjcgbjT+EPwV5fdLaaa
	cvSOk6TY2qEeLsUeC5G5KNg4CQMIkX2ooAejwo/XceW1/fc11wYZyhlGSl7Q8n+cEjO9OJ
	Ii8fxytnZFdNjyQYJ4iJxYMOiaYZluU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738092497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=gjs0esMUPchB4K4RtIem58fDt+M6QJS4Mh5QJBMLR40KmpfdO9OR+d1oMn3UBKFmkmzEEt
	+M/96OKGcvLSGHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738092496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=y688SLY7/DL5p8EccbkUszio2tZbA94boT4rwz+ACMq588fgH+Vf8EqkXANQNYWiQFG7DT
	anyf2Nx63Z/9IvWw9iThlkRnAXfe4qWQrFOQ8ghtd0mhYInrapGCBP4qDwcTlbxOa+r+Gv
	qtAW+mLbxCjg/w5prt5Mp5mE0k5zC1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738092496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu5AW9e6LIlMe18vHX/cu2btQmvEuNdVbxSGH23BpgQ=;
	b=9Rahx42hI6P64ZFl8I0lTTg8Zv21R573Kl+t/8z5GIP+ELkdKbRYFovpEy1CA3oSmAZSUq
	/XJL5V34JZcxoYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4BB313625;
	Tue, 28 Jan 2025 19:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MMhrK88vmWf/FgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 Jan 2025 19:28:15 +0000
Date: Tue, 28 Jan 2025 20:28:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	cocci@inria.fr, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Message-ID: <20250128192814.GZ5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-5-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-5-9a6ecf0b2308@linux.microsoft.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 31F44210F8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,intel.com,kernel.org,inria.fr,imag.fr,broadcom.com,HansenPartnership.com,oracle.com,perex.cz,suse.com,fb.com,toxicpanda.com,gmail.com,easystack.cn,kernel.dk,redhat.com,lst.de,grimberg.me,nxp.com,pengutronix.de,amd.com,linux.intel.com,hmh.eng.br,ziepe.ca,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,lists.sourceforge.net];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqrxpk6su4nbqht4p3tfcj1xc)];
	RCPT_COUNT_GT_50(0.00)[59];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Subject: Re: [cocci] [PATCH 05/16] btrfs: convert timeouts to
 secs_to_jiffies()
X-Loop: cocci@inria.fr
X-Sequence: 2291
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128192814.GZ5777%40suse.cz>

On Tue, Jan 28, 2025 at 06:21:50PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Acked-by: David Sterba <dsterba@suse.com>
