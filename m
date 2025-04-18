Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C899C369D7
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:message-id:from:to:cc:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3APNRWr/PhWBp/BuRBBE8YHfXq0Hacp6pVtnjq8DSTU=;
  b=gIqZsFDqOXL9qN96Yq2vj+3Jl1bzK6Sb/jxwHfdOjcnED+gfYNsvg4H7
   yaOev6uPp5/6g2SADKHpKSP7R80S+2tTF469TO9L1cIyIl69t/j7t2xwr
   eyrvlYYq+ZkxZIi7J6E9eG6/SvayeqEBMaBLXR8WzPeLBWUoGtCohm5Fa
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
   d="scan'208";a="219056397"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3A40DE0D87; Wed, 23 Apr 2025 10:51:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F0239E007A
	for <cocci@sympa.inria.fr>; Fri, 18 Apr 2025 17:34:22 +0200 (CEST)
IronPort-SDR: 680270ff_vlIwMEpQFaJrvZrcd/UjufPKHXAt4xgtPSnBBV/XwfOAA+f
 ia6rn3gj6JLbFMxDcI8L+sVpmCE7im/NnLIcWuQ==
X-IPAS-Result: =?us-ascii?q?A0ERAADJbwJohVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVsyBAtIjHFfhlWCJDCLMxCSH4F+DwEDAQ05CwQBAQMDAYUAA?=
 =?us-ascii?q?osrAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?QFASYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQINfgEBAQM6BgEBNwEPCxguEBA2BhODAgGCMAMxAwQNsi6BN?=
 =?us-ascii?q?IEBggwBAQaCadg+DWyBZQMGgUkBiDEeAYVsg316JxuBSUSBFYMqPoIfiGiCM?=
 =?us-ascii?q?YEDFIVdiAeIcosSUnscA1ksAVUTFwsHBWFIQwOBDyNOBTAdgXqDcoU2ghGBX?=
 =?us-ascii?q?AMDIgGDFXUchHGEVC1PgzOCAzsdQAMLbT03FBsGmQyBZ4IvAYEOLJVzgxivG?=
 =?us-ascii?q?3GEJYwZjziGEjOXRpMRmH6OBoQHlyiBZzqBXDMaCCgIgyJPAxkPjiEZhR+DV?=
 =?us-ascii?q?b4KQzQCOgIHCwEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 k8bi4dAD656F5DTVWYUVwoVvJJJ
IronPort-HdrOrdr: A9a23:P9DGWas+tL13sqmB0uZyhXnL7skDlNV00zEX/kB9WHVpmwKj5q
 OTdZUgpGbJYVMqNU3I9uruBEDtexLhHNtOkOws1NSZLW/bUQmTQr2KhLGKq1aLdxEWtNQtsZ
 uIGJIOauEYY2IbsS+32njeL/8QhOOutIy4heOb5XFrSg1hduVB1m5Ce36mO3wzfiEDKYs4EN
 657spD4xW6f3B/VLXAOlA1G9Lq4/HblJajWhQeGlob7mC1/EiVwY+/KTDd8gYfV3d0y78k9m
 TJ+jaJm5mejw==
X-Talos-CUID: =?us-ascii?q?9a23=3Aq6h8yWng0YWiBVfjuCoFObvPbunXOVfv8zTxeF2?=
 =?us-ascii?q?fM2YzQoOSe06h/P9DlsU7zg=3D=3D?=
X-Talos-MUID: 9a23:DEszdgU++50mV6Dq/GCxgQ46N/hr2YH0Kn8ytpQ9vNSabDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,222,1739833200"; 
   d="scan'208";a="218514714"
