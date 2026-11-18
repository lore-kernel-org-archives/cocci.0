Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4F60A261C
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=Df9htH1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=foydl+Nk9ZmJviej/30gV1cygoCTSVCceGPI7w/fow0=;
  b=Df9htH1fgGPBq4Y6LypTw6Bzy8A1FPh7zutAYh/7jbdzGkHdpBDdo8D3
   qzjWmo6nOA6EdTpSBzRsTtfcUU4IsiSxs9A82D1cF4DVBMs9bDgim6eK4
   giMmdcPv/iRaRLaUMa77rSfozo2cKhwalv/Km7h9MlXrOnNrlaedTO3lk
   I=;
X-CSE-ConnectionGUID: BO/ElEUkRaGx8oIT/yQh3Q==
X-CSE-MsgGUID: HqRIPgpiTGGzokHXVA9Drw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; 
   d="scan'208";a="306145636"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2026 16:31:07 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2CF938238D; Wed, 18 Nov 2026 16:31:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2DA1C81C4E
	for <cocci@sympa.inria.fr>; Wed, 18 Nov 2026 15:05:40 +0100 (CET)
X-CSE-ConnectionGUID: rbGKocRtQ92KpNToVfNzIA==
X-CSE-MsgGUID: 5CVyo/eTRmKBCliTj6cCGg==
IronPort-SDR: 6afdb0b3_RoSmFyxEgQ1IrL3Y1nGpmZEM6F4sVdkx3jrTX5xUo5uMr42
 Ya9rF+C2XltpHA2RNpXCySOOXQsQOmiz9aCTdhg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EoAgBWr/1qhSIym1pahRqBbDMEC0mNUoZZgiSgJAIPA?=
 =?us-ascii?q?QMBDU4BAgQBAQECBIR+Ao4hAh4HAQQ0EwECBAMCAwEBAQEBAQEBAQEBCwEBA?=
 =?us-ascii?q?QQBAQECAQECBAMBAQEBAhABAQEBQEmGTw2MGgGBJIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QINfgEBAQM6BgEBNwEPCxguKysGgxWCKksHAbtWgTSBAYIMAQEG3DWBawkVg?=
 =?us-ascii?q?TiFdIJuAYV5hH0nG4FJRIRBPosJgzKQPId1Unh4LAFVExcLBwVgRUMDgQYjS?=
 =?us-ascii?q?wUtHYEjOxcRHlgbBgUSICpAQ1uBEoEDXYErKF0BAh9GLRWBdgKCUYEjXQIBS?=
 =?us-ascii?q?UEOB0VTCSVDEkckIggSCQETGiwKgRo1PAkmPxUMWwwLGgUaRwgCCwIMdCgRE?=
 =?us-ascii?q?BMdHiQvBRomPhsKgQwnHx4IbT03FRmUaoRCmR8BsBgLhCuBaJ92BBYzg3EBp?=
 =?us-ascii?q?wAumFqpRYF/I4FcTTAIgyJQAxkPjjuIfMcLQzU9AQEHAgcOAwuBaINcAQGMV?=
 =?us-ascii?q?oFMAQE?=
IronPort-PHdr: A9a23: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
 h8whBF3bekk+HHr+VhlfjL3
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:HMuiA6MbTD4Eo8BcTgujsMiBIKoaSvp037BL7TETdfU7SKalfq
 yV8cjztiWVtN9yYh8dcLm7UcHqfZq7z/JICOIqXItKKTOW3ldAW7sSlLcKrQeOJwTOssZAyK
 ZtdLV/AtXsAVU/sdz3+2CDYrIdKaG8gcWVbLDlvhVQZDAvWKFl5BxwTiKWCFd/SgUDOpYjFJ
 Wd7MJbpzymEE5nCfiGOg==
X-Talos-CUID: 9a23:nl+YxmxuA4osm+1NC8mxBgUOEO8GdXbn0E6BeWygL1pudrOzW365rfY=
X-Talos-MUID: 9a23:EnAQOwWEgZt7PKPq/GLHuiBlc8pU2aGNImsJkKkE5cKvGiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; 
   d="scan'208";a="306120781"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHZKj4EwOvNGNL6az5Efxhg2tpBMZ6tLIN0Zo?=
 =?us-ascii?q?ACXGaSRxFVI6wFaJFAmlZvG7flZGh/w6mxPg44Q2wm0CG93OM/xgB/Jg?=
 =?us-ascii?q?e+Jbnf50FkDoFA2PMGYXcs81o9tKnORjFtCeliI6x4m8Gvuzer/LTtvu?=
 =?us-ascii?q?bCiiHZv54XXLZAgKyU+vF/Zg=3D=3D?=
Received: from casper.infradead.org ([90.155.50.34])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 15:05:39 +0100
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTgHi-0000000E2Nu-35xl;
	Wed, 18 Nov 2026 14:05:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2EC13005AF; Wed, 18 Nov 2026 15:05:13 +0100 (CET)
Date: Wed, 18 Nov 2026 15:05:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bence Csokas <bence.csokas@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Carlos Maiolino <cem@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-scsi@vger.kernel.org,
	cocci@inria.fr, linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
	ipsec@lists.linux.dev, linux-security-module@vger.kernel.org,
	linux-sound@vger.kernel.org
Message-ID: <20261118140513.GO1813469@noisy.programming.kicks-ass.net>
References: <20261118-offsetof-v4-0-95b385c10b22@arm.com>
 <20261118-offsetof-v4-2-95b385c10b22@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-offsetof-v4-2-95b385c10b22@arm.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v4 2/2] treewide: Use struct_offset()
Reply-To: Peter Zijlstra <peterz@infradead.org>
X-Loop: cocci@inria.fr
X-Sequence: 3814
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/UIe6GTogm5yryCl-6ro8vA>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 12:50:09PM +0100, Bence Csokas wrote:
> Generated with a simple Coccinelle patch found in
> scripts/coccinelle/api/struct_offsetof.cocci

I think this is a good example of why we don't need this. It adds yet
another macro to remember, and doesn't actually save many characters at
all.
