Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3DEEB105B
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4/p8AtxdJ3b4aYgpRIBgOOPVM9R5HZLzlaxPPsEZ2Q4=;
  b=ElJ+dlHzzQES492vDGjsBZE8tYy8GRmVzJheCdiQBJ3tUyrfbfmZVP0p
   pLZ352/r1LyKD7anGYC2RFvJ1r4YchiO6o5TLzTOhRrJ/t0Cz7swlEtLy
   2furTQdMZ0DmQiM8ftC9v7wTVbRKt4cg6Kswa58+dUG45GwuERPLQwtUS
   A=;
X-CSE-ConnectionGUID: ksaWGN8QQjuWQzmp/vlexg==
X-CSE-MsgGUID: ahqdUy5rT3iDfzvXeKGxcw==
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
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267117346"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 15:25:28 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C2175839AB; Tue, 10 Mar 2026 15:25:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id ED02E8399B
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 15:24:54 +0100 (CET)
X-CSE-ConnectionGUID: OWClrdaGTueA8e1S2vadWQ==
X-CSE-MsgGUID: pCSCzemBSqufjLqODlXqtA==
IronPort-SDR: 69b029b7_Y6z3CCE0qhaTo8YU7j98Sx2zEg8IM3YB9tU+mlXWrqwOiho
 PF3YVMozj3jFCgXSajX24kZvp3o8KugC/4HaN9Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GDAQDeKLBphQscCRJaHQEBAQEJARIBBQUBQIE/BQELA?=
 =?us-ascii?q?QGCP0EBgSQnCQMEC0mNU4h8oBkGCQEDAQsBAU8CBAEBAwSEdwkCjSIfBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGT?=
 =?us-ascii?q?w1JAQwBggsBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCFHcBAQEDOgYBASwLA?=
 =?us-ascii?q?Q8LDgocEisrBoMVgiMCBEsDAwKtQoE0gQGCDAEBBtwTAQmBdAkVgTgBiFMBh?=
 =?us-ascii?q?VoahHpCgg2BFYMqPohYgi+CJoEOiQqCZGKGUFJ4eCwBVRMXCwcFgSNDA4EGI?=
 =?us-ascii?q?0sFLR16KSEdFxQfWBsHBRIhKoFJeIIBD4ZqeQMuXhoOIgI6XEo+C1oFgj8DC?=
 =?us-ascii?q?208ATcUG4ECjik+gjMCgRWCKiyWXAGwHwqEHIFfB59yTaprLodVEJBzqRYCB?=
 =?us-ascii?q?AYFAhcBgX4kgVxyE4MiTwMZD44hGSWELMh4JzU8AgcLAQEDCYVIhH6HWIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8vQpt6Of86P5Y8BcTuejsMiBIKoaSvp037BL7TEIdfUxSKalfq
 +V7ZcmPHPP+VQssRIb6Km90cu7MBfhHPdOiOF7XYtKNDOGhILCFvAE0WKN+UyEJwTOssBYkY
 lvGpIQNDQyNzRHZATBjTWQIpIazNGL/aWlwcPT1W1kQw0vS4wI1XYeNu9TKCNLeDU=
X-Talos-CUID: 9a23:wX2Umm80xWeXe42EGcOVv2krMcQ/fnTy8GrdCh+1UF0zVrSZdmbFrQ==
X-Talos-MUID: 9a23:FOtBAArGZjGe5n9ZnKsezylJD+x67qGEM1kQn5ciou6oMRxpJx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267117068"
X-MGA-submission: =?us-ascii?q?MDEUYMG7222wVBZQyAcsE4UdLxWmQhx203kwFz?=
 =?us-ascii?q?8CIRu1FpMss2v9TP+s/QoofOPbLLqIJ9bdy/hedo/S4B87aqA3gd/5ql?=
 =?us-ascii?q?XofBAvDZf1P/21hbKS3GUu6uoYcCL1Td/PMEp+HAb8Kq7MaXKJ5TBkJb?=
 =?us-ascii?q?1rvW8KDIbMq8pa9JkeZzCFHA=3D=3D?=
Received: from outgoing-auth-1.mit.edu (HELO outgoing.mit.edu) ([18.9.28.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:24:54 +0100
Received: from macsyma.thunk.org (pool-173-48-117-133.bstnma.fios.verizon.net [173.48.117.133])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62AENmt4023241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 10:23:49 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 96A8A5C4FCED; Tue, 10 Mar 2026 10:23:48 -0400 (EDT)
Date: Tue, 10 Mar 2026 10:23:48 -0400
From: "Theodore Tso" <tytso@mit.edu>
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
        linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
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
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
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
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andreas Gruenbacher <agruenba@redhat.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Jan Kara <jack@suse.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
        Daniel Gomez <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>, John Crispin <john@phrozen.org>,
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
        Heiner Kallweit <hkallweit1@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
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
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <20260310142348.GA41218@macsyma-wired.lan>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: "Theodore Tso" <tytso@mit.edu>
X-Loop: cocci@inria.fr
X-Sequence: 3383
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/rCZdUnIv_4OCnoTdvLYRug>

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.

I'm going to gently suggest that you *not* try to do this as a
tree-wide change, since we don't need to change some interface
requiring a global, flag day change.  This is instead a cleanup, which
maybe makes the code slightly better, but which also has a the
downside of breaking lots of inflight development patches by
potentially causing merge or patch conflicts.

So why don't you send it to each subsystem as a separate patch or
small patch series, instead of spamming a dozen-plus mailing lists,
are probably hundreds of developers, most of whom aren't going to
care about changs in some far flung part of the kernel?

Regards,

						- Ted
