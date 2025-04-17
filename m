Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC99C369D3
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VHYbpwLHuvljn8dVbt/fXb3LbUKc7Sc+NNW5fjMzCUU=;
  b=Nr/Lz/Rkhqz9RATK7dPuRbs1E27PDMVinmTbMDys2ZpRgS6/dhM17tLO
   zIIpaMgGV4xw7XRyTye3xYmUdJH9uVeZ5cLmJaS0kqDyTs2d08iNhxKsq
   9Ny9ghwJyYyC/h35glNV+a4eV72xd6rrDRhD0LsO7Nglj55spChcBFPtw
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219056275"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 204E8E0D3F; Wed, 23 Apr 2025 10:51:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3FF5EE007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 20:11:31 +0200 (CEST)
IronPort-SDR: 68014453_1sM5DSKXIFXECiiLQxUMSI3If8gUs3K+REY54wzAHTRIVeu
 cRq5JfXPSS/tFbg+JeA/EecmnybyN1S+AR1MV9Q==
X-IPAS-Result: =?us-ascii?q?A0HqAwChQwFoctoeIE5aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VMCgXBSfVk0BAtIiCSMAVkBAQEBBoFBoB8BAwENOQgBAgQBAQMBAgGQLQIeB?=
 =?us-ascii?q?gY0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMhXsNSQEQA?=
 =?us-ascii?q?YIHATOCFgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQKBCwEFOgYBATcBDwEKDgouEEYGE4MDgmQEAw2xCoE0gQGCDAEBBoEI3?=
 =?us-ascii?q?H0DBoFJiFABhWyEdycbfYEQgRWBO4FvPosHg0iFX4gIk3VSexwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSlDA4EPI04FMB2BeoN0hTaCEYFcAwMjgxV3HIRxhFctT4MzgggGHUADC?=
 =?us-ascii?q?209NxQbmQSBaIIwAYEOLIIDk3CDFwGwDAqEG4wZlUozqleYfo4Gmy+BfiOBX?=
 =?us-ascii?q?FEwBIMiTxwPjiEMFoUWhju9ekUyAjoCBwsBAQMJhUYBAYVYhHyBSwEB?=
IronPort-PHdr: A9a23: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
 Z7Sl/CrQN+t29vO+M8dAdXEbsWdPzw8MkixcAM=
IronPort-Data: A9a23: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
 b4bh4dA3oxO5kEuhA==
IronPort-HdrOrdr: A9a23:RCNItKD/rgx83ljlHemp55DYdb4zR+YMi2TDGXoRdfVwSL3+qy
 nOpoV+6faQsl0ssR4b9exoVJPufZqYz+8S3WBzB8bGYOCFghrKEGgK1+KLqVDd8m/Fh4xgPI
 hbAtFD4bbLbWSS4/yV3DWF
X-Talos-CUID: =?us-ascii?q?9a23=3AiA1uDGvdXoajX/8juljG61CF6IsVdVrY8XDrBHS?=
 =?us-ascii?q?XV1tTdIyeQHuB04Jdxp8=3D?=
X-Talos-MUID: 9a23:ZGHUpgiBJcZ0owrVNmQYucMpCP5OxLX/VEo2kqom5OuhbA9aBRS2k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,219,1739833200"; 
   d="scan'208";a="218376187"
X-MGA-submission: =?us-ascii?q?MDHO3akGLSPNMSDB987c8nC0fOWFimYvZcNYuw?=
 =?us-ascii?q?R6JaocqE4ZgR56e4Hf+GRMHEcT6aN6qlWSUJGwvjYtx6Gke1DgOJ1cMe?=
 =?us-ascii?q?MoDqjP+Pj07ItsZ4htWkRvy7YSgZnPGaCypG/A2NQibfoL67EIsdFZaA?=
 =?us-ascii?q?NMXQ7NXZ9aVeftxV6SkJabqA=3D=3D?=
Received: from pandora.armlinux.org.uk ([78.32.30.218])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 20:11:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VHYbpwLHuvljn8dVbt/fXb3LbUKc7Sc+NNW5fjMzCUU=; b=aInTtjNqwlrROOwNVA9D6/KOgb
	tdljBolfEjvm5NfCpi86ZldFZoGJKfxFdNAWfSPV12YVSfK09E53mETYDb8yeJt35iNS4GKQ8YOBn
	Lf76bylRCZiVU2F7O9DTElD+j2Z+yjB1zzBufle0HD92rcof6bd8zBhVqq9WAui1CgoRT14He4hTE
	2psFzmGVL3CD4xG+2TMEmxat4si0N+Tl2jEWNzPZnYd4ho7pdp7eoOQVFrcPbazJDYG78qH77dVTm
	eAYwTGT3BpdmHV/sudXjyVmeWr5caNNum07ficSULUB8L3u0tm1/R6Eq9z+nYS0KFN5EryidJ/Ten
	VSUmjoBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57866)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5Thg-0007nk-0W;
	Thu, 17 Apr 2025 19:11:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5Tha-0002fW-1R;
	Thu, 17 Apr 2025 19:11:06 +0100
Date: Thu, 17 Apr 2025 19:11:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, andrew@lunn.ch, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com
Message-ID: <aAFEOr_PnZRH2ocR@shell.armlinux.org.uk>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-3-6f7992aafcb7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-field_modify-v3-3-6f7992aafcb7@quicinc.com>
Sender: cocci-request@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 3/6] arm64: tlb: Convert the opencoded field
 modify
Reply-To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2700
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAFEOr_PnZRH2ocR%40shell.armlinux.org.uk>

On Thu, Apr 17, 2025 at 06:47:10PM +0800, Luo Jie wrote:
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
>  arch/arm64/include/asm/tlbflush.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index eba1a98657f1..0d250ef4161c 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -112,8 +112,7 @@ static inline unsigned long get_trans_granule(void)
>  	    level >= 0 && level <= 3) {					\
>  		u64 ttl = level & 3;					\
>  		ttl |= get_trans_granule() << 2;			\
> -		arg &= ~TLBI_TTL_MASK;					\
> -		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
> +		FIELD_MODIFY(TLBI_TTL_MASK, &arg, ttl);			\

This could equally be:
		arg = u64_replace_bits(arg, ttl, TLBI_TTL_MASK);

which already exists, so doesn't require a new macro to be introduced.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
