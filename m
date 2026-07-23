Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFBAC531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=+cqQ6sQJkvsR3VtIbpEjUXStuHRs0SJj4jk7Uojzitk=;
  b=iMiIAKiqr88c5WlBrqGlSXxSXL2JYEns9Z4KpA/XO+nuJwkhUhB+KZTm
   HOhfDnEynghtlykls6T5JlAOUgsqDxj/L/vDfDLHi7ww1nxMSTknkpkmx
   NrAt2LDqktPcGgwLUkYu2QBmmrmVQxGumCn8p0vcSKONWTEgznvt7fHAl
   k=;
X-CSE-ConnectionGUID: G9Ij1aHVTWiq7dc+E97XMw==
X-CSE-MsgGUID: hRV83aP0S0SQgU1iuuTdMA==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287732969"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:53:49 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2A4F0803FA; Fri, 24 Jul 2026 10:53:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D9EF681331
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:45:58 +0200 (CEST)
X-CSE-ConnectionGUID: dI1fuy0wTnCiL43tmj0f4w==
X-CSE-MsgGUID: isj2KAexQ1+le32q6A+Odw==
IronPort-SDR: 6a626164_UXkLVM9LOA8g2eg82fAdl8nWq1th+p7d+a8Sw7xvnftT9LI
 y8w0l5qWz5Pab7PK3eBVov930b2aEEDMyCahQ4Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FfDwBZYGJqfDHYVdFaglkCgj+BCl8zBFSIJ4wDXQaBP?=
 =?us-ascii?q?oEWiBuCGTKQTYFVFIErPQIPAQMBCwEBMR4CBAEBAQIBA4R+jWICHgcBBDIHD?=
 =?us-ascii?q?gECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SK?=
 =?us-ascii?q?YZPDUkBAQQLAQQBAYIBATNxYQIFAzoBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBBQINHz8BIRYgAQ0BGx0BAxIQXREBBQEiATSCYAGCI?=
 =?us-ascii?q?gEGEAEDNwIBtleBAkKMUgUCFoEBgg0GgQnZXwoZKA11gWYCBwkBCwGBNwGEd?=
 =?us-ascii?q?ypdA4I+Im6ED3WDXSV6J4EYgRCBFYJzdoQlBC+GMASCInoSkioBBwcfEggBH?=
 =?us-ascii?q?AYIAgJIFRIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCD?=
 =?us-ascii?q?BQKKCISAikKAyAKCxIPAw0GBRUBAQcGAgIDAQQCBAwCBAUCAgUDAQMCBAYEA?=
 =?us-ascii?q?wMEAQEIAgItAwEDGQgJCAILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFB?=
 =?us-ascii?q?gs3FQUMEQECGwIhBB0RCAMBGAQCAgIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPA?=
 =?us-ascii?q?g0HLgsDAg4CCQgMFwICAgYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEB?=
 =?us-ascii?q?AMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGA?=
 =?us-ascii?q?wcIAw0DBAIDAwMEAQICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDB?=
 =?us-ascii?q?QEFAwUCAgMFBQMFAgIKAgMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEA?=
 =?us-ascii?q?wYCAwgDAwIJCAMWBgMDAwMFAQICAgMFAwMDCAgEAwMEAgIDCgICBgMDAwIDA?=
 =?us-ascii?q?wUDAwcCBAIDBgMDAwEDAwUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYED?=
 =?us-ascii?q?QkEAgQCAg8EBAUDAwcBAQIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCA?=
 =?us-ascii?q?QUOBwUCAgoSAwYCAwQFBQEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDA?=
 =?us-ascii?q?wEBAgIEBgQDAgMHAwMDAwMEAwUFAwIFAgQDBQMHAgMDAgEFAwEDAgEBBAUEC?=
 =?us-ascii?q?gEDAwMDBQUDAgIDAwQBAgQGAwQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDA?=
 =?us-ascii?q?wMEAwMDCAcFAwMFAgkDAwkDAwsCAgMhAgUBAgMDAwYDBwMDBAMDAwcHAgMCA?=
 =?us-ascii?q?wcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgHDAE8DAcKJAQEDCoBBg4UBQQlG?=
 =?us-ascii?q?WcHBwKNaCOBTh5UAYENAXuBLQENgUMBAQGORINkkiagah4JAQYCYIFngQoVC?=
 =?us-ascii?q?i+Ke4EmlToaM4VbkXiTGZYlgmMjo0eFLgIKBwcRJBKBOQQvgVwzGiOBAW2BS?=
 =?us-ascii?q?QlHAxkPkiOFQYl8AbxXNTU+AQcCBw8CgXODdoJOhlyBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:SZVTcauIEiolqj/IzyfvztBB7skDXtV00zEX/kB9WHVpmwKj5q
 WTdZMgpGTJYVMqMk3I9urwX5VoLUmslqKdgrNhRYtKPjOW3ldARbsKheCD/9SJIUzDH4VmpM
 NdmsZFeb/NJGk/o8K/zgfQKbkdKRq8nJxAR92y854Ud3ASV0io1WlENjo=