X-MGA-submission: =?us-ascii?q?MDHfdYKEoUDmklPDg7ZnwnZekZspzWZDhnS6ta?=
 =?us-ascii?q?tSHi5pUnR4ZqtGmIYS0/xvwJcTGNOLDpy2anC/oyddltMDK+bjdF9erA?=
 =?us-ascii?q?MlfmxL5ErWzCQ5ygkG6UmtZkLFrV0gJYpt/e8qf/Ot0Ek1OllePZtC2+?=
 =?us-ascii?q?R+CPpDxw2ky9aV1YKmGWFIsw=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 17:34:22 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 82C52A49308;
	Fri, 18 Apr 2025 15:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144EBC4CEE2;
	Fri, 18 Apr 2025 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990460;
	bh=IqfrOwyWG1N8zLTNAckQ4CesOQiehJPTCr+QzFBVjGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=et66A57SS/IazT+ZIFZOnE/SV7kXE0YSB2A+AgbN9eawLOkguleCnHto3In11sj3+
	 Hb1KRy+Ae4atyNjU6LAQxacjh2MUf1Bboc57G7MhdWEoUVSUdzAhw0fFu8+dgl2b8N
	 7+BHnalydI97FgNGAhkVKjmB0O/INXiH9gh4c1s+63FZVasjjSpu8w5Hd0upTj66s3
	 VrWUql5C1aMU0cjSxjD1XGXkwEwvc3oTLEjAYj7GcL6oIIz6HNR5U1PdPzbFPooCvL
	 rtps9pNwW0ENOXP1ibttsWT8Ki1qBzrcsbqmL+zdIjb6t8ySHyeDGbCcc+ufCehoeO
	 w4fjuKis6mpew==
Received: from sofa.misterjones.org ([185.219.108.64] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u5njN-006kqc-IK;
	Fri, 18 Apr 2025 16:34:17 +0100
Date: Fri, 18 Apr 2025 16:34:24 +0100
Message-ID: <87r01pxz3z.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Luo Jie <quic_luoj@quicinc.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	andrew@lunn.ch,
	quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com
In-Reply-To: <aAJsaNdznnz-1qap@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
	<20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
	<86r01rjald.wl-maz@kernel.org>
	<aAJsaNdznnz-1qap@yury>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: yury.norov@gmail.com, quic_luoj@quicinc.com, linux@rasmusvillemoes.dk, Julia.Lawall@inria.fr, nicolas.palix@imag.fr, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, cocci@inria.fr, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, andrew@lunn.ch, quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: Marc Zyngier <maz@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2703
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/87r01pxz3z.wl-maz%40kernel.org>

On Fri, 18 Apr 2025 16:14:48 +0100,
Yury Norov <yury.norov@gmail.com> wrote:
> 
> On Thu, Apr 17, 2025 at 12:23:10PM +0100, Marc Zyngier wrote:
> > On Thu, 17 Apr 2025 11:47:11 +0100,
> > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > 
> > > Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> > > - reg &= ~MASK;
> > > - reg |= FIELD_PREP(MASK, val);
> > > The semantic patch that makes this change is available
> > > in scripts/coccinelle/misc/field_modify.cocci.
> > > 
> > > More information about semantic patching is available at
> > > https://coccinelle.gitlabpages.inria.fr/website
> > > 
> > > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > index 34233d586060..b2af748964d0 100644
> > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > @@ -30,8 +30,7 @@ enum pkvm_page_state {
> > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > >  						 enum pkvm_page_state state)
> > >  {
> > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > +	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
> > >  	return prot;
> > >  }
> > 
> > Following up on my suggestion to *not* add anything new, this patch
> > could be written as:
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > index 34233d5860607..08cb6ba0e0716 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > @@ -30,9 +30,8 @@ enum pkvm_page_state {
> >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> >  						 enum pkvm_page_state state)
> >  {
> > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > -	return prot;
> > +	u64 p = prot;
> > +	return u64_replace_bits(p, state, PKVM_PAGE_STATE_PROT_MASK);
> >  }
> 
> This is a great example where u64_replace_bit() should NOT be used. 

Well, I'll like well it enough.

	M.

-- 
Jazz isn't dead. It just smells funny.
