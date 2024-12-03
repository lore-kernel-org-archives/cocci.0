Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A5E77172
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VQMebrBWojbOWHLi2V6GeEXp4jzM3FFKoHNY4IchQ7M=;
  b=f0MELhJQGZOj9AcJD6fZwZZOeO/Tj0VqgTTG8p/UZ1RmNhxfIjAGagTh
   vA750uYvNHZpCPZSIBSCa3XsIK86oY6GWyuro+Npctf4pVPTkqDPHU+HJ
   9/e2Z5rXrY66TMsnV4zcuy+//vU84Ovvrdd80HWsdGDHa+vhGNUcoN8so
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421423"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65341E0D78; Wed,  4 Dec 2024 23:28:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 54B39E00B6
	for <cocci@sympa.inria.fr>; Tue,  3 Dec 2024 18:47:17 +0100 (CET)
IronPort-SDR: 674f4424_zH21b37Y13Er0KfKVRIdxSgJnCijQnawWla+gth88ce+K/V
 A1hxQULA5wpWALQdCpiOy2gjZ0bbcJbIkW4FQlw==
X-IPAS-Result: =?us-ascii?q?A0FbAQDrQk9nhQfJy7lagQmBU4FyUoFXMwQLSIRWkXEwn?=
 =?us-ascii?q?BGBVoF+DwEDAQ1CAgQBAYUHAoppAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQFASYYIgmIBhAABAQECASMEUgULCw4MAiYCA?=
 =?us-ascii?q?lYGARKDAYJCIwQDsSh/M4EBhHzZN4FtgRouiEwBgWyDfRsghDyCC0SCUIFvP?=
 =?us-ascii?q?oQKOYNbgmkEgj+FEiVNh0togW+Lfh0wgi6LNwlJexwDWTIBVRMXCwcFgSoRE?=
 =?us-ascii?q?CwDIm5qTn+BNoFRAUKCTi8bIQtcgSl9HRQGFQSBDgU3Cj2CSmlNOgINAjaCJ?=
 =?us-ascii?q?CRZgk2FF4ELg15jLwMDAwODPYJLXYMEbh1AAwttPTcGDhuiLUaDToEOgQDIL?=
 =?us-ascii?q?QeCOIFlohGXUZMALodkkGkiqQmBZzqBXDMaJIM2TwMZD446kx8BsXVCNTwCB?=
 =?us-ascii?q?wsBAQMJhWmLATSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 uGQ3kUD
IronPort-HdrOrdr: A9a23:K7nGWKofnK5SpKZIxYFhjNsaV5uUL9V00zEX/kB9WHVpm5Oj+f
 xGzc516farslossSkb6Ku90KnpewK4yXcH2/hqAV7CZnithILGFvAa0WKP+UyCJ8SczJ8R6U
 4DSdkHNDSYNzET5qyWgWmF+r4bsZ66GcuT9IPjJgJWPGdXgtZbnmBE42igYy9LbTgDIaB8OI
 uX58JBqTblU28QdN6HCn4MWPWGj8HXlbr9CCR2SyIP2U2rt3eF+bT6Gx+X0lM1SDVU24ov9m
 DDjkjQ+rijifem0RXRvlWjoKi+2eGRhOerNvb8yvT9GQ+cyTpAo74RGYFqiQpF4d1HLmxa1e
 Uk7S1Qe/iboEmhA11d6SGdpzUIlgxerUMKgGXo/0cKraHCNU0HItsEioRDfhTD7U08+Nl6za
 JQxmqc84FaFBXagU3GlpH1vjxR5z2JSEAZ4Jgupm0aVZFbZK5arIQZ8k8QGJAcHDji4IRiFO
 V1FsnT6PtfbFvfNhnizyJS6c3pWm52EgaNQ0AEtMDQ2z9KnGphx09dwMAEhH8P+J80VpEB7e
 XZNaZjkq1IU6YtHOpALfZERdHyBn3GQBrKPm7XKVP7FLsfM3aIsJLz6KVd3pDfRHXJ9upGpH
 3saiIqiYdpQTOeNSSn5uw6zjnddmmtVzXkzc9T0Z90vNTHNcjWDRE=
