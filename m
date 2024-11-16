Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7C7D68BF0
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kE48igHqfpYo8FKKwrOfXlsXE7HLXB7dwIBk9D48XCM=;
  b=mUfh5DXCetSbPMnQrlQZP5iau71UvkPIAY1HiIy8ASjc20kbH8qHZUQP
   /hBeTmwXqGrkQRguHOYml5pIZTu4buv/IMn3ETO68q73DDXAN3DGO7eK6
   A0CWp5FQa9H2Su39i4WY8dJuyYiLajGM+IinAcWZT/y0yDFHkczFZHVuH
   o=;
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
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204651"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0085E0D4E; Sat, 16 Nov 2024 12:26:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CB1F9E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 08:46:18 +0100 (CET)
IronPort-SDR: 67384dca_Dh0cQx53LtoDfv/kCGO1NOKB7L2lpUuyaOGtfRfh7AW0ipy
 NaNJCaRyrfVeb09r0fEzOAR/Uumv07DsRup+4OA==
X-IPAS-Result: =?us-ascii?q?A0EMAAA1TDhnhQrrEV1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDfQZTNAQLSIRWiB1fhlGBdC0DhDuYBoFWgUA+DwEDA?=
 =?us-ascii?q?Q05CwQBAQMEhQACiksCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAUBJhXsNgmIBgSRRDQMHPgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQUCDV4BAR4BAQEDIw8BBUEQCw4KAgImAgJWB?=
 =?us-ascii?q?gESAgEBgn0BgmQHDQSxZoEygQHeM4FnBoEaLgGFaYJiAYVpO4Q8Jw+BVUSBP?=
 =?us-ascii?q?AuCeD6IHoJpBIJBhRMlgROHbIwXjX5SexwDWSASAVUTFwsHBYEpERAsAyJva?=
 =?us-ascii?q?k5/gTaBUQFBgk4vGyELXIEpfR0UBhUEgQ4FNwo/gkppSzcCDQI2giQkWYJPg?=
 =?us-ascii?q?SUEBYNsgQuDYWcvAwMDA4M8gk5kVR1AAgELbT01BgMLGwY9oA4BRoJDawaBO?=
 =?us-ascii?q?1AhAh5GAzkgF5Mtkm6fYzQHhB2BXQYMiieVMgYTL5dMCJJ6LodkkGUihHiIZ?=
 =?us-ascii?q?ZUvJx2FNYFCJToQgUxNJoM0TwMZD446iB+LAAG2cEUyOwIHAQoBAQMJjwKBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 EP/xeBG
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:J0wL8qtkRf/gUlPw2nWAnMmo7skDQ9V00zEX/kB9WHVpmwKj5r
 mTdYcgpGTJYVEqKQ4dcLG7SdW9qBznhPxICOUqTM2ftUzdyRaVxeJZnO7fKl/bak7DH4dmvM
 8KHsQQab3N5BpB/L7HCWKDYrEdKbe8gcaVbKvlvhNQpN5RAc9d0zs=
X-Talos-CUID: 9a23:M+99FmFeO80ni6kLqmJV+GcPJOc4fEbUxUfcIWKzWU9vEqSaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AfieJSg+diuJhOiZf7lDoQK6Qf8FuypuCUh0hrc8?=
 =?us-ascii?q?bupKJGwFBIhy60yviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194190562"
X-MGA-submission: =?us-ascii?q?MDFgTWiTYU1+821UyQvObDTdESkX93ezsNHpIB?=
 =?us-ascii?q?y+XXySAmhsxceluRoKB/PXhWrXePXlzQH2dPoP3YSMUP20J0llVNoM/X?=
 =?us-ascii?q?WJSgx02yHH5AVPvdM/nweQYjxcXIcj0Oen1mdh+U8LjLohmQWSw2SzGL?=
 =?us-ascii?q?NHhjRNPjchmXC+r+iq5XbJHQ=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 08:46:18 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr5YP29Z7z9sSS;
	Sat, 16 Nov 2024 08:46:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G9f7_WlJbwOH; Sat, 16 Nov 2024 08:46:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr5YN3qMWz9sSN;
	Sat, 16 Nov 2024 08:46:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 628488B7A7;
	Sat, 16 Nov 2024 08:46:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id UTYP2V69DH6f; Sat, 16 Nov 2024 08:46:16 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 93F818B763;
	Sat, 16 Nov 2024 08:46:12 +0100 (CET)
Message-ID: <856ae9de-0712-4a44-ab3d-9e5077725877@csgroup.eu>
Date: Sat, 16 Nov 2024 08:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
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
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <10ee4e8f-d8b4-4502-a5e2-0657802aeb11@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <10ee4e8f-d8b4-4502-a5e2-0657802aeb11@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2063
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/856ae9de-0712-4a44-ab3d-9e5077725877%40csgroup.eu>



Le 15/11/2024 à 22:29, Easwar Hariharan a écrit :
> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 11/15/2024 1:26 PM, Easwar Hariharan wrote:
>> This is a series that follows up on my previous series to introduce
>> secs_to_jiffies() and convert a few initial users.[1] In the review for
>> that series, Anna-Maria requested converting other users with
>> Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
>> that use the multiply pattern of either of:
>> - msecs_to_jiffies(N*1000), or
>> - msecs_to_jiffies(N*MSEC_PER_SEC)
>>
>> The entire conversion is made with Coccinelle in the script added in
>> patch 2. Some changes suggested by Coccinelle have been deferred to
>> later parts that will address other possible variant patterns.
>>
>> CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>
>> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20241030-open-coded-timeouts-v3-0-9ba123facf88%40linux.microsoft.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cff4857ad28a74e7051f708dd05bc8d45%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638673029556700628%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=q%2FHm%2Fal%2FBtK5J4nd%2BqJHNeSJ3f%2B0lVCKzigUUoL2vjw%3D&reserved=0
>> [2] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F8734kngfni.fsf%40somnus%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cff4857ad28a74e7051f708dd05bc8d45%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638673029556721028%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=PZiR%2B9GSo3Zk7cD85MyM4ZpqvIQtD0lSxd4G1gZ4UFE%3D&reserved=0
>>
>> ---
>> Changes in v2:
>> - EDITME: describe what is new in this series revision.
>> - EDITME: use bulletpoints and terse descriptions.
>> - Link to v1: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20241115-converge-secs-to-jiffies-v1-0-19aadc34941b%40linux.microsoft.com&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cff4857ad28a74e7051f708dd05bc8d45%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638673029556732854%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=NXdY%2FTuSufEPcy4ijIj%2F0%2BW3K%2FhkLs2JGu5C1WFMPOM%3D&reserved=0
>>
> 
> Apologies, I missed out on editing the changelog here. v1 included a
> patch that's already been accepted, there are no other changes in v2.

You should refrain from sending such a patch bomb twice in 4 minutes. If 
there is no other change you could have just replied to that already 
included patch to say so.

In any case wait a few days so that people have time to review and 
provide comments.

Christophe
