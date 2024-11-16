Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C8AD68BD2
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eoB4Zba0oDILq/GyWjNIQLXHlVmq6QUNlZtjwtBqfrw=;
  b=gFHL2kmIGJMqM4lgJpvs+lJkfhhUcSGoz2FzU1B8sZrcm/3o5QNBKTLP
   y4TcziINehnvsZKI0zGnvBQYl/+eCY9otbX/psyedvsr08zw6Wrk6Ihi0
   1w985Bpe3Psmhxq+wSJ6EIKOCaoPvv5OCtbyDUo70VRh4OZ26LjNYNdi7
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194200303"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 11:24:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CC46BE0D1D; Sat, 16 Nov 2024 11:24:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3EB01E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:24:42 +0100 (CET)
IronPort-SDR: 673872e8_p4NMj7zJn3RjiRS2mC93MkN0Nyggs6s2YYnVlJpi3ldcx3v
 meJwSbgIaykLZ6q3HmVfweOYsRqpaxt7Mp90Ijg==
X-IPAS-Result: =?us-ascii?q?A0FDAACXcThne07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQmIbBlQzBAtIhFaIHYcwgXQthD6PEYh1gVYUgWoPAQMBDT0EA?=
 =?us-ascii?q?QIEAQEDBIUAAopLAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBQg47hXsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAg06RAIBA?=
 =?us-ascii?q?yMdAQERJgEPCw4MAhEVAgJWBgEUAQGCfQGCLwEDMQcNsT6BMoEBggwBAQbaW?=
 =?us-ascii?q?x8sIleBZAMGgRouAYVpgmIBhWk7CYQzJw+BVUSBPAuBCYFvPoJKFwQYfwo9P?=
 =?us-ascii?q?4McgmmCRYE+E4NCJYRGgiKBCiVog3+EGIU/Y4IfLokPUnscA1kyAVUTFwsHB?=
 =?us-ascii?q?YEpISwDgXtOf4E2gVEBQYJOSoMugV4FNwo/gkppSzcCDQI2giQkWYJPgSUEB?=
 =?us-ascii?q?YNsgQuDYWcvAwMDA4M8hAcdQAIBC209NQkLGwY9oA5HgzSBO4EwjlGFPQyDO?=
 =?us-ascii?q?wGvQjQHgjiBZYFjDIonji2Dd4MOBhMvl0AOBpJ6LodkkGUijV2VZYVDgWc6I?=
 =?us-ascii?q?IE8MxokgzZPAxkPjiGELYRhwRJCNQIBATcCBwEKAQEDCYVGAQGBfYc9amEBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 JdcE9eztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:y4pcbK3QmNZajE43LRKGDAqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:PX+GNm4qqxamAotMANssrmtPRM8VI1vknSnRE3ayV35CEY2ucArF
X-Talos-MUID: 9a23:Q4AJBAoJDk3rtKcXnUAez2hIG+tk4vWhNB4cjLIehcKDaWtaYA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="101791043"
X-MGA-submission: =?us-ascii?q?MDEadKW5eHAmG3eVBF5Er7gh4NLy/4oSiFWzpq?=
 =?us-ascii?q?WRsfuhx7vXgBOSZ9JhZ8lzMBzBtMw5hZM5SeZcbVYJUF4zB9cEfmLwyG?=
 =?us-ascii?q?mAA71j9NVjrQ3qiYz6qeD3OKuq+zCZ7pBVoNS2x9TmgEs76lR3X+CjvC?=
 =?us-ascii?q?PjbaZHx+j7CaBgt1ASvrWxgg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:24:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731752603; x=1732357403; i=markus.elfring@web.de;
	bh=eoB4Zba0oDILq/GyWjNIQLXHlVmq6QUNlZtjwtBqfrw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tnnl91YQA9DSUV2bdoeF4YOzfbARJimu/tmTDLNdMzul1FlQPw5QAAWt1drAk3Ad
	 UaqUN1luEW9vrGmy5mWB1wRipPzGEoQ4902WuRX35XoQbOkOHx7N5kAyldxyp9LLl
	 1Vk/5239bUtdx8q/sqWvpw2IyfOhJfBK8McXtVpLEuSCNU5mE6cKsy0/6jClBDTUM
	 m+oUTX9sbL6OWR2KY3c7lHUrA/8zzFHEyHN37tBZ9WKhIaGnQCYZaZ/dESL4qqWra
	 HEE9nF1GNM2k2tc67GtBgE+9Wvrb9QIWtacHHbvnKxQVdIEh90Izoix70o+OBS4Mn
	 VfNCU6GXLXJcQEmlEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8kEV-1t87Dv2SuX-00FywX; Sat, 16
 Nov 2024 11:23:22 +0100
