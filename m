Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D91B10ED659
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2026 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4fUFXPph0d+U/6GDmGbgLZ/FXBjYuxpYsgD69WTKZEc=;
  b=gOLfHCgToHREiQnzF2IX57eKroZ5iCzoVYWXLgLL9/vPK9anCciJEs54
   m5WDkDLpVCMw3ruPLEz392+6XmA79yY/kQIf4wyGx5Hl9Sf5C2cTVpOfc
   qgD28Lv0El0HYl7LBKVrThGZXxDUiEo511yddDP/bZhYUuDvennIsHJkl
   0=;
X-CSE-ConnectionGUID: DVuu+h64RD6O98Kprssgww==
X-CSE-MsgGUID: vIpc+/4jQqWvVrbPcg6/3g==
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
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269791402"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2026 11:51:05 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 84EB481916; Fri, 27 Mar 2026 11:51:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C62FC82534
	for <cocci@sympa.inria.fr>; Thu, 19 Mar 2026 15:13:53 +0100 (CET)
X-CSE-ConnectionGUID: dpDD3tDTSkCWdXEmTSzYWQ==
X-CSE-MsgGUID: zigQbqEiS2SyFKRfYMKyaA==
IronPort-SDR: 69bc04a1_myrZ4OwETtehPrdY5lINVqo7VaU/uTG3pFMOdLkmCpp8FU4
 1LEQr5DzEco6b8hOm04x+VlF7C2nB0nQONkuhsQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EwAgAqBLxpj4Pfh8NahEdTQQGBJDMEC0mNU4ZYXQaBP?=
 =?us-ascii?q?gOLdIZ3jS4PAQMBDVEEAQEDAQOFAAKNIwIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYZPDYJbO4IWLA1+AQEBA?=
 =?us-ascii?q?zoGAQE3AQ8LDgouKysGEwiCeoIjBUwEA68/gTSBAYIMAQEG3AsfgWcJFAGBO?=
 =?us-ascii?q?IhVAYVbGoQAeicbfYEQgRWDKj6EChyGYYImgQ6IGopNUngcA1ksAUsKNQwzc?=
 =?us-ascii?q?EMDgSlLBTdlEj8hHSwfOQI4BwUSIREZYoIBD4ZneQMjC14aDiICOVxKPl0Fg?=
 =?us-ascii?q?iwCgSQDeD03FBuOdDuCMwEBgQ2BRJRMs0qEJoROnSFJA5c8DpMLLodlkHOjc?=
 =?us-ascii?q?YVQgX8jgVxNOIMiTwMZD446hA/GCUI1PgEHAgcOAoFzkAABJwyBSwEB?=
IronPort-PHdr: A9a23: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
 rAndYroLStattXJ4ZFaHNXPJYSLPSh5WSc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NRWVh6re1fsr++Q454bqaZAaV5rqeYIsimQD101hICG9Evb1qy
 lhpoV96fbRskdtZJhAo6H7BEDkexmwmvBICOYqTNWftWXdyQ6VxcRZnPffKl7balbDH4xmpN
 5dmsFFYbWabDgK7voSojPIa+rIq+P3lpxA692uq0uFoDsaG52I9T0JdDqzIwlNXQFDQaAyEo
 GRj/A32AaISDAsd8y+Cz0/U/LeosCjruOWXSI7
X-Talos-CUID: 9a23:lABz72Ci5KTob3D6EyV/2GJPBuwZSX7283vgDkqEMnRYd4TAHA==
X-Talos-MUID: 9a23:cpTmFgj+ejdvsX95BoRlI8MpJsZn2q63JUE2y64Xleq+Ox1VGCaUpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,129,1770591600"; 
   d="scan'208";a="268576689"
X-MGA-submission: =?us-ascii?q?MDFFDBJ/UXdW7o0KfrRUNRRt/IMPfmZvEKaROz?=
 =?us-ascii?q?wWf3sN3lPYeooKM7qC6erH2tmCutLJTiYsedujvfMkU2K95kyb7IWNYx?=
 =?us-ascii?q?FU6l1smH57lx9aeRTgF0LKtGPE5hGC+k8v69m1h8+urNTHYflRDwsjq3?=
 =?us-ascii?q?kJcuSB6BERLsjnjvdWzDUeHA=3D=3D?=
Received: from smtp-out2.suse.de ([195.135.223.131])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 15:13:52 +0100
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 233AB5BD4B;
	Thu, 19 Mar 2026 14:13:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14B714273B;
	Thu, 19 Mar 2026 14:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TmUEBZ8EvGlPZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 14:13:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C850FA0B32; Thu, 19 Mar 2026 15:13:46 +0100 (CET)
Date: Thu, 19 Mar 2026 15:13:46 +0100
From: Jan Kara <jack@suse.cz>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev, 
	intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Jan Kara <jack@suse.com>
Message-ID: <ol2d7c5z7yfyuwo5tyfxurgqedruhr6bzmuv37bx5phhrmmoyh@4zjspbtexid3>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLck44p98ib5bmd95s13xxw3gp)];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_GT_50(0.00)[55];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 12/61] quota: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Jan Kara <jack@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 3461
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/UZRiObvO83H9wCr5izZVWg>

On Tue 10-03-26 12:48:38, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Jan Kara <jack@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Thanks for the patch but frankly I find the original variant clearer wrt
what is going on. So I prefer to keep the code as is.

								Honza

> ---
>  fs/quota/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 33bacd70758007129e0375bab44d7431195ec441..2e09fc247d0cf45b9e83a4f8a0be7ea694c8c2a1 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -965,7 +965,7 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
>  	else
>  		drop_super_exclusive(sb);
>  out:
> -	if (pathp && !IS_ERR(pathp))
> +	if (!IS_ERR_OR_NULL(pathp))
>  		path_put(pathp);
>  	return ret;
>  }
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
