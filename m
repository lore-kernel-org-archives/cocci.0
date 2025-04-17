Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E67C369CB
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:message-id:from:to:cc:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zs/X+FKBXpATF3RR4EHqimFG0PhOPkUkpooJNjtBNYU=;
  b=YeE8lWcLgu1OIcsFazxvCtIfPhJzM25wPrd9uzCaGTNWRnr5vIQ2NDmd
   JrylwhN0+z/iji6HGm8Q7CuNU1KmL9lqKWtSlREuqVJocjHZQJKCfttBn
   SdgKL7cyE1a3lPXwnvbO89Ko8PMS98HC26ZHodhjzU/L0z9TI2SSyWGS7
   0=;
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
   d="scan'208";a="219056154"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0BEBDE0D60; Wed, 23 Apr 2025 10:51:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C486EE007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 13:23:18 +0200 (CEST)
IronPort-SDR: 6800e4a5_Qph8FlSiPQxSTyCPAKE68fsSNWCZfvmwIq3GvwO3NzTjAVb
 kCHTVZn+3MHu7dTqJLhmdRBnkD4PeH4xXypXA5g==
X-IPAS-Result: =?us-ascii?q?A0EWAADc4wBoj9lUsotaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?QGCQn1bMgQLSIxxX4ZVgiQwi0OSH4F+DwEDAQ05CwQBAQMDAYUAAosrAh4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFS?=
 =?us-ascii?q?YV7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQECDX4BAQEDOgYBATcBDwsOCi4QRgYTgwIBgmQDBA2zBYE0g?=
 =?us-ascii?q?QGCDAEBBoJp2TeBZQMGgUkBiE8BhWyDfXonG4FJRIEVgyo+iweCMYEDFIVfi?=
 =?us-ascii?q?AiTcVJ7HANZLAFVExcLBwVhSEMDgQ8jTgUwHYF6g3SFNoIRgVwDAyIBgxV3H?=
 =?us-ascii?q?IRxhFctT4MzggQdQAMLbT03FBsGmHeBaIIwAYEOLJVzgxcBsAyEJYwZlUozl?=
 =?us-ascii?q?0aTEZh+jgabL4FnOoFcMxoIKAiDIk8DGQ+OIRmFH4NVwR1DNAI6AgcLAQEDC?=
 =?us-ascii?q?YsghHyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b4biYdAD6B6F0H/YZcUhu8=
IronPort-HdrOrdr: A9a23:o8r/TqvsTstsCsVKrGLh0P4Q7skDlNV00zEX/kB9WHVpmwKj5q
 OTdZUgpGbJYVMqNU3I9uruBEDtexLhHNtOkOws1NSZLW/bUQmTQr2KhLGKq1aLdxEWtNQtsZ
 uIGJIOauEYY2IbsS+32njeL/8QhOOutIy4heOb5XFrSg1hduVB1m5Ce36mO3wzfiEDKYs4EN
 657spD4xW6f3B/VLXAOlA1G9Lq4/HblJajWhQeGlob7mC1/EiVwY+/KTDd8gYfV3d0y78k9m
 TJ+jaJm5mejw==
X-Talos-CUID: 9a23:kxU3w27PIZ0mp41t59ss/1MpK/kvbEbm1lD1fV6cBExkT4bKRgrF
X-Talos-MUID: 9a23:Xt/1qwowmr8zhCuebY0ezyEyHtVJ2Zq/MUwQg6wX4M+tMjwtJw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,218,1739833200"; 
   d="scan'208";a="114512912"
X-MGA-submission: =?us-ascii?q?MDGTo9AUEpbJCXnW+397Ho9XaCDpJhaGk6NIkq?=
 =?us-ascii?q?okclQKCAkjR42n6nVjsBCGFoWoLEoqlvNJywyOMrKusEBfR/ed1XAXp1?=
 =?us-ascii?q?99XBaNj01tSx4NQ/ndabBW+qzF9urXBHBhRSvXpRC4WlQykLEDwKPBoU?=
 =?us-ascii?q?HMp+FSWmDwoJVWGy4K0qcFQg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 13:23:17 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 47B705C5158;
	Thu, 17 Apr 2025 11:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB31C4CEE4;
	Thu, 17 Apr 2025 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888994;
	bh=7B70yJ4SRDrrXhm/q/EaJyQoxUqPWnLWl6ATh4yqNHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0m/wNfLNfos3JG0Gq0YguHhHEbc6iV0N78lLqtliDi4TJjftl0F+8NzdKtM51Bly
	 GLnWNv8W1PpDij5CZ8JuRVkZ96hhLCYPDuEAy/Mm1YL7qQEK6Vu1S4f8hXcSfZpzq4
	 y2Qk/IsUhIw1tOjPF280+jrfoQETLD34nSNunLH87yUT3QvnN8SeNjzBf3N1LL5uxc
	 zBqirpQcjS/mhyCUiQpwBpczn5LwlkYWVr2uGuv1JfW6CEJrICixBm5stTvnGBq8S+
	 KtpuJfYn1bWjbXfbUJWQRnZqm3c4OAcAkEHUd/miRM1Eio0KdfMXeQArMjkpHehdRy
	 LqjjO+Ycgllvw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u5NKp-006Ohy-Fj;
	Thu, 17 Apr 2025 12:23:11 +0100
Date: Thu, 17 Apr 2025 12:23:10 +0100
Message-ID: <86r01rjald.wl-maz@kernel.org>
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
In-Reply-To: <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
	<20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
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
Subject: Re: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: Marc Zyngier <maz@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2697
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/86r01rjald.wl-maz%40kernel.org>

On Thu, 17 Apr 2025 11:47:11 +0100,
Luo Jie <quic_luoj@quicinc.com> wrote:
> 
> Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> - reg &= ~MASK;
> - reg |= FIELD_PREP(MASK, val);
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/field_modify.cocci.
> 
> More information about semantic patching is available at
> https://coccinelle.gitlabpages.inria.fr/website
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> index 34233d586060..b2af748964d0 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> @@ -30,8 +30,7 @@ enum pkvm_page_state {
>  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
>  						 enum pkvm_page_state state)
>  {
> -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> +	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
>  	return prot;
>  }

Following up on my suggestion to *not* add anything new, this patch
could be written as:

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 34233d5860607..08cb6ba0e0716 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -30,9 +30,8 @@ enum pkvm_page_state {
 static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
 						 enum pkvm_page_state state)
 {
-	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
-	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
-	return prot;
+	u64 p = prot;
+	return u64_replace_bits(p, state, PKVM_PAGE_STATE_PROT_MASK);
 }
 
 static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)

	M.

-- 
Without deviation from the norm, progress is not possible.
