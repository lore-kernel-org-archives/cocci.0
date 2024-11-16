Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9615D68BE8
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=O5PjtYH+5GXLxl62kwij/A+XbSGB871bwcSxOeRKekY=;
  b=beBWLO4yRQfVBfKRUfFBSG6d897ZINU1O82QRsJqiFpYdc/8197B00f8
   +40cYhuia109PNJpb1U4iGNmNqHJhuyURKoKoKPHncmLoZlr8swMNA0w1
   EEla2tRJR0pHTZpehuZRCnwQz5qLmEGLIxeGXmxe6osw7gl6MrUaJSUCa
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@cs-soprasteria.com
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204842"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12473E0D7D; Sat, 16 Nov 2024 12:26:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 52EF0E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:23:09 +0100 (CET)
IronPort-SDR: 6738728c_FHQ/3GQAB+BZjSLkQKyWNjUC5vnW26OFpunXI/j9nqLzCYl
 8wrWF+rxO77nUU1gxSRXak93yP/OR4hR3KRXKeg==
X-IPAS-Result: =?us-ascii?q?A0EFAAATcjhnezT3ayhaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYFxUnsCWzIHCEgEhFKDTAOETl+IcgOBE50EgUA+DwEDA?=
 =?us-ascii?q?QsCOwkEAQEDAQOFAAIWijYgBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAUIOO4V7DYJiATNxUQ0DBz0BAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBBQINXgEBHgEBAQIBEggBCAQNDAEBJRIBD?=
 =?us-ascii?q?wIBCA4MAiYCAgIvFRACBAENBQIBAR6CXwGCQSMEAg4EAqRQAYFAAgKJWBo3e?=
 =?us-ascii?q?n8zgQGCDAEBBgQE3XsDBoEaLgGBYYZqAYFsg307gx2BH4JPgRUngks4PoQfB?=
 =?us-ascii?q?gEHLYNEgmmBFIJoB4EsgTMyRCUMh2aBDYFvghCFeIIggT8dHTOCOXaIIwlJe?=
 =?us-ascii?q?3gyAVUTFwsHBWNGERAsAyJvak5/gTaBUQFBgk4vGyELXIEpfR0UBhUEgQ4FN?=
 =?us-ascii?q?wo/gkppSzcCDQI2giQkWYJPgSUEBYNsgQuDYWcvAwMDA4M8gk5kVR1AAgELb?=
 =?us-ascii?q?T01BgMLG0OgDgFGgkMjLx8BAhRrDisFS0F0DjctVwGSFTOCb0mPFqAXBgErg?=
 =?us-ascii?q?3KEb4cnlTIGQqpOLodkjgaCXyKEeIZtgXiVVh2FCwIEAgQFAg8BAQaBZzo8g?=
 =?us-ascii?q?SBwgW6BSU8DGQ+OIQsBFoNYhD5WiioBtmZENAIBOAIHAQoBAQMJhkiIBxAXD?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:uGm8RqjDsKx00Utepopn6f1kzHBQX3533DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICRF4B8bpYOCUghrTEGgE1/qu/9SAIVy0ygc578
 tdmsdFebrN5DRB7PoSpTPIa+rIo+P3vJxA592uqUuFJDsCA84P0+46MHfjLqQcfnglOXNNLu
 v52iMxnUvERZ14VKSGL0hAe9KGi8zAlZrgbxJDLQUg8hO2lj+t6KT3CVyxwgoeeykn+8Z6zU
 H11yjCoomzufCyzRHRk0XJ6Y5NocDszttYCNbJotQJKxHhgAehY4R6X9S5zWgIidDqzGxvvM
 jHoh8mMcg2wWjWZHuNuhfo2xPtynIH92Li81mFmnHuyPaJHw4SOo5kv8Z0YxHZ400vsJVXy6
 RQxVuDu55WFx/b2A/WzbHzJk5Xv3vxhUBnvf8YjnRZX4dbQqRWt5Yn509QEI0NBmbBwqVPKp
 gyMOjsoNJtNX+KZXHQuWdihPa2WG4oJwyLRkgZttbQ7iNfm2phyVAE+dcWkXgB/q8sUpUs3Z
 WfDo1Y0JV1CuMGZ6N0A+kMBeGtDHbWeAnBNGKJLU6iHKYbO2jVo5qy+r884+utf4EF3YZaou
 WQbHpo8UoJP27+A8yH25NGtjrXRn+mZC/gzsFF64I8vrHnXrLkPTeEVEsln6Kb0qkiK/yef8
 z2FINdAvflI2erM51OxRfGQJVXKWMTSokSodY0W1WHp8jPKoHsq+zDePvfP7b2C18fKz3CK0
 pGeAK2CNRL70itVHO9qgPWQWnVYUD6/Yh9CuzC5O4YxJIWOoAJuRhQilKk/caCLD1EvMUNDR
 hDCYKitpn+iXi9/G7O4WksEAFaFFxt+7nlU2lHv0sWKEvya68EoMiDYmhc03uMOw9nQ6rtYV
 9ijmUy3ZjyA42bxCgkBd7iGHmdlWEvqHWDSIpZsrGf5O/+E6lIQKoOaehUL0HmBhZ1kQFlpC
 NocwkfXHLSETvolOGMkIEUPufCbNNx6T3bYPK86Eiv9Xl0l/tfBEfzbATeFPJ/RjxeAwa8s2
 cBsJP3RoDw3gpHZ1FPxtjQe2c8FVh/SIg2cDhtzr8kyIwDPjsAAltizAbq9S3aMADRhjovr3
 2kIiuOdf7RBF1B/nhez6bx6VtxMn6QZkRqdxlBwPtA/En9ywJOONWwF92O+nrUbkFHzvAWMT
 nDbzdXKgRyx8qv3BrQnDqZD30pypgnI+SYVd0YAvnu82LoLJfNmbANHvdS8pogPNfysvUTWe
 bafwOONjv3B+4gxgTQrHc4Pyt/rmUijJrTqVTYxXn92GR6DevZIVxgSb1eK9aA73L8T/LNy5
 l9hcJdh5rEDowwUK/19Uj6VU8xFvqImx/GcwgBk+ElgZ4P
X-Talos-CUID: =?us-ascii?q?9a23=3A6YMonmqQQnSUNu7GzIb4ebHmUe5/clzU8TD7HxC?=
 =?us-ascii?q?bJkdSS6y3ElGs6bwxxg=3D=3D?=
X-Talos-MUID: 9a23:6gCeTAT9Qhgd6S1SRXSwiDNhMc5qxp2eM0MvipEvvPa1PHRZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194200241"
X-MGA-submission: =?us-ascii?q?MDGz0EDYYXEAEoMpuXMwQcAz1C7SvKyWZfVxPi?=
 =?us-ascii?q?m6XlgN6/Wp0sFo6SWhIH+7pMEwi5U3OcW5WP6Uy//Jyl/ZYLhoxSW8TR?=
 =?us-ascii?q?yRPj35uYF3wDKLMSMZDlR7wn5PSMTiCYFtZQaVgsZwcThUujXNZLaE3Y?=
 =?us-ascii?q?Fkdwd1TeByWffRjV9XeApuVQ=3D=3D?=
