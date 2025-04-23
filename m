Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94188C369D9
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ehGug8WvDyCD5M5pIZOyKV928YDmAC5y0+gfYQ09jXs=;
  b=FrOxNNgt+7VWLX8YZgRGGZEI5T7Y1NsRHfoup23wmL71weSZm8fVErwe
   VAX9dqN53RIGjB0DZLzpiF0N8WwzDVtrOn/sSC97um5UyN/hkI8dg11AF
   hOWQTAPm1jTnJt7jR9SUTx6OWNMnvTtUv2TnyXIy4dtiSQlVUvgFc6jxG
   0=;
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
   d="scan'208";a="219234273"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9BF69E0D6B; Thu, 24 Apr 2025 10:55:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CEAF4E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 21:11:46 +0200 (CEST)
IronPort-SDR: 68093b69_y4g/ZA4eUAETOtKu5CQZyZFaKwk7pg7hbLTRo8Evjybvx/J
 ooB2JziOHqzUCxQkQs/iaGtrMSYxJa1nGf3iyKg==
X-IPAS-Result: =?us-ascii?q?A0EFAAAPOwloctoeIE5aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGBcFJ9WTQEC0iIJIRNhzSCBB0DgROdAIINA?=
 =?us-ascii?q?QMBDTkIAQIEAQEDAQIBkC8CHgYGMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABgQyFew1JAQwBggsBM4IWAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAoEKAQEBAQIBOgYBATcBBAsBChguE?=
 =?us-ascii?q?EYGExuCaIJBIwQDDbE0eIE0gQGCDAEBBoEI3H0DBoFJAYhPAYVshHcnG32BE?=
 =?us-ascii?q?IEVgnI4PoQthlqCMYEXgniHcYhdindSexwDWSwBVRMXCwcFgSZDA4EPI0sFM?=
 =?us-ascii?q?B2CV4UlghGBXAMDI4MTdByEaIRSLU+DL4IDaAodQAMLbT03FBuXD4E5gi0GA?=
 =?us-ascii?q?YEOCCQglVODGLAMCoQbjBmVSjOqV5h+jgaVWgMBhVGBZzqBXFEwBIMiTxwPj?=
 =?us-ascii?q?iGFPoY7ulJFMgI6AgcLAQEDCYVGAQGGYoM/M4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J83q6awD7iq50Eu
IronPort-HdrOrdr: A9a23:mXjIva0v7UvBZJQeqZEuGgqjBLckLtp133Aq2lEZdPWaSK2lfu
 SV7ZMmPH7P+VIssRQb8uxoV5PtfZqxz/FICMwqTNGftWrdyQ6VxeNZnOjfKlTbckWVm9K1l5
 0QEZSWJ+eAdGSS5vyb3ODXKbgd/OU=
X-Talos-CUID: 9a23:ohRXCm2FDiXQ/1GSorGlrLxfB+M7UFziyUbsHWS2UlQ2Sp6yQ2Go9/Yx
X-Talos-MUID: 9a23:9tHLNAad9jRDuuBTtha8hXZaPeBUoOeyCBkmra5ZhOSEOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219165116"
X-MGA-submission: =?us-ascii?q?MDHjkGd0xq8FvHw+0CGDdwFmUsQnQhCuR0ZPTT?=
 =?us-ascii?q?7y5uWVeenC6s+rpgFKtrqzZOpNu0ZzQ0FuTBLdZG2xjc0Ezqg23eR/UN?=
 =?us-ascii?q?m10yb/9CqRlMtAZsUUyMI/rvU3KZR7fO8cAqSkGqahE1XU+hxazd+fVx?=
 =?us-ascii?q?4/rs1bwffE+r8GXayPsnF+Ww=3D=3D?=
Received: from pandora.armlinux.org.uk ([78.32.30.218])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:11:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ehGug8WvDyCD5M5pIZOyKV928YDmAC5y0+gfYQ09jXs=; b=gR+JBAJ2qYXt394sKZwRWQbCpN
	HcCePrKHfFGuCBW/CVsEGeyPPPBU/OQFtTsArQ9YAQMdfrPO91pRpinnkaU+R3jp+UdCphKe75jFH
	ucyYXyXAR2foVu/mfhe3HwUcFVAYNSC0D2IF/239fM2PkQuMT0/jZ9Eup36+0LE43cVft0e9OZxx5
	dDTM3b1WXjpuJEb+/LCJQPWrlgDi1mUkEElwET/A/fla7O5FXGgwS0k0+1m++lZoElXyOp6z21cIM
	PjsApZ3zXuvkQ0rQfUsItb9D7TVFm1pADJUTTToBoUfafozF64nMdonx3qfC29IHEpO7FhUsX84Zq
	V3eCi9ZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52066)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7fVE-0006RY-0p;
	Wed, 23 Apr 2025 20:11:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7fV8-0000JD-0y;
	Wed, 23 Apr 2025 20:11:18 +0100
