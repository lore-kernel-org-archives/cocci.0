Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5C8F459F5
	for <cocci@archiver.kernel.org>; Fri, 10 Apr 2026 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BoGW7oywgvm57yYmgFIJhKPYzBfyhEW/uN+KSu6heaU=;
  b=axBYF2X6YPvWFrUiuQiiBfufm51hflpTO82LLtGguX911leN+YyKfi/g
   h7d5AbTHqWA4vrZmJuLz1tqw5GnRNUwXZt40dW1hwq3MgwGiZhB4huNTr
   CuxujU4SU91Iy7yjXhT1CNv5asX2X9vdqAr5ceL2aQRDbubpKnB62SonA
   o=;
X-CSE-ConnectionGUID: +6TGzpoWSdGTCpcQHHpYiA==
X-CSE-MsgGUID: G5ys1QX6RYmdbgvQWdVenA==
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
X-IronPort-AV: E=Sophos;i="6.23,171,1770591600"; 
   d="scan'208";a="271909921"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2026 17:26:12 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7EC0C82B02; Fri, 10 Apr 2026 17:26:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 659E082811
	for <cocci@sympa.inria.fr>; Thu,  9 Apr 2026 20:12:57 +0200 (CEST)
X-CSE-ConnectionGUID: AiSfaeeeT2uyS2MZOQBiRA==
X-CSE-MsgGUID: 9q5CrvjPS5aftMX6UYMwGw==
IronPort-SDR: 69d7ec28_726jimA95ckhaQLZ6JBmZzVbXT0ePKStXzMagnH96aLiqxn
 ACubpV8vtw/RVfSMGlVkGHPcsU2tRQ7HhHZ1vmA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H1AADK69dpcq2NWT5aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYIQgkGBZTQEC0mUK4IkgROfBBEBAwENTgECBAEBAwEDki0CHgYGNBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEBAgQGAQIQAYEMhk8NgmIBM?=
 =?us-ascii?q?4IWLA1+AQU6BgEBNwEPAQoOChwSVgaFP0oHtweBNIEBggwBAQbeEQkVgTiIV?=
 =?us-ascii?q?wGFXBqEeicbgg2BFYJyOD6LB4ImgQ6FBYp3UngcA1ksAUsKExcLBwUzcEMDg?=
 =?us-ascii?q?QYjSwUtChNSEj8hHRcVHzsdGwcFEiERGW6De3YuXhoOIgI5XEo+C1IFgXYCg?=
 =?us-ascii?q?R15AwttPTcUGwSMNiWCMAh6gw2WQAGwH4QmhHCcaE0Tg14TjROZVC6HVRCQc?=
 =?us-ascii?q?6lBgX8jgVxNNASDIk8DGQ+OIT6LPLhiRTI9AQEHAgcNAwuBaINcAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 9udzMobzR9M78qS+coaGtiSL9iIdmciY0KBJQ==
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:c7AJ66827kR7H2SFUa1uk+DbI+orL9Y04lQ7vn2ZhyY6TiW9rb
 HLoB17726QtN91YhodcL+7VZVoLUmxyXcx2/h3AV7AZniFhILLFuFfBOLZqlWLJ8S9zJ8/6U
 5OSdkZNDSaNzlHZKjBjzWFLw==
X-Talos-CUID: 9a23:1R6rImxbiVqEsxPr7BKvBgU9G/sre3DQwUuKPl6DU0Nbb4S/SGW5rfY=
X-Talos-MUID: 9a23:jXenCwUbpn6v7tvq/G712Rp4KsVQ2PmnBlwoocs7iuybGjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,170,1770591600"; 
   d="scan'208";a="271746030"
X-MGA-submission: =?us-ascii?q?MDEUU+FqOsVvzqSfa3JV63RhbjkdeSdlYtbevo?=
 =?us-ascii?q?lBXJbvvWaT/NaEqDCzMwGPLeg9fgGcFPZP4A3XbKh+qy5SmpkiR/8TEC?=
 =?us-ascii?q?OjZgec1ycJzrRNhuur0UWVQCAEPJ1QbpCDNy/inpF84zWz4Pkb9qnXWO?=
 =?us-ascii?q?TN1QZoN6b095AWNtHvir9Akg=3D=3D?=
Received: from zeniv.linux.org.uk ([62.89.141.173])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 20:12:56 +0200
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAtvH-00000003xj6-26He;
	Thu, 09 Apr 2026 18:16:11 +0000
Date: Thu, 9 Apr 2026 19:16:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Jan Kara <jack@suse.com>, Phillip Lougher <phillip@squashfs.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Jon Maloy <jmaloy@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	John Crispin <john@phrozen.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	Mark Greer <mgreer@animalcreek.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Dave Penkler <dpenkler@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>, Georgi Djakov <djakov@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <20260409181611.GP3836593@ZenIV>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
Sender: cocci-request@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: Al Viro <viro@zeniv.linux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 3474
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/eKIwbYtbpjVjyvx47tBXQw>

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().

... and valid uses of IS_ERR_OR_NULL are rare as hen teeth.
Most of those are "I'm not sure how this function returns an
error, let's use that just in case".

Please, do not introduce more of that crap.
