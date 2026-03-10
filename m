Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8452CFD2D6E
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sWy9ef7Hud0vVkgTkw0OoHXnvQiMcKWf2ClKsqXhea4=;
  b=H0Ke1MAAfobEINREO9YO5bmduEXJI+kI1J3jymzgVCD9A1m3mcWkzTC9
   J1iMP8CuiNz10BRMYhZkvEAdiCfePHXCWq8ok57M33iO8RV8Y2CpY3mei
   a21h1drJdmVnMM62bEV0Ty9u8BXL/Hykl6zhzigREfBIWDTBwVDjQHeEB
   U=;
X-CSE-ConnectionGUID: rQ7zwSo5T+mTAZ6ESuAUrQ==
X-CSE-MsgGUID: 5RovOOMXQFS1mAT7e8d82A==
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
   d="scan'208";a="267090037"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 13:46:06 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1720A833B7; Tue, 10 Mar 2026 13:46:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D9B1F8305E
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 13:23:35 +0100 (CET)
X-CSE-ConnectionGUID: bNrbIbx5QbGwTs3CFbajWA==
X-CSE-MsgGUID: aqhq4O8vRPu9bhNLnaLKig==
IronPort-SDR: 69b00d47_Ds7PPmX/VsTXrisdqCqc4xbCL5TqzMziz4x8UP0aFqSGg/+
 k8JHo6EUgPrRMu4MwZbcFaiBXIxX5IX0NTfCApw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQAADJC7Bphf4EaaxaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYJAgWYzBAtJhFiIHF+GWIIknEWBVYF9Ag8BAwENUQQBAQMEhQACj?=
 =?us-ascii?q?SECHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAUBJhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDIwQZAQE3AQ8LD?=
 =?us-ascii?q?goCAiYCAlYGARKDAoIjB0oDrU5/M4EBggwBAQaCadlBgWcJFAGBCi4BiFMBg?=
 =?us-ascii?q?XCDaho7g0V6JxuBSUSBFYMqPoRDFYNGgmmCJoEOiQqKFglJeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFXkUQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqgUl4gWYbD?=
 =?us-ascii?q?4ZqeQMuXhoOIgI6A1lKPgtaBYI/AwttPTcGDhsEjyc+gi0GAQFPPoJAlnuMc?=
 =?us-ascii?q?KMvhCahcjOXUpMZLodlkHMiqR+BaDo8gSAzGggoCIMiTwMZD44hDA0JiHGKK?=
 =?us-ascii?q?rliJzU8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Luv0R6n7PWEzWFfrP6nOflLLHPnpDfIY3DAbv31ZSRFFG/Gwv9
 yymv4BxQbo4QxhPE3IV+rhBEDmewK7yXcV2/h3AV7GZmTbUQSTXeJfBOfZrQEIXheOlNK1tp
 0QC5SWauedMbESt6+Ti2OF+pQbsby6GcuT6ts2oU0NcegnUdAY0ztE
X-Talos-CUID: =?us-ascii?q?9a23=3A371J/Gn96WLOmGQuECtb1aJ3SifXOXf71n3xKV/?=
 =?us-ascii?q?lMGxGV4GOEnS+8qpmrOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Az4qIOA/U8+fnwXvpT/LOsCqQf85x473yLxATq60?=
 =?us-ascii?q?b6sOEEwh2MhO+jTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140920565"
X-MGA-submission: =?us-ascii?q?MDF9QeT/TH55PIzMEfY5EVgzaKQT7LfdyQ9Hvq?=
 =?us-ascii?q?NiZSwj3hQ7oMHKMYxDCmE1O1kAApvHLMjxRUmtQwRIG7qfFLUEyKDUPY?=
 =?us-ascii?q?sX+/LtVmCqHb1ULRQpIeIOnfnQxTLyMqJNel/xblNBO8kFAeC3P1L9Cz?=
 =?us-ascii?q?5L8Mh2z/GpUyEnAy+gTJQjwg=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:23:35 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BB3CC600B0;
	Tue, 10 Mar 2026 12:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10E4C19423;
	Tue, 10 Mar 2026 12:23:27 +0000 (UTC)
Message-ID: <d97c4fd76d7b7fc8b38d3bb4e4ed700b1003ecba.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
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
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>,  Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>
Date: Tue, 10 Mar 2026 08:23:26 -0400
In-Reply-To: <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 30/61] net/sunrpc: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Jeff Layton <jlayton@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3371
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/wE3SDokrq5dU0fDFnOtwEA>

On Tue, 2026-03-10 at 12:48 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Trond Myklebust <trondmy@kernel.org>
> To: Anna Schumaker <anna@kernel.org>
> To: Chuck Lever <chuck.lever@oracle.com>
> To: Jeff Layton <jlayton@kernel.org>
> To: NeilBrown <neil@brown.name>
> To: Olga Kornievskaia <okorniev@redhat.com>
> To: Dai Ngo <Dai.Ngo@oracle.com>
> To: Tom Talpey <tom@talpey.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrd=
ma/svc_rdma_transport.c
> index 9b623849723ed0eb74b827881c6f32d3434c891b..b4d03e59a8202f20360cff1e2=
e79b1e325396517 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -578,7 +578,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xp=
rt *xprt)
>   errout:
>  	/* Take a reference in case the DTO handler runs */
>  	svc_xprt_get(&newxprt->sc_xprt);
> -	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
> +	if (!IS_ERR_OR_NULL(newxprt->sc_qp))
>  		ib_destroy_qp(newxprt->sc_qp);
>  	rdma_destroy_id(newxprt->sc_cm_id);
>  	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
> @@ -608,7 +608,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
>  	might_sleep();
> =20
>  	/* This blocks until the Completion Queues are empty */
> -	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> +	if (!IS_ERR_OR_NULL(rdma->sc_qp))
>  		ib_drain_qp(rdma->sc_qp);
>  	flush_workqueue(svcrdma_wq);
> =20
> @@ -619,16 +619,16 @@ static void svc_rdma_free(struct svc_xprt *xprt)
>  	svc_rdma_recv_ctxts_destroy(rdma);
> =20
>  	/* Destroy the QP if present (not a listener) */
> -	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> +	if (!IS_ERR_OR_NULL(rdma->sc_qp))
>  		ib_destroy_qp(rdma->sc_qp);
> =20
> -	if (rdma->sc_sq_cq && !IS_ERR(rdma->sc_sq_cq))
> +	if (!IS_ERR_OR_NULL(rdma->sc_sq_cq))
>  		ib_free_cq(rdma->sc_sq_cq);
> =20
> -	if (rdma->sc_rq_cq && !IS_ERR(rdma->sc_rq_cq))
> +	if (!IS_ERR_OR_NULL(rdma->sc_rq_cq))
>  		ib_free_cq(rdma->sc_rq_cq);
> =20
> -	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
> +	if (!IS_ERR_OR_NULL(rdma->sc_pd))
>  		ib_dealloc_pd(rdma->sc_pd);
> =20
>  	/* Destroy the CM ID */

Reviewed-by: Jeff Layton <jlayton@kernel.org>
