Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC54C282D3
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/+VnKz8ybmTvAjS33j2JgQnp2M6sjauaN0fdTPBPUC0=;
  b=VizWfuAefRsy/VMDwM1t0Q3h/zl1qKZMj5K68vWJ4Dyph+5tbReLELHY
   tPhUNYqGj34AfKCZ6BUib944xxKiLFHQGu0PT69vU7NOxubAoueM+MohE
   n6qGC43RpA7OLF/Ix4nVQ3L2TftBMxClbaDHDcRE4xHq3lg5QN8KyaBEz
   M=;
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
   d="scan'208";a="211070160"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00D69E12B4; Tue,  4 Mar 2025 10:58:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EB03DE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 20:41:14 +0100 (CET)
IronPort-SDR: 67c605da_wwE0SbMSaLY/iYHHNZAYFxj2O5YWFgPY1R7czgVYrdbOXGP
 nUxavprRnL9QOqq+9bHM+vEwQxR4cAi0pEOzsUQ==
X-IPAS-Result: =?us-ascii?q?A0EDAAAABcZnclvBS5NaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBAtIhFaIHV+GU4IEHQOFeoV5hnWFU?=
 =?us-ascii?q?IVcgX4PAQMBDUQEAQEDBIIMgnQCixUCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAYEMhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CD?=
 =?us-ascii?q?X0BAQEBAyMPAQ0BATcBDwsUAQMCAiYCAhBGBhOFZwOucXqBMoEBggwBAQbcI?=
 =?us-ascii?q?IFlCYEaLgGITgGJaHonG4E/CkSEPz6IHoJphBwBgz2oWFJ7HANZLAFLCjUMO?=
 =?us-ascii?q?ShISAOBMoEjBTR7gguBMjoCDQKCQHAfhEKCN4Q9gzCBEIFjg2+CEYFdAwMWD?=
 =?us-ascii?q?wGDH3cchHyEah1AA3g9NxQbBqIrOoNOAWsIUignOCaBbBiTDIMzAZA1n1GEJ?=
 =?us-ascii?q?aIog3CNCIY6kxEuh2WQaqkxgWc6gVxNMAiDIk8DGQ+OIYkNwyxCNTwCBwEKA?=
 =?us-ascii?q?QEDCZAcgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5E1DSKidzqtbLuufFWtHpXLVW3BQXt8ji2hC6mlwRA09TyVXra
 GTddAgpHjJYVEqKRcdcLG7Sc29qBbnmKKdjrN8AV7PZmbbUS6TXfhfBOjZsljd8k/Fh41gPM
 5bGsAUYuEYT2IK7/oSizPZLz9P+re6zJw=
X-Talos-CUID: 9a23:2Perz2MdhRdHWO5DYCxc1F4ZOv8ZKlbRlVSLL1+yDltJcejA
X-Talos-MUID: 9a23:/bRWiwuRcyAmdcvQRs2n3wl9K/diuYiVJkEdurAfhpXUcgtCNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="110543038"
X-MGA-submission: =?us-ascii?q?MDEIbtvhxC0YCyWkcRXLdAZDtQAF5R6NJHxpfU?=
 =?us-ascii?q?azWS6gW6ECp5IrlHE6pL0Ha0pQPvDHfFIfX80AGSzyCMJFrgXroc0kPz?=
 =?us-ascii?q?Q5jO5RdtRdu6v4ePNAHqIsy7SwrsvFLGdIXAOxe1yqDMxG/umEpaBM9E?=
 =?us-ascii?q?DHJXKSX7X4MAE0BTkETxTwvw=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 20:41:13 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4D96BA44F88;
	Mon,  3 Mar 2025 19:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B8C4CED6;
	Mon,  3 Mar 2025 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741030871;
	bh=KZ7XHt3siA+yNszSiXHA6b2kocbImvk02r3QUZ/DZZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4R/4wfqdlrIGvmcugqLfadqwrTOGhj7dTagqcKlM/tk0jdSaoHVHBi5NoHg/J+y6
	 2KFr/inmJ3UqWjEeYw+YYmQRr5G59RaZxbjV2H+TQrTVVL4RnjU1vYJyneFxFuSbcW
	 wc7nBI7LXcCvC6j708R2cjA6L7Dj/r1YRsS4Z+v9hJ0CvbBRDla/G6qWowhMfVCmMY
	 cvnl/DVYxMqxHe8biHWokNOEAx/gE2dN5chjNK17bYd0WzE0l6IJx8W6X+1Vy3Uk7K
	 o8hM7ZcIqrjiedyi2XMAWIZxlGo+TG4NubYoUedcd26BrriSqAucab1v6bmVXMl1bb
	 NV0ZC/Fnj+zgg==
Date: Mon, 3 Mar 2025 20:41:06 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Simona Vetter <simona@ffwll.ch>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <Z8YF0kkYLlh1m5ys@pollux>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
 <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] drm/nouveau: Add a jump label in
 nouveau_gem_ioctl_pushbuf()
Reply-To: Danilo Krummrich <dakr@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2517
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/Z8YF0kkYLlh1m5ys%40pollux>

On Mon, Mar 03, 2025 at 06:49:07PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 5 Apr 2023 18:38:54 +0200
> 
> The label “out_prevalid” was used to jump to another pointer check
> despite of the detail in the implementation of the function
> “nouveau_gem_ioctl_pushbuf” that it was determined already in one case
> that the corresponding variable contained an error pointer
> because of a failed call of the function “u_memcpya”.
> 
> Thus use an additional label.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 2be65641642e ("drm/nouveau: fix relocations applying logic and a double-free")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I'm not entirely sure, but I remember that we had this discussion already.

Can you please send patches from the same address as indicated by your SoB?
