Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D200BD68BDD
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KRAKVqkmYHFKsYpIbPFWmWMGYVvfzvIpOOiOmhExdwo=;
  b=txxmdOJ18OKA4+PkD7wLisARcWAwEYP+zneGPwps/r2wqV2xuqZ4M05a
   9eRJYrVb7FEkIWjOVE9XTCJn3X0RopUoaAQ4jVkp3hbP9c3+1endja2Jt
   cpkjyyMPT375gelDGecaTxS7Gm9hmzFZKO/cUa9Fu2bZhcCPDQRBrUjNG
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169429"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B030CE0D61; Fri, 15 Nov 2024 23:35:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 461ADE00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:52 +0100 (CET)
IronPort-SDR: 6737bbab_DE4rRhGyA8mND8CLItOMMHqtpdtxHMoWpy6W/88CanE/w7T
 wgVm8nWOVlp+jMQJHxOT2CQqLDa5S/WoFqr538g==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8lAiYCAkYQBgESgwGCZQYCn0wBh2ABAQKLI4EygQGCDAEBBoJn2?=
 =?us-ascii?q?TiBZAmBGi4BiEsBgWyDfTuDQnonG4FJRIFKgzOECk6DRoJpgkWFEyWFBoN5m?=
 =?us-ascii?q?XgJP4EFHANZIREBVRMNCgsHBWNXPAMib2pTeiuBC4EXOkKBO4ETLxshC1yBK?=
 =?us-ascii?q?YEaFAYVBIEORj+CSmlLNwINAjaCJCRZgR2BMoUahGxAJy8DAwMDgzyCTmQuH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefAkaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hg3qPPgG2GUM1OwIHCwEBAwmFRgEBiVs0gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1BeZoq8b+5/Xpr6jYBBuk+DiI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re/8jztCWVtN5yMEtLpTnkAsS9qBznmqKdjbN8AV7mZniDhILKFuBfBPXZsl/d8kTFn4Y36U
 4jSdkaNDSaNzZHZKjBkW6F+q4bsaC6zJw=
X-Talos-CUID: =?us-ascii?q?9a23=3Ac0rTR2tHmVRcxgtzMkc7Erm+6IsCL2KB6SrtKXS?=
 =?us-ascii?q?ZMkZ2EaKPeE+OoIp7xp8=3D?=
X-Talos-MUID: 9a23:R6fgZwjH8Q8PjaFknmRZzMMpPst22ZTzUH8xkJwlu5eFBABeZQ+TtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770986"
X-MGA-submission: =?us-ascii?q?MDEQ5VMaxM5FDUhP42GEUZzt+2DuxX2XWse5kI?=
 =?us-ascii?q?aR5FVWwk+tS8gdsNSsbGgeBgvKXR6Icbx/cIEFiTpWEWuxOk5ja4rRbV?=
 =?us-ascii?q?YzwVDikbnEYVBQF3LJwo7p/+oDWRBMpTdVrkrfeCnWEbXCJM8syz5PEW?=
 =?us-ascii?q?4yQUabvtgX5jmHZl3Z5x1OcQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:52 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6E2AB20BEBD3;
	Fri, 15 Nov 2024 13:22:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E2AB20BEBD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705764;
	bh=KRAKVqkmYHFKsYpIbPFWmWMGYVvfzvIpOOiOmhExdwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Go0aUNLY+uBRc1gulf22NPnT4wn803j0Yofkqbh+DxXkzhV99tx8UWceKEAkUZyjD
	 tejuZgR0LF67pK/elmBAeNnO4NhzZ4R+VTUBXRegmJhIlArTFy4HXwc9kGMh3mQr02
	 7PyIpQ3LVnHfWOT4NY7AkEac4yki6LEIgx0W/av8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-12-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 12/22] scsi: pm8001: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2017
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-12-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca12c2555419197ecdbebad817e4a6d..be88890716cc152b4687edf5e204d14bd177e188 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -734,7 +734,7 @@ static int pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
 		return -EIO;
 	}
 	time_remaining = wait_for_completion_timeout(&completion,
-				msecs_to_jiffies(60*1000)); // 1 min
+				secs_to_jiffies(60)); // 1 min
 	if (!time_remaining) {
 		kfree(payload.func_specific);
 		pm8001_dbg(pm8001_ha, FAIL, "get_nvmd_req timeout\n");

-- 
2.34.1

