Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C264C369DE
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:message-id:from:to:cc:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zWQLTGeMYrZVbdSVN7iT+V9f/EG/lT2izX+x1EmBqjA=;
  b=cVBeXWsXSWtmXfsG60IfmjkGrfpWYSQCkosFUvQE/6trGxfIcHsOfDyk
   ThmIVlPjAa4AUuv4GrGuImN2GLN9sc9514Af1I1ioUhmQTGQ/v0sUyhRW
   H63biPl897EjvgsZ2fRBhHwbxiM4ggqDRYod+zJLiP659neHdHtr2Kz3I
   U=;
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
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219056100"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FE73E0D70; Wed, 23 Apr 2025 10:51:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BF811E007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 13:11:01 +0200 (CEST)
IronPort-SDR: 6800e1c5_e7k1AOI0R4eRGNeP6gYdHfuyvpxpcpBBvbTtV7NTE5wdW71
 MeJnLzjtEOzDwt8X3iUe62jfBNAh3NqaM7/BpLw==
X-IPAS-Result: =?us-ascii?q?A0G+AQD84ABoj/4EaaxaHgEBCxIMQIFICwKCQoFYMgQLS?=
 =?us-ascii?q?I1QhlWCJDCLQ5IfgX4PAQMBDUQEAQEDBIUAAosrAh4HAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYV7DUkBEAGCBwGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINfgEBAQM6BgEBNwEPCw4EBi4QOA4GE4MCgmUDB?=
 =?us-ascii?q?LMTgTSBAYIMAQEGgmnZN4FlCYFJiFABhWyDfXonG4FJRIQ/PosHgjGBAxShV?=
 =?us-ascii?q?VJ7HANZLAFVExcLBwVhSEMDgQ8jTgUwHYF6g3KFNoIRgVwDAyIBgxV1HIRsh?=
 =?us-ascii?q?FQtT4MzggYdQAMLbT03FBsGmHOFJ4J7ljoBsAyEJaFjM5dGkxEumFCjVg2FU?=
 =?us-ascii?q?oFuAzCBXDMaCCgIgyJPAxkPjiEZiHTBRUM0PAIHCwEBAwmLIIRKLQWBSwEB?=
IronPort-PHdr: A9a23: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
 cLAxvqbFQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:oL68Ua+PqJBe8avgG4puk+BDI+orL9Y04lQ7vn2ZKCYlEfBw8v
 rEoB12726QtN9hYhEdcLm7UcHvfZryz/9ICOIqTNWftWfdyQ+VxMkL1+Hf6gylPyX/8+BA0u
 Nbf69yCNr/SXhiyf/95gzQKbod6ejC1KipgOnDyDNWQQZma6ZvqydhTj+cFEgzYwFDCfMCea
 Z1rKJ8yAZJNx8sH6OGL3MCWPXOoMCOlJ+OW29hO/Nv0nj2sdvrhYSKaSRxHH8lIkty6Kwv/m
 Tfnwvy6r/LiYDB9iPh
X-Talos-CUID: 9a23:OXrzlW1YWfadFKGjjObHOrxfJ+wvUSPxy1TrHmy+N1hLZpDWTwSB5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AFBk0dAw8vNoN8TCYtPL7pHnX9XiaqOPxWHwzs4c?=
 =?us-ascii?q?9gtO/bXVzOQuUlii5GpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="218299123"
X-MGA-submission: =?us-ascii?q?MDFgXj4q8vKSwCtTnLmWsB/EhYvUgnerkQGi8i?=
 =?us-ascii?q?V5GemgqymAIXXo9hcYmhgrcoNJnElHor2el7hPZp8VN4CshKcNM7Q1tA?=
 =?us-ascii?q?kzXA2VIcsZh/lhftmwcM4rFvNykbXqyAhZnwBW82biZyfqPy05sZ7XUy?=
 =?us-ascii?q?Hqj26xabmuXvEKTGjakR1xWw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 13:11:00 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6BBCC60010;
	Thu, 17 Apr 2025 11:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB080C4CEE7;
	Thu, 17 Apr 2025 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888258;
	bh=fEBqhxlmx82BtM/AlDZZ5wzx7wCNw1G9R+pxLG8DyL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zwe8MN7gY9/fyNSI6M4egF4DqTK6cOa74cIgePtVm5SxlHrH+BFGILB3SU+THyiY4
	 Y5zhBRJoX5lB6AJEvE2UyTUvrVAQQWJQpG5QB+/oxiv85AL6oeI7Ef3KZAX6LHi03p
	 3UcOsaKtnGf6MlDb9qqcOJYbWNLKJYBOa6HGAuh149UD5wQrwIa7APBHfo57SolIPz
	 iuEmJavhra38nemTtJ9MJyy41GvkjLD3zSJpPTiuWJA+/HCIrte5XzncA7QeFyTe12
	 /LfO983iZHYkOPkerszOlBINL8FzDe75AdGD155w/tvxk8A1h12DUOJiYNKqGYoXsm
	 S648FervPhCuA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u5N8y-006ONV-Cd;
	Thu, 17 Apr 2025 12:10:56 +0100
Date: Thu, 17 Apr 2025 12:10:54 +0100
Message-ID: <86sem7jb5t.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Nicolas\
 Palix" <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton
	<oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose
	<suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	<linux-kernel@vger.kernel.org>,
	<cocci@inria.fr>,
	<linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>,
	<andrew@lunn.ch>,
	<quic_kkumarcs@quicinc.com>,
	<quic_linchen@quicinc.com>,
	<quic_leiwei@quicinc.com>,
	<quic_suruchia@quicinc.com>,
	<quic_pavir@quicinc.com>
In-Reply-To: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: quic_luoj@quicinc.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, Julia.Lawall@inria.fr, nicolas.palix@imag.fr, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, cocci@inria.fr, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, andrew@lunn.ch, quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Marc Zyngier <maz@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2696
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/86sem7jb5t.wl-maz%40kernel.org>

On Thu, 17 Apr 2025 11:47:07 +0100,
Luo Jie <quic_luoj@quicinc.com> wrote:
> 
> Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
> macros. It is functionally similar as xxx_replace_bits(), but adds
> the compile time checking to catch incorrect parameter type errors.
> 
> This series also converts the four instances of opencoded FIELD_MODIFY()
> that are found in the core kernel files, to instead use the new
> FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
> the script field_modify.cocci.
> 
> The changes are validated on IPQ9574 SoC which uses ARM64 architecture.

We already have the *_replace_bits() functions (see
include/linux/bitfield.h).

Why do we need extra helpers?

	M.

-- 
Without deviation from the norm, progress is not possible.
