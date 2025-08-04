Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECA5C87FD1
	for <cocci@archiver.kernel.org>; Tue,  5 Aug 2025 06:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=n7lwJAJ9kw0y3Xb4IsdxiGSwyJ242iA54ADzG+aMcZQ=;
  b=EPwco63MEQwfFFhhSeTn4Bq1E3iv+DUHe12/BjW7vZDdkfuksQA5RwmC
   BwOR7Iz1qs4dTwWddJnSa4bIbAYmo05Dke5Wgckr+LFUFlof8tGT0t3YL
   +sUV9tBb2lntgZtiQqyJKRj7mQmUqFb11gN51d5Z6My/yeAY5RrjBUn0Q
   4=;
X-CSE-ConnectionGUID: KBkRA4a4QJii8MbLNMxq0g==
X-CSE-MsgGUID: pGOAcc3nRBOtCgzrI7KbLQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.17,265,1747692000"; 
   d="scan'208";a="234183440"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2025 08:04:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED875E0CDA; Tue,  5 Aug 2025 08:04:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EDA73E0171
	for <cocci@sympa.inria.fr>; Tue,  5 Aug 2025 01:48:01 +0200 (CEST)
X-CSE-ConnectionGUID: qIm0/58aQ/anZGotbFntOA==
X-CSE-MsgGUID: vcPhFteJQh2HKMaJAUyxRg==
IronPort-SDR: 689146b1_KPAWGp8I7gKfOWxXIDjgWqdFjZaIviMYBp+hAbW3OXyU8c+
 Tuo6fDa2lEGec4Rt0yy3+v8NaeFkGXj1G64ELKA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E/AADgRZFohf4EaaxaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YI/gVozBAtJjVCGVVsBAQaBPgOLdJImgX0CDwEDAQ1RBAEBAwSFAAKMHQIeB?=
 =?us-ascii?q?wEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQ?=
 =?us-ascii?q?EmGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQM6BgEBNwEPCxguVgaDF?=
 =?us-ascii?q?YIiB0YDthiBNIEBggwBAQaCaNsgCYFJAYhQAYVsg316Jxt9gRCEPz6EWIYNI?=
 =?us-ascii?q?oImgRaEGYIzihyId1J4HANZLAFVExcLBwVbRUMDgQ8jSwUtHYEnfYQbhCgrT?=
 =?us-ascii?q?4IidYF5Wj+DUxENBm0PBoEVGh4tAgICBQJDRYFgGQYoQAMLbT03FBsGlBmDJ?=
 =?us-ascii?q?3UQCy+BAUCTeJF4a6EOhCaEcJxnGjOXUpMZhTyTSqlBgW4BM4FcTTAIgyJPA?=
 =?us-ascii?q?xkPjiEZJYhVth0jNTwCBwsBAQMJlTSBSwEB?=
IronPort-PHdr: A9a23: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
 nbeZSN9bP4r+TOq5E04dAOimQ==
IronPort-Data: A9a23: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
 SufelZhKFx6FpDeVWXFdj7pbWJJ5Sq3I/WH
IronPort-HdrOrdr: A9a23:r1beqKmHNKemxOgMOeCe5F1ts+zpDfIj3DAbv31ZSRFFG/FwWf
 rOoB19726TtN9xYgBGpTnkAsS9qBznmaKdjbN/AV7mZniFhILKFvAH0WKB+UyCJ8SWzIc0vs
 1dmupFebjN5DNB7foSjjPXL+od
X-Talos-CUID: 9a23:4qH+S2yN1ZSpIp0JgwV0BgUNO8V9NSCNxU6XKkmKJmF1QpOTVXi5rfY=
X-Talos-MUID: 9a23:eGviSQppf1bHPxp3b6Uezy9pDMdG/6mMMUBXsbYjsuutCD1gATjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,265,1747692000"; 
   d="scan'208";a="122775016"
X-MGA-submission: =?us-ascii?q?MDGPViH4kGx2J0X4Nln+CLVEGXdHsNTm+T49XQ?=
 =?us-ascii?q?a+KAxNaHh7TfvgP8c7fYprsnM67t/7CuJRaBMR0VVth0Z69ouLzSDdvD?=
 =?us-ascii?q?Z9i9MQ3/dAHAy9AQjKHMSFevOWiZtBR67eEXkvnwuHjlrvIrVimN1g8D?=
 =?us-ascii?q?ft2eQ2/6LkXpkRG3fGHmLCKA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 01:48:01 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 942D460008;
	Mon,  4 Aug 2025 23:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D405BC4CEE7;
	Mon,  4 Aug 2025 23:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754351278;
	bh=wtgfgxNKbSjeU4JJ4SgTax2gvcfSRWNdBDOwIEm8CT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxBD8B8CPxHAZuIn992mtRh2/lJF9nTy4L2J17ezRvqzIhhHkjJpGSv9D0OkldmlB
	 O9c8Qix94ixaJPpoRCzZLwD/b6xEnwmThymBL+tpPRaNwBJvVD9n2UAYUqVrtBhJgI
	 BhYDlQ1pncaMiCJea4FSwdl+ctAP240hXkOkWiwWsiBA2ujIJj0l2YFkzgywv6hHKu
	 P1Gw1tnUxxq3JybsgGId/Zlg/YqE6uOxpLjSLG951DP0mw7oIB3wVnFWpmGnsLjDg5
	 wyRHvRSB5bKYYOdPiVF9WDCSvRwLIJfvKFI8ATFB/KCx7QGlhHB3IwHbGz5vQL0GL/
	 asIWS5ap1b7Lg==
Date: Mon, 4 Aug 2025 16:47:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <20250804164757.6a5c39f2@kernel.org>
In-Reply-To: <74e230ef-1e9c-94fb-6dbe-5f4d24add50@inria.fr>
References: <20250723080322.3047826-1-danishanwar@ti.com>
	<20250723080322.3047826-2-danishanwar@ti.com>
	<20250723064901.0b7ec997@kernel.org>
	<74e230ef-1e9c-94fb-6dbe-5f4d24add50@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation
 for RPMSG-ETH Driver
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2965
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/20250804164757.6a5c39f2%40kernel.org>

On Mon, 4 Aug 2025 18:45:50 +0200 (CEST) Julia Lawall wrote:
> > EXN: Failure("unexpected paren order") in /home/cocci/testing/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
> >
> > If I replace the brackets with a comma it works:
> >
> >    - Vendors must ensure the magic number matches the value expected by the
> >      Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
> >      source.
> >
> > Could you make that change in the next revision to avoid the problem?
> >
> > Julia, is there an easy way to make coccinelle ignore files which
> > don't end with .c or .h when using --use-patch-diff ?  
> 
> This will be the default shortly.

Perfect, thank you!
