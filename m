Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4988FD68BEC
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lSXFKM+ARjNBrckMO4jvpnEJoLVPjxN4kzAqYuwUUFc=;
  b=qjFZvMMBW3HruHWSke1zbcLcKwXB4Zn/zMylxBym+kyxA+8pxtS3ulEi
   QyUQl4zWiQKTQby4tMAn9SP4CwAI5PtRF1p+ov2DbMRfeaasMHRSg8Z0M
   A7MDKDpkvaTqyIg4Kd410EMCWZPzz2j3Hh1PrhW94NuufYkyRgcLXtcQY
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204877"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31791E0D8C; Sat, 16 Nov 2024 12:26:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0730AE00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:40:26 +0100 (CET)
IronPort-SDR: 67387699_esZ18j2fYsF7GfRcFTd13V+Rko23GjlsTHpdwcYNIA3skeb
 DQ/iLhv1X9Y+NY6A+vAUK8JM8SAbu1X9QI53YPw==
X-IPAS-Result: =?us-ascii?q?A0G/BQB/dThngS6AVdE9HYEJgVOCRIFXMwRTkjGBcoF0M?=
 =?us-ascii?q?J4XgX4PAQMBCwEBQgIEAQEDAQOFAAKKSwIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABASIZBw47hXsNgmIBM4IWLA1+AQEBAxIVE?=
 =?us-ascii?q?wYBATcBDwsYLjMBBQEcBjWBYH+CZQECB6Q3gQVCizyBATOBAYIMAQEG3B+BZ?=
 =?us-ascii?q?AkJAQqBNIVqgmIBhWmDfXonD4FVRIE8C4J4PosHgkWFARIlhxSBa4l3kB5Se?=
 =?us-ascii?q?xwDWTIBVRMXCwcFYEkhLAOCSX+BNoFRAYMPSoMugV4FNwo/gkppSzcCDQI2g?=
 =?us-ascii?q?iR9gk+BJQQFg2yBC4NhZy8DAwMDgzyEBx1AAgELbT01CQsboRiDAIFDW4Fwl?=
 =?us-ascii?q?mYBjnCgUjQHhB2BXQYMn1kGEy+XQAyTAi6HZJBlqH0CCgcGESOBRDqBXE0wg?=
 =?us-ascii?q?ypPAxkPly/BFEA1OwIHCwEBAwmFQyYTiQaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:LVxeSqNSZbwnG0rvrR1fk8FynXyQoLVcMsEvi/4bfWQNrUp2gTZUz
 DFJWG3SOPiCNmbyetknYd/k/BgEvMTTmNE3GnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQXNNwJcaDpOt/va8U035ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGX+Xlro++dSBnofLIAS/t8rAUth8
 f0hfWVlghCr34pawZq+Q+how9smdYzlYN1ZtXZnwjXUS/0hRPgvQY2QvY4ejGp235oeW6qAD
 yYaQWIHgBDobxRJfFweEoozmvulnFH7cjtRslXTorA4i4TW5FUgjOK1aoKKJrRmQ+1FwXeq+
 mfi8F/dLS89F/DH9RW4+3mF07qncSTTA99LTOLpqJaGmma7zWsYAxw+Tkq+ufD/i0ikWtsZJ
 VZ8x8Y1ha079UjuUdykGhPk/jiLuRkTX9cWGOo/gO2Q9kbKyz60J2w8XAJLU/U3ucUyfGAq/
 HCNnuq8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4oe0ts4mLTGYb3kKnczpzLJNZmOEZDt0Z/
 txnhC03hrFWkstSkqvnoxbIhDWjopWPRQkwjuk2Yo5HxlIhDGJGT9X3gbQ+0RqmBNjDJrVml
 CZe8/VyFMhUUfmweNWlGY3h5o2B6fefKyH7ilVyBZQn/DnF0yf8JtkOsWwidRo1a5ZsldrVj
 Kn76VI5CHh7bCrCUEOLS9vgYyjX5fG/RYS7CaqMBjawSsQuLlDWrUmCmnJ8L0i2zRF0zvBhU
 XtqWcmrCnkeBOxmyjHwL9rxIpd6rh3SMVj7HMihpzz+ieT2TCfMFd8tbgHSBshnt/jsiFuOr
 L5i2z6ikUQ3vBvWOXGPqdZ7wJFjBSRTOK0aXOQILrDZelM7SDxJ5j246epJRrGJVp99zo/gl
 kxRkGcBoLYmrSyWdVe5eTp4ZanxXJ1yi3s+MGZ+dRyrwnUvK8LnpqsWa5J9L/Ft+f1B3MxEa
 aAPW/yBJfBTFRXB2TAWNqfmoKJYKR+EuAOpPgieWgYZQaJOfQLzx4LbTlPdzxVWViuTnukik
 oKkzTLeEMYiRRw9LcP4a8CP7lKWvFoGkd0vX0DNcsRZI2fq0Yl1Kh7eiu08DNEMJC7imBqb9
 VeyKjUJqdbdp7Qa9IHyupmFiIOySc1sM1F/HVSH3Y2pNCLfwHWv8bVAXMmMYzrZcmH+o4emW
 sl40ND+N6chsGtRko8hDYtu870y1+Hvq5Be0A5gOnfBNHavK7F4J0i5zdt9jbJMypBZqDmJd
 Bq2oPcCAoqwOeThDFI1DygmZL7a1fgrxx/j3c5sK0D+vCJK7L6LVHtJBCa1iQtfEaBUNb00y
 uJwqe8U7A2C0iARCOiktRwN1WqwLS0naZ4F57U6G47gjzQ5xm5SOaL8DjDE27DRStFuHHRzH
 BqqqvvjvZp+yHDGUUIPLlnW/O8EhZ0xqBFAl1ADAFKSm+v6vPw83TwP0DEnVg5Q4ARNwr9tM
 W1gNmleB6aHzxF3judtAkGuHABgAkWC20rTklEmqkzQf3OKZEfsclIvCL2ox18I1V5cchxw3
 qCq+Ey8XRnEJMjOjzYPA2h7oPndfPlN3wzlmvH/Of+aHpM/MAHXsoX3aUUm8xLYUN4M3mvZr
 uxX/cF1W63xFQgUh4YZU4C697AheCqoFVx4Y8NK3f02RDnHWTSIxzKxBVi7eZpNK9z04EaIM
 ZFSCfwVZSuu9hSlj249PrENEY9WjfRyxdsle5HXH0AknYabjAJUtMP3ynCjqk4tG85jgOQsG
 LP3LjiiKFGdtVFQum3KrfRHBFaGXMk5VFX88tyYoOQtPLAfgd5oanA3g+eVvW3KEQ5J/CC0n
 QLkZo3K/tNm0qBck5fJKfxGISmFNOGpBfq6qhC3l9Foc9n0ENzvsjkNoQLNJDVmPro2WvV2m
 4+SsdXx4lj3gbYuX03dmLiDD6Ns9+zoeMZmaefMM2h8oSuOfOTO8ikz0Tm0BrIRmewM+/T9Y
 RWzbfWBUOI8WvBf9SVzUDdfGRNMMJbHRP7sig3lpsvdFyVH9xLMKe6m0nrbbWt7UCssEL+mA
 y/Wv8ee3PxpnL5uNjQlWc4/W4RZJWX9U5QIb9fy7DmULle5i2O454fNq0AS1iHpOFKlTuDB/
 pP3djrvfk+TuYbJ7u1jna5cgxk1NEt50M4MJh8z2tgvhz6DWTtMaaxXNJgdEZhbnxDjzJyyN
 nmHcGImDj67RjheNwn15NP4RAqEG+gSIZHDKyc0+1+PITKDbG9a7GCNKg87i5u3Rtfi8A1jA
 dQX+3m1IR3oh581G6Ac4fu0heohzfTfrp7NFYYRjOSqayvyw51TvJCiIOaJfSjGFcjXkwPMP
 2ddqaVsXhSgUUCoeSp/Uyc9Jfza1Q8DCx0sbCGG2tGZvJ+UpAGFJDsTJMmruoA+gA82yHLii
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:qpLazqHMfVeJxMM1pLqEIMeALOsnbusQ8zAXPo5KOHtom+ij5r
 2TdZUgpGXJYVMqMk3I9urwWpVoLUmskKKdpLNhQYtKPzOWw1dATrsSlLcKqgeIc0aOldK1l5
 0QC5SWYOeRMbEQt7ed3ODXKadF/PC3tI+vnvnX1HpgQEVHbKt6/x5lBgvzKCFLrcp9aqbR1q
 Dw2iOKnVSdkL0sD/iGOg==
