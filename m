Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ECEC02193
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:message-id:from:to:cc:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
  b=d06onMrA6Bka7YvXvGTOGwqxXIJx4LradLXjBM6vXgHluSnBd1Te52hK
   2ZDNSdMqIb6ycDv3OBcFsUKAmIS1XiHo+FFOfUJdnbKz0oARb99MGsRww
   4dVc4cTOrr/V0B7zQSdCOh+VxEf94bZ6VKtBL8pxlhk4eNRm94p836qIZ
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.de
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205537841"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 10:46:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F3E6E0261; Wed, 29 Jan 2025 10:46:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0DA2DE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 10:46:56 +0100 (CET)
IronPort-SDR: 6799f90f_wtCcMuNvuWs1JScV4vsc68hkTHdgqvJ/GvREl6oIi2PKVLO
 yfcgQvSCgR0GQrMbwQL5ut66VqxPJL7cLUuZSeg==
X-IPAS-Result: =?us-ascii?q?A0GkAQA0+Jlnj4Lfh8NaHgEBCxIMQIFICwKBcFKBVzMEC?=
 =?us-ascii?q?0iNUoZTgiSeFxSBag8BAwENRAQBAQMBA4UAAop1Ah4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYV7DUkBEAGCBwEzg?=
 =?us-ascii?q?hYsDX4BAQEDJxMGAQE3AQ8LDgouEEYGE4MCgmUEA7NKgS+BATOBAYIMAQEGg?=
 =?us-ascii?q?mjZN4FkCYFIiE4BhWsbKYM5eicbgUlEgRWDKj6EBIcDgjOBc4NAhlQShCyCa?=
 =?us-ascii?q?pM+UnscA1ksAVUTFwsHBYEpSAOBESOBJgU1Cjc6gg1pSToCDQI1gh58giuCI?=
 =?us-ascii?q?YI7hEVgLwMDAwODNoVbghSBZQMDFhABgyd4HIIsHUADC209NxQbBp4lPIQDg?=
 =?us-ascii?q?Q6BJxaUJoNPAbAAgj+BZqFgM5dEDpMBLodkkGqpLYFnOoFcMxoIHBSDIk8DG?=
 =?us-ascii?q?Q+IAIYhGYQUyV9CNTwCBwsBAQMJiyCEQwQwgUsBAQ?=
IronPort-PHdr: A9a23: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
 5dIRrIJDDQI
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:s1tNmawyJGWKBaIZEHvFKrPw471zdoMgy1knxilNoHxuHvBwWf
 re+8jztCWE9Qr5PUtL9L/vBEDuewK+yXcY2/h1AV7mZniehILKFvAZ0WKB+UyDJ8SWzIc0vs
 YBT0E9MqyJMbEQt7ed3ODXKadF/DDKytHSuQ4y9QYdcehxUdAd0y5JTjyDGkkzfgNBHpZRLu
 vj2uN34wC4cXAbKv+2HGUBQoH41qL2qK4=
X-Talos-CUID: 9a23:soLwKWwEzB37vCNGDTO0BgVNQPwdUUTh7EzpBFC1OCE3SaaueEW5rfY=
X-Talos-MUID: 9a23:hnmRAQg3LzKTpF96DVY9pcMpE8RJ07ySKnkxrcsXl/uWbAh5HQ2wg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="107631746"
X-MGA-submission: =?us-ascii?q?MDEWWYHx6cR7CUDghlHazy9KGjCcRqPfNAVBKi?=
 =?us-ascii?q?YwD9WJIbo9JtVe2ctMzlZvP6YUrNm9/mLNWYXNPlqzwdkrQ7pMZjJjAs?=
 =?us-ascii?q?KA5281fL1f+h34iv60Pbi8e2LSiteWwppzL1xqElcZmKfzVYtxtnaWiH?=
 =?us-ascii?q?e57HP/mt9SEFClXN1CVTuBZg=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.223.130])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:46:55 +0100
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8E0D210F5;
	Wed, 29 Jan 2025 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6489C137DB;
	Wed, 29 Jan 2025 09:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C9NOFw35mWf7LAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jan 2025 09:46:53 +0000
