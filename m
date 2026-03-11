Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A46E1049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7hV5LSkoaULvfWpcA92IONFe2jiU8FtnTFTGMKYHxiU=;
  b=cQC/zyvWOxrrnFJqIIPvvmQnSU2eUCF2iT+38DunWEj8TwDd9hdI0SJu
   4QSJwjBN/voIi8VPBpi59EhwieCwP1GssDlqPR6ozg13LqMdeRfEnHOKJ
   hhZEnxXui6x6mIHn4Qeeyw0Op98n4QNZHg/8UVnzxUdLy2BjX3CoRWGEY
   U=;
X-CSE-ConnectionGUID: adO+ekixSQWfJnwylhkaQA==
X-CSE-MsgGUID: 8Teh85UASp623KQ0OytsSQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245577"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:05 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BC3FE818D0; Wed, 11 Mar 2026 10:46:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4938280F45
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 01:11:20 +0100 (CET)
X-CSE-ConnectionGUID: DqGnE1cZSoKZubKpbmDVbA==
X-CSE-MsgGUID: vy6jIR2qTtyy9pVV1EzAow==
IronPort-SDR: 69b0b324_XdUyttOoE0hE0EsjUQmHpXkb99q74jIMD/BmZ+o+SlxIOZK
 NnOZuSHmkUda+yZMrv/4HDKNZzPmStfBaupwBdw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GGAwAEsrBpctoeIE5aHQEBAQEJARIBBQUBQIFQgW5Tg?=
 =?us-ascii?q?QdeNAQLSZQrWQEBAQEGgUGBE58EEQEDAQ09EQECBAEBAwSSJQIeBgY0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAYEMhk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDX4BBToGAQE3AQ8BCg4KLhBGBoMWgilKBAMNrgmBN?=
 =?us-ascii?q?IEBggwBAQbeEQMGFYE4iFQBhVoahHonG32BEIEVgnI4PosHgzSJCooZUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcUH1gbBwUSISqBSXiCAQ+GankDL?=
 =?us-ascii?q?l4aDiICOlxKPgtaBYJIAwttPTcUG48tPoI1gTmZDgGuYYE+CoQcoXIzqmsuh?=
 =?us-ascii?q?1UQkHOpQYF/I4FcUTAEgyJPHA+ISoVXPos7wQlGMjwCBwsBAQMJhUYBAYxWg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 AMmzAxkbqIw92W0i2o=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Y4H2aKCTkzRDDXjlHemp55DYdb4zR+YMi2TDGXoRdfVwSL3+qy
 nOpoV+6faQsl0ssR4b9exoVJPufZqYz+8S3WBzB8bGYOCFghrKEGgK1+KLqVDd8m/Fh4xgPI
 hbAtFD4bbLbWSS4/yV3DWF
X-Talos-CUID: =?us-ascii?q?9a23=3AdICK2mnomC1YkuQDcGKa5rUSA77XOVHE43H9ekS?=
 =?us-ascii?q?KMmFKeqCfakea/Y9ameM7zg=3D=3D?=
X-Talos-MUID: 9a23:nVGlAwqDu5GuvyRwDQwezy9zasVJ2f63NFwcgMQehffdGD5ZPCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="140977467"
X-MGA-submission: =?us-ascii?q?MDErWc1lH5kqYotQJ5Mm7QT+hmHF+bPCi1pAQK?=
 =?us-ascii?q?GIYM6sp2V1j88HcEYbmK0fWhex7FGXQe47LRYsXKvatxMEERr3FAYv0R?=
 =?us-ascii?q?2wKWYsqw7WMv1zKyNEkvk73QkUlIK1gbhZgLxYZJKNFtLAv7w0LJtBLW?=
 =?us-ascii?q?bWoN2ndDm7XDz9Pm1cfL6wcA=3D=3D?=
Received: from pandora.armlinux.org.uk ([78.32.30.218])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:11:16 +0100
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w079p-000000005ZQ-1adR;
	Wed, 11 Mar 2026 00:10:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w079B-000000005hV-0rNO;
	Wed, 11 Mar 2026 00:09:57 +0000
Date: Wed, 11 Mar 2026 00:09:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <abCy1Xs9yQx0Sjbn@shell.armlinux.org.uk>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
Sender: cocci-request@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 3389
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/X50lKQhiKVJWb3yHOJRhDw>

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().

One thing you need to check for each of these cases is whether the tests
are actually correct.

There are certainly cases amongst those that you have identified where
the check for NULL is redundant.

For example, get_phy_device() never returns NULL, yet in your netdev
patch, you have at least one instance where the return value of
get_phy_device() is checked for NULL and IS_ERR() which you then
turn into IS_ERR_OR_NULL(). Instead, the NULL check should be dropped
(as a separate patch.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
