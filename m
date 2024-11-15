Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C742D68BDD
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uwqJCSe3GXdPjGHghPvDBfnEwZdT0uYA3z4HTDFu1hA=;
  b=MtqNbJ/w1LDsPw3Vm3L0eI6n7vfFtJNj5mfKnooJTZI3SCyEkljLWT6Q
   dBEoVfT10WizyGNZmycf6HQsYaZhwpEarg5GkCsA9Wg3Z1LU6gf3wmLXC
   UXk7vx2m8sUXUqCpeuN15pDngFAcHzOa8pkHlwbfihBM8SjC3RrZx4km7
   o=;
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
   d="scan'208";a="194169849"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D94E0E0E68; Fri, 15 Nov 2024 23:35:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A061E013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:45 +0100 (CET)
IronPort-SDR: 6737bc95_lIWunDTSppMoNEtSDm5juASAWTJ2Ywvgwze1UbGuZfJ6K4Q
 uXdixzN1YbxbHi2Q9pB2+WkPRoWgOYOQsJ0pZgw==
X-IPAS-Result: =?us-ascii?q?A0EgAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9NAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhApOg0aCaYJFhRMlhQaDe?=
 =?us-ascii?q?Yl3kAcJP4EFHANZIREBVRMNCgsHBWNXPAMib2pTeiuBC4EXOkKBO4ETLxshC?=
 =?us-ascii?q?1yBKYEaFAYVBIEORj+CSmlLNwINAjaCJCRZgR2BMoUahGxnLwMDAwODPIJOZ?=
 =?us-ascii?q?DIdQAMLGA1IESw1Bg4bQwFuB58ERoM0gQ6Ze41CoWuEJKFdATKqTi6HZJBlI?=
 =?us-ascii?q?qhUghg6gVxGByMVgyJPAxkPjiGDeo8+AbYeQzU7AgcLAQEDCYVGAQGJWzSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:btSCyaKNmwhDWxsVFE+RS5ElxSXFcZb7ZxGr2PjKsXjdYENS1GEOy
 mpNCD+CafqDYmP1eIgia4Xk9EsF7JOBm9AyTwAd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb/s9JIGjhMsf7a8Uoy5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuIziym9UxKWYPOIQcucEuAnlz1
 q03EWVYBvyDr7reLLOTTuhqm9RlKcjgJoQEvX98izreCJ7KQ7iaGOOVupkBgWt235AUdRrdT
 5JxhT5HYR3AagdOOl4/DJM4gffug3j0aTpDr1yJ46Ew5gA/ySQoiOGyb4OMIIHiqcN9nm3Gh
 nv7+ifCDQARauPA9jOn+0iyr7qa9c/8cNlJTuHnnhJwu3WXz3MaDBk+R1q+q+OwzE+4QdNWb
 UIOkgIlqqM59WSwX9zlVlu5pmSFt1gSQbJt//YS7ACL17qS5geSHG8fSTBdLtchsafaWADGy
 HfZ3I2xJWNKl4SQQHbe0e6XtQ6RaAcseDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsjETMW6vq
 9xthHdg74j/nfI2O7OHEUcrag9AS7DNTwgo9kPSX2m/6Rh+apLjbIutgbQ60RqiBNjEJrVil
 CFd8yR70AzoJcrS/MBqaL5TdIxFH97fbFXhbadHRvHNDQiF9X+5Zpx36zpjPkpvOctsUWa2O
 xaN4VIJtMMKZCvCgUpLj2SZW5VCIU/IRYWNaxwoRoQfO8YZmPKvoH8xOBbMgTyFfLYEyPhuY
 MnFKq5A8kr2+Yw8l2DqGI/xIJcuxyskwnjUS4yzxBO9ydKjiI29GN843K+1Rr5itsus/l6Km
 +uzwuPTl32zpsWnPnGPqeb+7DkicRAGOHwBg5cOJrHceVA5QDxJ5j246epJRrGJVp99zo/gl
 kxRkGcBoLYmrSSfcVvYWWMpc771Q5d0oFQyOCFmbx7i2GEubczrpO0Tfoc+N+tvvuFy7+9Gf
 99cceW5A9NLVmvm/RYZZsLDt4BMTkmgqj+PGCuHWwIBWaBcaTbHwOK5QTu3xhIyVnK2keAcv
 4yf0hjqRMtfZgZ6U+fTRvGd73Kwmnk/g+tNAhLFCYRPcXrK4YIxDTLDiMYqEptdNTTC2Tqo+
 AKECjgIpeT2gtEU8fuYoYumvouWA+9FMU4CJFbi7JGyLjv/0le45I19DNazYjHWUV3r9JWYZ
 el6y+/2NNsFlg1ot7VQPqlKz6VkwffSvJ5fkxpZGUvUY2SRCr9PJmeM2e9NvPZvwp5boQ6HZ
 VKdyOJFOLmmONLXL3BJHVALNt+87PAzniXeyd8XI0+gvS9+w+ehYHVoZhKJjHRQEatxPIYb2
 twegc8x6TGkqx8UI92D3zF19WONEyQ6aJ8ZlKomWa3ltgl67Wt5Q834KjT365SxedlzIhEUA
 juLtpHj2ZVY5GT/KkQWK1ac/NBglawvuQ9LxmAsP16muMTIrd5p0Qxz8QYYdBV0zBJG2c13J
 2RbOFB/GqGM9DI5lsIZbTiIHidfDia44W308UMCz0fCfnmrV0vMDWwzAvmM90Yn6FBhfiBX0
 bWb6WT9WxP4VZjV8gprfmA9sN3lb9h61jOaqfCdB87fQqULO2v0sJGhdU8jikXBA/pooGblu
 OMz3uJ7SZOjBB4qu6dhVrWrj+UBeiulel5Hb+pqpp4SPGfmfzq35ziCBmaxdu5JJN3I6UWIM
 NNvFO0eSyWB0DuykR5DCZ4uO7NUmNsb1OgGcJ7vJk8EtOK7hRhtu5Ty6CP/pTEKR/NDrMUDE
 b7SJgmySjGouXhpmmH2vJZlPEi8aoI6fwHS5r2+39gIMJMhi9tSV38O/IG6hFivCzs/zSmo5
 FvCQ4T0091dzZ9dmtqwM6dbWCSxB9DBdMWJ1wGRqN1xMIrCGprSvjwzu1O8GRpkO4IMao4mi
 ZWMr9/F80fXt5kmU23iusegFosYwe6QTeZoIsbMA30CphS7Wejo+Akm112jDJ50zONm+cisQ
 jWnZPuKddI6X8lXwFtXYXN8FykxJrvWbKC6gw+AtNWJVwYg1DLYIOOd9XPGaX9RcgkKMcbcD
 i72o/Of2cBKnr9TBRMrB+BUPLEgGQXNAZAZTtzWsSWUKkKKgVnY47vrqkcG2AHxU3KBFJ733
 ILBSh3Aby+NgaDvzuxCkolMrxYSXWdcg+4xQxonwORIqQuGVUwIEedMFq89KMBkonSnntWwL
 jTAd3ArBijBTCxJO0e0qsjqWgCEQPcCIJHlLzgu5FmZcDqyGJjGOrZ66yN8+D1jT1MPFg18x
 Q02oRUc/yRdw62Fgc4X5/qmkaFix/jAwWkP91y7mMv3a/rbKatfz2RvRWKhSgSee/whVm2ST
 YT2eYyAaEW6T1PhV8NhcGRSAxYXoHXkyDBAgeKn3oPEo4vCpAFf4KSXBgwwu4HvqOwOJbgTV
 TXyRmCX5HuR1GBVsqws0z7sbWmYFtrTdvWHwGTfqcH+Uk1+BqnL/y/PoMbXcPwfxQ==
