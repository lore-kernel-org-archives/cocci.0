Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720DBC76195
	for <cocci@archiver.kernel.org>; Sun, 19 Mar 2023 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=atOcwWXw5/24+xuNsffRXE9kkIWsCZr7nYT26/HuvDg=;
  b=PLDsPf0PvTdvYM0CPhvM2DlDTkT0OnNORjn+8IJous5gEPfdlyYYUbI/
   e69+Z/6U0z+HnqVKoImBC/fvykdzddhYs5uXVDJ5oE8e/Dqx1rPAX1BUr
   ew062FKEge6JmArrIE8ooiiY0EX+2gA7AfCX7Bd0Q6qzjO6c0Fjj86CNx
   s=;
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
   d="scan'208";a="97936992"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2023 12:48:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CACA9E0A9B; Sun, 19 Mar 2023 12:48:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D30EFE0A9B
	for <cocci@sympa.inria.fr>; Sun, 19 Mar 2023 12:40:55 +0100 (CET)
IronPort-SDR: 6416f4c7_IkbYZCn3/8FrR7oTTYrlAHZ0n/688jr8WRakXOjMvrHcSxf
 8Cg2e65tjEkY1F2MaOyMP6swLf5SCVe/nb/+n3A==
X-IPAS-Result: =?us-ascii?q?A0EkAADmzhZkkEtEKJFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH1+GDIIlA5IZhWOFWIF+DwEDAQ1EBAEBAwSCC?=
 =?us-ascii?q?4JzAoU1Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEBAQEXCR4QDgUihWgNgjcpAXWBCAEBAQEBAQEBAQEBAQEBAQEBAQEWA?=
 =?us-ascii?q?g1SeAECAyMPAQ0BATcBDwsUBAICJgICVwYTgn6CXQYBszOBMoEBgggBAQadS?=
 =?us-ascii?q?oFeCYEULAGQOXonG4INgRWDKj6IHDmCLpBtiCMKgTR1gSAOgT2BBAIJAhFrg?=
 =?us-ascii?q?RIIZ4F9QQINZQsOdoFLAoFbNwNEHUADCzs6PzUUIQZYgRkkBQMLFSpHBAg5B?=
 =?us-ascii?q?hw0EQIIDxIPBiZDDkI3NBMGXAEpCw4RA0+BRwQvgVoKBgEmJJ0NAVIoE0wmg?=
 =?us-ascii?q?Qd9BJJlsHGEBIFZnxNME4EzgjeMZoYlRZFyLoctilKFPagagWI6gVx9CIMiT?=
 =?us-ascii?q?wMZD44gGYhtimc/NDsCBwEKAQEDCYtDAQE?=
IronPort-PHdr: A9a23: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
 XCcCUCxZlxreBHqWgqpPOUKizuUbkU2hQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ubluCq6tzlFux3UBjAPXwPnXdLJyesId70hD6qkXc20wTiX4rb
 HKoB1/73TJYVkqKQkdcK+7Sc69qB/nlaKdy7NhW4tKJTOWwVdAT7sSj7cKoQePJ8SWzIc0v5
 uIGJIeNDSfNykYsS7KizPULz7Sq+PqzEnRv4jj80s=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="50605725"
X-MGA-submission: =?us-ascii?q?MDEqFOzlunlwrYGifn9MW9oTqJZ4kcVAPZlmcO?=
 =?us-ascii?q?Cyvk0vQpD6jRHugL+ZUcsHbs36LSYu42gfhfQedW+r2sJmgwrukVZfxe?=
 =?us-ascii?q?VdyiDs4AS1z39IfpHnF+snq1PRB6at/AJaf3CaTfY4YDftiN30OeuBim?=
 =?us-ascii?q?bRCwUlXmWCLxok9GB0SYa8tA=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 12:40:55 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 241B1B80A6C;
	Sun, 19 Mar 2023 11:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A93C433D2;
	Sun, 19 Mar 2023 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679226052;
	bh=LldkDG7q1fdcJMFLpCO5/nBIKzU9c/xA/fLYRPQZFdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvRQ9wIPHfFR6JB9JCMJ4w97u/hq5jiMubcgODSoRSXQW8WsESnSizCcnxxJJh8Ar
	 qxWLlpXabMLDPXhcsXGpI583MEqcPO48Tcs44apqaJpH/yyA0mM4W6jOIKKAax68MR
	 I6YiWXAwYPqQZ41dq9BIOMtp3+3s1gkz0j6ac8EUQnUbVSn/oQP7jmBTDbnCdiLDid
	 lp65sGiJUmUJz24k8XWsA7tMgOgo84QlJHESuOP+5UVpWeJt1HDfsDg2gLtnn0QbR4
	 PLWnP7LW5kRnFBQeDQwk+grQCZmgEjzXf4gvAuacOBwO0wSNZHvLc/ymnpUozirDu5
	 Co/d4Nj+PJtqg==
Date: Sun, 19 Mar 2023 13:40:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <20230319114048.GB36557@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] RDMA/siw: Fix exception handling in
 siw_accept_newconn()
Reply-To: Leon Romanovsky <leon@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 896
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230319114048.GB36557%40unreal>

On Sat, Mar 18, 2023 at 08:43:04PM +0100, Markus Elfring wrote:
> Date: Sat, 18 Mar 2023 20:30:12 +0100
> 
> The label “error” was used to jump to another pointer check despite of
> the detail in the implementation of the function “siw_accept_newconn”
> that it was determined already that corresponding variables contained
> still null pointers.
> 
> 1. Use more appropriate labels instead.
> 
> 2. Delete two questionable checks.
> 
> 3. Omit extra initialisations (for the variables “new_cep” and “new_s”)
>    which became unnecessary with this refactoring.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 6c52fdc244b5ccc468006fd65a504d4ee33743c7 ("rdma/siw: connection management")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 32 ++++++++++++++----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)

Please read Documentation/process/submitting-patches.rst and resubmit.
Your patch is not valid.

Thanks
