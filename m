Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A03C61DB4
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:message-id:date:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L0HTQS1LYVWSdc3RimfvMueRkxBKnov+tJfBP1Nzenc=;
  b=XeMkSoF5wSwZsj9de8G8FCA05wsfvuychH81kTTbB9I+DE8vtbjnmhkA
   MriRcNXrMQ/VNbKSLoEFYxEiAhbNBxxTGf6E9NUl1N7j2rHu/2e/HCv1y
   a+1RODq9rc6EpW+P8xbfiVinUFG7CNGcW/Kp+T3d7i4Hf6QuNkGDVSYHD
   0=;
X-CSE-ConnectionGUID: x/zfnuPuRQ+3RD8ixfaotg==
X-CSE-MsgGUID: YAQA5CTER0myOL0JPrQmVQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291206862"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:05 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9C0B681674; Mon, 24 Aug 2026 09:35:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 515B2802DA
	for <cocci@sympa.inria.fr>; Tue, 11 Aug 2026 20:52:12 +0200 (CEST)
X-CSE-ConnectionGUID: qpzTQs6rS/CiCaV2ecaGKw==
X-CSE-MsgGUID: n5FC2gsiSS6t6jpQo1ggWg==
IronPort-SDR: 6a7b6f5b_lkHejENDvBHqqsj/gcgoYAElAifWufFma2uF/W+4zFQw89T
 /foU2h/GCMH39x+ZHOSOmIxYWjvh14zsgrIc5fQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HsAAB+bntqj/4EaaxaHgEBCxIMggULgkGBaTMEC0mEW?=
 =?us-ascii?q?Ih6hliCJJxGgVWBfAIPAQMBDVEEAQEBAgSEfgKNXgIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQEBATkFSYZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBAyMdAQE3AQ8LGAICJgICRhAGAQqDC?=
 =?us-ascii?q?oIjB0sDxSSBMoEBggwBAQbcMoFpCRWBCi6IXQGBcIQIO4NHeicbgUlEgUeCQ?=
 =?us-ascii?q?Tg+hFiDRoJqgRKBD4EMjTeFZgk/CngcA1ksAUETDQoLBwVeA0IQMwMgCgsSE?=
 =?us-ascii?q?hgVAhQNEBIPBBYFLR1wDCcSDx0XFx5YGwYFEiAqQUQjAxMUBBMdQwWBTQKBd?=
 =?us-ascii?q?T8jGTZ8gQkKVIErKmEBAhAXRi4VTwEDAoFfAgaCcIEtBF4CARYLGA1IESw3B?=
 =?us-ascii?q?g4ZBD0BbgeOJiCFfZdbjV9ooRKEKKF1BC+DcQGTYZMZmQgjqSCBaDqBXDMaC?=
 =?us-ascii?q?CgIgyJQAxkPjiEZiHyKKgG8Yzw1PQEBBwIHDgMLgWiEXotWgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:WeP4CahuN1T8+3XTNVjjLLSeuHBQXt8ji2hC6mlwRA09TyVXra
 6TdZMgpHnJYVcqKRYdcLW7VZVoLkmskKKdjbN8AV7mZmjbUQiTXeVfBPXZsl/d8kTFn4Y3v5
 uIMZIfNDSaNykYsS+V2maF+q4bsaC6zJw=
X-Talos-CUID: 9a23:yBre3GNowvfexu5DQTF1yHcPRNoeNVbc537ueUKzAElKV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A/Sfj4g8unlVALAPMm8d/qVmQf8E1zY/0B1sMqq5?=
 =?us-ascii?q?Yp5eGLRV3YjiSszviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,218,1779141600"; 
   d="scan'208";a="289839140"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHArr5Z+wXmyQpiRABxuQj5OCzbyRnT5SM+Uh?=
 =?us-ascii?q?YSYKRlm20vUub+9vBT+o30Ir+W6jEwrxPOGT5IP77YIPpcQLz9jX75v1?=
 =?us-ascii?q?0pNXdrKrnvlWw4n9LlHwTEvevzkjuWko5K64aymmmY29mJbBZfEP7qp8?=
 =?us-ascii?q?bvsN7VaaHLcaIS27dzPJ7OEw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 20:52:11 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B1915600AE;
	Tue, 11 Aug 2026 18:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C9D1F00A3A;
	Tue, 11 Aug 2026 18:51:41 +0000 (UTC)
From: Vinod Koul <vkoul@kernel.org>
To: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Andrew Morton <akpm@linux-foundation.org>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Borislav Petkov <bp@alien8.de>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 David Airlie <airlied@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Johan Hovold <johan@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Matthew Sakai <msakai@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Nicolas Palix <nicolas.palix@imag.fr>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ping-Ke Shih <pkshih@realtek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sebastian Reichel <sre@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Simon Horman <horms@verge.net.au>, Stephen Boyd <sboyd@kernel.org>, 
 Steve French <sfrench@samba.org>, Takashi Iwai <tiwai@suse.com>, 
 Thomas Renninger <trenn@suse.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Tony Luck <tony.luck@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Will Deacon <will@kernel.org>, 
 Yazen Ghannam <Yazen.Ghannam@amd.com>, 
 Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: cocci@inria.fr, amd-gfx@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, dm-devel@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org, 
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Message-Id: <178647430099.1113716.2263974283705757692.b4-ty@kernel.org>
Date: Wed, 12 Aug 2026 00:21:40 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] (subset) [PATCH 00/36] treewide: remove conditional
 returns with no effect
Reply-To: Vinod Koul <vkoul@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3698
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/k51wWZBD7jIYYJG288xZQw>


On Fri, 24 Jul 2026 03:45:02 +0900, Sang-Heon Jeon wrote:
> While reading mm/memblock, I found a conditional return where both
> branches return the same value:
> 
> 	err = do_something();
> 	if (err)
> 		return err;
> 	return err;
> 
> [...]

Applied, thanks!

[19/36] dmaengine: qcom_hidma: remove conditional return with no effect
        commit: 04b8c3de13871653a8ecbd9f1adfea4d0694ecfe

Best regards,
-- 
~Vinod


