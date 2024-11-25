Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A1D58D6A
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vxV0birux+/ieoj0LvxDeQ6bk951+7EUB2+rh8jCo/4=;
  b=B/HLuuADJvlCvf1imGB9n4Qygw5MGtqH+3WNi59HGnmlGLf8jCcwuwKX
   wGin8brpGZQke5DYhVkdhVufmOaFW5D/q4W/dAKFE0ttNF9IwH1hyGen+
   coXt0gsSdC2MwYQ/Z9kIFYfyKGAKaKVJu03z+TuKcJEAmv9bQ76sbjEsS
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724542"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0BDB1E0D85; Mon, 25 Nov 2024 17:57:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 192EBE00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 12:31:01 +0100 (CET)
IronPort-SDR: 67445ff4_5A60oTdx4J9B93c8EwDVC0yxLYd2p28twXX01u1tOjY71gI
 6rst2RbZo2nHN9T7DaZ11PSNQWpI4uh5eiLqu9g==
X-IPAS-Result: =?us-ascii?q?A0FNAwBxX0Rn/5iny3RaHgEBCxIMQIFIC4JEgVgyBAtIH?=
 =?us-ascii?q?YQ5iHyIcgMRkTmMTYF+DwEDAQ1BAQIEAQGFBwKKWh8JAzIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQKBChOGCIJiAYQAAQEBAgEjBFIFCwIBC?=
 =?us-ascii?q?BoCDRkCAlYCF4UyAw4jAgWvXH8zgQHdOg1sgW2BGi6FaoJiAYVQGRuEXEKCD?=
 =?us-ascii?q?YFHgng+gh+BewcBASBNgw6CaQSCQIExg14lTYQ5g3qbM0gKexwDWSERAVUTD?=
 =?us-ascii?q?QoLBwWBKSEsA4JHBXorgQsobzoBgX2BE0qDLoFeBTcKPYJKaU03Ag0CNoIkf?=
 =?us-ascii?q?YJNhRmBC4NeZS8DAwMDghOBK4YGHUADCxgNSBEsNxQbBj5uB6AeRoNBBgEBg?=
 =?us-ascii?q?Q4vHS4JV04ikxeDTwGvd4I/gWWBY59+L4FMgjiNBYZGkwKIL5BMo3IBhTUkg?=
 =?us-ascii?q?R4sDCqBWYEFgyJPAxcCD9lmQzQ7AgcBCgEBAwmFRgEBIYsdNC4BgRwBAQ?=
IronPort-PHdr: A9a23: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
 X51bxETxoA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:m/FD4qDxm44hx6blHemb55DYdb4zR+YMi2TDGXoBKiC9Ffbo7/
 xG/c5rrCMc5wx+ZJhNo7G90ey7MBbhHP1OkO8s1NWZLWvbUQKTRekIh+aPrAEIWReOktK1vp
 0QFJSWfeeAcWSS+vyKnTVQfexB/DD+ytHTuQ6I9QYXcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3Ap0SWQGlbC5bVkpR03OknnT4ycV3XOVbY8muNAHS?=
 =?us-ascii?q?ANVlSdJG4ZFiOo5k/wsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ATbtAJA2tIbu8AUEQOiXZpyymbDUjwKqWDgMcu40?=
 =?us-ascii?q?/qdiraD5wISWY3QXwXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195639892"
X-MGA-submission: =?us-ascii?q?MDHL0UA5AE0hRpLgST2FZ3EW9O70a00d5X2GRP?=
 =?us-ascii?q?75psT6ARqQvJgazb2TKNPg+dTfjj8bsPen/BOTs5YgZGxvb/Ora1szmz?=
 =?us-ascii?q?Vs0mfwgbEfUa26NCJWzs+Q9IoY2waa/JKoX/9OqfCFkQIpMjzdfDQzNT?=
 =?us-ascii?q?OKb8/9E1441Z8n+biPZMQ+Pw=3D=3D?=
Received: from mailout.nod.at (HELO lithops.sigma-star.at) ([116.203.167.152])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:31:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B357B2E6142;
	Mon, 25 Nov 2024 12:30:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zBiM6kBr8mqI; Mon, 25 Nov 2024 12:30:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F0F482E613D;
	Mon, 25 Nov 2024 12:30:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6isOqRtT0GRU; Mon, 25 Nov 2024 12:30:58 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C3F6B2A87E6;
	Mon, 25 Nov 2024 12:30:58 +0100 (CET)
Date: Mon, 25 Nov 2024 12:30:58 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: cgzones@googlemail.com
Cc: LSM <linux-security-module@vger.kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, cocci <cocci@inria.fr>
Message-ID: <1045101183.70157813.1732534258584.JavaMail.zimbra@nod.at>
In-Reply-To: <20241125104011.36552-5-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de> <20241125104011.36552-5-cgoettsche@seltendoof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF132 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: reorder capability check last
Thread-Index: CIQyHdt2r7cFMRbn2TiAVM+y9UFUfA==
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 06/11] ubifs: reorder capability check last
Reply-To: Richard Weinberger <richard@nod.at>
X-Loop: cocci@inria.fr
X-Sequence: 2116
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/1045101183.70157813.1732534258584.JavaMail.zimbra%40nod.at>

----- Urspr=C3=BCngliche Mail -----
> Von: "Christian G=C3=B6ttsche" <cgoettsche@seltendoof.de>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>  1. A denial message is generated, even in case the operation was an
>     unprivileged one and thus the syscall succeeded, creating noise.
>  2. To avoid the noise from 1. the policy writer adds a rule to ignore
>     those denial messages, hiding future syscalls, where the task
>     performs an actual privileged operation, leading to hidden limited
>     functionality of that task.
>  3. To avoid the noise from 1. the policy writer adds a rule to permit
>     the task the requested capability, while it does not need it,
>     violating the principle of least privilege.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> drivers/gpu/drm/panthor/panthor_drv.c | 2 +-

This change is unrelated, please remove it.

> fs/ubifs/budget.c                     | 5 +++--
> 2 files changed, 4 insertions(+), 3 deletions(-)

[...]

> diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
> index d76eb7b39f56..6137aeadec3f 100644
> --- a/fs/ubifs/budget.c
> +++ b/fs/ubifs/budget.c
> @@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_inf=
o *c,
> int min_idx_lebs)
>  */
> static int can_use_rp(struct ubifs_info *c)
> {
> -=09if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) |=
|
> -=09    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
> +=09if (uid_eq(current_fsuid(), c->rp_uid) ||
> +=09    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
> +=09    capable(CAP_SYS_RESOURCE))
> =09=09return 1;
> =09return 0;
> }

The UBIFS part looks ok:

Acked-by: Richard Weinberger <richard@nod.at>

Since I was not CC'ed to the whole series, I miss a lot of context.
Will this series merged as a whole? By whom?

Thanks,
//richard
