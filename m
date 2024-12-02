Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A980BE77178
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FZHtDSci4mxW9uObrOpyGXF4tVtVRk+OAevn+2+RUUc=;
  b=rfhgpGYqDh1ueY4pU3akh+zrhg7jMhL6zCZ7bGmKGWaSlQH8IP1pOBIe
   xfBsK2ZLvLs5K8C1kofILDIaE+ZYGgCW39eBH+ZLpx5Y3xqt+LFVt0XKZ
   9bWmdcrsPojxUgkiww7KNEZr0tyaASM3s7dozvLChhylwFMrdNnEjmKtT
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421401"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D785E0D62; Wed,  4 Dec 2024 23:28:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A5C8CE00B6
	for <cocci@sympa.inria.fr>; Mon,  2 Dec 2024 22:17:09 +0100 (CET)
IronPort-SDR: 674e23d3_/yD8Hd6HsgKkBaKiRUOLl2GeIzBRnBPTdm4Cqn3NtikGqD/
 Cijs/CDfVcXSjhyIZGcXOLu+OElnK7LkXZo2wbQ==
X-IPAS-Result: =?us-ascii?q?A0EJAgBLIk5nga7XVdFagQmBU4JEfVk0BAtIhFaDT4t+g?=
 =?us-ascii?q?iSTTIpLgUA+DwEDAQ05CwQBAQMBA4UAAopoAh4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDjuFew2CYgEzcWECBQM6AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCDR8/AR8BAQECA?=
 =?us-ascii?q?RIRBBkBGx0BAwwGBQsDDAImAgIhAREBBQEcBhMigl8Bgi8BAw4jAxGkWYEFQ?=
 =?us-ascii?q?os+fxYFAhaBAYINBoEJ2VMKGSgNbAOBYQIBBhSBBi6EcylODoI3HQGBbIN9g?=
 =?us-ascii?q?316Jw+BVUSBSoEGgW8+hAqEFIJpBII+hQ8liQCBb4t7HTCCLosNJggBBhcDB?=
 =?us-ascii?q?wcJBQQJEwYFBQJCCQYFChIDBAMEBAECCxMJAwMCDgIIAwIIBh8BPxIEEwoNC?=
 =?us-ascii?q?wcFHwoHDBEKKAQiBA8SHBABAgExAwQFAwUDAwQHAQIFBAkIAQQDAgQDAwICA?=
 =?us-ascii?q?wIIBQcEAwoGAQEDBAMBAQUHBwMCAQEDAQEKCwgNBQMIAwYJAwQBAQIHCAIDD?=
 =?us-ascii?q?gICAgMCAQoGCAUBAwYhAQwDAQMDBQwEFAMEBQICDwwBAgMDBwMFAgICAgICA?=
 =?us-ascii?q?gUEAQIEAgQBBQQJAQICAgMCAQEGBAICAgMCBwwHAwQCBgIGAgMCBwsKAgMGB?=
 =?us-ascii?q?QUDBQIeAgMCAgQDAxUBAQMBAgECAwICAwIDBAEDAwIBAQMHAgICBwYFAgIDD?=
 =?us-ascii?q?AIDAwEBBgECAQIPBQUGBAEKAwIUAwUiAg8FCAEmAR4CAgMEDQgFAgIHAgQMA?=
 =?us-ascii?q?gQPBQMDDgYWBgEECAQGBAwKAwQOBxcRAQEEBAIRBwIIAgIGBAICBxoGAwUIA?=
 =?us-ascii?q?wIFBRACAgsCBAMVBAQbAwECCAICGAIBBwECEgEHAgIBFAIKAwIFBgcCHAICA?=
 =?us-ascii?q?wMEBAMBBQMEEAMLAQUGBQEBBA4BAgECAQECAwMOAQICAwMCAgEJAgIBAQINC?=
 =?us-ascii?q?AEEAwEHAgEEAwUDCgEBAQIBBAkEDQYDBQMDBwMEAgMCBgIECAICAwMCAwEDA?=
 =?us-ascii?q?wIBAgMJAgEPDwoPAgIDBAIGAgIBBCYCARUFAgMEAgIHAgIDAQIBAgICBAIEA?=
 =?us-ascii?q?gIGAwkIAQICBwECAgIDFQIFAQQJAwMFEgwiAwICAgIDBwoDBQIBAQIEAwMDA?=
 =?us-ascii?q?wkNBwIDAQIBAwUDAQIBAgkDBgICAwMFEhkFAwIPAwIBBQQCCBILBwEBDxYFB?=
 =?us-ascii?q?AkFFQMGAgMDFgsEBQMDAwEMBQwOAgILAxcFAQEHAQMOCAMEBAIDAwkCARABA?=
 =?us-ascii?q?wQCCQIEAQIKAgICAgIEAQEFBAIEAwIFAgIBCAQDAwMNBAMICAMFAwwSAgICC?=
 =?us-ascii?q?QIDAQIDAwMEDQgWDQMCDRgKFRMHBwMDBAsCCQMEDQIEAgIBBgMGCgYWAQIYA?=
 =?us-ascii?q?gIGDAQDAwkCAwICAQICAgERAgIJCA0FCQUGAhYDAgMIAQkDDwMCFAEGAggDB?=
 =?us-ascii?q?wEBBAICChMKAQECAgEGKAMBAQIUEwcDCAICAgIGFgwBBQcDBw8FBQQCAhYDA?=
 =?us-ascii?q?xUEBAwCBQICAwMCAQEUBhUBBQIDBgsBBgECBQQCAwQCFAIDDwMEAwoCDwMGA?=
 =?us-ascii?q?wQGAwECDBACBAIJCgEFBAMHBQIfAwMCAgULAggCAgUCBQcDCQsGAQIFAwQJA?=
 =?us-ascii?q?hQCEAICAgIIFwICAgIFBhgBAiYCBAECAQIBAgECAQoBAgIOCQMEPAYTBAIDA?=
 =?us-ascii?q?wIOAQICCwECAgQCAwEEBwkDAwkKBwEKDQcCAgoICRABAgIPBwMCAgICBgcQA?=
 =?us-ascii?q?wITDwUGBgIKBw0KAwIBAgITAgMJBgMFDQMHBAoPAhUCFgUDIAIICQsCBw4FA?=
 =?us-ascii?q?gUSAw4FAwICEgQCAwYFAwEHAR8DBwgCAg0CAgICBQIFAgUYEQENBAMDAwIIA?=
 =?us-ascii?q?QQVBgMJCBQYCAQDCwYdAgIDAgQFAQEWAQEBBQEJAgMCAwQMAwMDAwIDBA4LA?=
 =?us-ascii?q?gEHCAIDAwYMHQIJAyMPAwsJCBM9AQsHMgQ2ARQUByshX6BvAUaDTIEOLFSBQ?=
 =?us-ascii?q?JZxAa9FNAeEHYFdBgyKKJVHM6pRLodkkGmOApsXESMSgTI6gVwzGiOBAYI2T?=
 =?us-ascii?q?wMZD5IbglnBd0UyPAIHCwEBAwmRWzSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QCmr+q1VQIMJxrL/VSVw+AqjBa1yeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4exoS5PwOk80lKQFlrX5WI3PYOCIghrNEGgP1+rfKnjbalTDH41mpN
 FdmspFebrN5DFB5K6UjjVQUexQpuVvm5rY5ts2uk0dKD2CHJsQjTuRZDz6LmRGAC19QbYpHp
 uV4cRK4xC6f24MU8i9Dn4ZG8DeutzijvvdEFY7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl55+kr+qwxnbnpiTuBtVt6ZHcI+l4dYCxY/suW3rRYzOTFclcsvO5zX4ISaqUmSwXeZ
 H30mod1oJImjrslyiO0GTQM0OL6kdT11byjVCfmnftusr/WXYzDNdAn5tQdl/D51Mnp8wU6t
 M+44s3jeslMfrsplWO2zHzbWAeqqOZmwtTrQdItQ0gbWI3Us4hkbAi