Date: Wed, 29 Jan 2025 10:46:53 +0100
Message-ID: <87o6zq6jg2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,	Yaron Avizrat
 <yaron.avizrat@intel.com>,	Oded Gabbay <ogabbay@kernel.org>,	Julia Lawall
 <Julia.Lawall@inria.fr>,	Nicolas Palix <nicolas.palix@imag.fr>,	James Smart
 <james.smart@broadcom.com>,	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,	David Sterba <dsterba@suse.com>,	Ilya
 Dryomov <idryomov@gmail.com>,	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>,	Xiubo Li <xiubli@redhat.com>,	Damien Le Moal
 <dlemoal@kernel.org>,	Niklas Cassel <cassel@kernel.org>,	Carlos Maiolino
 <cem@kernel.org>,	"Darrick J. Wong" <djwong@kernel.org>,	Sebastian Reichel
 <sre@kernel.org>,	Keith Busch <kbusch@kernel.org>,	Christoph Hellwig
 <hch@lst.de>,	Sagi Grimberg <sagi@grimberg.me>,	Frank Li
 <Frank.Li@nxp.com>,	Mark Brown <broonie@kernel.org>,	Shawn Guo
 <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix
 Kernel Team <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,	Hans de Goede
 <hdegoede@redhat.com>,	Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,	Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>,	Selvin Xavier <selvin.xavier@broadcom.com>,	Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>,	Jason Gunthorpe <jgg@ziepe.ca>,	Leon
 Romanovsky <leon@kernel.org>,	cocci@inria.fr,
	linux-kernel@vger.kernel.org,	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,	linux-sound@vger.kernel.org,
	linux-btrfs@vger.kernel.org,	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,	linux-ide@vger.kernel.org,
	linux-xfs@vger.kernel.org,	linux-pm@vger.kernel.org,
	linux-nvme@lists.infradead.org,	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,	ibm-acpi-devel@lists.sourceforge.net,
	linux-rdma@vger.kernel.org
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
	<20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,intel.com,kernel.org,inria.fr,imag.fr,broadcom.com,HansenPartnership.com,oracle.com,perex.cz,suse.com,fb.com,toxicpanda.com,gmail.com,easystack.cn,kernel.dk,redhat.com,lst.de,grimberg.me,nxp.com,pengutronix.de,amd.com,linux.intel.com,hmh.eng.br,ziepe.ca,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,lists.sourceforge.net];
	R_RATELIMIT(0.00)[to_ip_from(RL41ih3fejwepcmbj4wj583m3u)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Subject: Re: [cocci] [PATCH 04/16] ALSA: ac97: convert timeouts to
 secs_to_jiffies()
Reply-To: Takashi Iwai <tiwai@suse.de>
X-Loop: cocci@inria.fr
X-Sequence: 2305
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/87o6zq6jg2.wl-tiwai%40suse.de>

On Tue, 28 Jan 2025 19:21:49 +0100,
Easwar Hariharan wrote:
> 
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

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


> ---
>  sound/pci/ac97/ac97_codec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
> index 6e710dce5c6068ec20c2da751b6f5372ad1df211..88ac37739b7653f69af430dd0163f5ab4ddf0d0c 100644
> --- a/sound/pci/ac97/ac97_codec.c
> +++ b/sound/pci/ac97/ac97_codec.c
> @@ -2461,8 +2461,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
>  		 * (for avoiding loud click noises for many (OSS) apps
>  		 *  that open/close frequently)
>  		 */
> -		schedule_delayed_work(&ac97->power_work,
> -				      msecs_to_jiffies(power_save * 1000));
> +		schedule_delayed_work(&ac97->power_work, secs_to_jiffies(power_save));
>  	else {
>  		cancel_delayed_work(&ac97->power_work);
>  		update_power_regs(ac97);
> 
> -- 
> 2.43.0
> 
