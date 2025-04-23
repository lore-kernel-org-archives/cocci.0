Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C7BC369AB
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pQtVtfjcISAXVaI5AkP35trRWt3Y1MNmZDafxANLqh0=;
  b=rx004bNow5pYfAsYjBigibJP12wvcQT5gmKOLu1kmWAdGTK5F9HgRmBy
   OCdLjYDWAAPRsSMkrRljtjgG8E2EkKoMo/TrReGIDPDn6b9KxhLxCMnQ3
   LF58CfgtiO+6vU3YWguZR++CxlzzHpeEEFk1mFL7LrDAdcUphaL7W6QE2
   w=;
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
X-IronPort-AV: E=Sophos;i="6.15,235,1739833200"; 
   d="scan'208";a="219234168"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0DAABE0D78; Thu, 24 Apr 2025 10:55:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6252DE0261
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 19:48:49 +0200 (CEST)
IronPort-SDR: 68092800_LFv1jxQwxHcJoTg0xx4poy3tntG6m7vBz1q7KTVNkc5YAY8
 pJwydutI5deFSoSzF7DLHxVsSYarEGeVYJws+uA==
X-IPAS-Result: =?us-ascii?q?A0EFAAASJwloctoeIE5aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGBcFJ9WTQEC0iIJIRNhzRdBoEhIJ4Tgg0BA?=
 =?us-ascii?q?wENOQgBAgQBAQMBAgGQLwIeBgYwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAGBDIV7DUkBDAGCCwEzghYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECgQsBBToGAQE3AQ8BChguEEYGE4MDg?=
 =?us-ascii?q?mQEAw2yDoE0gQGCDAEBBoEI3H0DBoFJAYhPAYVshHcnG32BEIEVgyo+iweDS?=
 =?us-ascii?q?IJ4h3GTU1J7HANZLAFVExcLBwWBJkMDgQ8jSwUwHYJXhSWCEYFcAwMjgxN0H?=
 =?us-ascii?q?IRohFItT4MvggNoCB1AAwttPTcUG5cOgTmCMwGBDiyVc4MYsAwKhBuMGZVKM?=
 =?us-ascii?q?6pXmH6OBpsvgWc6gVxRMASDIk8cD44hhT6GO7o0RTICOgIHCwEBAwmFRgEBh?=
 =?us-ascii?q?mKDcoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 586q6thLl16AkAuhJY=
IronPort-HdrOrdr: A9a23:0B5DtqPCGQd74cBcTu+jsMiBIKoaSvp037BN7TEUdfU1SL38qy
 nKpp4mPHDP+U4ssR0b6LK90de7MArhHO9OkO4s1N6ZNWGMyQiVxelZjbcKqAeQfREWmNQtrp
 tIQuxRDJnfAzFB4voSIzPVLz/j+rS6GWyT69s2t00dNz2CopsA0ztE
X-Talos-CUID: 9a23:Z7CQ+GNmSdX8ye5DWHBg7R8zRdEedWDX7mr8IladMWRZR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A/za89gylKdnjIqXKlwLeSLrObL2aqIrzDl0qn48?=
 =?us-ascii?q?Gh8TaPC1oCxS2pxHmQ4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="115009644"
X-MGA-submission: =?us-ascii?q?MDGge32D6V0s3V1ZAHLbFdibVMv/Kjq5j5Io3a?=
 =?us-ascii?q?I8qB/sc2jbxz9aZywAWHoUlDlewsXplTSodS1qaDzrbVN8rDh+tls7IS?=
 =?us-ascii?q?xhczqWsGOfVQdX1H7fMztZPbK/wvphjdSM3zXMM3Sdy94oUNwyTcrbnW?=
 =?us-ascii?q?KQumqlCyiRF7U42fX7/fHh6Q=3D=3D?=
Received: from pandora.armlinux.org.uk ([78.32.30.218])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 19:48:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pQtVtfjcISAXVaI5AkP35trRWt3Y1MNmZDafxANLqh0=; b=flczgPhJv9872LkI9et9T6x2/0
	OPgsl+sGZke1RUeQyscDdDs4GZCWisrK1xr6Ywv1u5BG1MsOWYrM/LuT78pfbIJI9AschGQVFUq7Z
	rSBUNfbbyK/d8iZ6ZCflpEVTa7EVx4o1ogXzL77WBvUmdrj7ec4xaE7CVlOfYSKVv/zoJ2kLeXPVy
	IoK9Dz+c0hfOYoCs2+EwPsP7b0N1AbrfT0pRgIw+5nZsvvTFrIGWO7adzV9Kpb0GEEY3vXMJp1PFi
	oDQfH42qZeCPYQ5kBE4HEG+MhocFyF0AoXaVwVpnKRLEb4yHiGQSE839LjU+Hmr+JZdHzyddsp+vw
	9gb86kKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45988)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7eD6-0006Kz-0U;
	Wed, 23 Apr 2025 18:48:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7eD4-0000Dl-0q;
	Wed, 23 Apr 2025 18:48:34 +0100
Date: Wed, 23 Apr 2025 18:48:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yury Norov <yury.norov@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Luo Jie <quic_luoj@quicinc.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, andrew@lunn.ch, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com
Message-ID: <aAkn8lvzoa1grdkt@shell.armlinux.org.uk>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
 <86r01rjald.wl-maz@kernel.org>
 <aAJsaNdznnz-1qap@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAJsaNdznnz-1qap@yury>
Sender: cocci-request@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2715
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAkn8lvzoa1grdkt%40shell.armlinux.org.uk>

On Fri, Apr 18, 2025 at 11:14:48AM -0400, Yury Norov wrote:
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

Why not? Explain it. Don't leave people in the dark, because right
now it looks like it's purely a religous fanaticism about what
should and should not be used. Where's the technical reasoning?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