Date: Wed, 23 Apr 2025 20:11:18 +0100
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
Message-ID: <aAk7VqNOLujcyZS0@shell.armlinux.org.uk>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
 <86r01rjald.wl-maz@kernel.org>
 <aAJsaNdznnz-1qap@yury>
 <aAkn8lvzoa1grdkt@shell.armlinux.org.uk>
 <aAkw-tFctkk3xyS8@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkw-tFctkk3xyS8@yury>
Sender: cocci-request@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2718
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAk7VqNOLujcyZS0%40shell.armlinux.org.uk>

On Wed, Apr 23, 2025 at 02:27:06PM -0400, Yury Norov wrote:
> On Wed, Apr 23, 2025 at 06:48:34PM +0100, Russell King (Oracle) wrote:
> > On Fri, Apr 18, 2025 at 11:14:48AM -0400, Yury Norov wrote:
> > > On Thu, Apr 17, 2025 at 12:23:10PM +0100, Marc Zyngier wrote:
> > > > On Thu, 17 Apr 2025 11:47:11 +0100,
> > > > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > > > 
> > > > > Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> > > > > - reg &= ~MASK;
> > > > > - reg |= FIELD_PREP(MASK, val);
> > > > > The semantic patch that makes this change is available
> > > > > in scripts/coccinelle/misc/field_modify.cocci.
> > > > > 
> > > > > More information about semantic patching is available at
> > > > > https://coccinelle.gitlabpages.inria.fr/website
> > > > > 
> > > > > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > > > > ---
> > > > >  arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > index 34233d586060..b2af748964d0 100644
> > > > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > @@ -30,8 +30,7 @@ enum pkvm_page_state {
> > > > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > > > >  						 enum pkvm_page_state state)
> > > > >  {
> > > > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > > > +	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
> > > > >  	return prot;
> > > > >  }
> > > > 
> > > > Following up on my suggestion to *not* add anything new, this patch
> > > > could be written as:
> > > > 
> > > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > index 34233d5860607..08cb6ba0e0716 100644
> > > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > @@ -30,9 +30,8 @@ enum pkvm_page_state {
> > > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > > >  						 enum pkvm_page_state state)
> > > >  {
> > > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > > -	return prot;
> > > > +	u64 p = prot;
> > > > +	return u64_replace_bits(p, state, PKVM_PAGE_STATE_PROT_MASK);
> > > >  }
> > > 
> > > This is a great example where u64_replace_bit() should NOT be used. 
> > 
> > Why not? Explain it. Don't leave people in the dark, because right
> > now it looks like it's purely a religous fanaticism about what
> > should and should not be used. Where's the technical reasoning?
> 
> Because enum is an integer, i.e. 32-bit type.

This statement is false, in this case.

The kernel currently uses -std=gnu11, and GNU tends to be more relaxed
about things, and while the C standard may say that enums are ints,
that isn't the case - gcc appears to follow C++ and allow enums that
are wider than ints.

$ aarch64-linux-gnu-gcc -S -o - -std=gnu99 -x c -
enum foo {
A = 1L << 0,
B = 1L << 53,
};
int main()
{ return sizeof(enum foo); }

Gives the following code:

main:
.LFB0:
        .cfi_startproc
        mov     w0, 8
        ret
        .cfi_endproc

meaning that sizeof(enum foo) is 8 or 64-bit.

If B were 1L << 31, then sizeof(enum foo) is 4.

> Now, the snippet above
> typecasts it to 64-bit fixed size type, passes to 64-bit fixed-type
> function, and the returned value is typecasted back to 32-bit int.

In this case, the enum is defined using:

        KVM_PGTABLE_PROT_X                      = BIT(0),
        KVM_PGTABLE_PROT_W                      = BIT(1),
        KVM_PGTABLE_PROT_R                      = BIT(2),

        KVM_PGTABLE_PROT_DEVICE                 = BIT(3),
        KVM_PGTABLE_PROT_NORMAL_NC              = BIT(4),

        KVM_PGTABLE_PROT_SW0                    = BIT(55),
        KVM_PGTABLE_PROT_SW1                    = BIT(56),
        KVM_PGTABLE_PROT_SW2                    = BIT(57),
        KVM_PGTABLE_PROT_SW3                    = BIT(58),

As it contains bits beyond bit 31, and we use -std=gnu11 when building
the kernel, this enum is represented using a 64-bit integer type. So,
the casting to a u64 is not increasing the size of the enum, and the
return value is not getting truncated down to 32-bits.

> Doesn't sound the most efficient solution, right? On 32-bit arch it
> may double the function size, I guess.

Given that there's no inefficiency here, and that this is arm64 code
which is a 64-bit arch, both those points you mention seem to be
incorrect or not relevant.

> But the most important is that if we adopt this practice and spread it
> around, it will be really easy to overflow the 32-bit storage. The
> compiler will keep silence about that.

Given that in Marc's suggestion, "prot" is a 64-bit value, it's being
assigned to a u64, which is then being operated on by the u64 variant
of _replace_bits(), which returns the u64 result, which then gets
returned as a 64-bit enum, there is no issue here as far as I can see.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
