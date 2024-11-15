Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620FCD68BDC
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YTcGWD0h0ZDgyuZTU2DPl12ZGyATdibDkhzA92Hlf6s=;
  b=ezsOy50zxlWblRDnrnFczO0St9PyGKqdZj2iRBAkvZ5e9ZPFcxzX8nv6
   nYGOHzUr6dnxNboxTSVy00rhDWDgQS8RJl6vxajfNL0ZnBsMSLFB7nKGn
   XdHvuRlnBd9wY+0NLKlYBM80mh2+EXxfyWVr3WxbirsSiKDwL9q0bIs4o
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194170067"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79E6BE0E10; Fri, 15 Nov 2024 23:36:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C6365E013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:49 +0100 (CET)
IronPort-SDR: 6737bc99_pOq9FwpvEjJbG3FkC37DJx7ht8PJL+dZY6qeLyLw/yUwM34
 3pOLzZD4eLXjVVjyJWa6+SdNQb0KhMY5/8PtSYA==
X-IPAS-Result: =?us-ascii?q?A0EgAADnuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9LAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoEGgi2EWINGgmmCRYUTJYUGg?=
 =?us-ascii?q?3mZfgk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7gRMvGyELX?=
 =?us-ascii?q?IEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA4M8gk5kM?=
 =?us-ascii?q?h1AAwsYDUgRLDUGDhtDAW4HnwRGgzSBDoEJlH2DdY1CoWuEJKFdATKqTi6HZ?=
 =?us-ascii?q?JBlIqhUghg6PIEgRgcjFTuCZ08DGQ+OIQkDFoNYjz4Bth5DNTsCBwsBAQMJh?=
 =?us-ascii?q?UYBAYoPgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:q6ICJayvIFGCBDsUdAHyKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: 9a23:krnJBmCIdRNfz3D6Eytl1VMGGewkTibM6lr/CmuULntDWITAHA==
X-Talos-MUID: 9a23:ZwnMgguUsqJBkLCwNs2nwzRmb+NBvvmXFB4hwJYaqcicBR4hAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166036"
X-MGA-submission: =?us-ascii?q?MDHWpT+rTETVWu84MjN2nFDbkexwP+qtTj2cBS?=
 =?us-ascii?q?VX/YtmylFreWbs7C4/mhHZuu/XPT669fwcfL+KavVMVYb3padjh9wzzw?=
 =?us-ascii?q?QlxclbEYrnErLjOiavOuQ2BTwiME7zr+bz4zHHkrT5B+ihK9d2303Eqt?=
 =?us-ascii?q?lk/kMq4JWkRDc2gGuPihpz7w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:26:48 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D67F23834C7;
	Fri, 15 Nov 2024 13:26:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D67F23834C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706004;
	bh=YTcGWD0h0ZDgyuZTU2DPl12ZGyATdibDkhzA92Hlf6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kgi+n57xgjrI+4Gqepq6GlPnqUO2pihV1Dud4yQ2c1OZjf2P0xDWwr3M3tR1eBq1a
	 vDVbKDgW5iQn+Dgdp88SCgfK7MyuioOzZEhii+W9EEl6/VO7bUxJqfEKNKtLWDwsua
	 4MilbVg5zRzDEtFWaobQFW22HSHuxVekSW69j0Ag=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-14-911fb7595e79@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 14/21] gve: Convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2042
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-14-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index f879426cb5523a7e150f363b5e57b9d472b5817c..394debc62268aadf2579f9b516e045cb48287e7c 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -1146,8 +1146,7 @@ static void gve_handle_miss_completion(struct gve_priv *priv,
 	/* jiffies can wraparound but time comparisons can handle overflows. */
 	pending_packet->timeout_jiffies =
 			jiffies +
-			msecs_to_jiffies(GVE_REINJECT_COMPL_TIMEOUT *
-					 MSEC_PER_SEC);
+			secs_to_jiffies(GVE_REINJECT_COMPL_TIMEOUT);
 	add_to_list(tx, &tx->dqo_compl.miss_completions, pending_packet);
 
 	*bytes += pending_packet->skb->len;
@@ -1191,8 +1190,7 @@ static void remove_miss_completions(struct gve_priv *priv,
 		pending_packet->state = GVE_PACKET_STATE_TIMED_OUT_COMPL;
 		pending_packet->timeout_jiffies =
 				jiffies +
-				msecs_to_jiffies(GVE_DEALLOCATE_COMPL_TIMEOUT *
-						 MSEC_PER_SEC);
+				secs_to_jiffies(GVE_DEALLOCATE_COMPL_TIMEOUT);
 		/* Maintain pending packet in another list so the packet can be
 		 * unallocated at a later time.
 		 */

-- 
2.34.1

