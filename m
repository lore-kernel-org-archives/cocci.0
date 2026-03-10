Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6068FD2D96
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aVv/PSZT5NGeZjfHxwg8OpWgNHlsgZDJ/5CMzeiUbdo=;
  b=XewGCo88uE8rVUfZUzBmLwZR4BeT76JG5S456YtBOLLAfX3Bt9H515eb
   KQDrTKKj9S0LHQhUienMCc8xBZT5wqmp8TbbohoMcyIxvYEAWAV14HXQ+
   FUb4bYgFABL38b8Yp+W55KPzq2QesTPvlEB06h6q5zk115uZyDockk/iF
   8=;
X-CSE-ConnectionGUID: EYQ2L00rRt+ZrzlALoRAqA==
X-CSE-MsgGUID: CS2KavqfS4aFptKXdHD0mw==
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
   d="scan'208";a="267107424"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 14:48:41 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7912D8342C; Tue, 10 Mar 2026 14:48:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9302C8340D
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 14:47:10 +0100 (CET)
X-CSE-ConnectionGUID: rItVzik/S3uSIk+LSdr3Nw==
X-CSE-MsgGUID: OWJ+zrjzQUS2bZXXNAcjuA==
IronPort-SDR: 69b020dd_/Hxylh05G/l9cl/tueQJ1asKiAJpOT1+r5CW0uunQPxmNsD
 PtiDDm1GQ/8AASFW5DPcjnT8HNIADLoE7jLXhxA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FfAADKH7Bp/+WdvQVaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YJAB4FeNAcISYRYiByJWxOLYYZbiXaBVYF9Ag8BAwENTgECBAEBAwEDhQACC?=
 =?us-ascii?q?I0ZAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECg?=
 =?us-ascii?q?QoThk8NgmIBM4IWLA19AQEBAQIBIwQZAQE3AQQLCxgCAgUTDgICDwE2EAYBE?=
 =?us-ascii?q?oUsIycHrEx6fzOBAYIMAQEG3hEJFAGBCi4Bg0OFEAGBcINqGjuEPyeBGIEQg?=
 =?us-ascii?q?RWDKj6BWIZGgmmDNIkKg0aGUAlJeBwDWSwBSwoTFwsHBTMuQhAzAyAKLxQZA?=
 =?us-ascii?q?hQNEBIPBBYFLQoTUhIMDCcSDx0XFB85Ah0bBwUSIREZgUl4gWYbD4ZqeQMjC?=
 =?us-ascii?q?14aDiICKBIDMgQjSj4LWgWCPwMLbT03Bg4bBD2Oaj6CMwEBgQ6CP5Z7Sa9WD?=
 =?us-ascii?q?YQZoiUTqlguh2WQcyKobjGBaD05gSBwgzdPAxkPjiEMFoNejz25dEUyPAIHC?=
 =?us-ascii?q?wEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FnwUYfpNckxsfmov/kxDBQPkzpz3tAzB+o=
IronPort-HdrOrdr: A9a23:/QTwGqrt+AyVmxQTFGViKF4aV5pIeYIsimQD101hICG9Ffb5qy
 nOppUmPHDP4gr5NEtNpTniAse9qBHnnqKdiLN5VYtKNzOKhILHFu5f0bc=
X-Talos-CUID: 9a23:fG/iuWHPUhXiI5+3qmJ91VIqCMEmNUaG0UzxIAycMmpzE5uKHAo=
X-Talos-MUID: 9a23:UhUPUwUleu6ycSbq/BjTpnJwLsV62pmVUko/oaUgksKGKAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140931091"
X-MGA-submission: =?us-ascii?q?MDGgv19sfKjCa8SuHRKolNcJisHUvBFW916nzL?=
 =?us-ascii?q?2ewA8nQggm6xv58GjDFZGl7KysLy8Hlw3raIMsvZWhQs5He4PIIG+O31?=
 =?us-ascii?q?JbZmYByjFBmYvZjKzRAtRaaDXyVpScQipRIjC5K1gnd6IYfCFaBhWCKP?=
 =?us-ascii?q?MZF+UYvVOT2zf6FxXLz5XHsQ=3D=3D?=
Received: from kylie.crudebyte.com ([5.189.157.229])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:47:10 +0100
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
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
 Philipp Hahn <phahn-oss@avm.de>, Philipp Hahn <phahn-oss@avm.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Date: Tue, 10 Mar 2026 14:47:03 +0100
Message-ID: <1948861.tdWV9SEqCh@weasel>
In-Reply-To: <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
References:
 <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 24/61] net/9p: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Christian Schoenebeck <linux_oss@crudebyte.com>
X-Loop: cocci@inria.fr
X-Sequence: 3379
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/GrK150a6dmUJeJS8oH7oIw>

On Tuesday, 10 March 2026 12:48:50 CET Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: v9fs@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  include/net/9p/client.h | 2 +-
>  net/9p/trans_rdma.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index
> 838a94218b593f3fb19e6827c472753380193461..4bde6bd716f323c819745e64c7aac0dea
> 7beb72f 100644 --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -364,7 +364,7 @@ static inline struct p9_fid *p9_fid_get(struct p9_fid
> *fid)
> 
>  static inline int p9_fid_put(struct p9_fid *fid)
>  {
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))
>  		return 0;
> 
>  	if (tracepoint_enabled(9p_fid_ref))
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index
> aa5bd74d333f3b5e6fd1e4344d26bc0201ff7f7f..60461344b536bcb6e94112aace75a88b6
> a99ad86 100644 --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -252,16 +252,16 @@ static void rdma_destroy_trans(struct p9_trans_rdma
> *rdma) if (!rdma)
>  		return;
> 
> -	if (rdma->qp && !IS_ERR(rdma->qp))
> +	if (!IS_ERR_OR_NULL(rdma->qp))
>  		ib_destroy_qp(rdma->qp);
> 
> -	if (rdma->pd && !IS_ERR(rdma->pd))
> +	if (!IS_ERR_OR_NULL(rdma->pd))
>  		ib_dealloc_pd(rdma->pd);
> 
> -	if (rdma->cq && !IS_ERR(rdma->cq))
> +	if (!IS_ERR_OR_NULL(rdma->cq))
>  		ib_free_cq(rdma->cq);
> 
> -	if (rdma->cm_id && !IS_ERR(rdma->cm_id))
> +	if (!IS_ERR_OR_NULL(rdma->cm_id))
>  		rdma_destroy_id(rdma->cm_id);
> 
>  	kfree(rdma);


