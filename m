Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5A5D58D69
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MR460/22Hym0+H/Ew4C1lgle14QaTxq4iIzLRGr8TCE=;
  b=SkbbSKSiK+u+gvAdZbJyDa+E6RQ95hsDCFcuAPZI7ecWAuykjyuoD4By
   cABSp8DZ1vK1fgRxT8pOKhShjLs06aU7APyvr3O4m5PgRfCwk4jpPWxCK
   vdrKXyKj7mCuQWyiy4KUMQ7O0LJl1qflb8iidGrOPkqHt6rak/Bqhxgbh
   8=;
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
   d="scan'208";a="195724499"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D5CE6E0DC7; Mon, 25 Nov 2024 17:57:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BFE76E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 12:11:15 +0100 (CET)
IronPort-SDR: 67445b53_lHhyacf1A8TgIIOTT7QBcrjuk/nbXN15IKb/1fDad2BW+NS
 pSI6kz7oSIVNXDS9BXmLNCCuGCRxakrScORI4pw==
X-IPAS-Result: =?us-ascii?q?A0EvAACaWURncqxujNlaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgVY0BAtIhFaIHV+GUYIEHQORSoxNgX4PAQMBTgECBAEBhQcCilkCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMhgiCYgGDf?=
 =?us-ascii?q?wEBAQECASMECwFGBQsLFQMCAiYCAhBGGYUyAw4jB65qen8zgQHdOg1sgW2BG?=
 =?us-ascii?q?i4BhWmCYgGFUBmEdycPgVVEhD8+gh+BeylNgw6CaQSBEIEwgTGDXiWFNgGDS?=
 =?us-ascii?q?ZJ6iDlSe3gyAVUTFwsHBYEpISwDgkd/gTYogSkBgxBKgy6BXgU3Cj2CSmlNN?=
 =?us-ascii?q?wINAjaCJH2CTYUZgQuDXmUvAwMDA4ITgSuGBh1AAwttPTcUG6FXRoNBBwGBD?=
 =?us-ascii?q?QEbFB0uYFQRC5MXLoMhAa9DNAeEHYFdBgygIapRiC+QTKNyAYccOoFcMxojg?=
 =?us-ascii?q?zdPAxkP2WNGMjsCBwEKAQEDCYVGAQGBAIo+NIFLAQE?=
IronPort-PHdr: A9a23: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
 5m3tDRJwQclZ9kwd/S4GQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:A1ofha73qjUeaGv6ewPXwMfXdLJyesId70hD6qm+c3Jom+ij5q
 STdZMgpHjJYVcqKRQdcL+7VZVoLUmxyXcx2/h2AV7AZniFhILLFuFfBOLZqlWKcREWtNQttp
 uIGJIeNDSfNzdHsfo=
X-Talos-CUID: 9a23:0/f/Tm+9bti82ITrfcuVv0JOQusKLkP09XT/fGOhJFdVTLi+VVDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Ap79aXg08uwzxFhdGpuSgyo/ZxDUj+qqICx4fyrw?=
 =?us-ascii?q?9sOaDC3B3ZD6EkWnue9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102550383"
X-MGA-submission: =?us-ascii?q?MDGwI4T6B2Io6V/T7riVrml7pPrNITFn9LxXzZ?=
 =?us-ascii?q?PKQTcQ4GjA98UTuZqn50xeCpYL/aDRcqDvQ40+SblZymKojURwsDC4xe?=
 =?us-ascii?q?5BwLNdFI1dOKCkJnOygMW0mtYB7Cy6hWcfcTERDDu7i5WmYxHRACaxaq?=
 =?us-ascii?q?XEbmyWL9+V94eQECKTOCO9Dg=3D=3D?=
Received: from foss.arm.com ([217.140.110.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Nov 2024 12:11:15 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4FA31FCD
	for <cocci@inria.fr>; Mon, 25 Nov 2024 03:11:43 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 892BB3F66E
	for <cocci@inria.fr>; Mon, 25 Nov 2024 03:11:13 -0800 (PST)
Date: Mon, 25 Nov 2024 11:10:51 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
	cocci@inria.fr
Message-ID: <Z0RbO1lSXoUnAtxj@e110455-lin.cambridge.arm.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-5-cgoettsche@seltendoof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125104011.36552-5-cgoettsche@seltendoof.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 06/11] ubifs: reorder capability check last
Reply-To: Liviu Dudau <liviu.dudau@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 2115
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/Z0RbO1lSXoUnAtxj%40e110455-lin.cambridge.arm.com>

Hi Christian,

On Mon, Nov 25, 2024 at 11:39:58AM +0100, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
>  fs/ubifs/budget.c                     | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index ac7e53f6e3f0..2de0c3627fbf 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -791,7 +791,7 @@ static int group_priority_permit(struct drm_file *file,
>  		return 0;
>  
>  	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
> -	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
> +	if (drm_is_current_master(file) || capable(CAP_SYS_NICE))
>  		return 0;
>  
>  	return -EACCES;

Can the patch above be split into a separate one? It's for a different subsystem than ubifs.

Otherwise, it looks good to me, so you can add my Reviewed-by to the new patch.

Best regards,
Liviu

> diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
> index d76eb7b39f56..6137aeadec3f 100644
> --- a/fs/ubifs/budget.c
> +++ b/fs/ubifs/budget.c
> @@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
>   */
>  static int can_use_rp(struct ubifs_info *c)
>  {
> -	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
> -	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
> +	if (uid_eq(current_fsuid(), c->rp_uid) ||
> +	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
> +	    capable(CAP_SYS_RESOURCE))
>  		return 1;
>  	return 0;
>  }
> -- 
> 2.45.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