X-Talos-CUID: 9a23:mFqzVmHVGdMY60PVqmJf2W8QItIZeEb03XraJ3bkCUxGTLysHAo=
X-Talos-MUID: 9a23:UZYIawadORMN5+BTp2Ddtm1nEMhTx4uQL2MhyakphsCPHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194202074"
X-MGA-submission: =?us-ascii?q?MDHNjvhkTwOQ9PsyRs6ancChdo2BN0QhbtObPU?=
 =?us-ascii?q?2jRon8u2oc0yrkjrBI5VqY7UQ5FKPBikE8ZD/WuoSfGzLY9YQjt0nak2?=
 =?us-ascii?q?x955lJOxUJrEeLhZk6Mviwff2fuaBIhlFuSa2U3nfxTsQoXWJfv19ca8?=
 =?us-ascii?q?rEna50ddaXlNNVQRdZGVspkQ=3D=3D?=
Received: from mail-wm1-f46.google.com ([209.85.128.46])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:40:25 +0100
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43193678216so23228295e9.0
        for <cocci@inria.fr>; Sat, 16 Nov 2024 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731753625; x=1732358425; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSXFKM+ARjNBrckMO4jvpnEJoLVPjxN4kzAqYuwUUFc=;
        b=fpb17p5wCG86OwAiv65ALQ3ECAP3TWtFh1ptYsE1bNwyDDpljX+9TvNW4ri7Qb6IMp
         4sjP+utJlU3jwVgbmew7piYaAXG1o8AlyPBMG1aLckjS63olErbjKxTgozAYUzXQ/iHn
         xlAjmMiu7XNlWR0VVb7QxdspP6pkFJMAiBE1+chXOJTfsBkyry0/XDBTtvLLa/hyOTSe
         RF8Ne3CKcF13ssFuN66ZfJ+4dfWNIYXK1vH2qqxStCbXHqgJJQMynIpXfaMeXMYpQDaa
         VFscow04gl95dKn6h/fsHUYgZ4UCnsbtRKNQRDE5QZqYrlS7qHHI7aZRF/NrFulDeEmL
         ajkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731753625; x=1732358425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSXFKM+ARjNBrckMO4jvpnEJoLVPjxN4kzAqYuwUUFc=;
        b=Om+eOp+tqlnX0b5zYNqjmOEua5R8Bqmt9oGVFDIxIvtaCILHhD9ub9tLVpUBoq+zSB
         kwwjufoDg7nttqDFLHkCKgIMQ+P4t7xdMZNkPvk2nWBmhAMz23rxwM+qt63u4++YYM5g
         1MsMW/TBAYu73xAWNpbtOSj9XgsqSulx0SBs+iwH7FdXD0px8DVpjVleh+9Qh6h8/y6F
         yLkSYfWZkiomkO7KhF+AmlUMfl2FOykU42IxeDAQRe6HcGOjXr7rJj/VjMIwKUfytVuS
         8fhCCeXrpVkgWKJioGiMyet4zC8sh1IF4jRTM55e5PIK0yT2l/Zg7rIQx6+Mt43nnqd9
         WYAg==