X-Talos-CUID: 9a23:Y3rozGPjj2TiHe5DVAg++lMFQt8ZdFbc6CuLP0q6UWg1V+jA
X-Talos-MUID: 9a23:dZqz1glncKv9gqFd03bGdnpjL8UywI2jGHlU0pEL4JOdawUzHDuC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815223"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEu0iWaR5y5/qtL8TbomC6abVNMwza0LL6sHZ?=
 =?us-ascii?q?saFZcCgKDC5JAbziXA3MCB/tRtHkgHdk2h8ZH1JNdUh88TOiV6lUOi7F?=
 =?us-ascii?q?cryHVGmqDa8ue2mcRUzX08TMrnO0jhhE2y8mS0z7hv29VNdQxk9KLsvK?=
 =?us-ascii?q?dWj6P+CnCOlkYlG6RlQSfC0A=3D=3D?=
Received: from mail-pj1-f49.google.com ([209.85.216.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:45:57 +0200
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1049690a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832355; x=1785437155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cqQ6sQJkvsR3VtIbpEjUXStuHRs0SJj4jk7Uojzitk=;
        b=mM6/FpmwZHSiqcQpdDIeyIdTuL97enO81foyRFRS8HfOChJ9MIZ84IG4H+OMpDHWFK
         E8vc/FFvkYtld1QV8W9lyZGhDe5l55+8YiUePxb3VhH0pygkqVUbLYqnQZL/Qzhh08UX
         s5y6jEvwEwu3xEJeDaKVh2yU5V537zZtS2l7XtoLLGcilAsblIpVYo6ttkukLywbPFVw
         Y74sElFEhSDPIU+pWbstufZtK8CXSwcjMO/TqJTNkga3SjnzW8/FMITtTARUIIfbG3wj
         Xw3TWRVajFJtByTYSbRxorXWS4YELTkrYH8JrYxp7i7AKD6atsOopBNmHLfpsV+cIj1S
         WmYQ==
X-Gm-Message-State: AOJu0Yz3x2yV9hErlxg0BnyS1RGfOTHzufh04SxvQ9VC1FUw69lxrr9G
	9i3T4vJtxGuGQJ7UN3ZuSCpI6TQjq34u02yDgUdQIpD2mHSygEApd0nE
X-Gm-Gg: AR+sD11hvYZ1BBs975K+r0EZDKoVPa2+BUPLNTtsTsu15x/1VwdwScYNuJ0xdpSU/0t
	dt0lwvks2MJHub+hxoqxXlxd/OhAEsObHJeUB6nffhCCHjifEaLAVMxyCZKrNxn8dcP8S1tJkht
	cZLPzRDSedWMjPaQBvSr5x+cbMi5MBV9hvSWPC5baF2MY2WSx/NKMFClDCUmtekMUUzl44mV6Ij
	JaxiPzUNVEck9UD9VnahiDZS9/6R6nveWIzWrP92eWHYw9lRfo86lHSZNGV2h7xOkBzp2Rlevf5
	7ItTH7yd4JB8b/Je8DcH/WQQ2um3u8ZSdExO0UVDFiQ3GMt4frl0ccjVsJk3Ajzvh+4UvPb12m2
	xn5Nu2oUdn7fqxqWjXfhmFsJvKCWhEtNi2m9BO88cOtthlMShbNmZDqFcEG+JK89QsdQflBBv
X-Received: by 2002:a17:90b:1350:b0:36d:66d4:270e with SMTP id 98e67ed59e1d1-38ec6455120mr4430242a91.5.1784832354540;
        Thu, 23 Jul 2026 11:45:54 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:45:53 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Alex Deucher <alexander.deucher@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hansg@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jiri Pirko <jiri@resnulli.us>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Julian Anastasov <ja@ssi.bg>,
	Leon Romanovsky <leon@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
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
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Simon Horman <horms@verge.net.au>,
	Stephen Boyd <sboyd@kernel.org>,
	Steve French <sfrench@samba.org>,
	Takashi Iwai <tiwai@suse.com>,
	Thomas Renninger <trenn@suse.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tony Luck <tony.luck@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Will Deacon <will@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: cocci@inria.fr,
	amd-gfx@lists.freedesktop.org,
	dmaengine@vger.kernel.org,
	dm-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org,
	iommu@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:02 +0900
Message-ID: <20260723184538.3888637-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 00/36] treewide: remove conditional returns with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3597
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/O51GC3Pu2lQc29y2Teu73Q>

Hello,

While reading mm/memblock, I found a conditional return where both
branches return the same value:

	err = do_something();
	if (err)
		return err;
	return err;

Such code is usually a leftover from removing a statement between
the two returns, and the tree has about a hundred of these.

Patch 1 adds a Coccinelle script that matches the pattern, including
negation and constant-comparison variants. Where a local variable is
assigned right before the check, the assignment and the two returns
turn into a single return of the assigned expression.

Patches 2-36 are generated by the script, with hand fixes to restore
unexpectedly removed comments and to fix the formatting checkpatch.pl
complained about.

The patches are grouped by subsystem instead of split per file. If
you would rather split, merge or drop your part, just let me know
and I will address it in the next version.

All patches are independent and can be applied separately, but for
everyone's convenience, it would be nice if they were merged through
a single tree.

The series is based on next-20260721.

Sang-Heon Jeon (36):
  coccinelle: misc: add cond_return_no_effect.cocci
  drm/amd: remove conditional return with no effect
  drm/radeon: remove conditional return with no effect
  dpll: zl3073x: remove conditional return with no effect
  drm/i915: remove conditional return with no effect
  drm: remove conditional return with no effect
  net: ethernet: remove conditional return with no effect
  net: remove conditional return with no effect
  net: intel: remove conditional return with no effect
  wifi: remove conditional return with no effect
  ipvs: remove conditional return with no effect
  media: remove conditional return with no effect
  ALSA: remove conditional return with no effect
  ASoC: remove conditional return with no effect
  iio: remove conditional return with no effect
  Input: remove conditional return with no effect
  clk: remove conditional return with no effect
  crypto: drivers - remove conditional return with no effect
  dmaengine: qcom_hidma: remove conditional return with no effect
  stm class: remove conditional return with no effect
  RDMA/ocrdma: remove conditional return with no effect
  iommu/s390: remove conditional return with no effect
  dm vdo: remove conditional return with no effect
  pinctrl: mediatek: remove conditional return with no effect
  platform/x86: toshiba_haps: remove conditional return with no effect
  power: supply: pm8916_lbc: remove conditional return with no effect
  RAS/AMD/ATL: remove conditional return with no effect
  regulator: wm831x-isink: remove conditional return with no effect
  rtc: pcf2127: remove conditional return with no effect
  scsi: mpt3sas: remove conditional return with no effect
  thermal/drivers/k3_bandgap: remove conditional return with no effect
  USB: serial: ch341: remove conditional return with no effect
  usb: typec: fusb302: remove conditional return with no effect
  smb: client: remove conditional return with no effect
  cpupower: remove conditional return with no effect
  memblock: remove conditional return with no effect

 drivers/clk/clk-cs2000-cp.c                   |   6 +-
 drivers/clk/clk-lmk04832.c                    |  12 +-
 .../intel/qat/qat_common/adf_gen2_config.c    |   8 +-
 .../marvell/octeontx2/otx2_cpt_mbox_common.c  |   7 +-
 drivers/dma/qcom/hidma_ll.c                   |   6 +-
 drivers/dpll/zl3073x/dpll.c                   |   6 +-
 drivers/dpll/zl3073x/out.c                    |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  32 ++---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  19 +--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |   7 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |   7 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  19 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |   6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  10 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  19 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |   9 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  16 +--
 drivers/gpu/drm/i915/display/intel_hdmi.c     |   7 +-
 drivers/gpu/drm/i915/gvt/gtt.c                |   8 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      |   6 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  14 +-
 .../drm/panel/panel-osd-osd101t2587-53ts.c    |   7 +-
 drivers/gpu/drm/radeon/ci_dpm.c               |   6 +-
 drivers/gpu/drm/radeon/kv_dpm.c               |  30 ++---
 drivers/gpu/drm/radeon/si_dpm.c               |  14 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |   6 +-
 drivers/hwtracing/stm/core.c                  |   8 +-
 drivers/iio/light/isl29028.c                  |   6 +-
 drivers/iio/light/tsl2583.c                   |  14 +-
 drivers/iio/magnetometer/ak8974.c             |   6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |   7 +-
 drivers/input/keyboard/pmic8xxx-keypad.c      |   8 +-
 drivers/input/mouse/synaptics_i2c.c           |   6 +-
 drivers/input/rmi4/rmi_smbus.c                |   7 +-
 drivers/iommu/s390-iommu.c                    |   8 +-
 drivers/md/dm-vdo/encodings.c                 |   8 +-
 drivers/media/i2c/mt9p031.c                   |   6 +-
 .../microchip/microchip-sama7g5-isc.c         |   7 +-
 .../media/platform/qcom/iris/iris_resources.c |   6 +-
 .../media/platform/qcom/venus/pm_helpers.c    |   7 +-
 drivers/media/platform/renesas/rcar-csi2.c    |   6 +-
 .../platform/samsung/s3c-camif/camif-core.c   |   7 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.c       |  12 +-
 drivers/media/usb/gspca/jl2005bcd.c           |   7 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |   6 +-
 .../ethernet/aquantia/atlantic/aq_macsec.c    |   6 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |   6 +-
 drivers/net/ethernet/freescale/gianfar.c      |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   8 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c   |   6 +-
 drivers/net/ethernet/intel/igc/igc_phy.c      |   6 +-
 .../ethernet/qlogic/netxen/netxen_nic_hw.c    |   7 +-
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_init.c |   6 +-
 drivers/net/ethernet/renesas/rtsn.c           |   7 +-
 drivers/net/phy/microchip_t1.c                |   6 +-
 drivers/net/pse-pd/tps23881.c                 |   6 +-
 drivers/net/wireless/ath/ath6kl/init.c        |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   6 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   |   7 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   6 +-
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.c  |   6 +-
 drivers/platform/x86/toshiba_haps.c           |   6 +-
 drivers/power/supply/pm8916_lbc.c             |   8 +-
 drivers/ras/amd/atl/map.c                     |   6 +-
 drivers/regulator/wm831x-isink.c              |   6 +-
 drivers/rtc/rtc-pcf2127.c                     |   7 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c           |   6 +-
 drivers/thermal/k3_bandgap.c                  |   7 +-
 drivers/usb/serial/ch341.c                    |   8 +-
 drivers/usb/typec/tcpm/fusb302.c              |  14 +-
 fs/smb/client/smb1maperror.c                  |   6 +-
 mm/memblock.c                                 |   7 +-
 net/netfilter/ipvs/ip_vs_sync.c               |   7 +-
 .../misc/cond_return_no_effect.cocci          | 121 ++++++++++++++++++
 sound/pci/echoaudio/echoaudio_dsp.c           |   6 +-
 sound/pci/echoaudio/layla24_dsp.c             |   6 +-
 sound/pci/riptide/riptide.c                   |   5 +-
 sound/soc/amd/acp/acp-mach-common.c           |  11 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  |   7 +-
 sound/soc/samsung/smdk_spdif.c                |   8 +-
 sound/soc/sof/intel/hda-dsp.c                 |   6 +-
 sound/usb/mixer_scarlett.c                    |  26 ++--
 tools/power/cpupower/utils/powercap-info.c    |   2 -
 102 files changed, 295 insertions(+), 643 deletions(-)
 create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.cocci

--
2.43.0