Received: from mail-am0eur02on2052.outbound.protection.outlook.com (HELO EUR02-AM0-obe.outbound.protection.outlook.com) ([40.107.247.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:23:08 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4J35la4mCZE62aD1tsFleEKSbIrrraqp281Ug0l8B0oyfA/MQbj8d7fnFBCM9e0Tz8ek2YRc5Vx5yWb/FVtPWKfGNnM3GCb/vGaDqhtS5ikHKKxpoUezC62hMb7Nb7H6U6A8xcrI0YeKjXwZM2eCm7T/lFbdYF9RwIV3UjVK3/WDMEFa52FwCG5Dielp/f1gJ/4tDweGnJWMXSK0VdUxy/UDlkICTxNInq1V6bWvShabTJQhX7W+p42VpPb/ZmrYdIC3cADtWI+JfnfTjSfqFtin07hTQeHKe00i8gUjkFz8kPzlbzsncYKGulo2SYWkhdWyk8fg75M4zJPEieqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5PjtYH+5GXLxl62kwij/A+XbSGB871bwcSxOeRKekY=;
 b=rUC2hbhhQ1xwjJdTSSEZ09W5b14+V7Agn8/2BSfIcANk3iuTAVC/HmG6jCw6POMPzHBU2Q1Onl7LEaw+in9QFoA9vhxeWIeTCWEfTUWZQVqvIX9ALNBKJF5K60w0Zq1yICGcI3+MuEzEk+8S9X0S8TUmHfwke70mygWCYQK64R82eXEh8T9i2xPZZO+2GdiUZ99+68Eo5sT610cUd/kDoc+sCrP/cO1vObwGnbeI1CC0R1A6RpWDSE9PxGd2Ut5UAhsOAvSp2WzMPgsZk2p0eWVm9Mij3iSogWnAU+UWOt/4mRMC+2x0Df5d42fVEAp1veeczgrRHlsjAh84cDLnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5PjtYH+5GXLxl62kwij/A+XbSGB871bwcSxOeRKekY=;
 b=YwHWRSfUeypGZWW27iq88iMUusI2nY+Z8Nc6LYbh9g6B78o9YgManTmNN1wvp1ivCjbruvzweVyniISfd3o31NJk+vvDkBU6LIzchLZkcJsGHLO/eKmDCXk1caq1uT5hRIJ+FwwYs5k+YgF9eMS0nMQS+bcpG6a7NXgMgNIAfvP5lZ226bUpIe62Uop/Tfk/JKVFKMHqhcp9C1DknMBkrRwVR/ddRnCW9ApXUBfTU10mE0v9jKS76xIurQU/hW7c3XXAzMcIsIuJ50sBVqH7mas0T0bxZaKYNrMElGbGClduk3AhweYYUw8zH57oOYxP3e8ue5bsN6jiX+hKhVvcuQ==
Received: from AM8PR07MB7443.eurprd07.prod.outlook.com (2603:10a6:20b:24d::10)
 by PAXPR07MB9604.eurprd07.prod.outlook.com (2603:10a6:102:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Sat, 16 Nov
 2024 10:23:05 +0000
Received: from AM8PR07MB7443.eurprd07.prod.outlook.com
 ([fe80::e817:d7bb:61fe:296a]) by AM8PR07MB7443.eurprd07.prod.outlook.com
 ([fe80::e817:d7bb:61fe:296a%6]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 10:23:04 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, Pablo Neira Ayuso
	<pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang
	<haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell
 King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, Oded Gabbay
	<ogabbay@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand
	<shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, James Smart
	<james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, Jens Axboe <axboe@kernel.dk>, Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jack
 Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li
	<xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes
	<mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
	<joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, Russell King
	<linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
	<christian.gmeiner@gmail.com>, Louis Peens <louis.peens@corigine.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
CC: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "ath11k@lists.infradead.org"
	<ath11k@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-rpi-kernel@lists.infradead.org"
	<linux-rpi-kernel@lists.infradead.org>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, "live-patching@vger.kernel.org"
	<live-patching@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "etnaviv@lists.freedesktop.org"
	<etnaviv@lists.freedesktop.org>, "oss-drivers@corigine.com"
	<oss-drivers@corigine.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>
Thread-Topic: [PATCH v2 00/21] Converge on using secs_to_jiffies()
Thread-Index: AQHbN6USSIGB1JJt4USQhi0ekmT7q7K5s7+A
Date: Sat, 16 Nov 2024 10:23:04 +0000
Message-ID: <fb97b58c-4d77-43d1-88a0-d838d5030d3e@cs-soprasteria.com>
References:
 <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
In-Reply-To:
 <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7443:EE_|PAXPR07MB9604:EE_
x-ms-office365-filtering-correlation-id: 069e4311-2c91-4258-60ba-08dd0628a82f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018|41080700001;
x-microsoft-antispam-message-info:
 =?utf-8?B?alhwblFZdzJEbVhRRWFtSzdkbk9DZjZ1N0F6TUl2WWtDZVJjYjZwTlp4TnVx?=
 =?utf-8?B?bFhXaFNXZ1N1ZTBXSFl0Qk5ROTNuQjhEekxtcVdRK1RvdmNtVzFoQXJ4WlZL?=
 =?utf-8?B?NHdRRzBTalpvQ1NjWW1IZzJ6WGJJR3R4M2J4V3EreVh0SWJEd3lnT2c4U2NN?=
 =?utf-8?B?N2htVVFNZW43SE5DT2xpVUQwWVJ4RXZnTkRidlhnZkxPSGNwV0RxSXB6MWtE?=
 =?utf-8?B?L3dsUnBwRlIrQm13QlBTK2k2MEs0ZVROenEwRWE3eVE4SlNiQVFvZk5ielhj?=
 =?utf-8?B?TEl4ZThxS0w4ZldtSVlGY1AwbU9qUXI1M2ZJeWQ2RjdvMngvNllIT1VrYzlW?=
 =?utf-8?B?bThYYmtPc1hxZW9iY3d1ZEZSWnlId2JaUmpmMzJ1bmdnSk9WMjFJbkN0ZTUz?=
 =?utf-8?B?SFh2dVZBQ2VBeWY0UGFpT2xXUXBkYVR5LzMwR3BhbzRJeXpGbTlpSGxIRzJP?=
 =?utf-8?B?MDViNjUwenlZVVZMTDNBd1ozS0pDVExXaDlRSk8yYk9EV0U1cnZCdXR3WUxx?=
 =?utf-8?B?WXgwNHZCYUY5SFdRVEZFMDFOYkVGVm1BR3F4MEdTdHh1eHZZaUxSS0EwK1lF?=
 =?utf-8?B?T3dCYlpaNFFRRnRkRDJLTnRxNzZpeVF2NUN3a0t1QVhUQzVWWmFKbVd4cXFO?=
 =?utf-8?B?TXpWV0hYTTJLTWhrZ0lLYzRqc01Wb25ZcEppNGliWmRReVJoZjhJaWNpeXlT?=
 =?utf-8?B?akZpakl6aXV0YVFFd1loT0Zya0NuVGxkNjdWYlR4dzk3NlRCS090NlFmWEdm?=
 =?utf-8?B?TjNtQ3I5T1dDRGVsc080Ly84ZEJpa2c1MWxEUnBETjVsajZTZWtLaWEyR3lt?=
 =?utf-8?B?dnMwdzd2MUwyb2RzS05qcUo0MVR5dHNqb2lubUNlaTNvYjA0dldqd28xUXF4?=
 =?utf-8?B?c0o2Zi9qVGxkeTdxQ2Jsb0pocGNHNkdTemIvVitIbXo0QUVQM2pGU2JMcXZs?=
 =?utf-8?B?VU9nZ0ZOaThvMHV1VnFJazI3M1I3Q2FqbnNkeElzS3N3YUpGSFdyNXR0bmZZ?=
 =?utf-8?B?Q3V0bVo5b1JWMm1wWGpjRE0wcVBFQlNxM0pCaDlOaFErU0ZzL0JkcmovYWha?=
 =?utf-8?B?YldxS3YvLzNOMi9PRDZDK3dGd0h2TDVPcVNqcE1UN1UrT2xRUWFlUndrQkR6?=
 =?utf-8?B?d2ZPRm9SZSttdGdSa2FoQ0Y2VFpDdVhUOGRYVDRZd1RRb2lNNFRHOUZ1QTNT?=
 =?utf-8?B?bW9BU2hFQSs5cTZZbWtpMzJxeFRHZU1HVVkxc0RNVlRsSkxMcFlPaHdoelpq?=
 =?utf-8?B?RjN4Mm9WRWMrNkxuWkF2MGV1eE5PRmJZRTFxZ3NpZEtqRHNsYWJwRk4vUm13?=
 =?utf-8?B?dXZYRmpvUkEzTTZIMUhNRHV5RmZjT0ZoSEV6QVdDdjlSTlhqK2p4WHZGY0Vj?=
 =?utf-8?B?V1B3LzNkMlB4OEE3OHVldndqbHpEckgzTmlQMWJHRFdiRXMzZk5Pb3JJMUpY?=
 =?utf-8?B?NjdwM0V3SVM3ZHBxYWhpWUQxWk1wV1dmSkl5NkFSUTVDYXBsaXIyT0k5MlVC?=
 =?utf-8?B?Y2VCUUtCT2RUYW9waDV3dHgzYTVrMSsvMnhOWk03eVpDUkZ6cUpzSU5sVXlJ?=
 =?utf-8?B?RUxLSHcvNFRTc2dHTXZWSmM3VkRzdktTOFFwMHlpU2lPd2NqTjUrV3E4dHhh?=
 =?utf-8?B?eDdJUVF4OHVVYWgzckovdkR3OEsvYWQ1eDJuVjNMVW9XbzVLQlRLdHh4a3R5?=
 =?utf-8?B?Mm42NExjZDhGQzdKQVJHcnNscWM5ZGZwVThTSzgwVWpObDlmbzFXRXE5N2tn?=
 =?utf-8?B?QlQvVlpGY2RhN09WRXlrb1NURGlveVdObXd1ODlJSTNkUFErUzRNcHFJcjdP?=
 =?utf-8?B?V2xsVkdEVmZSZ24xTHo5YW9Jc1JyVXR2Znl2cjVsb1BNZXBQWndWZ0prS2t2?=
 =?utf-8?B?RjB3aVJQWnVOQ2NadVU5QjF2V3hGcklMMWh3Y2xEQjd5OHFZbHAveWtYUDJm?=
 =?utf-8?Q?gGIELPEfkvI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7443.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2tWQ2ZrcFdQejg0WkdzZnNPbzhoSmRGZ29zZ2NVU1B1ZGlscnIvSnBGZ0Zp?=
 =?utf-8?B?SmorRkZnVzdjbmFWYWxndk5PcDluTWpEVDhlSksvM3VpbmhkSDFOaElFNUNj?=
 =?utf-8?B?a0dHVnhhenAyNmlxRWlDc0pteHZmbFVyV2IyMVlEZXdCanFYT1hkeDNmMXk0?=
 =?utf-8?B?L2FBczh1c3piRVExdWNmWjhEWEFTWjYzZTBxRGR3SE81TXU0WUZWOVlLMlZN?=
 =?utf-8?B?Ym8xV2YrNnJtOHo1b1p5bXlYV3d4ODhzamIzaDB4ZkFlZ3cxSC9RNDZHVHhG?=
 =?utf-8?B?M1kwalNYV01vbjdGOERpNzJOTzZpc2xCTG1vbHd3VXpzMEY4TEFtVy9SQUZG?=
 =?utf-8?B?T2IzUDhTQ3dycXB0NHluVkNGZXA2NzZzdjBVV2VhblBvVEc3b3d5VFZZQ2gv?=
 =?utf-8?B?OXFRVkpHc1lFcmErY0ozbVczWnp2WC9VMnpRWGFDRVhmWllISk9NWXNScUlS?=
 =?utf-8?B?dUlMOGNWVXlvdTl5eXhQRkV4c1Q1SlljcmxQVTZ3SUVNOEkzSEVEeEJsOUdD?=
 =?utf-8?B?bC9MVVNXNWFnTEdxbXBvMzVBUzlZQnRJZXVkVzRGUDRIYXI5UEUyMmtBSGtz?=
 =?utf-8?B?TVJrZGpJa2EyMURLYk9LNzJ0TlJza1lZaUN3YUF0V0VyVE95aXYvQk5Ta0RB?=
 =?utf-8?B?SlpqblUwbExkQTRCT1ZtN1grL1R5MHo4SytaWU5tTElsL3FtWFFjN0ppTXFL?=
 =?utf-8?B?TlZzWU9KUkxkZXZqWGcyZWd0NmRqMEpQVkIxTmNnSzUrZU9iMldaeUpFd3VO?=
 =?utf-8?B?anJ1YzI5VlN4aVJ4SDRIVHVjVnZjdU9jVGFwa1RzVnZnNEZ0di8vSUt4b0xl?=
 =?utf-8?B?VmhZS0tDWkVYRHUvejVBK1hQTDlPSTlBTVB1L3hEVWUwZFRrdFd2d1ArRGRQ?=
 =?utf-8?B?eFhnT0J6QlRYcmVWS2Ixb29EZDMxc0l6U0VYOHVBK2xhR2haNC92N3F3TkRm?=
 =?utf-8?B?WEhCcEtUb1Y0VndTaFBteWZ5VXJzSStPLzM5NGJjcXJNa01zQWduRFJDdi82?=
 =?utf-8?B?a1FTbnI5RUY0K3NNVEd5U0tIbGtOTC95NUxJNGpVcHRlUWEyVy9XZndOTk5M?=
 =?utf-8?B?aUdTc2JZaExtaVZUVTB4ckRZamF4MFl0OGpZdUFGbkJlZzFQS1hjeUpSTWhR?=
 =?utf-8?B?aFR1aVRvTlUwWCtKVmR3RE9Lc0VUTjllMzI5bmtkODd5VmNYVGQ0S0NRNmRL?=
 =?utf-8?B?SXhnZ2ppVkpMQmdiemEzcHc1TzJ5K1o2eGVxTTNTdkZ3czRZNVh3QlJ2UHVW?=
 =?utf-8?B?UU16REVaWXV0OEVSZVZROWJrMEczd3NRSDZ2Z2VJTVFERE82MG5hZHN2cVMz?=
 =?utf-8?B?dmZtZDcwVk5UU2Y0S0FreGJrbzRzdEh2M29vRkVTNm5wNlFpRGJkWmc0Ym5u?=
 =?utf-8?B?bHlhUHU2UEl6bmpuTTFZaWFkbEpmdkhxNENYTGY3UDliMDVJdFNsUUd2YXQ4?=
 =?utf-8?B?SHdhTkFWTWw3NWlSS2s1dXVwQnNJNjJxbXk3Y29FZ0VvUnp2bDJyU29FRWk5?=
 =?utf-8?B?NklNUlhwdThSRlVaazFPcjVFYlRFRzd2UE9TODVWVjBOQ1VMck81RGRYVnFN?=
 =?utf-8?B?VFFxSTZsakI2SDZyTGJBUDM2OFN3Y3NjU0xJSTNXYXZuYmNzNFhCRW4zR1JR?=
 =?utf-8?B?RFJKMXV2N1ZZSmFFK0QyZ1gwUG15QVVua3kwL2NWZFkvcUdwalJ5Y292bFU0?=
 =?utf-8?B?bDdsU1FjVGZCTCtPL2FtTmN2ZE8ranBpRm0wckdqMGx0L25Sd21NTm1oc004?=
 =?utf-8?B?L2R1Z0F5eHBWZGRId0JqL3hxYVRLcldGb0xmWnEyOEdJMFRaSys4NzAzcWhV?=
 =?utf-8?B?QVBubWRrNUEraVdYRUZET2pxUmhIUjNSMVdVRHJPYTdMT0sxYkxaNU12Y2hu?=
 =?utf-8?B?d3VqWER3R3dEckdXVEVITzRNM3ZqdTFwcjNhRVRqVnJFc2pDcDVCdy9RcGFU?=
 =?utf-8?B?cnpoWXlCN05oa2dwcExKcVVIWjgwN3p5bVNOZTN4ZTNiY2R2T2o0Y2dWN1ZU?=
 =?utf-8?B?dTZqQmNJSXhYbU5PZms0MytJUG81czAvT0JsWldhTms1UlFZK1orT2xrRTgz?=
 =?utf-8?B?ZVRFYTA4amVYVUp5TkFDZ1I1c0tDTllYcmpwMEVaWEVhU0I1Z3hpLy9hQTNq?=
 =?utf-8?B?anRHSnE1OHlpUXJRQ0VGSVo2MXp4VHJ4aXQzNFdTZGVnd0tyaVE1ZjNjWm1l?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE90D1A19E82C47B87FACB873A1B8B2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7443.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069e4311-2c91-4258-60ba-08dd0628a82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2024 10:23:04.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1epJf2BsvuMvFP4MTAMMl9GB+ltZjWIBRqGCJtKjWYZ/HH3sNQKazDwruVImQ3kM3xeQIR3eZI0SpXgwnR9GS0tUWuQOllRnR/fe9IDL3vFO650rVnT+Pou38o9QdaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB9604
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM8PR07MB7443.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: PAXPR07MB9604.eurprd07.prod.outlook.com
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
X-Loop: cocci@inria.fr
X-Sequence: 2071
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/fb97b58c-4d77-43d1-88a0-d838d5030d3e%40cs-soprasteria.com>

DQoNCkxlIDE1LzExLzIwMjQgw6AgMjI6MjYsIEVhc3dhciBIYXJpaGFyYW4gYSDDqWNyaXQgOg0K
PiBbVm91cyBuZSByZWNldmV6IHBhcyBzb3V2ZW50IGRlIGNvdXJyaWVycyBkZSBlYWhhcmloYUBs
aW51eC5taWNyb3NvZnQuY29tLiBEw6ljb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFu
dCDDoCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0K
PiBUaGlzIGlzIGEgc2VyaWVzIHRoYXQgZm9sbG93cyB1cCBvbiBteSBwcmV2aW91cyBzZXJpZXMg
dG8gaW50cm9kdWNlDQo+IHNlY3NfdG9famlmZmllcygpIGFuZCBjb252ZXJ0IGEgZmV3IGluaXRp
YWwgdXNlcnMuWzFdIEluIHRoZSByZXZpZXcgZm9yDQo+IHRoYXQgc2VyaWVzLCBBbm5hLU1hcmlh
IHJlcXVlc3RlZCBjb252ZXJ0aW5nIG90aGVyIHVzZXJzIHdpdGgNCj4gQ29jY2luZWxsZS4gVGhp
cyBpcyBwYXJ0IDEgdGhhdCBjb252ZXJ0cyB1c2VycyBvZiBtc2Vjc190b19qaWZmaWVzKCkNCj4g
dGhhdCB1c2UgdGhlIG11bHRpcGx5IHBhdHRlcm4gb2YgZWl0aGVyIG9mOg0KPiAtIG1zZWNzX3Rv
X2ppZmZpZXMoTioxMDAwKSwgb3INCj4gLSBtc2Vjc190b19qaWZmaWVzKE4qTVNFQ19QRVJfU0VD
KQ0KDQpBZnRlciBhcHBseWluZyB0aGlzIHNlcmllcyBvbiB0b3Agb2YgdGlwL3RpbWVycy9jb3Jl
IHRyZWUsIEkgc3RpbGwgZmluZA0KYSBsb3Qgb2YgY2FuZGlkYXRlcyB0byB0aGUgY29udmVyc2lv
bjoNCg0KRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL21lZGlhL2R0di1mcm9udGVuZC5yc3Q6DQpz
dGF0ZS0+cGVyX2ppZmZpZXNfc3RhdHMgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygxMDAw
KTsNCmFyY2gvYXJtL2tlcm5lbC9zbXAuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQphcmNoL2FybS9tYWNoLWlteC9z
cmMuYzogICAgICAgIHRpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygxMDAwKTsN
CmFyY2gvbWlwcy9rZXJuZWwvc21wLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpKSB7DQphcmNoL29wZW5yaXNjL2tlcm5lbC9zbXAuYzog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAw
KSkpIHsNCmFyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYzogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQphcmNoL3h0ZW5zYS9r
ZXJuZWwvc21wLmM6ICAgICAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGppZmZpZXMgKw0KbXNl
Y3NfdG9famlmZmllcygxMDAwKTsNCmFyY2gveHRlbnNhL2tlcm5lbC9zbXAuYzogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQphcmNoL3h0ZW5z
YS9rZXJuZWwvc21wLmM6ICAgICAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGppZmZpZXMgKw0K
bXNlY3NfdG9famlmZmllcygxMDAwKTsNCmJsb2NrL2JmcS1pb3NjaGVkLmM6ICAgICAgICAgICAg
ICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApKSkgew0KYmxvY2svYmZxLWlvc2NoZWQuYzogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAw
MCkpKQ0KZHJpdmVycy9hY2NlbC9oYWJhbmFsYWJzL2NvbW1vbi9jb21tYW5kX3N1Ym1pc3Npb24u
YzogICAgICAgICAgICAgICAgICAgPw0KbXNlY3NfdG9famlmZmllcyhhcmdzLT5pbi50aW1lb3V0
ICogMTAwMCkNCmRyaXZlcnMvYWNjZWwvaGFiYW5hbGFicy9jb21tb24vZGVidWdmcy5jOiAgICAg
ICAgICAgICAgaGRldi0+dGltZW91dF9qaWZmaWVzID0NCm1zZWNzX3RvX2ppZmZpZXModmFsdWUg
KiAxMDAwKTsNCmRyaXZlcnMvYWNjZWwvaGFiYW5hbGFicy9jb21tb24vZGV2aWNlLmM6DQptc2Vj
c190b19qaWZmaWVzKGhkZXYtPmRldmljZV9yZWxlYXNlX3dhdGNoZG9nX3RpbWVvdXRfc2VjICog
MTAwMCkpOw0KZHJpdmVycy9hdGEvbGliYXRhLXpwb2RkLmM6ICAgICAgICAgICAgICAgbXNlY3Nf
dG9famlmZmllcyh6cG9kZF9wb3dlcm9mZl9kZWxheSAqDQoxMDAwKTsNCmRyaXZlcnMvYXV4ZGlz
cGxheS9hcm0tY2hhcmxjZC5jOiNkZWZpbmUgQ0hBUkxDRF9USU1FT1VUDQoobXNlY3NfdG9famlm
ZmllcygxMDAwKSkNCmRyaXZlcnMvYmxvY2svbXRpcDMyeHgvbXRpcDMyeHguYzogICAgICB0aW1l
b3V0ID0gamlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDAwKTsNCmRyaXZlcnMvYmxvY2sv
bXRpcDMyeHgvbXRpcDMyeHguYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9ibG9jay9y
YmQuYzojZGVmaW5lIFJCRF9SRVRSWV9ERUxBWSAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVz
KDEwMDApDQpkcml2ZXJzL2Jsb2NrL3JiZC5jOiAgICAgICAgICAgIG9wdC0+bG9ja190aW1lb3V0
ID0NCm1zZWNzX3RvX2ppZmZpZXMocmVzdWx0LnVpbnRfMzIgKiAxMDAwKTsNCmRyaXZlcnMvYmx1
ZXRvb3RoL2J0bnhwdWFydC5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNtNDM3
Ny5jOiNkZWZpbmUgQkNNNDM3N19USU1FT1VUDQptc2Vjc190b19qaWZmaWVzKDEwMDApDQpkcml2
ZXJzL2JsdWV0b290aC9oY2lfaW50ZWwuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNl
Y3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2JsdWV0b290aC9oY2lfaW50ZWwuYzogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJz
L2JsdWV0b290aC9oY2lfbm9raWEuYzogICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSkp
IHsNCmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9ub2tpYS5jOiAgICAgICAgICBtc2Vjc190b19qaWZm
aWVzKDEwMDAwKSkpIHsNCmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV92aGNpLmM6ICAgaGRldi0+ZHVt
cC50aW1lb3V0ID0NCm1zZWNzX3RvX2ppZmZpZXModGltZW91dCAqIDEwMDApOw0KZHJpdmVycy9i
bHVldG9vdGgvaGNpX3ZoY2kuYzogICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmRhdGEtPm9wZW5f
dGltZW91dCwNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9jaGFyL2FncC9pbnRl
bC1ndHQuYzogICB1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCk7DQpkcml2ZXJzL2NvbWVkaS9kcml2ZXJzL2pyM19wY2kuYzogICAgICAgZGV2
cHJpdi0+dGltZXIuZXhwaXJlcyA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmllcygxMDAwKTsN
CmRyaXZlcnMvY3J5cHRvL2ludGVsL3FhdC9xYXRfY29tbW9uL2FkZl9hZXIuYzogIHVuc2lnbmVk
IGxvbmcNCndhaXRfamlmZmllcyA9IG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApOw0KZHJpdmVycy9j
cnlwdG8vaW50ZWwvcWF0L3FhdF9jb21tb24vYWRmX2Flci5jOiAgICAgICAgICB1bnNpZ25lZCBs
b25nDQp3YWl0X2ppZmZpZXMgPSBtc2Vjc190b19qaWZmaWVzKDEwMDAwKTsNCmRyaXZlcnMvY3J5
cHRvL214cy1kY3AuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9jcnlwdG8vc3RhcmZpdmUvamg3MTEwLWFl
cy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMo
MTAwMCkpKQ0KZHJpdmVycy9jcnlwdG8vc3RhcmZpdmUvamg3MTEwLWhhc2guYzogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpKQ0KZHJpdmVy
cy9jcnlwdG8vc3RtMzIvc3RtMzItY3J5cC5jOiAgICAgIGlmDQooIXdhaXRfZm9yX2NvbXBsZXRp
b25fdGltZW91dCgmY3J5cC0+ZG1hX2NvbXBsZXRpb24sDQptc2Vjc190b19qaWZmaWVzKDEwMDAp
KSkgew0KZHJpdmVycy9kbWEvcGx4X2RtYS5jOiAgdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlm
ZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9kbWEvdGkvazMtdWRtYS5j
OiAgICAgICB1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0K
ZHJpdmVycy9kbWEveGlsaW54L3hkbWEuYzoNCndhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgm
eGRtYV9jaGFuLT5sYXN0X2ludGVycnVwdCwNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJp
dmVycy9mcGdhL3hpbGlueC1jb3JlLmM6ICAgICB1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBqaWZm
aWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY29ubmVjdG9ycy5jOg0KbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmM6ICAgICBhZGV2LT5nZnhfdGltZW91
dCA9DQptc2Vjc190b19qaWZmaWVzKDEwMDAwKTsNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNl
Y3NfdG9famlmZmllcyg2MDAwMCkNCjogbXNlY3NfdG9famlmZmllcygxMDAwMCk7DQpkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYzojZGVmaW5lIEFNREdQVV9JQl9URVNUX1RJ
TUVPVVQNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qcGVnLmM6I2RlZmluZSBKUEVHX0lETEVfVElNRU9VVA0KbXNlY3NfdG9famlmZmll
cygxMDAwKQ0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jOiNkZWZpbmUg
VVZEX0lETEVfVElNRU9VVA0KbXNlY3NfdG9famlmZmllcygxMDAwKQ0KZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jOiNkZWZpbmUgVkNFX0lETEVfVElNRU9VVA0KbXNlY3Nf
dG9famlmZmllcygxMDAwKQ0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5o
OiNkZWZpbmUgVkNOX0lETEVfVElNRU9VVA0KbXNlY3NfdG9famlmZmllcygxMDAwKQ0KZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jOiNkZWZpbmUgVlBFX0lETEVfVElNRU9V
VA0KbXNlY3NfdG9famlmZmllcygxMDAwKQ0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMV8wLmM6IGxvbmcgdG1vID0gbXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjZfMC5jOiBsb25nIHRtbyA9IG1zZWNzX3RvX2ppZmZpZXMo
MTAwMCk7DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzAuYzogbG9uZyB0bW8g
PSBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9jYWRlbmNl
L2NkbnMtZHNpLWNvcmUuYzoNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9ncHUv
ZHJtL2JyaWRnZS9pdGUtaXQ2NTA1LmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYv
ZXRuYXZpdl9ncHUuYzogIHRpbWVvdXQgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAw
MCk7DQpkcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dwdS5jOiAgdW5zaWduZWQgbG9u
ZyB0aW1lb3V0ID0NCm1zZWNzX3RvX2ppZmZpZXMoMTAgKiAxMDAwMCk7DQpkcml2ZXJzL2dwdS9k
cm0vZ21hNTAwL2Nkdl9pbnRlbF9jcnQuYzogICAgICAgICB0aW1lb3V0ID0gamlmZmllcyArDQpt
c2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9kcnJzLmM6DQptb2RfZGVsYXllZF93b3JrKGk5MTUtPnVub3JkZXJlZF93cSwgJmNydGMtPmRy
cnMud29yaywNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9sc3Bjb24uYzogICAgICAgICAgICBpZiAodGltZV9hZnRlcihqaWZmaWVz
LA0Kc3RhcnQgKyBtc2Vjc190b19qaWZmaWVzKDEwMDApKSkNCmRyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfdGMuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9ncHUvZHJtL21zbS9hZHJlbm8vYTV4eF9w
cmVlbXB0LmM6DQptb2RfdGltZXIoJmE1eHhfZ3B1LT5wcmVlbXB0X3RpbWVyLCBqaWZmaWVzICsg
bXNlY3NfdG9famlmZmllcygxMDAwMCkpOw0KZHJpdmVycy9ncHUvZHJtL21zbS9hZHJlbm8vYTZ4
eF9ncHUuYzogIGlmDQooIXdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZ211LT5wZF9nYXRl
LCBtc2Vjc190b19qaWZmaWVzKDEwMDApKSkNCmRyaXZlcnMvZ3B1L2RybS9tc20vYWRyZW5vL2Fk
cmVub19kZXZpY2UuYzoNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9ncHUvZHJt
L21zbS9hZHJlbm8vYWRyZW5vX2dwdS5oOiNkZWZpbmUgQURSRU5PX0lETEVfVElNRU9VVA0KbXNl
Y3NfdG9famlmZmllcygxMDAwKQ0KZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUv
c2VjMi9iYXNlLmM6DQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvZ3B1L2RybS9u
b3V2ZWF1L252a20vZW5naW5lL3NlYzIvZ2ExMDIuYzoNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkp
Ow0KZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUvc2VjMi9ncDEwMi5jOg0KbXNl
Y3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL2ZhbGNv
bi9jbWRxLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19q
aWZmaWVzKDEwMDApKSkgew0KZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9zdWJkZXYvcG11
L2dtMjBiLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBtdS0+c3ViZGV2
LA0KbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmtt
L3N1YmRldi9wbXUvZ3AxMGIuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
cG11LT5zdWJkZXYsDQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvZ3B1L2RybS9w
YW5mcm9zdC9wYW5mcm9zdF9wZXJmY250LmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9n
cHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X3BlcmZjbnQuYzogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9ncHUvZHJt
L3BhbnRob3IvcGFudGhvcl9mdy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCkpKSB7DQpkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jb25uZWN0
b3JzLmM6DQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2Nvbm5lY3RvcnMuYzoNCnNjaGVkdWxlX2RlbGF5ZWRfd29yaygmcmRldi0+aG90cGx1
Z193b3JrLCBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvZ3B1L2RybS90ZWdyYS9o
dWIuYzogICAgdGltZW91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJp
dmVycy9ncHUvZHJtL3RlZ3JhL2h1Yi5jOiAgICB0aW1lb3V0ID0gamlmZmllcyArIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL2dwdS9kcm0vdGVncmEvc3VibWl0LmM6ICAgICAgICAg
ZXJyID0gZG1hX2ZlbmNlX3dhaXRfdGltZW91dChmZW5jZSwNCnRydWUsIG1zZWNzX3RvX2ppZmZp
ZXMoMTAwMDApKTsNCmRyaXZlcnMvZ3B1L2RybS92YzQvdmM0X2JvLmM6ICAgdW5zaWduZWQgbG9u
ZyBleHBpcmVfdGltZSA9IGppZmZpZXMgLQ0KbXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZl
cnMvZ3B1L2RybS92YzQvdmM0X2JvLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpKTsNCmRyaXZlcnMvZ3B1L2RybS92
YzQvdmM0X2RzaS5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9f
amlmZmllcygxMDAwKSkpIHsNCmRyaXZlcnMvZ3B1L2RybS92YzQvdmM0X3R4cC5jOiAgICAgICAg
ICB1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAw
MCk7DQpkcml2ZXJzL2dwdS9kcm0veGUveGVfZXhlY2xpc3QuYzogICAgICAgcG9ydC0+aXJxX2Zh
aWwuZXhwaXJlcyA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMv
Z3B1L2RybS94ZS94ZV9leGVjbGlzdC5jOiAgICAgICBwb3J0LT5pcnFfZmFpbC5leHBpcmVzID0g
amlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9ncHUvaXB1LXYzL2lw
dS1jb21tb24uYzogICAgICAgIHRpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygx
MDAwKTsNCmRyaXZlcnMvZ3B1L2lwdS12My9pcHUtaW1hZ2UtY29udmVydC5jOiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwMCkpOw0KZHJpdmVy
cy9ncHUvaXB1LXYzL2lwdS1pbWFnZS1jb252ZXJ0LmM6IHJldCA9DQp3YWl0X2Zvcl9jb21wbGV0
aW9uX3RpbWVvdXQoJmNvbXAsIG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApKTsNCmRyaXZlcnMvaGlk
L2hpZC1ybWkuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlm
ZmllcygxMDAwKSkpIHsNCmRyaXZlcnMvaGlkL2kyYy1oaWQvaTJjLWhpZC1jb3JlLmM6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSkpIHsN
CmRyaXZlcnMvaGlkL3VzYmhpZC9oaWQtY29yZS5jOiAgICAgICAgICB1c2JoaWQtPnN0b3BfcmV0
cnkgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL2hpZC93YWNv
bV9zeXMuYzogICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmd2Fjb20tPmluaXRfd29yaywN
Cm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9od21vbi9vY2MvY29tbW9uLmM6I2Rl
ZmluZSBPQ0NfVVBEQVRFX0ZSRVFVRU5DWQ0KbXNlY3NfdG9famlmZmllcygxMDAwKQ0KZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1jYWRlbmNlLmM6I2RlZmluZSBDRE5TX0kyQ19USU1FT1VUDQptc2Vj
c190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWNhZGVuY2UuYzogICAg
ICAgbXNnX3RpbWVvdXQgPSBtc2Vjc190b19qaWZmaWVzKCgxMDAwICoNCm1zZy0+bGVuICogQklU
U19QRVJfQllURSkgLyBpZC0+aTJjX2Nsayk7DQpkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWVnMjB0
LmM6ICAgICAgICAgICAgICAgICAoYWRhcC0+cGNoX2V2ZW50X2ZsYWcgIT0gMCksDQptc2Vjc190
b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW1nLXNjYi5jOiNkZWZp
bmUgSU1HX0kyQ19USU1FT1VUDQoobXNlY3NfdG9famlmZmllcygxMDAwKSkNCmRyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtbHBjMmsuYzogdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArDQpt
c2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1scGMyay5jOiAg
ICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpID09IDApIHsNCmRy
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXhzLmM6ICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlm
ZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1t
eHMuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9f
amlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9tYXAuYzojZGVmaW5lIE9N
QVBfSTJDX1RJTUVPVVQNCihtc2Vjc190b19qaWZmaWVzKDEwMDApKQ0KZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy12aWFpMmMtY29tbW9uLmg6I2RlZmluZSBWSUFJMkNfVElNRU9VVA0KKG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCkpDQpkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXhpaWMuYzojZGVmaW5lIFhJ
SUNfSTJDX1RJTUVPVVQNCihtc2Vjc190b19qaWZmaWVzKDEwMDApKQ0KZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy14aWljLmM6I2RlZmluZSBYSUlDX1hGRVJfVElNRU9VVA0KKG1zZWNzX3RvX2ppZmZp
ZXMoMTAwMDApKQ0KZHJpdmVycy9pM2MvbWFzdGVyL2R3LWkzYy1tYXN0ZXIuYzojZGVmaW5lIFhG
RVJfVElNRU9VVA0KKG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpDQpkcml2ZXJzL2kzYy9tYXN0ZXIv
aTNjLW1hc3Rlci1jZG5zLmM6ICAgaWYNCighd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZ4
ZmVyLT5jb21wLCBtc2Vjc190b19qaWZmaWVzKDEwMDApKSkNCmRyaXZlcnMvaTNjL21hc3Rlci9p
M2MtbWFzdGVyLWNkbnMuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vj
c190b19qaWZmaWVzKDEwMDApKSkNCmRyaXZlcnMvaTNjL21hc3Rlci9pM2MtbWFzdGVyLWNkbnMu
YzogICBpZg0KKCF3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnhmZXItPmNvbXAsIG1zZWNz
X3RvX2ppZmZpZXMoMTAwMCkpKQ0KZHJpdmVycy9pM2MvbWFzdGVyL3N2Yy1pM2MtbWFzdGVyLmM6
ICAgICAgICAgICAgaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgc3RhcnQgKw0KbXNlY3NfdG9famlm
ZmllcygxMDAwKSkpIHsNCmRyaXZlcnMvaTNjL21hc3Rlci9zdmMtaTNjLW1hc3Rlci5jOiAgICBp
Zg0KKCF3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnhmZXItPmNvbXAsIG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCkpKQ0KZHJpdmVycy9pM2MvbWFzdGVyL3N2Yy1pM2MtbWFzdGVyLmM6ICAgIGlm
DQooIXdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmeGZlci0+Y29tcCwgbXNlY3NfdG9famlm
ZmllcygxMDAwKSkpDQpkcml2ZXJzL2kzYy9tYXN0ZXIvc3ZjLWkzYy1tYXN0ZXIuYzogICAgaWYN
Cighd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZ4ZmVyLT5jb21wLCBtc2Vjc190b19qaWZm
aWVzKDEwMDApKSkNCmRyaXZlcnMvaTNjL21hc3Rlci9zdmMtaTNjLW1hc3Rlci5jOiAgICBpZg0K
KCF3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnhmZXItPmNvbXAsIG1zZWNzX3RvX2ppZmZp
ZXMoMTAwMCkpKQ0KZHJpdmVycy9paW8vYWNjZWwvYm1jMTUwLWFjY2VsLWkyYy5jOg0Kc2NoZWR1
bGVfZGVsYXllZF93b3JrKCZkYXRhLT5yZXN1bWVfd29yaywgbXNlY3NfdG9famlmZmllcygxMDAw
KSk7DQpkcml2ZXJzL2lpby9hZGMvYWQ0MTMwLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvaWlvL2FkYy9h
ZDc2MDYuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9paW8vYWRjL2FkNzc2OC0xLmM6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2
ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2lpby9h
ZGMvYXQ5MV9hZGMuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2lpby9hZGMvYmVybGlu
Mi1hZGMuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9paW8vYWRjL2JlcmxpbjItYWRjLmM6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsN
CmRyaXZlcnMvaWlvL2FkYy9pbnRlbF9tcmZsZF9hZGMuYzojZGVmaW5lIEJDT1ZFX0FEQ19USU1F
T1VUDQptc2Vjc190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9paW8vYWRjL25hdTc4MDIuYzogICAgICAgICAgICAgICAg
ICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2lpby9hZGMvc3RtcGUtYWRj
LmM6I2RlZmluZSBTVE1QRV9BRENfVElNRU9VVA0KbXNlY3NfdG9famlmZmllcygxMDAwKQ0KZHJp
dmVycy9paW8vYWRjL3N1bjRpLWdwYWRjLWlpby5jOiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpKSB7DQpkcml2ZXJzL2lpby9hZGRh
Yy9hZDc0MTE1LmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9paW8vYWRkYWMvYWQ3NDQxM3IuYzog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAw
KSk7DQpkcml2ZXJzL2lpby9jaGVtaWNhbC9zY2QzMF9jb3JlLmM6ICAgICAgdGltZW91dCA9DQpt
c2Vjc190b19qaWZmaWVzKHN0YXRlLT5tZWFzX2ludGVydmFsICogKDEwMDAgKyBTQ0QzMF9FWFRS
QV9USU1FT1VUX1BFUl9TKSk7DQpkcml2ZXJzL2lpby9saWdodC9ncDJhcDAyMGEwMGYuYzojZGVm
aW5lIEdQMkFQMDIwQTAwRl9EQVRBX1JFQURZX1RJTUVPVVQNCiAgICAgICAgbXNlY3NfdG9famlm
ZmllcygxMDAwKQ0KZHJpdmVycy9paW8vbWFnbmV0b21ldGVyL2FrODk3NC5jOiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMSArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0K
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbWFkX3JtcHAuYzogICAgICAgICAgICAgICAgICAgICAg
ICAmcm1wcF9yZWN2LT5jbGVhbnVwX3dvcmssDQptc2Vjc190b19qaWZmaWVzKDEwMDAwKSk7DQpk
cml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9xcGxpYl9yY2Z3LmM6DQptc2Vjc190b19qaWZm
aWVzKHJjZnctPm1heF90aW1lb3V0ICogMTAwMCkpOw0KZHJpdmVycy9pbmZpbmliYW5kL2h3L21s
eDQvYWxpYXNfR1VJRC5jOg0KbXNlY3NfdG9famlmZmllcyhyZXNjaGVkX2RlbGF5X3NlYyAqIDEw
MDApKTsNCmRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L21yLmM6ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVy
cy9pbmZpbmliYW5kL2h3L21seDUvbXIuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvaW5m
aW5pYmFuZC9ody9tbHg1L21yLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtc2Vjc190b19qaWZmaWVzKDMwICogMTAwMCkpOw0KZHJpdmVycy9pbmZpbmliYW5kL2h3
L29jcmRtYS9vY3JkbWFfaHcuYzoNCnNjaGVkdWxlX2RlbGF5ZWRfd29yaygmZGV2LT5lcWRfd29y
aywgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL2luZmluaWJhbmQvaHcvb2NyZG1h
L29jcmRtYV9tYWluLmM6DQpzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmRldi0+ZXFkX3dvcmssIG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnAvaWJfc3Jw
LmM6ICAgIHJxX3Rtb19qaWZmaWVzID0NCm1zZWNzX3RvX2ppZmZpZXMobWF4X2NvbXBsX3RpbWVf
bXMgKyAxMDAwKTsNCmRyaXZlcnMvaW5wdXQvcm1pNC9ybWlfZjU0LmM6ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKSkgew0K
ZHJpdmVycy9pbnB1dC9zZXJpby9wczItZ3Bpby5jOiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApKSkNCmRyaXZlcnMvaW5wdXQv
c2VyaW8vc3VuNGktcHMyLmM6ICAgICAgICB1bnNpZ25lZCBsb25nIGV4cGlyZSA9IGppZmZpZXMg
Kw0KbXNlY3NfdG9famlmZmllcygxMDAwMCk7DQpkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL3N0
bWZ0cy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlm
ZmllcygxMDAwKSkpDQpkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL3pmb3JjZV90cy5jOiNkZWZp
bmUgV0FJVF9USU1FT1VUDQptc2Vjc190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL2lvbW11L2lv
bW11ZmQvbWFpbi5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMo
MTAwMDApKSkNCmRyaXZlcnMvbWFpbGJveC9wbDMyMC1pcGMuYzogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9tZWRp
YS9jZWMvdXNiL2V4dHJvbi1kYS1oZC00ay1wbHVzL2V4dHJvbi1kYS1oZC00ay1wbHVzLmM6DQog
ICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9tZWRpYS9jZWMvdXNiL2V4dHJv
bi1kYS1oZC00ay1wbHVzL2V4dHJvbi1kYS1oZC00ay1wbHVzLmM6DQogICAgbXNlY3NfdG9famlm
ZmllcygxMDAwKSk7DQpkcml2ZXJzL21lZGlhL2NlYy91c2IvZXh0cm9uLWRhLWhkLTRrLXBsdXMv
ZXh0cm9uLWRhLWhkLTRrLXBsdXMuYzoNCiAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpk
cml2ZXJzL21lZGlhL2R2Yi1mcm9udGVuZHMvY3gyNDEyMC5jOiAgICAgICAgICBzdGF0ZS0+cGVy
X2ppZmZpZXNfc3RhdHMgPQ0KamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2
ZXJzL21lZGlhL2R2Yi1mcm9udGVuZHMvY3hkMjg0MWVyLmM6ICAgICAgICAgICAgICAgIHByaXYt
PnN0YXRzX3RpbWUgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJz
L21lZGlhL2R2Yi1mcm9udGVuZHMvZGliNzAwMHAuYzogICAgICAgICBzdGF0ZS0+cGVyX2ppZmZp
ZXNfc3RhdHMgPQ0KamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL21l
ZGlhL2R2Yi1mcm9udGVuZHMvZGliODAwMC5jOiAgICAgICAgICBzdGF0ZS0+cGVyX2ppZmZpZXNf
c3RhdHMgPQ0KamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL21lZGlh
L2R2Yi1mcm9udGVuZHMvbGdkdDMzMHguYzogc3RhdGUtPmxhc3Rfc3RhdHNfdGltZSA9IGppZmZp
ZXMNCisgbXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvbWVkaWEvZHZiLWZyb250ZW5k
cy9sZ2R0MzMweC5jOiBzdGF0ZS0+bGFzdF9zdGF0c190aW1lID0gamlmZmllcw0KKyBtc2Vjc190
b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9tZWRpYS9kdmItZnJvbnRlbmRzL21iODZhMjBzLmM6
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZm
aWVzKDEwMDApOw0KZHJpdmVycy9tZWRpYS9kdmItZnJvbnRlbmRzL3NwMi5jOiAgICAgICAgICAg
ICAgcy0+bmV4dF9zdGF0dXNfY2hlY2tlZF90aW1lID0NCmppZmZpZXMgKyAgICAgICBtc2Vjc190
b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9tZWRpYS9pMmMvZHM5MHViOTYwLmM6ICB0aW1lb3V0
ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL21lZGlhL3BjaS9i
dDh4eC9idHR2LWlucHV0LmM6ICAgICAgICAgICBpci0+dGltZXIuZXhwaXJlcyAgPSBqaWZmaWVz
ICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL21lZGlhL3BjaS9idDh4eC9idHR2
cC5oOiNkZWZpbmUgQlRUVl9GUkVFX0lETEUNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkgICAvKiBv
bmUgc2Vjb25kICovDQpkcml2ZXJzL21lZGlhL3BjaS9jeDE4L2N4MTgtZmlsZW9wcy5jOiAgICAg
ICAgICAgICAgICAgIGlmICh0aW1lX2FmdGVyKGppZmZpZXMsDQpjeC0+ZHVhbHdhdGNoX2ppZmZp
ZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMDApKSkgew0KZHJpdmVycy9tZWRpYS9wY2kvY3gyMzg4
NS9jaW1heDIuYzogICAgICAgICAgICAgICAgICAgICArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7
DQpkcml2ZXJzL21lZGlhL3BjaS9jeDg4L2N4ODgtYmxhY2tiaXJkLmM6ICAgICAgICB0aW1lb3V0
ID0gamlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9tZWRpYS9wY2kv
aXZ0di9pdnR2LWZpbGVvcHMuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vj
c190b19qaWZmaWVzKDEwMDApKSkgew0KZHJpdmVycy9tZWRpYS9wY2kvaXZ0di9pdnR2LW1haWxi
b3guYzogIGludCBhcGlfdGltZW91dCA9DQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVy
cy9tZWRpYS9wY2kvbWdiNC9tZ2I0X2RtYS5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApKSkgew0KZHJpdmVycy9tZWRpYS9wY2kv
bmV0dXBfdW5pZHZiL25ldHVwX3VuaWR2Yl9jb3JlLmM6DQptb2RfdGltZXIoJmRtYS0+dGltZW91
dCwgamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9tZWRpYS9wY2kv
c2FhNzEzNC9zYWE3MTM0Lmg6I2RlZmluZSBUU19CVUZGRVJfVElNRU9VVA0KbXNlY3NfdG9famlm
ZmllcygxMDAwKSAgLyogMSBzZWNvbmQgKi8NCmRyaXZlcnMvbWVkaWEvcGNpL3R3NTg2NC90dzU4
NjQtY29yZS5jOiBpbnB1dC0+bmV3X2ZyYW1lX2RlYWRsaW5lID0NCmppZmZpZXMgKyBtc2Vjc190
b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5oOiNk
ZWZpbmUgVlBVX1RJTUVPVVQNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkNCmRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYXNwZWVkL2FzcGVlZC12aWRlby5jOiNkZWZpbmUgU1RPUF9USU1FT1VUDQptc2Vj
c190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL2Nv
ZGEvY29kYS1iaXQuYzogICAgIHVuc2lnbmVkIGxvbmcNCnRpbWVvdXQgPSBqaWZmaWVzICsgbXNl
Y3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEv
Y29kYS9jb2RhLWNvbW1vbi5jOg0KbXNlY3NfdG9famlmZmllcygxMDAwKSkpIHsNCmRyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbnZpZGlhL3RlZ3JhLXZkZS9oMjY0LmM6DQomdmRlLT5kZWNvZGVfY29t
cGxldGlvbiwgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L3Fjb20vdmVudXMvaGZpLmM6I2RlZmluZSBUSU1FT1VUDQptc2Vjc190b19qaWZmaWVzKDEwMDAp
DQpkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3JvY2tjaGlwL3JraXNwMS9ya2lzcDEtY2FwdHVyZS5j
Og0KbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3RpL29t
YXAzaXNwL2lzcC5jOiNkZWZpbmUgSVNQX1NUT1BfVElNRU9VVA0KbXNlY3NfdG9famlmZmllcygx
MDAwKQ0KZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS90aS9vbWFwM2lzcC9pc3AuYzogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKSkgew0K
ZHJpdmVycy9tZWRpYS9yYWRpby9yYWRpby13bDEyNzMuYzogICAgIHQgPQ0Kd2FpdF9mb3JfY29t
cGxldGlvbl90aW1lb3V0KCZyYWRpby0+YnVzeSwgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpk
cml2ZXJzL21lZGlhL3JhZGlvL3JhZGlvLXdsMTI3My5jOg0Kd2FpdF9mb3JfY29tcGxldGlvbl90
aW1lb3V0KCZyYWRpby0+YnVzeSwgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL21l
ZGlhL3JhZGlvL3JhZGlvLXdsMTI3My5jOiAgICAgaWYNCighd2FpdF9mb3JfY29tcGxldGlvbl90
aW1lb3V0KCZyYWRpby0+YnVzeSwgbXNlY3NfdG9famlmZmllcygxMDAwKSkpDQpkcml2ZXJzL21l
ZGlhL3JhZGlvL3RlYTU3NXguYzogIHRpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmll
cygxMDAwMCk7DQpkcml2ZXJzL21lZGlhL3R1bmVycy9zaTIxNTcuYzogIHNjaGVkdWxlX2RlbGF5
ZWRfd29yaygmZGV2LT5zdGF0X3dvcmssDQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZl
cnMvbWVkaWEvdXNiL2R2Yi11c2ItdjIvYWY5MDE1LmM6ICBmb3IgKHZhbCA9IDB4MDAsIHRpbWVv
dXQgPQ0KamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL21lZGlhL3Vz
Yi9kdmItdXNiLXYyL2FueXNlZS5jOiAgc3RhdGUtPmNpX2NhbV9yZWFkeSA9IGppZmZpZXMgKw0K
bXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvbWVkaWEvdXNiL2hkcHZyL2hkcHZyLXZp
ZGVvLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsN
CmRyaXZlcnMvbWVtc3RpY2svaG9zdC9qbWIzOHhfbXMuYzogICAgICBob3N0LT50aW1lb3V0X2pp
ZmZpZXMgPQ0KbXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvbWVtc3RpY2svaG9zdC9y
NTkyLmM6ICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArDQptc2Vjc190b19qaWZm
aWVzKDEwMDApOw0KZHJpdmVycy9tZW1zdGljay9ob3N0L3I1OTIuYzogICAgICAgICAgICAgICAg
ICAgJmRldi0+ZG1hX2RvbmUsIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpKSB7DQpkcml2ZXJzL21l
bXN0aWNrL2hvc3QvdGlmbV9tcy5jOiAgICAgICAgaG9zdC0+dGltZW91dF9qaWZmaWVzID0NCm1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL21pc2MvY3hsL2d1ZXN0LmM6ICAgICAgIHNj
aGVkdWxlX2RlbGF5ZWRfd29yaygmYWZ1LT5ndWVzdC0+d29ya19lcnIsDQptc2Vjc190b19qaWZm
aWVzKDEwMDApKTsNCmRyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jOiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpk
cml2ZXJzL21pc2MvcGNpX2VuZHBvaW50X3Rlc3QuYzogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9tbWMvaG9z
dC9tZXNvbi1teC1zZGlvLmM6ICAgICAgICAgICAgICAgdGltZW91dCA9IG1zZWNzX3RvX2ppZmZp
ZXMoMTAwMCk7DQpkcml2ZXJzL21tYy9ob3N0L21veGFydC1tbWMuYzogIGhvc3QtPnRpbWVvdXQg
PSBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9tbWMvaG9zdC9zaF9tbWNpZi5jOiAg
ICBob3N0LT50aW1lb3V0ICAgPSBtc2Vjc190b19qaWZmaWVzKDEwMDAwKTsNCmRyaXZlcnMvbW1j
L2hvc3Qvc3VueGktbW1jLmM6ICAgdW5zaWduZWQgbG9uZyBleHBpcmUgPSBqaWZmaWVzICsNCm1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL210ZC9oeXBlcmJ1cy9oYm1jLWFtNjU0LmM6
ICAgICAgaWYNCighd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZwcml2LT5yeF9kbWFfY29t
cGxldGUsDQptc2Vjc190b19qaWZmaWVzKGxlbiArIDEwMDApKSkgew0KZHJpdmVycy9tdGQvbmFu
ZC9lY2MtbXhpYy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2Ut
bmFuZC1jb250cm9sbGVyLmM6IHVuc2lnbmVkIGxvbmcgdGltZW91dCA9DQptc2Vjc190b19qaWZm
aWVzKDEwMDAwKTsNCmRyaXZlcnMvbXRkL25hbmQvcmF3L2RlbmFsaS5jOiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJp
dmVycy9tdGQvbmFuZC9yYXcvZ3BtaS1uYW5kL2dwbWktbmFuZC5jOiAgICAgdG8gPQ0Kd2FpdF9m
b3JfY29tcGxldGlvbl90aW1lb3V0KGRtYV9jb21wbGV0aW9uLCBtc2Vjc190b19qaWZmaWVzKDEw
MDApKTsNCmRyaXZlcnMvbXRkL25hbmQvcmF3L2dwbWktbmFuZC9ncG1pLW5hbmQuYzogICAgICAg
ICAgICAgdG8gPQ0Kd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KGJjaF9jb21wbGV0aW9uLCBt
c2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvbXRkL25hbmQvcmF3L2ludGVsLW5hbmQt
Y29udHJvbGxlci5jOiAgIHRpbWVfbGVmdCA9DQp3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQo
ZG1hX2NvbXBsZXRpb24sIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9tdGQvbmFu
ZC9yYXcvbHBjMzJ4eF9tbGMuYzoNCndhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmaG9zdC0+
Y29tcF9kbWEsIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9tdGQvbmFuZC9yYXcv
bHBjMzJ4eF9zbGMuYzoNCndhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmaG9zdC0+Y29tcCwg
bXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL210ZC9uYW5kL3Jhdy9yODUyLmM6ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVy
cy9tdGQvbmFuZC9yYXcvcjg1Mi5jOiAgICAgICAgICAgICZkZXYtPmNhcmRfZGV0ZWN0X3dvcmss
DQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvbmV0L2FtdC5jOiAgICAgIG1vZF9k
ZWxheWVkX3dvcmsoYW10X3dxLCAmYW10LT5yZXFfd3EsDQptc2Vjc190b19qaWZmaWVzKGV4cCAq
IDEwMDApKTsNCmRyaXZlcnMvbmV0L2FyY25ldC9hcmNuZXQuYzogICAgbW9kX3RpbWVyKCZscC0+
dGltZXIsIGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL25ldC9h
cmNuZXQvYXJjbmV0LmM6ICAgICAgICAgICAgICAgICAgICBtb2RfdGltZXIoJmxwLT50aW1lciwg
amlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvbmV0L2Nhbi9rdmFz
ZXJfcGNpZWZkLmM6I2RlZmluZSBLVkFTRVJfUENJRUZEX1dBSVRfVElNRU9VVA0KbXNlY3NfdG9f
amlmZmllcygxMDAwKQ0KZHJpdmVycy9uZXQvY2FuL3NqYTEwMDAvcGVha19wY21jaWEuYzoNCm1z
ZWNzX3RvX2ppZmZpZXMoUENDX1NQSV9NQVhfQlVTWV9XQUlUX01TKSArIDE7DQpkcml2ZXJzL25l
dC9ldGhlcm5ldC9icm9hZGNvbS9ibnh0L2JueHQuaDojZGVmaW5lDQpCTlhUX1NSSU9WX0NGR19X
QUlUX1RNTyBtc2Vjc190b19qaWZmaWVzKDEwMDAwKQ0KZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2
aXVtL2xpcXVpZGlvL2xpb19tYWluLmM6I2RlZmluZQ0KV0FJVF9JTkZMSUdIVF9SRVFVRVNUICAg
bXNlY3NfdG9famlmZmllcygxMDAwKQ0KZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL2xpcXVp
ZGlvL2xpb19tYWluLmM6DQp3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmZpcnN0X3N0YWdl
LCBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvbmV0L2V0aGVybmV0L2VtdWxleC9i
ZW5ldC9iZV9tYWluLmM6ICAgIHF1ZXVlX2RlbGF5ZWRfd29yayhiZV93cSwNCiZhZGFwdGVyLT53
b3JrLCBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvbmV0L2V0aGVybmV0L2VtdWxl
eC9iZW5ldC9iZV9tYWluLmM6ICAgIHF1ZXVlX2RlbGF5ZWRfd29yayhiZV93cSwNCiZhZGFwdGVy
LT53b3JrLCBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvbmV0L2V0aGVybmV0L2li
bS9laGVhL2VoZWFfbWFpbi5jOg0Kcm91bmRfamlmZmllc19yZWxhdGl2ZShtc2Vjc190b19qaWZm
aWVzKDEwMDApKSk7DQpkcml2ZXJzL25ldC9ldGhlcm5ldC9pYm0vZWhlYS9laGVhX21haW4uYzoN
CnJvdW5kX2ppZmZpZXNfcmVsYXRpdmUobXNlY3NfdG9famlmZmllcygxMDAwKSkpOw0KZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9lc3dpdGNoX2JyLmM6I2RlZmluZQ0KSUNFX0VT
V19CUklER0VfVVBEQVRFX0lOVEVSVkFMIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkNCmRyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9saWIuYzogICAgICAgICAgICAgICAgICAgICAg
ICBtc2Vjc190b19qaWZmaWVzKDEwMDAwKSk7DQpkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxs
L3ByZXN0ZXJhL3ByZXN0ZXJhX2NvdW50ZXIuYzojZGVmaW5lDQpDT1VOVEVSX1BPTExfVElNRSAg
ICAgICAobXNlY3NfdG9famlmZmllcygxMDAwKSkNCmRyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlh
dGVrL210a19ldGhfc29jLmg6I2RlZmluZQ0KTVRLX0RNQV9NT05JVE9SX1RJTUVPVVQgICAgICAg
ICBtc2Vjc190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHg1L2NvcmUvY21kLmM6ICBwb2xsX2VuZCA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmllcyhj
bWRfdG9fbXMgKyAxMDAwKTsNCmRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lbl9hY2NlbC9pcHNlYy5jOiNkZWZpbmUNCk1MWDVfSVBTRUNfUkVTQ0hFRCBtc2Vjc190b19q
aWZmaWVzKDEwMDApDQpkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnNf
Y291bnRlcnMuYzojZGVmaW5lDQpNTFg1X0ZDX1NUQVRTX1BFUklPRCBtc2Vjc190b19qaWZmaWVz
KDEwMDApDQpkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnNfY291bnRl
cnMuYzojZGVmaW5lDQpNTFg1X0ZDX0JVTEtfUVVFUllfQUxMT0NfUEVSSU9EIG1zZWNzX3RvX2pp
ZmZpZXMoMTgwICogMTAwMCkNCmRyaXZlcnMvbmV0L2V0aGVybmV0L25ldHJvbm9tZS9uZnAvZmxv
d2VyL3Fvc19jb25mLmM6I2RlZmluZQ0KTkZQX0ZMX1FPU19VUERBVEUgICAgICAgICAgICAgICBt
c2Vjc190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ct
bnVzcy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYzog
ICAgICAgICAgICAgICBpID0NCndhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmY29tbW9uLT50
ZG93bl9jb21wbGV0ZSwNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9uZXQvZXRo
ZXJuZXQvdGkvaWNzc2cvaWNzc2dfcHJ1ZXRoLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9uZXQvZXRoZXJuZXQv
dGkvaWNzc2cvaWNzc2dfcHJ1ZXRoX3NyMS5jOg0KbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpk
cml2ZXJzL25ldC9ldGhlcm5ldC90aS9pY3NzZy9pY3NzZ19zdGF0cy5jOg0KbXNlY3NfdG9famlm
ZmllcygoU1RBVFNfVElNRV9MSU1JVF8xR19NUyAqIDEwMDApIC8gZW1hYy0+c3BlZWQpKTsNCmRy
aXZlcnMvbmV0L2V0aGVybmV0L3ZlcnRleGNvbS9tc2UxMDJ4LmM6ICAgICAgIHVuc2lnbmVkIGxv
bmcgd29ya190aW1lb3V0ID0NCmppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJp
dmVycy9uZXQvaWVlZTgwMjE1NC9jYTgyMTAuYzogICAgICAgICAgICAgICAgICAgICAgICBtc2Vj
c190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL25ldC9waHkvc2ZwLmM6I2RlZmluZSBUX0ZBVUxU
X1JFQ09WRVIgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkNCmRyaXZlcnMvbmV0L3Bo
eS9zZnAuYzogIHNmcC0+cGh5X3RfcmV0cnkgPSBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJp
dmVycy9uZXQvcHNlLXBkL3BkNjkyeDAuYzogICB0aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcygx
MDAwMCkgKyBqaWZmaWVzOw0KZHJpdmVycy9uZXQvdGh1bmRlcmJvbHQvbWFpbi5jOiAgICAgICAg
ICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL25ldC93aXJlbGVz
cy9hdGgvd2lsNjIxMC93aWw2MjEwLmg6I2RlZmluZSBXSUw2MjEwX1NDQU5fVE8NCm1zZWNzX3Rv
X2ppZmZpZXMoMTAwMDApDQpkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2xlZ2FjeS80OTY1
LW1hYy5jOiAgICAgICAgICAgamlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKHJlY2FsaWJfc2Vj
b25kcyAqIDEwMDApKTsNCmRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3J4
LmM6DQptc2Vjc190b19qaWZmaWVzKHJlZ19yZWNhbGliX3BlcmlvZCAqIDEwMDApKTsNCmRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvZGVidWdmcy5jOiAgICAgICAgZndydC0+
dGltZXN0YW1wLmRlbGF5ID0NCm1zZWNzX3RvX2ppZmZpZXMoZGVsYXkgKiAxMDAwKTsNCmRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVyc2lsL3A1NC9wNTR1c2IuYzogICAgIHRpbWVvdXQgPSBqaWZm
aWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
cnNpbC9wNTQvcDU0dXNiLmM6ICAgICB0aW1lb3V0ID0gamlmZmllcyArDQptc2Vjc190b19qaWZm
aWVzKDEwMDApOw0KZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3NjAxdS9tY3UuYzog
ICAgaWYNCighd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZjbXBsLCBtc2Vjc190b19qaWZm
aWVzKDEwMDApKSkgew0KZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hp
Zi5jOg0KbW9kX3RpbWVyKCZ2aWYtPnBlcmlvZGljX3Jzc2ksIGppZmZpZXMgKyBtc2Vjc190b19q
aWZmaWVzKDUwMDApKTsNCmRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9o
aWYuYzoNCm1vZF90aW1lcigmdmlmLT5wZXJpb2RpY19yc3NpLCBqaWZmaWVzICsgbXNlY3NfdG9f
amlmZmllcyg1MDAwKSk7DQpkcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAv
bmV0ZGV2LmM6DQptc2Vjc190b19qaWZmaWVzKDUwMDApKSkNCmRyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmg6I2RlZmluZQ0KV0lMQ19DRkdfUEtUU19USU1FT1VU
ICAgbXNlY3NfdG9famlmZmllcygzMDAwKQ0KZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dm
eC9kYXRhX3R4LmM6DQptc2Vjc190b19qaWZmaWVzKDEwMDApKSA8PSAwKQ0KZHJpdmVycy9uZmMv
czNmd3JuNS9maXJtd2FyZS5jOiAgICAgICAgICZmd19pbmZvLT5jb21wbGV0aW9uLA0KbXNlY3Nf
dG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL25mYy9zdDk1aGYvc3BpLmM6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsN
CmRyaXZlcnMvbnRiL2h3L2FtZC9udGJfaHdfYW1kLmg6I2RlZmluZSBBTURfTElOS19IQl9USU1F
T1VUDQptc2Vjc190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL252bWUvaG9zdC9jb3JlLmM6ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoYWRtaW5fdGltZW91
dCAqIDEwMDApOw0KZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtbWhpLmM6
ICAgcmV0ID0NCndhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmY29tcGxldGUsIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYt
bWhpLmM6ICAgcmV0ID0NCndhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmY29tcGxldGUsIG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9wY2kvaG90cGx1Zy9zaHBjaHBfaHBjLmM6
ICAgICAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCA9DQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0K
ZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtbHlueC0yOGcuYzogICAgICAgICAgICAgICAg
ICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9waHkvZnJlZXNjYWxl
L3BoeS1mc2wtbHlueC0yOGcuYzogICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9waHkvbW90b3JvbGEvcGh5LWNwY2FwLXVzYi5jOiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJp
dmVycy9waHkvcm9ja2NoaXAvcGh5LXJvY2tjaGlwLXBjaWUuYzogICAgICAgdGltZW91dCA9IGpp
ZmZpZXMgKw0KbXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvcGxhdGZvcm0vY2hyb21l
L2Nyb3NfdHlwZWNfc3dpdGNoLmM6ICAgIGVuZCA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmll
cygxMDAwKTsNCmRyaXZlcnMvcGxhdGZvcm0vc3VyZmFjZS9zdXJmYWNlX2R0eC5jOiBzZHR4X3Vw
ZGF0ZV9kZXZpY2Vfc3RhdGUoZGRldiwNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVy
cy9wbGF0Zm9ybS94ODYvYW1kL3BtZi9hY3BpLmM6DQpzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmRl
di0+aGVhcnRfYmVhdCwNCm1zZWNzX3RvX2ppZmZpZXMoZGV2LT5oYl9pbnRlcnZhbCAqIDEwMDAp
KTsNCmRyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwvZGVsbC11YXJ0LWJhY2tsaWdodC5jOiNkZWZp
bmUgREVMTF9CTF9USU1FT1VUDQptc2Vjc190b19qaWZmaWVzKDEwMDApDQpkcml2ZXJzL3BsYXRm
b3JtL3g4Ni90aGlua3BhZF9hY3BpLmM6DQptc2Vjc190b19qaWZmaWVzKGZhbl93YXRjaGRvZ19t
YXhpbnRlcnZhbCAqIDEwMDApKTsNCmRyaXZlcnMvcG93ZXIvc3VwcGx5L3Fjb21fcG1pODk5OF9j
aGFyZ2VyLmM6DQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvcnRjL3J0Yy1pc2wx
MjA4LmM6ICAgICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArDQptc2Vjc190b19q
aWZmaWVzKDEwMDApOw0KZHJpdmVycy9zY3NpL2N4bGZsYXNoL21haW4uYzogICB1bG9uZyB0aW1l
b3V0ID0NCm1zZWNzX3RvX2ppZmZpZXMoY21kLT5yY2IudGltZW91dCAqIDIgKiAxMDAwKTsNCmRy
aXZlcnMvc2NzaS9oaXNpX3Nhcy9oaXNpX3Nhc192MV9ody5jOiAgICAgICAgIGVuZF90aW1lID0g
amlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9zY3NpL2hpc2lfc2Fz
L2hpc2lfc2FzX3YxX2h3LmM6IGVuZF90aW1lID0gamlmZmllcyArDQptc2Vjc190b19qaWZmaWVz
KDEwMDApOw0KZHJpdmVycy9zY3NpL2hpc2lfc2FzL2hpc2lfc2FzX3YyX2h3LmM6ICAgICAgICAg
ZW5kX3RpbWUgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL3Nj
c2kvaGlzaV9zYXMvaGlzaV9zYXNfdjJfaHcuYzogZW5kX3RpbWUgPSBqaWZmaWVzICsNCm1zZWNz
X3RvX2ppZmZpZXMoMTAwMCk7DQpkcml2ZXJzL3Njc2kvaGlzaV9zYXMvaGlzaV9zYXNfdjJfaHcu
YzogaGlzaV9oYmEtPnRpbWVyLmV4cGlyZXMgPQ0KamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMo
MTAwMCk7DQpkcml2ZXJzL3Njc2kvbHBmYy9scGZjLmg6I2RlZmluZSBRVUVVRV9SQU1QX0RPV05f
SU5URVJWQUwNCihtc2Vjc190b19qaWZmaWVzKDEwMDAgKiAxKSkNCmRyaXZlcnMvc2NzaS9scGZj
L2xwZmNfYnNnLmM6ICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDAgKg0KZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19ic2cuYzogICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCAqDQpk
cml2ZXJzL3Njc2kvbHBmYy9scGZjX2Vscy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDAgKiB0bW8pKTsNCmRyaXZlcnMvc2NzaS9scGZj
L2xwZmNfZWxzLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBqaWZmaWVzICsgbXNlY3Nf
dG9famlmZmllcygxMDAwICogdG1vKSk7DQpkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2Vscy5jOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAw
MCAqDQp0aW1lb3V0KSk7DQpkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2Vscy5jOiAgICAgICAgICAg
ICAgICAgICBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygxMDAwICoNCnBoYmEtPmZjX3JhdG92
KSk7DQpkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2Vscy5jOiAgIG1vZF90aW1lcigmbmRscC0+bmxw
X2RlbGF5ZnVuYywgamlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMv
c2NzaS9scGZjL2xwZmNfaGJhZGlzYy5jOiAgICAgICBtb2RfdGltZXIoJnZwb3J0LT5mY19kaXNj
dG1vLCBqaWZmaWVzDQorIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCAqIHRtbykpOw0KZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19pbml0LmM6ICAgICAgICAgICAgamlmZmllcyArIG1zZWNzX3RvX2ppZmZp
ZXMoMTAwMCAqDQp0aW1lb3V0KSk7DQpkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2luaXQuYzogICAg
ICAgICAgICBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygxMDAwICoNCnBoYmEtPmVyYXR0X3Bv
bGxfaW50ZXJ2YWwpKTsNCmRyaXZlcnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jOiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2
ZXJzL3Njc2kvbHBmYy9scGZjX25wb3J0ZGlzYy5jOiAgICAgbW9kX3RpbWVyKCZuZGxwLT5ubHBf
ZGVsYXlmdW5jLA0KamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19ucG9ydGRpc2MuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
amlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KZHJpdmVycy9zY3NpL2xwZmMvbHBm
Y19ucG9ydGRpc2MuYzogICAgICAgICAgICAgICAgICAgICAgIGppZmZpZXMgKyBtc2Vjc190b19q
aWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2NzaS5jOg0KbXNlY3NfdG9f
amlmZmllcygyKnZwb3J0LT5jZmdfZGV2bG9zc190bW8qMTAwMCkpOw0KZHJpdmVycy9zY3NpL2xw
ZmMvbHBmY19zY3NpLmM6ICBsYXRlciA9IG1zZWNzX3RvX2ppZmZpZXMoMiAqDQp2cG9ydC0+Y2Zn
X2Rldmxvc3NfdG1vICogMTAwMCkgKyBqaWZmaWVzOw0KZHJpdmVycy9zY3NpL2xwZmMvbHBmY19z
Y3NpLmM6ICBsYXRlciA9IG1zZWNzX3RvX2ppZmZpZXMoMiAqDQp2cG9ydC0+Y2ZnX2Rldmxvc3Nf
dG1vICogMTAwMCkgKyBqaWZmaWVzOw0KZHJpdmVycy9zY3NpL2xwZmMvbHBmY19zbGkuYzogICBu
ZXh0X3RpbWUgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCAqIChwaGJhLT5mY19y
YXRvdiArIDEpKTsNCmRyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2xpLmM6ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwICogKHBoYmEtPmZjX3JhdG92DQorIDEp
KTsNCmRyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2xpLmM6ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDAgKg0KKHBoYmEtPmZjX3JhdG92IDw8IDEpKSk7DQpk
cml2ZXJzL3Njc2kvbHBmYy9scGZjX3NsaS5jOiAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCAqDQpwaGJhLT5lcmF0dF9wb2xsX2ludGVydmFsKSk7DQpkcml2ZXJzL3Nj
c2kvbHBmYy9scGZjX3NsaS5jOiAgICAgICAgICAgICBqaWZmaWVzICsgbXNlY3NfdG9famlmZmll
cygxMDAwICoNCihwaGJhLT5mY19yYXRvdiAqIDIpKSk7DQpkcml2ZXJzL3Njc2kvbHBmYy9scGZj
X3NsaS5jOiAgICAgICAgICAgICBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcygxMDAwICoNCnBo
YmEtPmVyYXR0X3BvbGxfaW50ZXJ2YWwpKTsNCmRyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2xpLmM6
ICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCAqDQpscGZjX21ib3hfdG1vX3ZhbChw
aGJhLCBtYm94cSkpKSk7DQpkcml2ZXJzL3Njc2kvbHBmYy9scGZjX3NsaS5jOiAgICAgICAgICAg
dGltZW91dF9yZXEgPSBtc2Vjc190b19qaWZmaWVzKHRpbWVvdXQgKg0KMTAwMCk7DQpkcml2ZXJz
L3Njc2kvbHBmYy9scGZjX3NsaS5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG1zZWNzX3RvX2ppZmZpZXModGltZW91dCAqIDEwMDApKTsNCmRyaXZlcnMvc2NzaS9scGZj
L2xwZmNfdnBvcnQuYzogd2FpdF90aW1lX21heCA9DQptc2Vjc190b19qaWZmaWVzKCgocGhiYS0+
ZmNfcmF0b3YgKiAzKSArIDMpICogMTAwMCk7DQpkcml2ZXJzL3Njc2kvbXB0M3Nhcy9tcHQzc2Fz
X2Jhc2UuYzogICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApKTsNCmRyaXZlcnMvc2NzaS9t
cHQzc2FzL21wdDNzYXNfYmFzZS5jOiAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwMCkpOw0K
ZHJpdmVycy9zb2MvYXBwbGUvcnRraXQuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL3Nv
Yy9xY29tL3JwbWguYzojZGVmaW5lIFJQTUhfVElNRU9VVF9NUyAgICAgICAgICAgICAgICAgbXNl
Y3NfdG9famlmZmllcygxMDAwMCkNCmRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYzogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSkpDQpk
cml2ZXJzL3NwaS9zcGktYXQ5MS11c2FydC5jOiNkZWZpbmUgVVNfRE1BX1RJTUVPVVQNCihtc2Vj
c190b19qaWZmaWVzKDEwMDApKQ0KZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmM6ICAgICBpZiAo
IXdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmcS0+YywNCm1zZWNzX3RvX2ppZmZpZXMoMTAw
MCkpKQ0KZHJpdmVycy9zcGkvc3BpLWltZy1zcGZpLmM6ICAgICAgICAgICAgIG1zZWNzX3RvX2pp
ZmZpZXMoeGZlci0+bGVuICogOCAqIDEwMDAgLw0KeGZlci0+c3BlZWRfaHogKyAxMDApOw0KZHJp
dmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLXFzcGkuYzogIGlmDQooIXdhaXRfZm9yX2NvbXBs
ZXRpb25fdGltZW91dCgmcXNwaS0+ZGF0YV9jb21wbGV0aW9uLA0KbXNlY3NfdG9famlmZmllcygx
MDAwKSkpDQpkcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYzogICAgIGlmICghd2FpdF9mb3JfY29t
cGxldGlvbl90aW1lb3V0KCZmLT5jLA0KbXNlY3NfdG9famlmZmllcygxMDAwKSkpDQpkcml2ZXJz
L3NwaS9zcGktb21hcDItbWNzcGkuYzogIHRpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlm
ZmllcygxMDAwKTsNCmRyaXZlcnMvc3BpL3NwaS1zdW5wbHVzLXNwNzAyMS5jOiAgICAgICB1bnNp
Z25lZCBsb25nIHRpbWVvdXQgPQ0KbXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvc3Bp
L3NwaS10ZWdyYTExNC5jOiNkZWZpbmUgU1BJX0RNQV9USU1FT1VUDQoobXNlY3NfdG9famlmZmll
cygxMDAwKSkNCmRyaXZlcnMvc3BpL3NwaS10ZWdyYTIwLXNmbGFzaC5jOiNkZWZpbmUgU1BJX0RN
QV9USU1FT1VUDQoobXNlY3NfdG9famlmZmllcygxMDAwKSkNCmRyaXZlcnMvc3BpL3NwaS10ZWdy
YTIwLXNsaW5rLmM6I2RlZmluZSBTTElOS19ETUFfVElNRU9VVA0KKG1zZWNzX3RvX2ppZmZpZXMo
MTAwMCkpDQpkcml2ZXJzL3NwaS9zcGktdGVncmEyMTAtcXVhZC5jOiNkZWZpbmUgUVNQSV9ETUFf
VElNRU9VVA0KKG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpDQpkcml2ZXJzL3NwaS9zcGkteGxwLmM6
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmll
cygxMDAwKSk7DQpkcml2ZXJzL3NwaS9zcGktenlucS1xc3BpLmM6ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVz
KDEwMDApKSkNCmRyaXZlcnMvc3BpL3NwaS16eW5xLXFzcGkuYzogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMo
MTAwMCkpKQ0KZHJpdmVycy9zcGkvc3BpLXp5bnEtcXNwaS5jOiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygx
MDAwKSkpDQpkcml2ZXJzL3NwaS9zcGktenlucS1xc3BpLmM6ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEw
MDApKSkNCmRyaXZlcnMvc3BpL3NwaS16eW5xbXAtZ3FzcGkuYzogdGltZW91dCA9IGppZmZpZXMg
KyBtc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy9zdGFnaW5nL2dyZXlidXMvZnctZG93
bmxvYWQuYzojZGVmaW5lIE5FWFRfUkVRX1RJTUVPVVRfSg0KbXNlY3NfdG9famlmZmllcygxMDAw
KQ0KZHJpdmVycy9zdGFnaW5nL21lZGlhL2lwdTMvaXB1My5jOiAgICAgICAgICBpbWd1X2Nzc19x
dWV1ZV9lbXB0eSgmaW1ndS0+Y3NzKSwNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpKQ0KZHJpdmVy
cy9zdGFnaW5nL21lZGlhL29tYXA0aXNzL2lzcy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpKSB7DQpkcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3Vh
cnRwcy5jOiAgICAgdGltZW91dCA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmllcygxMDAwKTsN
CmRyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmM6ICAgICB0aW1lb3V0ID0gamlmZmll
cyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0KZHJpdmVycy91c2IvYXRtL3NwZWVkdGNoLmM6
ICAgICBtb2RfdGltZXIoJmluc3RhbmNlLT5zdGF0dXNfY2hlY2tfdGltZXIsDQpqaWZmaWVzICsg
bXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL3VzYi9hdG0vdWVhZ2xlLWF0bS5jOiAg
IHJldCA9IHVlYV93YWl0KHNjLCAwLCBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMv
dXNiL2F0bS91ZWFnbGUtYXRtLmM6ICAgICAgICAgICAgICAgICAgIHVlYV93YWl0KHNjLCAwLCBt
c2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2
Yy5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1dmMtPmZ1bmNfY29ubmVjdGVkID09IGZh
bHNlLA0KbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0
OTFfdWRjLmM6I2RlZmluZSBWQlVTX1BPTExfVElNRU9VVA0KbXNlY3NfdG9famlmZmllcygxMDAw
KQ0KZHJpdmVycy91c2IvbXVzYi9tdXNiX2NvcmUuYzogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmRyaXZlcnMvdXNiL211c2IvdXg1MDAu
YzogICAgICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArDQptc2Vjc190b19qaWZm
aWVzKDEwMDApOw0KZHJpdmVycy91c2Ivc3RvcmFnZS9yZWFsdGVrX2NyLmM6ICAgICAgIGNoaXAt
PnRpbWVyX2V4cGlyZXMgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCpzc19kZWxh
eSk7DQpkcml2ZXJzL3VzYi90eXBlYy90aXBkL2NvcmUuYzogIHRpbWVvdXQgPSBqaWZmaWVzICsg
bXNlY3NfdG9famlmZmllcygxMDAwKTsNCmRyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvdWNzaV9jY2cu
YzogICAgICB1bnNpZ25lZCBsb25nIHRhcmdldCA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmll
cygxMDAwKTsNCmRyaXZlcnMvdmlkZW8vZmJkZXYvb21hcDIvb21hcGZiL2Rzcy9kc2kuYzogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpDQo9PSAwKSB7
DQpkcml2ZXJzL3cxL21hc3RlcnMvZHMyNDkwLmM6ICAgIGNvbnN0IHVuc2lnbmVkIGxvbmcganRp
bWUgPQ0KbXNlY3NfdG9famlmZmllcygxMDAwKjgvNzUpOw0KZnMvYnRyZnMvZGlzay1pby5jOiAg
ICAgICAgICAgICBkZWxheSA9IG1zZWNzX3RvX2ppZmZpZXMoZnNfaW5mby0+Y29tbWl0X2ludGVy
dmFsICoNCjEwMDApOw0KZnMvYnRyZnMvZGlzay1pby5jOiAgICAgICAgICAgICAgICAgICAgIGRl
bGF5IC09IG1zZWNzX3RvX2ppZmZpZXMoKGRlbHRhIC0gMSkgKiAxMDAwKTsNCmZzL2J0cmZzL2Rp
c2staW8uYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVz
KGZzX2luZm8tPmNvbW1pdF9pbnRlcnZhbCAqDQoxMDAwKSk7DQpmcy9vY2ZzMi9jbHVzdGVyL2hl
YXJ0YmVhdC5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAw
MCkpOw0KZnMvb2NmczIvZGxtL2RsbW1hc3Rlci5jOiAgICAgICAgICAgICAgICAgIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwMCkpOw0KZnMvb2NmczIvZGxtL2RsbXJlY292ZXJ5LmM6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZm
aWVzKDEwMDApKTsNCmZzL29jZnMyL2RsbS9kbG1yZWNvdmVyeS5jOiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpmcy9wc3RvcmUv
em9uZS5jOiAgICAgICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmcHN6X2NsZWFuZXIs
DQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCmZzL3hmcy94ZnNfaWNhY2hlLmM6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoeGZzX2Jsb2NrZ2Nfc2VjcyAq
IDEwMDApKTsNCmluY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaDojZGVmaW5lIE1BWF9XQUlUX1ND
SEVEX0VOVElUWV9RX0VNUFRZDQptc2Vjc190b19qaWZmaWVzKDEwMDApDQppbmNsdWRlL2xpbnV4
L2NlcGgvbGliY2VwaC5oOiNkZWZpbmUgQ0VQSF9NT1VOVF9USU1FT1VUX0RFRkFVTFQNCm1zZWNz
X3RvX2ppZmZpZXMoNjAgKiAxMDAwKQ0KaW5jbHVkZS9saW51eC9jZXBoL2xpYmNlcGguaDojZGVm
aW5lIENFUEhfT1NEX0tFRVBBTElWRV9ERUZBVUxUDQptc2Vjc190b19qaWZmaWVzKDUgKiAxMDAw
KQ0KaW5jbHVkZS9saW51eC9jZXBoL2xpYmNlcGguaDojZGVmaW5lIENFUEhfT1NEX0lETEVfVFRM
X0RFRkFVTFQNCm1zZWNzX3RvX2ppZmZpZXMoNjAgKiAxMDAwKQ0KaW5jbHVkZS9saW51eC9jZXBo
L2xpYmNlcGguaDojZGVmaW5lIENFUEhfTU9OQ19IVU5UX0lOVEVSVkFMDQptc2Vjc190b19qaWZm
aWVzKDMgKiAxMDAwKQ0KaW5jbHVkZS9saW51eC9jZXBoL2xpYmNlcGguaDojZGVmaW5lIENFUEhf
TU9OQ19QSU5HX0lOVEVSVkFMDQptc2Vjc190b19qaWZmaWVzKDEwICogMTAwMCkNCmluY2x1ZGUv
bGludXgvY2VwaC9saWJjZXBoLmg6I2RlZmluZSBDRVBIX01PTkNfUElOR19USU1FT1VUDQptc2Vj
c190b19qaWZmaWVzKDMwICogMTAwMCkNCmluY2x1ZGUvbmV0L2JsdWV0b290aC9jb3JlZHVtcC5o
OiNkZWZpbmUgREVWQ09SRURVTVBfVElNRU9VVA0KbXNlY3NfdG9famlmZmllcygxMDAwMCkgLyog
MTAgc2VjICovDQppbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpLmg6I2RlZmluZSBIQ0lfSU5JVF9U
SU1FT1VUDQptc2Vjc190b19qaWZmaWVzKDEwMDAwKSAvKiAxMCBzZWNvbmRzICovDQppbmNsdWRl
L25ldC9ibHVldG9vdGgvbDJjYXAuaDojZGVmaW5lIEwyQ0FQX1dBSVRfQUNLX1RJTUVPVVQNCm1z
ZWNzX3RvX2ppZmZpZXMoMTAwMDApDQprZXJuZWwva2NzYW4va2NzYW5fdGVzdC5jOiAgICAgIGVu
ZF90aW1lICs9IG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7IC8qIFRoaXMNCnRlc3QgcmVxdWlyZXMg
YSBiaXQgbW9yZSB0aW1lLiAqLw0Ka2VybmVsL3Bvd2VyL2VuZXJneV9tb2RlbC5jOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkp
Ow0KbmV0L2JhdG1hbi1hZHYvZGlzdHJpYnV0ZWQtYXJwLXRhYmxlLmM6ICAgICAgICAgICAgICAg
ICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDAwKSk7DQpuZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmM6
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXModGltZW91
dCAqIDEwMDApKTsNCm5ldC9ibHVldG9vdGgvbWdtdC5jOiAgICAgICAgICAgaW50IHRvID0gbXNl
Y3NfdG9famlmZmllcyhoZGV2LT5kaXNjb3ZfdGltZW91dCAqDQoxMDAwKTsNCm5ldC9ibHVldG9v
dGgvbWdtdC5jOiAgICAgICAgICAgICAgICAgICBpbnQgdG8gPSBtc2Vjc190b19qaWZmaWVzKGhk
ZXYtPmRpc2Nvdl90aW1lb3V0ICoNCjEwMDApOw0KbmV0L2JyaWRnZS9icl9wcml2YXRlLmg6I2Rl
ZmluZSBCUl9NVUxUSUNBU1RfUVVFUllfSU5UVkxfTUlODQptc2Vjc190b19qaWZmaWVzKDEwMDAp
DQpuZXQvY2VwaC9jZXBoX2NvbW1vbi5jOiAgICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKHJl
c3VsdC51aW50XzMyICogMTAwMCk7DQpuZXQvY2VwaC9jZXBoX2NvbW1vbi5jOiAgICAgICAgIG9w
dC0+b3NkX2lkbGVfdHRsID0NCm1zZWNzX3RvX2ppZmZpZXMocmVzdWx0LnVpbnRfMzIgKiAxMDAw
KTsNCm5ldC9jZXBoL2NlcGhfY29tbW9uLmM6ICAgICAgICAgb3B0LT5tb3VudF90aW1lb3V0ID0N
Cm1zZWNzX3RvX2ppZmZpZXMocmVzdWx0LnVpbnRfMzIgKiAxMDAwKTsNCm5ldC9jZXBoL2NlcGhf
Y29tbW9uLmM6ICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMocmVzdWx0LnVpbnRfMzIgKiAx
MDAwKTsNCm5ldC9jb3JlL3BhZ2VfcG9vbC5jOiNkZWZpbmUgREVGRVJfVElNRSAobXNlY3NfdG9f
amlmZmllcygxMDAwKSkNCm5ldC9pcHY0L2lwY29uZmlnLmM6ICAgICAgICAgICAgICAgICAgICAg
ICBtc2Vjc190b19qaWZmaWVzKGNhcnJpZXJfdGltZW91dCAqIDEwMDApKSkgew0KbmV0L21hYzgw
MjE1NC9zY2FuLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmll
cygxMDAwKSk7DQpuZXQvbWFjODAyMTU0L3NjYW4uYzogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCm5ldC9uZXRmaWx0ZXIveHRfSURMRVRJTUVS
LmM6ICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoaW5mby0+dGltZW91dCAqIDEwMDApDQor
IGppZmZpZXMpOw0KbmV0L25ldGZpbHRlci94dF9JRExFVElNRVIuYzogICAgICAgICAgICAgICAg
ICAgICAgICAgICBtc2Vjc190b19qaWZmaWVzKGluZm8tPnRpbWVvdXQgKiAxMDAwKQ0KKyBqaWZm
aWVzKTsNCm5ldC9uZXRmaWx0ZXIveHRfSURMRVRJTUVSLmM6ICAgICAgICAgICAgIG1zZWNzX3Rv
X2ppZmZpZXMoaW5mby0+dGltZW91dCAqIDEwMDApDQorIGppZmZpZXMpOw0KbmV0L25ldGZpbHRl
ci94dF9JRExFVElNRVIuYzogICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190b19qaWZm
aWVzKGluZm8tPnRpbWVvdXQgKiAxMDAwKQ0KKyBqaWZmaWVzKTsNCm5ldC9uZXRmaWx0ZXIveHRf
SURMRVRJTUVSLmM6ICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcyhpbmZvLT50
aW1lb3V0ICogMTAwMCkNCisgamlmZmllcyk7DQpuZXQvbmV0ZmlsdGVyL3h0X0lETEVUSU1FUi5j
OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcyhpbmZv
LT50aW1lb3V0ICogMTAwMCkNCisgamlmZmllcyk7DQpuZXQvbmZjL25jaS9zcGkuYzogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygx
MDAwKSkgPT0gMCkgew0KbmV0L3RpcGMvY3J5cHRvLmM6I2RlZmluZSBUSVBDX1RYX0xBU1RJTkdf
VElNRSAgbXNlY3NfdG9famlmZmllcygxMDAwMCkNCi8qIDEwcyAqLw0KbmV0L3RpcGMvZGlzY292
ZXIuYzojZGVmaW5lIFRJUENfRElTQ19GQVNUICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKQ0K
bmV0L3RpcGMvZGlzY292ZXIuYzogICAgICAgICAgICB0bi0+YWRkcl90cmlhbF9lbmQgPSBqaWZm
aWVzICsgbXNlY3NfdG9famlmZmllcygxMDAwKTsNCm5ldC90aXBjL2Rpc2NvdmVyLmM6ICAgICAg
ICAgICAgdG4tPmFkZHJfdHJpYWxfZW5kID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAw
MCk7DQpzYW1wbGVzL2Nvbm5lY3Rvci9jbl90ZXN0LmM6ICAgIG1vZF90aW1lcigmY25fdGVzdF90
aW1lciwgamlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCnNhbXBsZXMvY29ubmVj
dG9yL2NuX3Rlc3QuYzogICAgbW9kX3RpbWVyKCZjbl90ZXN0X3RpbWVyLCBqaWZmaWVzICsNCm1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0Kc2NyaXB0cy9jb2NjaW5lbGxlL21pc2Mvc2Vjc190b19q
aWZmaWVzLmNvY2NpOi8vLyAtDQptc2Vjc190b19qaWZmaWVzKHZhbHVlKjEwMDApDQpzY3JpcHRz
L2NvY2NpbmVsbGUvbWlzYy9zZWNzX3RvX2ppZmZpZXMuY29jY2k6LSBtc2Vjc190b19qaWZmaWVz
KEMgKiAxMDAwKQ0Kc291bmQvaGRhL2hkYWNfY29udHJvbGxlci5jOiAgICB0aW1lb3V0ID0gamlm
ZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpzb3VuZC9pc2Evd3NzL3dzc19saWIuYzog
ICAgICAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlmZmll
cygxMDAwKTsNCnNvdW5kL3BjaS9hYzk3L2FjOTdfY29kZWMuYzogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcyhwb3dlcl9zYXZlICogMTAwMCkpOw0Kc291
bmQvcGNpL2hkYS9oZGFfaW50ZWwuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpzb3VuZC9wY2kvaGRh
L3BhdGNoX2NhMDEzMi5jOiAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGppZmZpZXMgKw0KbXNl
Y3NfdG9famlmZmllcygxMDAwKTsNCnNvdW5kL3BjaS9oZGEvcGF0Y2hfY2EwMTMyLmM6ICAgdW5z
aWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmllcyArDQptc2Vjc190b19qaWZmaWVzKDEwMDApOw0K
c291bmQvcGNpL2hkYS9wYXRjaF9jYTAxMzIuYzogICB1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBq
aWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpzb3VuZC9wY2kvaGRhL3BhdGNoX2Nh
MDEzMi5jOiAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGppZmZpZXMgKw0KbXNlY3NfdG9famlm
ZmllcygxMDAwKTsNCnNvdW5kL3BjaS9oZGEvcGF0Y2hfY2EwMTMyLmM6ICAgICAgICAgICB1bnNp
Z25lZCBsb25nIHRpbWVvdXQgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpz
b3VuZC9wY2kvbG9sYS9sb2xhLmM6ICB0aW1lb3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZp
ZXMoMTAwMCk7DQpzb3VuZC9zb2MvY29kZWNzL2NzNDJsNDMtamFjay5jOiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0Kc291bmQvc29jL2NvZGVjcy9j
czQzMTMwLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9f
amlmZmllcygxMDAwKSk7DQpzb3VuZC9zb2MvY29kZWNzL3J0NTY3Ny5jOiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSk7DQpzb3VuZC9z
b2MvY29kZWNzL3dtODk3MS5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ3bTg5NzEt
PmNoYXJnZV93b3JrLCBtc2Vjc190b19qaWZmaWVzKDEwMDApKTsNCnNvdW5kL3NvYy9jb2RlY3Mv
d204OTk0LmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Vjc190
b19qaWZmaWVzKDEwMDApKTsNCnNvdW5kL3VzYi9lbmRwb2ludC5jOiAgIHVuc2lnbmVkIGxvbmcg
ZW5kX3RpbWUgPSBqaWZmaWVzICsNCm1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7DQpzb3VuZC91c2Iv
bWl4ZXJfc2NhcmxldHQyLmM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpKSB7DQoNCg0KDQo+DQo+IFRoZSBlbnRpcmUgY29udmVyc2lv
biBpcyBtYWRlIHdpdGggQ29jY2luZWxsZSBpbiB0aGUgc2NyaXB0IGFkZGVkIGluDQo+IHBhdGNo
IDIuIFNvbWUgY2hhbmdlcyBzdWdnZXN0ZWQgYnkgQ29jY2luZWxsZSBoYXZlIGJlZW4gZGVmZXJy
ZWQgdG8NCj4gbGF0ZXIgcGFydHMgdGhhdCB3aWxsIGFkZHJlc3Mgb3RoZXIgcG9zc2libGUgdmFy
aWFudCBwYXR0ZXJucy4NCj4NCj4gQ0M6IEFubmEtTWFyaWEgQmVobnNlbiA8YW5uYS1tYXJpYUBs
aW51dHJvbml4LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBFYXN3YXIgSGFyaWhhcmFuIDxlYWhhcmlo
YUBsaW51eC5taWNyb3NvZnQuY29tPg0KPg0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjQxMDMwLW9wZW4tY29kZWQtdGltZW91dHMtdjMtMC05YmExMjNmYWNmODhAbGludXgu
bWljcm9zb2Z0LmNvbS8NCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84NzM0a25n
Zm5pLmZzZkBzb21udXMvDQo+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEVESVRNRTog
ZGVzY3JpYmUgd2hhdCBpcyBuZXcgaW4gdGhpcyBzZXJpZXMgcmV2aXNpb24uDQo+IC0gRURJVE1F
OiB1c2UgYnVsbGV0cG9pbnRzIGFuZCB0ZXJzZSBkZXNjcmlwdGlvbnMuDQo+IC0gTGluayB0byB2
MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MTExNS1jb252ZXJnZS1zZWNzLXRvLWpp
ZmZpZXMtdjEtMC0xOWFhZGMzNDk0MWJAbGludXgubWljcm9zb2Z0LmNvbQ0KPg0KPiAtLS0NCj4g
RWFzd2FyIEhhcmloYXJhbiAoMjEpOg0KPiAgICAgICAgbmV0ZmlsdGVyOiBjb25udHJhY2s6IENs
ZWFudXAgdGltZW91dCBkZWZpbml0aW9ucw0KPiAgICAgICAgY29jY2luZWxsZTogbWlzYzogQWRk
IHNlY3NfdG9famlmZmllcyBzY3JpcHQNCj4gICAgICAgIGFybTogcHhhOiBDb252ZXJ0IHRpbWVv
dXRzIHRvIHVzZSBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAgICAgczM5MDoga2VybmVsOiBDb252
ZXJ0IHRpbWVvdXRzIHRvIHVzZSBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAgICAgcG93ZXJwYy9w
YXByX3NjbTogQ29udmVydCB0aW1lb3V0cyB0byBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAgICAg
bW06IGttZW1sZWFrOiBDb252ZXJ0IHRpbWVvdXRzIHRvIHNlY3NfdG9famlmZmllcygpDQo+ICAg
ICAgICBhY2NlbC9oYWJhbmFsYWJzOiBDb252ZXJ0IHRpbWVvdXRzIHRvIHNlY3NfdG9famlmZmll
cygpDQo+ICAgICAgICBkcm0veGU6IENvbnZlcnQgdGltZW91dCB0byBzZWNzX3RvX2ppZmZpZXMo
KQ0KPiAgICAgICAgZHJtL2V0bmF2aXY6IENvbnZlcnQgdGltZW91dHMgdG8gc2Vjc190b19qaWZm
aWVzKCkNCj4gICAgICAgIHNjc2k6IGxwZmM6IENvbnZlcnQgdGltZW91dHMgdG8gc2Vjc190b19q
aWZmaWVzKCkNCj4gICAgICAgIHNjc2k6IGFyY21zcjogQ29udmVydCB0aW1lb3V0cyB0byBzZWNz
X3RvX2ppZmZpZXMoKQ0KPiAgICAgICAgc2NzaTogcG04MDAxOiBDb252ZXJ0IHRpbWVvdXRzIHRv
IHNlY3NfdG9famlmZmllcygpDQo+ICAgICAgICB4ZW4vYmxrYmFjazogQ29udmVydCB0aW1lb3V0
cyB0byBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAgICAgZ3ZlOiBDb252ZXJ0IHRpbWVvdXRzIHRv
IHNlY3NfdG9famlmZmllcygpDQo+ICAgICAgICB3aWZpOiBhdGgxMWs6IENvbnZlcnQgdGltZW91
dHMgdG8gc2Vjc190b19qaWZmaWVzKCkNCj4gICAgICAgIEJsdWV0b290aDogTUdNVDogQ29udmVy
dCB0aW1lb3V0cyB0byBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAgICAgc3RhZ2luZzogdmMwNF9z
ZXJ2aWNlczogQ29udmVydCB0aW1lb3V0cyB0byBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAgICAg
Y2VwaDogQ29udmVydCB0aW1lb3V0cyB0byBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAgICAgbGl2
ZXBhdGNoOiBDb252ZXJ0IHRpbWVvdXRzIHRvIHNlY3NfdG9famlmZmllcygpDQo+ICAgICAgICBB
TFNBOiBsaW5lNjogQ29udmVydCB0aW1lb3V0cyB0byBzZWNzX3RvX2ppZmZpZXMoKQ0KPiAgICAg
ICAgbmZwOiBDb252ZXJ0IHRpbWVvdXRzIHRvIHNlY3NfdG9famlmZmllcygpDQo+DQo+ICAgYXJj
aC9hcm0vbWFjaC1weGEvc2hhcnBzbF9wbS5jICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysr
LS0tDQo+ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BhcHJfc2NtLmMgICAgICAg
ICAgIHwgIDIgKy0NCj4gICBhcmNoL3MzOTAva2VybmVsL2xnci5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMyArKy0NCj4gICBhcmNoL3MzOTAva2VybmVsL3RpbWUuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNCArKy0tDQo+ICAgYXJjaC9zMzkwL2tlcm5lbC90b3Bv
bG9neS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2FjY2Vs
L2hhYmFuYWxhYnMvY29tbW9uL2RldmljZS5jICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZl
cnMvYWNjZWwvaGFiYW5hbGFicy9jb21tb24vaGFiYW5hbGFic19kcnYuYyAgICB8ICAzICstLQ0K
PiAgIGRyaXZlcnMvYmxvY2sveGVuLWJsa2JhY2svYmxrYmFjay5jICAgICAgICAgICAgICAgICB8
ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9jbWRidWYuYyAgICAg
ICAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2aWNlLmMgICAgICAg
ICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2dvb2dsZS9n
dmUvZ3ZlX3R4X2Rxby5jICAgICAgICB8ICA2ICsrLS0tLQ0KPiAgIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L25ldHJvbm9tZS9uZnAvbmZwX25ldF9jb21tb24uYyB8ICAyICstDQo+ICAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvYXRoL2F0aDExay9kZWJ1Z2ZzLmMgICAgICAgICAgIHwgIDIgKy0NCj4gICBk
cml2ZXJzL3Njc2kvYXJjbXNyL2FyY21zcl9oYmEuYyAgICAgICAgICAgICAgICAgICAgfCAgMiAr
LQ0KPiAgIGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jICAgICAgICAgICAgICAgICAgICAg
ICB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfbnBv
cnRkaXNjLmMgICAgICAgICAgICAgICAgICB8ICA4ICsrKystLS0tDQo+ICAgZHJpdmVycy9zY3Np
L2xwZmMvbHBmY19udm1lLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBkcml2
ZXJzL3Njc2kvbHBmYy9scGZjX3NsaS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArKy0t
DQo+ICAgZHJpdmVycy9zY3NpL2xwZmMvbHBmY192bWlkLmMgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIgKy0NCj4gICBkcml2ZXJzL3Njc2kvcG04MDAxL3BtODAwMV9pbml0LmMgICAgICAgICAg
ICAgICAgICAgfCAgMiArLQ0KPiAgIC4uLi92YzA0X3NlcnZpY2VzL2JjbTI4MzUtYXVkaW8vYmNt
MjgzNS12Y2hpcS5jICAgICB8ICAyICstDQo+ICAgZnMvY2VwaC9xdW90YS5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBtbS9rbWVtbGVhay5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArKy0tDQo+ICAgbmV0L2JsdWV0
b290aC9tZ210LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBu
ZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90b19zY3RwLmMgICAgICAgICAgICAgfCAyMSAr
KysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICBzYW1wbGVzL2xpdmVwYXRjaC9saXZlcGF0Y2gtY2Fs
bGJhY2tzLWJ1c3ltb2QuYyAgICAgfCAgMiArLQ0KPiAgIHNhbXBsZXMvbGl2ZXBhdGNoL2xpdmVw
YXRjaC1zaGFkb3ctZml4MS5jICAgICAgICAgICB8ICAyICstDQo+ICAgc2FtcGxlcy9saXZlcGF0
Y2gvbGl2ZXBhdGNoLXNoYWRvdy1tb2QuYyAgICAgICAgICAgIHwgMTAgKysrKystLS0tLQ0KPiAg
IHNjcmlwdHMvY29jY2luZWxsZS9taXNjL3NlY3NfdG9famlmZmllcy5jb2NjaSAgICAgICB8IDIx
ICsrKysrKysrKysrKysrKysrKysrKw0KPiAgIHNvdW5kL3VzYi9saW5lNi90b25lcG9ydC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAgMzAgZmlsZXMgY2hhbmdlZCwgNzkg
aW5zZXJ0aW9ucygrKSwgNjUgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogMmQ1
NDA0Y2FhOGM3YmI1YzRlMDQzNWY5NGIyODgzNGFlNTQ1NjYyMw0KPiBjaGFuZ2UtaWQ6IDIwMjQx
MTEyLWNvbnZlcmdlLXNlY3MtdG8tamlmZmllcy1kOTlkMTAxNmJkMTENCj4NCj4gQmVzdCByZWdh
cmRzLA0KPiAtLQ0KPiBFYXN3YXIgSGFyaWhhcmFuIDxlYWhhcmloYUBsaW51eC5taWNyb3NvZnQu
Y29tPg0KPg0K
