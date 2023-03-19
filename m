Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82097C7618A
	for <cocci@archiver.kernel.org>; Sun, 19 Mar 2023 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3cgerpuYmbmj2qEFI3rZFuYAFR5u8Db+sHrMfSqWTLo=;
  b=H86uTFUKk61zfG1t2lKWNZ5Y7WeQdBFyCm2RxKZlOQrIVqGSksTBOMfR
   IXsFIwkHFQPQD8cJIkW+gba3+yTuGIlWB52HSGeDCWQj4zYR/YGpI+UbB
   k96Z/rrGAcEtRuivnIJNmenvNdcn1Mw9OFHM0FEFz853A5lgEwPrSN/4A
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="97937017"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2023 12:48:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1641CE0C9A; Sun, 19 Mar 2023 12:48:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E451E0A9B
	for <cocci@sympa.inria.fr>; Sun, 19 Mar 2023 12:41:39 +0100 (CET)
IronPort-SDR: 6416f4f2_Eg33rp9nDA/HzpWA8dMEdmOxdNHyelpCzpmE98lBYuZ2X9Y
 f8afzhkSE6KNHHtgBZ9+xGh2ATO/b3wnginCu1Q==
X-IPAS-Result: =?us-ascii?q?A0EDAADmzhZkkNlUsotaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgTsEAQEBAQELAYItgUsvBAtGhFOIH1+GDIIlA5IZh?=
 =?us-ascii?q?WOFWIF+DwEDAQ1EBAEBAwSCC4JzAoU1Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAEBAhABAQEBAQEXCR4QDgUihWgNgjcpAXWBCAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEWAg1SeAECAyMPAQ0BATcBDwkCFAQCAiYCAlcGE?=
 =?us-ascii?q?4J+gl0DA5cdnBeBMoEBgggBAQadSoFeCYEULAGQOXonG4INgRWDKj6IHDmCL?=
 =?us-ascii?q?oIrh12GZYgjCoE0dYEgDoE9gQQCCQIRa4ESCGeBfUECDWULDnaBSwKBWzcDR?=
 =?us-ascii?q?B1AAws7Oj81FCEGWIEZJAUDCxUqRwQIOQYcNBECCA8SDwYmQw5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNPgUcEL4FaCgYBJiSdDQFSKBNMJoF3DZJYEYMTjxyeQoQEgVmfE0wTg?=
 =?us-ascii?q?TOVQpI3LoctilKFPagagWI6gVx9CIMiTwMZD44gGYhtimc/NDsCBwEKAQEDC?=
 =?us-ascii?q?YtDAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:DJ57p6MKPW6AysBcTsSjsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 eV7ZImPH7P+VIssRQb9OxoV5PtfZqxz/FICMwqTM6ftWrdyQ6VxeNZnOjfKlTbckWUnNK1l5
 0QEZSWY+eRMbEVt6jH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="97936769"
X-MGA-submission: =?us-ascii?q?MDEt+ntDo2u1u9hUJmqU35GcYjzQJWIITF7NhZ?=
 =?us-ascii?q?E0QUI8XW9Fp6WGt4EmBoyWDstNrnYAA7A9mIrMX/aIl9GV+xSpBtLlsR?=
 =?us-ascii?q?RTwnnPDW9QcWz4TkbLLSX6MNmLNMkR17TiUuK7Nku6vNqeOS9AVNu5ID?=
 =?us-ascii?q?UDtryToNXQnb7Em+dQV6hsBw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 12:41:38 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE1160FCC;
	Sun, 19 Mar 2023 11:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF5FC433D2;
	Sun, 19 Mar 2023 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679226095;
	bh=ExZwx8jh/Z19yiEgpkbK+BLckhnmEjECfuwpp5U7nW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ha8+NoV5KMotFaVzeYbTTD0suS9RQhwThazW8291t+hgww4f0xcPfrj9jgFcFOf5v
	 2L7C2u1/bVqlT97R7EHX1ke2bQkA/gTuxbaw9ce9AMWEqb7cnohczlyJ9GrZIRXfqP
	 pyJxs2ofUrBoG9XjYnSAyZVvXK943irTuZlpKGoo64viKasN/0aCS+nzz3vFaOpGfk
	 oZIiFfawDpAoHNBPf9TodIQg9XuxGEkHu+KGPT1CXtbVE1oW4f8dq3WzoPfMrwDjQ4
	 H3U/+90PtAdU/D0gMVkRZkIGrnSXUmqwWXP9bbV2CoA8VqUQYGfQNrM8OwXUYZM42u
	 6C20zTKGgbUrw==
Date: Sun, 19 Mar 2023 13:41:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Yang Li <yang.lee@linux.alibaba.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <20230319114131.GC36557@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] RDMA/erdma: Fix exception handling in
 erdma_accept_newconn()
Reply-To: Leon Romanovsky <leon@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 897
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230319114131.GC36557%40unreal>

On Sat, Mar 18, 2023 at 09:15:58PM +0100, Markus Elfring wrote:
> Date: Sat, 18 Mar 2023 21:08:58 +0100
> 
> The label “error” was used to jump to another pointer check despite of
> the detail in the implementation of the function “erdma_accept_newconn”
> that it was determined already that corresponding variables contained
> still null pointers.
> 
> 1. Thus return directly if
>    * the cep state is not the value “ERDMA_EPSTATE_LISTENING”
>      or
>    * a call of the function “erdma_cep_alloc” failed.
> 
> 2. Use more appropriate labels instead.
> 
> 3. Delete two questionable checks.
> 
> 4. Omit extra initialisations (for the variables “new_cep”, “new_s” and “ret”)
>    which became unnecessary with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 920d93eac8b97778fef48f34f10e58ddf870fc2a ("RDMA/erdma: Add connection management (CM) support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/infiniband/hw/erdma/erdma_cm.c | 39 +++++++++++---------------
>  1 file changed, 17 insertions(+), 22 deletions(-)

Same comment as for your RDMA/siw patch.

Thanks