X-Talos-CUID: 9a23:d3yAPm3mKsK85WenM4BBwbxfB9E0X3nk8UnsAAyoKHxmReONdl2B9/Yx
X-Talos-MUID: 9a23:PG7OIQl6iPGWktYyY8Tydnp4L+l2pIDyOnstnK4rm+vDOCxeIRuC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,203,1728943200"; 
   d="scan'208";a="103224940"
X-MGA-submission: =?us-ascii?q?MDEU44goAvB0Pzr4+jGVnk8Z9R9nsZnGeJCnWn?=
 =?us-ascii?q?ZxXMMvg14QH3I2V8QWrT0Oqh5MBHmJVvjwCW4lAJ6Go7iKwuoR1GUTUU?=
 =?us-ascii?q?fApGaTL8jVztANOeCeyDk/tTp5rkzRMoY5l6Y6H/3LVrKAWnZ4dYOgMv?=
 =?us-ascii?q?xmVhsJ4D9h3qYr/S+Enwqj0g=3D=3D?=
Received: from mail-pg1-f174.google.com ([209.85.215.174])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:17:07 +0100
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso3491579a12.3;
        Mon, 02 Dec 2024 13:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174225; x=1733779025; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FZHtDSci4mxW9uObrOpyGXF4tVtVRk+OAevn+2+RUUc=;
        b=e6FTJvhOC1tWIgkICPIz8c4UhN85jFzWYylhbQpGN+SwDvRHeTai3Pigw7o1BYDVe9
         gBxZZyz3/i0k6nGIf/bCj9t+jM0rt50vXI30636C1LmpUeRcNn9Dqg/yWsPPMX+FJ3Rl
         Km5Acdhh4RjrSgZNS6bKvQvfF6one5kGEjSKYMx1uxGPutFUBfEi+XgZaiyflusAm756
         7qNFWr8T8BfPKQin/hpuvTAWSHZLuEN0CTT4fOQ+0AunjkoH32M43iqq9QMSTrdMe/ZR
         iVlaAJ46LPmQf89oNyktzBqXi53Mko/nQCNEiK3oQdU51JcVTSs24iYaK6e+RF6psP80
         +EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174225; x=1733779025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZHtDSci4mxW9uObrOpyGXF4tVtVRk+OAevn+2+RUUc=;
        b=RlAjFpRQ/C+wgSKVmOGWuHYIIUeMa2FXlknyRA30J+OtGJ18IbAKFf7NEH2YxAkuZH
         7XCOP16Ue+WJt6l1asI9gDU6osMtl9ls13tlbrdPYdGjjy/QS4Fp0ajjz3XAPh8SnC2D
         6PUGfFTDmgDjvsb2a9lbMWuhjg2Rl2uv2fiP4Vpd5zFBmfNq8lp9UmHAxg9eDRXYhT/K
         U9P9DZLd8wXcPtkX2TebSR5T/O++Gk8FxZdxfmHiD9PRGAKQOPaeDYaVj2MeDhXCQ0jp
         76tR6krVyAq/EN+YBr7Snb5EJMNXUKJ+QWpqsfKQrX8bKVvOipkxofXQZFzB0CzibPvf
         Ze2g==
