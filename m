Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DCCFD2D93
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tqNoaL94Dj4pObM+6pGSr4RMsIJmELh6Cj7p3cxJGxE=;
  b=fK/+VgqOPEVY1sypwetk/A5svmquqkvibh7IHqznwiPDyhDS363GxsxQ
   yb4c+SchApUfSLHCwVnNvZ8tNDmbvdPQl5RUUB9H0uTPG4lMKVSFFYjAW
   QPU8/n7oHWDCN/Q0wkhpILica0XmEJxijDCLSBHGVjh54iP18mjGuNOWy
   g=;
X-CSE-ConnectionGUID: MRerHvlwRaWATjw6ItjDIQ==
X-CSE-MsgGUID: nIs4q1NVTtKgcgUbMypmpQ==
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
   d="scan'208";a="267107393"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 14:48:39 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9597B8342B; Tue, 10 Mar 2026 14:48:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 96C0383410
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 14:45:17 +0100 (CET)
X-CSE-ConnectionGUID: xHazgQIyRe698Q77tFCu7Q==
X-CSE-MsgGUID: 1SaKKOArQtKu/ReBHl3VyQ==
IronPort-SDR: 69b0206d_kxsRyWnWf1q3Tktsi4BlC5wT+Qp0kz6kotsR1QRPgQZ1kJK
 DkPmnXjwB8KsAizwSkbKLf2IfvliDh6TmKC6bGg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F0BQBLH7Bp/+WdvQVaHgEBCxIMQIFFC4JBB4FeNAcIS?=
 =?us-ascii?q?YRYkXcTi2GGW4l2gVWBfQIPAQMBDU4BAgQBAQMBA4UAAgiNGQIfBgEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAoEKE4ZPDYJiATOCF?=
 =?us-ascii?q?iwNfQEBAQECASMdAQE3AQQLCxgCAgUTDgICDwE2EAYBEoUsIycHrEt6gTKBA?=
 =?us-ascii?q?YIMAQEG3hEJFAGBCi6DRIUQAYFwg2oaO4Q/J4EYgRCBFYMqPoFYgjKEFIJpg?=
 =?us-ascii?q?iaBDokKg0aGUAlJeBwDWSwBSwoTFwsHBTMuQhAzAyAKLxQZAhQNEBIPBBYFL?=
 =?us-ascii?q?QoTUhIMDCcSDx0XFB85Ah0bBwUSIREZgUl4gWYbD4ZqeQMjC14aDiICKBIDM?=
 =?us-ascii?q?gQjSj4LWgWCPwMLbT03Bg4bBD2Oaj6CMwEBgQ2CQJdEr1YNhBmiJRODcY0Tm?=
 =?us-ascii?q?VQuh2WQcyKobjGBaD2BWXCDN08DGQ+OIQwWg16PPblxRTI8AgcLAQEDCYVGA?=
 =?us-ascii?q?QGMIjSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:vUUOOaPiCjZf6MBcTsqjsMiBIKoaSvp037Dk7SxMoHtuA6mlfq
 GV7ZAmPHrP4wr5N0tPpTntAsO9qDbnlaKdgrNhX4tKPjOGhILAFugL0WKh+UyCJ8SUzIFgPM
 lbHpRDNA==
X-Talos-CUID: =?us-ascii?q?9a23=3AGotsX2lX6VqavWJR1GvpCinCI6vXOW39xWXfGm6?=
 =?us-ascii?q?pM2s3Ge2sFgCM1oh5zPM7zg=3D=3D?=
X-Talos-MUID: 9a23:NZwFvAVARCtjJWHq/GbXjRJBE+5y2riNFQc3nL8mv5K6JBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267106602"
X-MGA-submission: =?us-ascii?q?MDGYXhKASBiwMxNCld8AbrMc8EoyNj8cTaK0hm?=
 =?us-ascii?q?wLm9I6f3dx/gMgP3JWvX8VMqAKjcbPtxpVne1n4g6WGXlrwWnKp1zhAX?=
 =?us-ascii?q?0cfspLWPIDlwGJ8xEB1u3VpgVhNxep9YsTzChxWl2ICSI7PzSvpUTiU+?=
 =?us-ascii?q?h3N0NE3VQw16L1ZY77XBECLA=3D=3D?=
Received: from kylie.crudebyte.com ([5.189.157.229])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:45:16 +0100
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
 Dominique Martinet <asmadeus@codewreck.org>
Date: Tue, 10 Mar 2026 14:45:07 +0100
Message-ID: <2401874.ElGaqSPkdT@weasel>
In-Reply-To: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
References:
 <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Christian Schoenebeck <linux_oss@crudebyte.com>
X-Loop: cocci@inria.fr
X-Sequence: 3378
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/asjJyMdprcgUScAcyTxwgg>

On Tuesday, 10 March 2026 12:48:32 CET Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: v9fs@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

"fs/9p" in the subject on this one, please, not just "9p".

Except of that:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index
> 0d6138bee2a3d1ab565ab2d210c0a3f3bf97e4e3..3bb7ef4380e972a2d9ab67eb4aab6cc5b
> fe2eea7 100644 --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -27,7 +27,7 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry
> *dentry) struct p9_fid *fid, *nfid;
> 
>  	fid = v9fs_fid_lookup(dentry);
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))
>  		return fid;
> 
>  	nfid = clone_fid(fid);