Message-ID: <9088f9a2-c4ab-4098-a255-25120df5c497@web.de>
Date: Sat, 16 Nov 2024 11:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-mm@kvack.org, linux-bluetooth@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 ceph-devel@vger.kernel.org, live-patching@vger.kernel.org,
 linux-sound@vger.kernel.org, etnaviv@lists.freedesktop.org,
 oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King
 <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ozemPo5Q9OPy+/gWIfbNb/yTAwp7zpbaqzDjn4mcTmOYffBLZAH
 E0gCP/qnqze9l4Bx97cEhIN2OOovptOgRBkBUi+bKyV+a6ol7S4atoRxVmjqBCc2g41VI8a
 ROXhUKP5mlUoyzcJqOavJdVAoW8iKSPURqEhcga4JsnmJm/Pjl1vO+foxZw0grHWEblCrYI
 LJ17n1lYaEdE61JhX5uvg==
UI-OutboundReport: notjunk:1;M01:P0:cqxyRecUHWI=;mdNOJxMPXJ1GyzF//eKGdLZ+Q8F
 gZOm7zXyKp5nkSwMIvY2D1Pf29OTgIQNnEk2sxWaloC9j5qlT3qQUm44Qe1eN8K2TrIb7Ylam
 rbOIjXCI16gwyjr6u6Tm4wzXx3QEqIRDJ6vPTxa1qCHZ5nXH9awzzielfDD+nIYBqn+NysMC0
 QZsEszMBUB9IXfIsHktBfi8cBsv+k0746M1afH1AQnbUe7vbWDpvJQfebcg6n+Wz3fvdqxIZD
 kSPPyScjl7oMRh9gl8//4l2V7VzBO9LPR7x4sdROj+PLFL3oFRJx+0h1y9SyUqJ0GnPpxdEL0
 PMzZq88Rt40rnD8qxMQHh7I/uNcMzG6WX18JYqJkBzSmPhgPNeCMeiVI23Ufs+Q4nUJ3qhDsK
 0p5vEIj2tML+6DTh9sRN/Vkr1Nv2iQxQGIWmrKuhxE6H4MNkCnw+r/vzSC3EjHoSsbQuNjTP7
 r+pzwFQBW5yKjimU/E0otnHQxITegw0hqubdGvkG7V+M9Xbvv+rLAmjIvBciAuyFg9KBmCLA8
 CWrj3n83t/hiJIglwxY4Dk0jEZxvykwS9+BkMPoCtPW+iQ8gW/25w94Qj8e0xURq8TAcN0dXU
 AuweP7ynvWG484eB8hCbKDvioN+mlpMsRwjC2FQlrRm4HHD/6yeo6jL47sG63P4yysOuS2zfg
 IN1JwCXmYpKMSvSbVFw4XwyvjYvlKQDYKIw85OFcoZ0jKCnyiqcKt/8cDr+RhTK1EOdwwhDck
 OYb6KgYNVujGNSJD3nwWyFRxhnrOGI6zg/KUG07nQrZrZUdDjSpdUqLqFAptM+j5kRW2zaeV7
 aAINj3gIMOnIF9IxH3vxoaq7UZVlr1ioWkWYi8cog6WCU27yEI6la8XQh2utvVDIt3r9tDYKA
 xoMAYChjmKcdRYrZMLRfSf6EiCXhz9YR9r6L9u2NSImvIGamFAFskjhIg
Subject: Re: [cocci] [PATCH v2 02/21] coccinelle: misc: Add secs_to_jiffies
 script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2054
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/9088f9a2-c4ab-4098-a255-25120df5c497%40web.de>

Why is a change description missing here?


=E2=80=A6
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -0,0 +1,21 @@
=E2=80=A6
> +/// Find usages of:
> +/// - msecs_to_jiffies(value*1000)
> +/// - msecs_to_jiffies(value*MSEC_PER_SEC)

I suggest to take another look at corresponding development documentation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.12-rc7#n71

Will the attention grow for the proper usage of operation modes
according to the tool =E2=80=9Ccoccicheck=E2=80=9D?


=E2=80=A6
> +// Copyright: (C) 2024 Easwar Hariharan Microsoft

Should personal details and company names be better distinguished in such =
information?


> +//
> +// Keywords: secs, seconds, jiffies

May a (blank) comment line be omitted here?


> +@@ constant C; @@
> +
> +- msecs_to_jiffies(C * 1000)
> ++ secs_to_jiffies(C)
> +
> +@@ constant C; @@
> +
> +- msecs_to_jiffies(C * MSEC_PER_SEC)
> ++ secs_to_jiffies(C)

I suggest to take a SmPL code variant (like the following)
better into account.


@depends on patch@
constant C;
@@
-msecs_to_jiffies
+secs_to_jiffies
 (C
- * \( 1000 \| MSEC_PER_SEC \)
 )


Can any expressions become relevant besides =E2=80=9Cconstants=E2=80=9D?

Regards,
Markus