X-Talos-CUID: 9a23:4a0x5mHosuo3wbsGqmJ6qm89Os14XEH261fLL0SqElpHUJ2sHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AhWwyfQwX8Fxqpqv8lqGoru0NBGeaqPWTMhoRzZU?=
 =?us-ascii?q?egpS7LyEgERi8kAuoYIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,205,1728943200"; 
   d="scan'208";a="103330274"
X-MGA-submission: =?us-ascii?q?MDHJnQdJa30IfSW4ktpckjP29PI26jMCs4dH7L?=
 =?us-ascii?q?lY1DCv1JqAUc6MIkd/rmpzr/HtHbvx7JJNCgfCeyiAaz9nnvbhUlzh81?=
 =?us-ascii?q?c51SW4cuUqWOy8RPB2Gj0qARmSO/bfWSGqjycisXfql4BPcs3deKrXOh?=
 =?us-ascii?q?3tTSCA+EhXLRaFf6Yr9HOydg=3D=3D?=
Received: from metis.whiteo.stw.pengutronix.de ([185.203.201.7])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 18:47:16 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIWyE-0003sq-Mm; Tue, 03 Dec 2024 18:45:58 +0100
Message-ID: <fc624e3fd4a4a38dedf02e31be9e4f1c85fb40a0.camel@pengutronix.de>
From: Lucas Stach <l.stach@pengutronix.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,  Nicolas Palix
 <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ofir
 Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Smart <james.smart@broadcom.com>, Dick Kennedy
 <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Roger Pau =?ISO-8859-1?Q?Monn=E9?=
 <roger.pau@citrix.com>, Jens Axboe <axboe@kernel.dk>, Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jack
 Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo
 Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,  Josh Poimboeuf
 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes
 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
 <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian
 Gmeiner <christian.gmeiner@gmail.com>,  Louis Peens
 <louis.peens@corigine.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org,
 linux-bluetooth@vger.kernel.org,  linux-staging@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org,  ceph-devel@vger.kernel.org,
 live-patching@vger.kernel.org,  linux-sound@vger.kernel.org,
 etnaviv@lists.freedesktop.org,  oss-drivers@corigine.com,
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
Date: Tue, 03 Dec 2024 18:45:50 +0100
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-9-19aadc34941b@linux.microsoft.com>
References: 
	<20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
	 <20241115-converge-secs-to-jiffies-v1-9-19aadc34941b@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 09/22] drm/etnaviv: Convert timeouts to
 secs_to_jiffies()
Reply-To: Lucas Stach <l.stach@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 2154
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/fc624e3fd4a4a38dedf02e31be9e4f1c85fb40a0.camel%40pengutronix.de>

Am Freitag, dem 15.11.2024 um 21:22 +0000 schrieb Easwar Hariharan:
> Changes made with the following Coccinelle rules:
>=20
> @@ constant C; @@
>=20
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>=20
> @@ constant C; @@
>=20
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>=20
Thanks, applied to etnaviv/next.

Regards,
Lucas

> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/e=
tnaviv/etnaviv_cmdbuf.c
> index 721d633aece9d4c81f0019e4c55884f26ee61c60..0f5a2c885d0ab7029c7248e15=
d6ea3c31823b782 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> @@ -100,7 +100,7 @@ int etnaviv_cmdbuf_init(struct etnaviv_cmdbuf_suballo=
c *suballoc,
>  		mutex_unlock(&suballoc->lock);
>  		ret =3D wait_event_interruptible_timeout(suballoc->free_event,
>  						       suballoc->free_space,
> -						       msecs_to_jiffies(10 * 1000));
> +						       secs_to_jiffies(10));
>  		if (!ret) {
>  			dev_err(suballoc->dev,
>  				"Timeout waiting for cmdbuf space\n");
>=20

