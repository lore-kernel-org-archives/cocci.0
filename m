Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA118D68BDF
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Q64Lap8gGilYnZS8wBYuXVtg6CkDWFgIDR5hpRb/qKY=;
  b=X8PH92vJbRemA8sU3At/6B9MbPYQt4WqEtuoaD/yqeFS5uQK9v70i3t0
   Hi8rNIiJvAAnBkV7dAvTzheinSaSiVN70z8mqRWrHzWGKipemshlXJ6jR
   kMXkx6KP54r48e90uQyAUT5OvuikkO4xqZuzlIRVmaWi34jjJvlXHG4Jf
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
   d="scan'208";a="194169144"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35B62E0D2F; Fri, 15 Nov 2024 23:35:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AE9EE0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:47 +0100 (CET)
IronPort-SDR: 6737bba5_np563BfNlRTsO3PN2cxlFLwLsaUSXkhqD69HBlhq40nq8P1
 gzQGZ0BqkvICHqfMNQt3c5qYFeNTweA+Bb7PDRw==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?UEIMg2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4CA?=
 =?us-ascii?q?QMREh0BATcBDyUCJgICRhAGARKDAYJlBgKfTAGHYAEBAosjgTKBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGISwGBbIN9O4NCeicbgUlEgRU1gzOEWINGgmmHWCWFBoN5m?=
 =?us-ascii?q?XgJP4EFHANZIREBVRMNCgsHBWNXPAMib2pTeiuBC4EXOkKBO4ETLxshC1yBK?=
 =?us-ascii?q?YEaFAYVBIEORj+CSmlLNwINAjaCJCRZgR2BMoUahGxnLwMDAwODPIJOZC4dQ?=
 =?us-ascii?q?AMLGA1IESw1Bg4bQwFuB58CRoM0gQ4odYEMk2eDa41CoWuEJKFdATKqTph3I?=
 =?us-ascii?q?qhUghg6gVxGByMVgyJPAxkPWIJoimGDeo8+AbYZQzU7AgcLAQEDCYVGAQGKD?=
 =?us-ascii?q?4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:+OjN/ajVBvoy1uKAIecg7H3PW3BQXuAji2hC6mlwRA09TyVXrb
 HJoB19726WtN9xYhEdcbLpAsO9qBbnmKKdjrN/AV7PZmXbUS6TXeVfBOjZogEIZReOlNK1vJ
 0IG8ND4Z/LfD1HZK3BjjVQfexQp+VviJrY/Nvj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3Axr4gg2lf9jlW2NwGBYalJ0euZ7fXOUXFj3zre2C?=
 =?us-ascii?q?oNTlScp2QS2DToJF0mMU7zg=3D=3D?=
X-Talos-MUID: 9a23:ZVri4AaDcKLooOBTmB3LqDBCL8dTwKWABlAIwK4ZhPaZHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770971"
X-MGA-submission: =?us-ascii?q?MDH2l69vZBAL6oGFyzZzRq8GJCtu+8O0zgTF9M?=
 =?us-ascii?q?+8C1P/vWfEKhwyPHIhaA10vO1PnhkhaIOfTjsohJ6JByasdFr4FGrSH5?=
 =?us-ascii?q?+zCl/AmvGFApzJv9NLJzJP8Any6xpWXiklEyUljdLcQK9hK0TxBclB1R?=
 =?us-ascii?q?588MVygJWxrXSSVmLzOV3jzQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:45 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1682D206BCE4;
	Fri, 15 Nov 2024 13:22:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1682D206BCE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705762;
	bh=Q64Lap8gGilYnZS8wBYuXVtg6CkDWFgIDR5hpRb/qKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TpPSBC6Q0pyCMIPKcOfsvZX/wWIHu4+ejmKY8xw+0GecDvIAUfgwshz01AoOkZ0WD
	 k4gHIei/egZSo7W0NlMAlHYHatQ5bzRsbZtX1NOQvIcE9aFKMDcUHtqmglM484AIGB
	 /3Fdhfw7EN1qT/zCvUp8095p9P9VmicZ+TZgDM0I=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-1-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 01/22] netfilter: conntrack: Cleanup timeout
 definitions
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2007
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-1-19aadc34941b%40linux.microsoft.com>

None of the higher order definitions are used anymore, so remove
definitions for minutes, hours, and days timeouts. Convert the seconds
denominated timeouts to secs_to_jiffies()

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 4cc97f971264ed779434ab4597dd0162586b3736..6c95ac96fa42a39acafb5b88a7cf8898010e911c 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -39,20 +39,15 @@ static const char *const sctp_conntrack_names[] = {
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= "HEARTBEAT_SENT",
 };
 
-#define SECS  * HZ
-#define MINS  * 60 SECS
-#define HOURS * 60 MINS
-#define DAYS  * 24 HOURS
-
 static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
-	[SCTP_CONNTRACK_CLOSED]			= 10 SECS,
-	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
-	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
-	[SCTP_CONNTRACK_ESTABLISHED]		= 210 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
-	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
+	[SCTP_CONNTRACK_CLOSED]			= secs_to_jiffies(10),
+	[SCTP_CONNTRACK_COOKIE_WAIT]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_COOKIE_ECHOED]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_ESTABLISHED]		= secs_to_jiffies(210),
+	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= secs_to_jiffies(3),
+	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= secs_to_jiffies(3),
 };
 
 #define	SCTP_FLAG_HEARTBEAT_VTAG_FAILED	1

-- 
2.34.1

