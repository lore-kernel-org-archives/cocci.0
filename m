Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A6DC282D9
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ubXqCrWmLNdqftFOFh6hu/5PTN/Xy4dIMlz6U4vUvLA=;
  b=h4/y3ASDGJ7lvKxKKQxzEuC3tHjenhFmUss92iGfAv7FVh5s4dMwIHou
   FAzp9jfSJg7AS8kFICwS5ORtzkL7ydhxd6ofYiDOS8lVeuf48RGVe/A8t
   raFbijGOGoZeB3bxNsVch5vdhPialE7nDTdjtWt3lNGxOLtS7rZqrbPR5
   M=;
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
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069935"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C804E114D; Tue,  4 Mar 2025 10:58:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B8EAE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 14:49:27 +0100 (CET)
IronPort-SDR: 67c5b366_SB9v6KA8l+EbJyOiwRIUL3wOn8CK31DvU/eME7y6T1cnlLm
 jBJg3Gm9nbCC9KuluyRcTslBVvBRz92InFqvEhw==
X-IPAS-Result: =?us-ascii?q?A0EaAADZssVng7zU+S1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUIBAQEBAQELAYJDgVczBAtIHYQ5kUMtA4Q7jQyOS?=
 =?us-ascii?q?w8BAwEMAUQEAQGFBwKLFQIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQEBOQdJhgiCYgGEAAIBAyMECwEFQRAJAhUFAiYCAkYQB?=
 =?us-ascii?q?g0BBQIBAYJ+gjEDMQOScpxFfzOBAYR82D8NglqBGi4BiE4BgWyDZhmEdyeCK?=
 =?us-ascii?q?IE8gwM+gh+Be3aDDoJpBIQZgz2aBY5TCUl7HANZLAFVExcLBwWBKUgDgQ8jg?=
 =?us-ascii?q?SMFNAo3OoILaUk6Ag0CNYIefIIragQFgSSCN4Q9XC8DAwMDgymFUoIRgV0DA?=
 =?us-ascii?q?xEFDwGDH3ccg31/gjCCOh1AAgELbT03CQsbBj2hbjqEOgcBgQ0wHS5gZQuBL?=
 =?us-ascii?q?wGRaoNRSY40oQkGhB+Eb5xeBg8EL5dZkn2IMJBNmjiJQgGFDAIEAgQFAheBf?=
 =?us-ascii?q?SSBXDMaI4FugUlPAxcCD446zEA2NTwCBwEKAQEDCY9oNC6BHQEB?=
IronPort-PHdr: A9a23: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
 VFtKzrFAblWiuk4HV0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8tYYeKCtOdeSt6DlHemT55DYdb4zR+YMi2TC1yhKJyC9Ffbo7v
 xG/c5rsyMc5wxhOk3I9erhBEDEewK6yXcX2/h0AV7BZniEhILAFugLhuGO/9SjIUzDH4VmuZ
 uIHZIQNDS9NykesS6sizPIaOrIl+P3iJyVuQ==
X-Talos-CUID: 9a23:1KizKWyDSFxsUqjki6PDBgUZENhidn/l/EuAIneBDltGdJOvFnOPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3ANyswug2jS1J59Vmm1dbHaHXJXDUj25inFhAsy6w?=
 =?us-ascii?q?6uuaIMiN6IgWxrj2ce9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110507032"
X-MGA-submission: =?us-ascii?q?MDGQeccZdaXbozDZ/KxTyG01uyVZD5Zy4zbnqy?=
 =?us-ascii?q?bGfMeCJgxrfX0gzJxBEOoTbgG+RRM5URUjlRCbgjVLgkHmMLtpqjUCKE?=
 =?us-ascii?q?whXyXiw/72lTpKX6mcvooXpZBlrGyqU97myXrl3hAj7wl5nMTKOlxx2w?=
 =?us-ascii?q?3JoqfGvjsbd+NnoSSpsf0TMw=3D=3D?=
Received: from szxga02-in.huawei.com ([45.249.212.188])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 14:49:25 +0100
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z60St47YKzCs7q;
	Mon,  3 Mar 2025 21:45:50 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 77DF11401F0;
	Mon,  3 Mar 2025 21:49:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Mar 2025 21:49:18 +0800
To: <cgzones@googlemail.com>
CC: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<cocci@inria.fr>, Richard Weinberger <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-5-cgoettsche@seltendoof.de>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a9257803-c5cd-bb83-21b6-a8b152c943e6@huawei.com>
Date: Mon, 3 Mar 2025 21:49:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20250302160657.127253-5-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 06/11] ubifs: reorder capability check last
Reply-To: Zhihao Cheng <chengzhihao1@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 2513
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/a9257803-c5cd-bb83-21b6-a8b152c943e6%40huawei.com>

在 2025/3/3 0:06, Christian Göttsche 写道:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>    1. A denial message is generated, even in case the operation was an
>       unprivileged one and thus the syscall succeeded, creating noise.
>    2. To avoid the noise from 1. the policy writer adds a rule to ignore
>       those denial messages, hiding future syscalls, where the task
>       performs an actual privileged operation, leading to hidden limited
>       functionality of that task.
>    3. To avoid the noise from 1. the policy writer adds a rule to permit
>       the task the requested capability, while it does not need it,
>       violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Richard Weinberger <richard@nod.at>
> ---
> v2: split into two patches for each subsystem
> ---
>   fs/ubifs/budget.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
> index d76eb7b39f56..6137aeadec3f 100644
> --- a/fs/ubifs/budget.c
> +++ b/fs/ubifs/budget.c
> @@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
>    */
>   static int can_use_rp(struct ubifs_info *c)
>   {
> -	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
> -	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
> +	if (uid_eq(current_fsuid(), c->rp_uid) ||
> +	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
> +	    capable(CAP_SYS_RESOURCE))
>   		return 1;
>   	return 0;
>   }
> 

