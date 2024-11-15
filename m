Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5496DD68BDE
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YTcGWD0h0ZDgyuZTU2DPl12ZGyATdibDkhzA92Hlf6s=;
  b=PN31F0v6YGKn0sj0L/0aX5am7JNG9ApUjCZ4ftO80av0pwWhSVooV2p/
   jjCwegXn7LKcs7qgab0aYuSNxe7M927SYK8OsxufpUFlm2idS02nVoliq
   6y1l81eNOYjaKfVIogzOZ96zu6p2ps73yDyxipksH2qHlORvD9UoufpfM
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169478"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E57BE0D62; Fri, 15 Nov 2024 23:35:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8E886E013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:52 +0100 (CET)
IronPort-SDR: 6737bbac_jFF1JDTRBvq6qjUFy33FKFKJDltn4w4XD7FpMvbsQrLFHO+
 WFV3N39bP6Mq97XHxVXuPP3Cpo1H8NMr5+sGtPA==
X-IPAS-Result: =?us-ascii?q?A0EgAAC+ujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9OAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoEGgi2EWINGgmmCRYUTJYUGg?=
 =?us-ascii?q?3mZeAk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7gRMvGyELX?=
 =?us-ascii?q?IEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA4M8gk5kL?=
 =?us-ascii?q?h1AAwsYDUgRLDUGDhtDAW4HnwJGgzSBDoEJlH2DdY1CoWuEJKFdATKqTi6HZ?=
 =?us-ascii?q?JBlIqhUghg6PIEgRgcjFTuCZ08DGQ+OIQkDFoNYjz4BthlDNTsCBwsBAQMJh?=
 =?us-ascii?q?UYBAYoPgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:h3HY6a4zwtzGZlw9/gPXwPLXdLJyesId70hD6qm+c20yTiX+rb
 HMoB1773/JYFR4YhsdcLW7VZVoLkmyyXcY2+Us1PKZLW3bUQiTTb2Kk7GSoQEIcheWnoVgPO
 VbAs1D4bbLY2SS4/yKhzVQa+xQueW6zA==
X-Talos-CUID: 9a23:8tzV4W0tvDduUGUK9D+pw7xfCMEFQnPtySjpKUKcBWp3YZTLYAaw9/Yx
X-Talos-MUID: 9a23:cVt49ATUaZ7yZSELRXTjwxxNBf1L556SBWA0jZk6pM+kdiZ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194165768"
X-MGA-submission: =?us-ascii?q?MDEzo0h8yQTkZ2Oh/Nj43MBh2/P1w+LEdbMxRV?=
 =?us-ascii?q?LKHDw9VAdu/Ppx0atLW2XHr9YBqJKozh6pdcg0LJ7iJuqvXQsIggtyMI?=
 =?us-ascii?q?80eT1YA48ourIDS1Gi7sUqGuKhwltoVWy+7P9Ty5yv3GkkGiTI6R+lQj?=
 =?us-ascii?q?LQBc9ysxmEH3HsxGEKR4eZEA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:22:51 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA1F220BEBD5;
	Fri, 15 Nov 2024 13:22:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA1F220BEBD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705765;
	bh=YTcGWD0h0ZDgyuZTU2DPl12ZGyATdibDkhzA92Hlf6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DBa8qjnf5MNMswOkSvV0JQ0FZ5Ed99ngIFRkSTMDnQu36t8YmBRJOYBHSU3QDj3se
	 Fc7TuS2jcyT4LTDRPo4wVBYTyNbI1RA/bW4apXI30r4Q7ECcxM6eooQMWk2K6CFIVq
	 CFABxdq7HpjQyK3+DUwbjslOaeOI5LwZ/vHYLMt0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-14-19aadc34941b@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 14/22] gve: Convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2018
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-14-19aadc34941b%40linux.microsoft.com>

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