X-Forwarded-Encrypted: i=1; AJvYcCV3f/EtBFlwRpKUk5tUhvmibhW8R33ldWcyDV01OyKrce7ah4pYoiMnpyt2E31gpw7thLOz5w==@inria.fr
X-Gm-Message-State: AOJu0YyAqiROYpFp3oNc8aQ+eL7gp+ZIHpNOET+y6F+rAOmm5R/BkJRK
	Xi5vXRDnrYXkI4SXNmYJ9dAvtTxRmU/braKR95jdh9+xZVRUS9SRSkB+9q3plDA=
X-Google-Smtp-Source: AGHT+IH8fBA+4s5F3P6X/kjn5LT5A4plOne9CKmDoZ8QUK+uLzjM3K0QAglApJbsapoZYtb9Ft2RHQ==
X-Received: by 2002:a05:600c:1d1c:b0:431:4e82:ffa6 with SMTP id 5b1f17b1804b1-432df78c5b5mr46184285e9.24.1731753625076;
        Sat, 16 Nov 2024 02:40:25 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2800absm87243245e9.25.2024.11.16.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 02:40:24 -0800 (PST)
Date: Sat, 16 Nov 2024 13:40:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Louis Peens <louis.peens@corigine.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <e4872a15-ff3d-4619-9b03-c7f0b6230934@stanley.mountain>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-5-911fb7595e79@linux.microsoft.com>
 <b6a059d8-7b23-455d-9ecd-eb3cdddd22a2@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a059d8-7b23-455d-9ecd-eb3cdddd22a2@csgroup.eu>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 05/21] powerpc/papr_scm: Convert timeouts to
 secs_to_jiffies()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2073
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/e4872a15-ff3d-4619-9b03-c7f0b6230934%40stanley.mountain>

On Sat, Nov 16, 2024 at 11:06:55AM +0100, Christophe Leroy wrote:
> > diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> > index 9e297f88adc5d97d4dc7b267b0bfebd58e5cf193..9e8086ec66e0f0e555ac27933854c06cfcf91a04 100644
> > --- a/arch/powerpc/platforms/pseries/papr_scm.c
> > +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> > @@ -543,7 +543,7 @@ static int drc_pmem_query_health(struct papr_scm_priv *p)
> > 
> >          /* Jiffies offset for which the health data is assumed to be same */
> >          cache_timeout = p->lasthealth_jiffies +
> > -               msecs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL * 1000);
> > +               secs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL);
> 
> Wouldn't it now fit on a single line ?
> 

Some maintainers still prefer to put a line break at 80 characters.  It's kind
of a nightmare for an automated script like this to figure out everyone's
preferences.  In this particular file, there are some lines which go over 80
characters so sure.  Earlier in the patchset one of these introduced a line
break that wasn't there before so I think maybe Coccinelle is applying the 80
character line break rule?

There are sometimes where the 80 character rule really hurts readability, but
here it doesn't make any difference.

regards,
dan carpenter

