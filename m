Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33D1D68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DTjXQ8JEnxKHPkRfiey8gv8xkSCkh1L+oMakOx6bumQ=;
  b=OooLcbIbBOv01OOWlIfm5mWDJGzJ+HXAwIz1I50cTRVQDcPsy/5a7QfN
   9I6BhOaHv+yTB5v9kHTeomsj1j1t08WfsB+yc94e37MtLKq64n4Q4tT1M
   aeXrr6I3ekTabhWjMAYp+T/gu9WToMkDaBTykx7Fq5rihEPNjJQtms4Zl
   U=;
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
   d="scan'208";a="194169584"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05AC1E0D2F; Fri, 15 Nov 2024 23:35:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E1A99E0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:53 +0100 (CET)
IronPort-SDR: 6737bbad_lU0TH10ylto1zSHCunGJp1N9WdHDxIqojKg2u7H+NRtSMvi
 Z7NPiDNo1ixIk5LKd1yik2w8I1XXdtK/dLKAiiA==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8lAiYCAkYQBgESgwGCZQYCn0wBh2ABAQKLI4EygQGCDAEBBoJn2?=
 =?us-ascii?q?TiBZAmBGi4BiEsBgWyDfTuDQnonG4FJRIEVNYMzhApOg0aCaYJFhRMlhQaDe?=
 =?us-ascii?q?Zl4CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQuH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefAkaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hg3qPPgG2GUM1OwIHCwEBAwmFRgEBiVs0gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+9MRGq/Hj1tN0zoW5fNuk+DiI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re/8jztCWVtN5yMEtLpTnkAsS9qBznmqKdjbN8AV7mZniDhILKFuBfBPXZsl/d8kTFn4Y36U
 4jSdkaNDSaNzZHZKjBkW6F+q4bsaC6zJw=
X-Talos-CUID: 9a23:Gmuu7m4af5UR2fV4dtss0xMLRuV4T3fm7UzwPBanE1d5VuW8VgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A/0FEVg3lr/K6sW0vEGkEedGDaDUj4aKhEWIcgag?=
 =?us-ascii?q?/gczHCnx+BhG3rTSpe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770991"
X-MGA-submission: =?us-ascii?q?MDFBCDMTzvxFJf1k37SAj4HRof+n1r2bCbZt1v?=
 =?us-ascii?q?zRvWo59TVz1NFimrmrtZxvnqhXeJ8duC60TZXMFCSXy/Y35sf2oTZHkb?=
 =?us-ascii?q?udCDYGFjwSLmnugaGqPU8/xkMl4KOv8q/yHL5M1WaftE8vN1en0A9MG3?=
 =?us-ascii?q?uSTsTm06bPaW1dL/gzOqiquA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:53 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F33820BEBD7;
	Fri, 15 Nov 2024 13:22:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F33820BEBD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705765;
	bh=DTjXQ8JEnxKHPkRfiey8gv8xkSCkh1L+oMakOx6bumQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PrkdMSJsCXq7e/LVXAIqADh6VOx2LSK3q8Voqjd439eNhh8b6N4u5aB1nfKzAe2Tm
	 +kT+vzsuhI8O0/+YRjBVlaEQ5kmFrot1X5DGJclM8+YlYZkjA4xQVjB3ZX/xX3Lrsj
	 FbrAa2GDIV5JdurdApM8LMcIFqaWmUwvCMzOiXGc=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-16-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 16/22] Bluetooth: MGMT: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2021
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-16-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a429661b676a83ec2d34ed7e228195f39a153f9f..ca89c26d04ec64869e6b99de099d343f4c548ce5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -209,7 +209,7 @@ static const u16 mgmt_untrusted_events[] = {
 	MGMT_EV_EXP_FEATURE_CHANGED,
 };
 
-#define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
+#define CACHE_TIMEOUT	secs_to_jiffies(2)
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"

-- 
2.34.1

