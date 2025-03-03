Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE3C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=stP5+xrKjHBJbbAz3A7R4Tv62A0m//9hc45qhhNuXnA=;
  b=dQP57ieCURmDQelIg+hmFHuNAQyTBNPSyTSD6WY0cB7UUmt179zXV0zZ
   tOauGpRSMhVXv0jsxn6AJPgAsqtL7oqltCJ8/234wZTBgIq3UMoDnHx1s
   mvOeRqc3ViHgO8XS5OCoP/zqqOqn8c7DPrCIyu5R5gEBBNvXWE0nDtIbl
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070153"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA78CE12AE; Tue,  4 Mar 2025 10:58:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ABE86E0261
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 20:04:32 +0100 (CET)
IronPort-SDR: 67c5fd3f_KzqMKTL8Y7v0IVfWiW5uElEHxJVEEJ6L65jApqEdSYn/93d
 SiffWknBwgpSGvftNp0BHOiEWXwjgFz2TIEjVTg==
X-IPAS-Result: =?us-ascii?q?A0EBAADl+8Vnj9lUsotaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUADAQEBAQELAYJDfVozBAtIjVKGU4IhA5FHgQWLS?=
 =?us-ascii?q?IF+DwEDAQ00EAQBAQMEhQACixUCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CDX0BAQEBA0ABATcBDwsVAy5WGYMCAYIwAzEDEa5VeIE0gQGCDAEBBoFbD?=
 =?us-ascii?q?9k9DWyBZQMGgUgBhWuCYwGFUhkbg2J6JxuCDYQ/PoIfJAcXBBiBHSlNg0iCL?=
 =?us-ascii?q?4J4gSQBgz2aBY5TUnscA1ksAUsKExcLBwU5KEhIA4EPI4EjBTQKNzqCC2lJO?=
 =?us-ascii?q?gINAjWCCxNdH4IrgheCN4Q9XC8DAwMDghmBEIFjg2+CEYFdAwMRBQ8Bgx93H?=
 =?us-ascii?q?IN9f4IwgjodQAMLbT03FBsGoioBOoQ6BwGBDSwEHS5gZQuTGrNXhCWBY4o1l?=
 =?us-ascii?q?TBNE4E4lXqTEYgwkE2OBZV1AYU2gWgBOIFcfQiDIk8DGQ+OIRmIdMMgQTUCA?=
 =?us-ascii?q?QgxAgcBCgEBAwmPaDSBSwEB?=
IronPort-PHdr: A9a23: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
 NvCjqT+LHFF6d2GpaMh
IronPort-Data: A9a23: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
 RvKeodG34xaNrH/d0fkVxLFTJKY0c62I/U=
IronPort-HdrOrdr: A9a23:znNxyq/VRvEuxOi4r3huk+AgI+orL9Y04lQ7vn2ZKCYlCfBx9a
 iV8MjzsCWatN9/YgBCpTntAtjjfZqYz+8T3WBzB8bbYOCFghrNEGgK1+KLqFeMek3DH6xmpM
 FdmsNFeaTN5C1B/LjHCX6DYqkdKbe8gcWVrNab52txTA1sdqFr5xp0B0KmCEFsLTM2eabRbK
 Dsm/av8ADQA0g/X4CDIkhAZfHKo7Tw5ePbiME9aSIa1A==
X-Talos-CUID: =?us-ascii?q?9a23=3Ag0qbUWuZ0gxt/+qIeG3J91FC6IsEbmP61VPteXO?=
 =?us-ascii?q?XKno0QeW0bVKZ//Ndxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AE7O4Jg3vqOLU2MveYJQirAs3YjUj6Z71DHlclqo?=
 =?us-ascii?q?8tea4PBdCfGzNgTfqXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="110541338"
X-MGA-submission: =?us-ascii?q?MDEUj5PoCc5cLMv9WM45KcId+2f36UKBwKIvuI?=
 =?us-ascii?q?oCCgTbU9ONRssLcvRjvEoNkQn2/MHaPmL3z1azzmJRaM93XkcQ26uGx5?=
 =?us-ascii?q?zdHLngYyXBTsvJ7tfQ/ES057EhwE3pxDzM9j7tk5d3O5azSskF4c6HcF?=
 =?us-ascii?q?9rGJ0eULVItna01uN4h86B1w=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 20:04:31 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 68F6A5C10D9;
	Mon,  3 Mar 2025 19:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB9C4CED6;
	Mon,  3 Mar 2025 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741028667;
	bh=8LWjj1yF/l6+Nko2dcGTFSkEZL9I6BsHVDOlJmSVy6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLTA0aWp1PJmysQcPGb5IH62IBT2mqNCpy9v7Q6+ovo7Om05FhNhhV5tOiCWgcNO0
	 xnXU26aMFijSyIycRCyObC4e+iygvPKnKOilWuErIxU3FkgBdGwonbgm0axassVAD4
	 RIKFLYITJzwZK2Wbh+PMGVLjj4iEQfU9w7GYpsJlwZGQ4E/5Ad9nSGlPJj1FgiB2Ci
	 XqGROHu/cjf+8jQlWKOTS3Bu2e4+gcTD6YgIB5gAfgy90PapQrXMf19IJYxHiYiit/
	 SiBGymKYizRwkxEaFz55Shw0tcwg5Qdr57PDjmzmfDZs0DcYISb9gcES1esOYH6Zyo
	 XSjrTaopHlWbw==
Date: Mon, 3 Mar 2025 21:04:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, cocci@inria.fr,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Message-ID: <20250303190424.GB1955273@unreal>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-10-cgoettsche@seltendoof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250302160657.127253-10-cgoettsche@seltendoof.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 11/11] infiniband: reorder capability check
 last
Reply-To: Leon Romanovsky <leon@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2515
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250303190424.GB1955273%40unreal>

On Sun, Mar 02, 2025 at 05:06:47PM +0100, Christian G=F6ttsche wrote:
> From: Christian G=F6ttsche <cgzones@googlemail.com>
>=20
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
>=20
> Signed-off-by: Christian G=F6ttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Thanks, applied.
https://web.git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=
=3Dwip/leon-for-next&id=3D3745242ad1e1c07d5990b33764529eb13565db44