IronPort-HdrOrdr: A9a23:ZLwRyKgCsHhsYqDMFWHnwAFEHHBQXuAji2hC6mlwRA09TyVXrb
 HJoB19726WtN9xYhEdcbLpAsO9qBbnmKKdjrN/AV7PZmXbUS6TXeVfBOjZogEIZReOlNK1vJ
 0IG8ND4Z/LfD1HZK3BjjVQfexQp+VviJrY/Nvj8w==
X-Talos-CUID: 9a23:4sFQWWCgbjK45Cz6E3kkqhY0ReUCS3jUyDT3ekygNEU4Z4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AR4QcEw1uiiWFkmiGhrApKrLsGjUj44/wKFkwlNY?=
 =?us-ascii?q?9tNiPaxMvBD6/hQ6pa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771125"
X-MGA-submission: =?us-ascii?q?MDFoxpFJEcGzdwgS61lbRT77xgzbygAbawVRNZ?=
 =?us-ascii?q?OyPDTT/y8M2nejNkWOWSeH9L4RqKkVg2AH5Sim+qqD1PV3SdCeOvA5Oy?=
 =?us-ascii?q?UodBsM6D0/c2Bp3AbG2Or0gl4+eGX/pCdJuKm0nr1trEIJr4lJkeCXek?=
 =?us-ascii?q?pQS9nyZEgIl63bqYNYma0u3w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:45 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2B4EB206BCFA;
	Fri, 15 Nov 2024 13:26:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B4EB206BCFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706002;
	bh=uwqJCSe3GXdPjGHghPvDBfnEwZdT0uYA3z4HTDFu1hA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L5h+l6RmonxJ2az0g4MEjFj1mZrgP6QcCu4emVFVPsXRGSbOqO7anS7hNG7T+pDPJ
	 RufyF3X+SQAP7OBNi9L4oof0Mf/N1pw5KpaxKZGsx9C6BQjH2p+gXUlgOVsy2nu8Ns
	 vF3R0Is+PXb/IIvu2e2kzQ8Cg4xNfFZKq8iVxdGc=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-5-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 05/21] powerpc/papr_scm: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2032
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-5-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 9e297f88adc5d97d4dc7b267b0bfebd58e5cf193..9e8086ec66e0f0e555ac27933854c06cfcf91a04 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -543,7 +543,7 @@ static int drc_pmem_query_health(struct papr_scm_priv *p)
 
 	/* Jiffies offset for which the health data is assumed to be same */
 	cache_timeout = p->lasthealth_jiffies +
-		msecs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL * 1000);
+		secs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL);
 
 	/* Fetch new health info is its older than MIN_HEALTH_QUERY_INTERVAL */
 	if (time_after(jiffies, cache_timeout))

-- 
2.34.1

