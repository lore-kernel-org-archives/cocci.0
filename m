Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96BCC4828D
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Upz8SJ2P2gdo3qzXc/oXyaEMkG/LDwsZZUrBesbNlzw=;
  b=c4cB8a+KZMB4dyiAsGSihphwUiyFoC/6eJvf1Cg9fQy85gCCFZVxkRBA
   8FThvzMiEh6/rGRq/CrKdgTxobEILQfDnvuMSP4QbRxSyy/bIgfhdqF7a
   ot0JDVBKVvMLKdDRotbgHYr0Q77PSb7G01KpZhlrr8JZZ+Y23f4bbs0l5
   w=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150584075"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 16:16:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED7EBE0CD8; Tue,  6 Feb 2024 16:16:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A7887E008A
	for <cocci@sympa.inria.fr>; Tue,  6 Feb 2024 16:14:48 +0100 (CET)
IronPort-SDR: 65c24ce8_uOFp4+rnkD7Mdq9It3vcPrWt7Qaj8HA4qi+37w+tdz/Ro/2
 R5bd87o3svl8rfx5LIvMU3boljamdQ4Xb0g0WwA==
X-IPAS-Result: =?us-ascii?q?A0FmBwCXS8JlkNlUsotaHQEBAQEJARIBBQUBQIFPgjmBU?=
 =?us-ascii?q?jIEC0iNT4ZJXAEGgUKLb4dMjEkPAQMBDUQEAQEDBIR/AodXAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBIB4QDieFbA2CX?=
 =?us-ascii?q?AGBHIEeAQEBAQEBAQEBAQEBHQINfAECAzoGAQE3AQ8LGC5WBoMTgmADt3mBN?=
 =?us-ascii?q?IEBggoBAQaCZbAZCYFIiCYBiS96Jxt9gRCEPz6EGz2GLoVViWeMWFR/HQOBB?=
 =?us-ascii?q?gRcDRsQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FE0IDQAZJCwMCGgUDAwSBM?=
 =?us-ascii?q?AUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2cfMgk8DwwaAhsbDScjA?=
 =?us-ascii?q?ixAAxEQAhYDHRYENhEJCyYDKgY2AhIMBgYGXSMWCQQlAwgEA1QDIXQRAwQKA?=
 =?us-ascii?q?xQHCwd4gVE4gT4EE0QDEIE0hUGBYQNEHUADC209NRQbBiOfCYEOgTBApQVpo?=
 =?us-ascii?q?GGEG4RqnDUaM4NyAZM6knKYVqh0gXojgVxNMAiDIk8DGQ+OIBmIdYsGIjU7A?=
 =?us-ascii?q?gcLAQEDCYhvM4FGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HhPn4KrLJloW0hlRwkPDkokaV5okeYIsimQD101hICG9vPb4qy
 nIpoV86faUskd3ZJhEo7290ca7LU80maQb3WBVB8bBYOCEghrNEGgB1/qA/9SIIUSXnYRgPO
 VbAs1D4bbLbWSS4/yV3DWF
X-Talos-CUID: 9a23:9o4rWm1e2flbBPXM7LPsWrxfMJgLL0eM0mzqG1acMWZuU4G5FE+29/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A9UaxqA6c9nC2WcxnXcEkJTP4xowxzL6UV19WnK4?=
 =?us-ascii?q?EhPa8CQhbGhKPqSiOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150583827"
X-MGA-submission: =?us-ascii?q?MDHZRvs8uYDSZv9+mBwxasAHp16jxhLG9sbd22?=
 =?us-ascii?q?mCfF+b2oluSODlRdblhKYEpe6E9TKs/kWLJwsp1bAY3kJh1p37qBEWsi?=
 =?us-ascii?q?brImKgRyqRPhFYk93YC1nTLTx8bCyPoa59Frf1OM9eleZ+zDElX+jDFs?=
 =?us-ascii?q?Ga8oXR/uGubtl6wTg8xp3l0A=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 16:14:48 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 00C5C61575;
	Tue,  6 Feb 2024 15:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E99C433C7;
	Tue,  6 Feb 2024 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232486;
	bh=NeEKf1Ch2NEbF1alUQ+hd6kv6Jmax3DqZnxwsqTWR2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lkubwGQScTE23dydAl+Mv2KOLfvEMAZjHZr1u9gktq2Q6m7gCRefd1+Nh9eYg7L3y
	 1yOeZseJNHv1L15AdhnJQVn7tlh/YGG+I4hRcddLPz68EfkUdAaDNaEqSSl9vumElL
	 KW8FpUyVCFzhJn9sbid4QY796ldJASOFF0SubhAjIwM+le3yS/LevCYsTe1BMH17q6
	 2xkEkvrPZtAgtdXOcroWSNABTtAhcSfnFOosk3vvxO+kuv2ufjJgsNpnU7FzvECWbx
	 kB9HW5x+32c84jQUHIzoEznB1qEOfFgkYRNt9sd3QiGXUXt4Zh9X16YsCIxwGsHvBj
	 TMmkHd+8B0gTg==
Date: Tue, 6 Feb 2024 07:14:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240206071445.301a0792@kernel.org>
In-Reply-To: <4524b4f-f0b9-3889-a665-5feaccde3778@inria.fr>
References: <20240205095637.54f3f450@kernel.org>
	<4524b4f-f0b9-3889-a665-5feaccde3778@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch --use-patch-diff broken?
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1507
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/20240206071445.301a0792%40kernel.org>

On Tue, 6 Feb 2024 14:58:43 +0100 (CET) Julia Lawall wrote:
> > I've been trying to run coccicheck with --use-patch-diff
> > to try to limit the number of processed files. I _think_
> > it worked when I set it up early last month but recently
> > I went back to check and make coccicheck stops after
> > the first spatch call, all it prints is "hd"  
> 
> The problem should be fixed in the github version.

Thank you! I pulled & rebuilt and it works now! :)