X-Forwarded-Encrypted: i=1; AJvYcCUnq7zgwcb2Qq3drNpsH7oRcze3rfP0FShBDHLuJjf2fuoLkQvb9hEmO4LaSGqvB1JZqVopzK0=@inria.fr, AJvYcCXOKdatndysj8TCHU7lXNeTaFrdD219a7SH80yY30m6lU+k+GYAR7OxZ3OPRHK4IbW/Slv8aF0Wga7wmgs=@inria.fr
X-Gm-Message-State: AOJu0YwRtw/yex8f3oSddZ4DrRUK0QEq84pMprwS3o+yx7GaSu2nTZxt
	EvLsetetJS4McraB9ezlebzNGo8dPLYYt6SK4dKEQQbdpkDgjgc7YVseQJzd0kTwykV/5Bl5d80
	igYv0iuWN9X0gWjWxKhNSiQVM0nw=
X-Gm-Gg: ASbGncuMRWJ1CBqq2adXCt6BIUHEPh5SqiDMHon8icqhyMNUb/hyYDUWi6FhNkRVWus
	de3Lo9bjQLggvkp1UGBqEeJeRN4eckA==
X-Google-Smtp-Source: AGHT+IFDh1yb6d6zM40EzPJelJu2iVMH0WClLwmjysRWgfnYNSB8awfS5UuhO/EqqMc0eH1dffTLKgwFM99xaAmy4L8=
X-Received: by 2002:a17:90b:1c09:b0:2ee:3cc1:793a with SMTP id
 98e67ed59e1d1-2ef0124c720mr32029a91.29.1733174224966; Mon, 02 Dec 2024
 13:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-9-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-9-911fb7595e79@linux.microsoft.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 2 Dec 2024 22:16:53 +0100
Message-ID: <CAH9NwWdjXKH-AcKa-prwdqj2JqWLYVp1qM+0kxtQYSwo1J1c7g@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
	Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Louis Peens <louis.peens@corigine.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-mm@kvack.org, linux-bluetooth@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	ceph-devel@vger.kernel.org, live-patching@vger.kernel.org, 
	linux-sound@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 09/21] drm/etnaviv: Convert timeouts to
 secs_to_jiffies()
Reply-To: Christian Gmeiner <christian.gmeiner@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2153
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAH9NwWdjXKH-AcKa-prwdqj2JqWLYVp1qM%2B0kxtQYSwo1J1c7g%40mail.gmail.com>

>
> Changes made with the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> index 721d633aece9d4c81f0019e4c55884f26ee61c60..0f5a2c885d0ab7029c7248e15d6ea3c31823b782 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> @@ -100,7 +100,7 @@ int etnaviv_cmdbuf_init(struct etnaviv_cmdbuf_suballoc *suballoc,
>                 mutex_unlock(&suballoc->lock);
>                 ret = wait_event_interruptible_timeout(suballoc->free_event,
>                                                        suballoc->free_space,
> -                                                      msecs_to_jiffies(10 * 1000));
> +                                                      secs_to_jiffies(10));
>                 if (!ret) {
>                         dev_err(suballoc->dev,
>                                 "Timeout waiting for cmdbuf space\n");
>
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
