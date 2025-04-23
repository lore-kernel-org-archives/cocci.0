Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96988C369D1
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3g25cudfdER1fultAc6guoG7d90Bj2J+6OCH21hX/70=;
  b=WtRdeSUDLA4u5IrzBAYv6yN0/HUAECCRcCD8FVUtGVVVjXQqcTU36cQ5
   CxCLfwhsc0eyXl2HUiBGaHFhVI1n/kBnRZKYf8OJmcv0t8rs1xHc51fL/
   wl0NzqRJtJoXmZDyZatGOj3FIiKYJ51w13hIYaO4YPjEwW32kZQmPvsPm
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.15,235,1739833200"; 
   d="scan'208";a="219234202"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F10DE0D86; Thu, 24 Apr 2025 10:55:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 50F71E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 20:27:12 +0200 (CEST)
IronPort-SDR: 680930ff_t6s3QAePR989vgStVfolzTvrolWzNsjpTXWuXShtdWLXEJk
 sdnajkCesSHz4Kbvg++Nz+8zV7fc99zibcLnSTg==
X-IPAS-Result: =?us-ascii?q?A0EbAACTMAlofKrSVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQn1aMwRTjHGHNIIhA4V6jFIciyuBQD4PAQMBCwEBOQkCBAEBA?=
 =?us-ascii?q?wMBOIRIAostAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBIhkHDhIphXsNSQEQAYIHAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIsPwEBHgEBAQMSKAYBGx0BAwwGB?=
 =?us-ascii?q?RguEBIRAQUBHAYKCRsHgmGCLwEDMQMRpRSBBUKLPIEXBQIWgQGCDQbaXQoZK?=
 =?us-ascii?q?A1sA4FiAgEGCQEKgTUBhHUpTg6COB0BhWwbg2J6Jw+BVUSBFYMqPoQthloEg?=
 =?us-ascii?q?i1FUoJ4h3GIXYp2CAcxCQkTBgoCSwsKEgMEAwQEAQILEwkDAwIOAggDAggGG?=
 =?us-ascii?q?QE/DAYEHRgMHwoICAQRCigiBA4rCgNbNQgGAgIEBAIEAgoCCQICBQcCEQMEA?=
 =?us-ascii?q?QEIAgIDKwYDBhsJCAINBQ8IAgMDAwMMAgIDAwIOAQICDAgDAwkCBgoJAQIKB?=
 =?us-ascii?q?gIJEAECAhADAgICAgYHCgMCEwwFBgYCCgcNCwISAgMJBgMFCgMHBAoNAhUCF?=
 =?us-ascii?q?QUfAQIICQ4RAgUSAw4FAwICEQQCAwMFAwEHARUICAwCAgICBQIFAhgRDQQDA?=
 =?us-ascii?q?wMCCAEEFQYDCQglGwoBAwEJAwIDBAgDAwMCBgwLAgEHCAMDBgsICQYDAgcIG?=
 =?us-ascii?q?QMFBAMHBQshAgYDAgQFBAEFAhMNAgMZAgYDBhEJDQYIBwkDBwEBAQICAggBB?=
 =?us-ascii?q?gUSAgMEAgUEBAEBCAMDBAYCAQMCAgQJAQEBAgoCCAoBCRMEAwgDAwMDAwUCA?=
 =?us-ascii?q?goRBQUCAQUKEwwKBgMGAwQCAgILBwIDAwMHAQscAgEDAgIFAgIBBQMCAgYEA?=
 =?us-ascii?q?wIBAQkCAwIIAQICAQICAgQBBwEEBwYBAQIEAgIyAgEDCAIFAQEOAgIEAgIBA?=
 =?us-ascii?q?gICBAIEAQIGCwQFDQEBAgECAgEBAQQBCAMBAQICAwMFAwUIDw0BARcLHQMEB?=
 =?us-ascii?q?QICAQEBAQISAgIBBwECAQEDGgIBAwMEAQsCAQEEHgQWAgICAgIEAwIDAgILE?=
 =?us-ascii?q?yUBAgMGEwIEAgECAgUFBQEDBBEQCQMCBQQCAgYCBAYKAgcEAhoEAgICAQMEB?=
 =?us-ascii?q?gMBAggCAgcEBAYDAgIBAgIHGQIZAQMBAQICAgQCAgIJCgQFBAQEAwICAgEMA?=
 =?us-ascii?q?wECAwICAgIBAwICAQEDAQUGDQISAgEDDwgEAgIHAgIhDwsBAgEBBgYCAwMDC?=
 =?us-ascii?q?gMBCgECAQECBgIBAhIFAgIBAgQBAgIDBCUBAgECAQEBBQIBAgECBAIHAgECA?=
 =?us-ascii?q?gsBBQIGAQICCQECAQICAgECAQECBgIBFQECAgICAgMBAwYCAgICAgIJAgICA?=
 =?us-ascii?q?gUCBQMCAwEGAgIFAgMDAgIDBAMJAwMIAwYEAgMBAQECAQICAgECAQIFAgMJA?=
 =?us-ascii?q?QEDAgECAgICAwYCBQUBAwsFBAcBAQIBAwUDAwQDBgEMBAMCAgQCAgICAgIEA?=
 =?us-ascii?q?gIBBQMDAgIFAQUDCAECBAIBAwMDBAQDAQICCgcFAgQBAQEBAgECAgoDAgUBA?=
 =?us-ascii?q?QMDARIDBAEGBQUGAgcJAwICBAIDAgQDCQQCBgMDAgICAQELAgIBAgIBAQMDB?=
 =?us-ascii?q?wYQAQICAgIBDwIDAwMDAw8GAwUJAQMHAQEBAQECFAMCAQQBCB0CCQMjDwMUC?=
 =?us-ascii?q?BM9DAcyBDYBFBQHBiWBAJVjgTmCMwGBDiQIlXODGJp5lF80B4QegV4GDIopl?=
 =?us-ascii?q?hCXMwyTBZh+jgaVWgSFJgIKBwcRIxKBMjqBXDMaI4M3TwMZD44hhACBPsEQJ?=
 =?us-ascii?q?zUCOgIHCwEBAwmFQyYThBeFVjOBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 NWzyyBWOXlp43y9FFFbJcvlNn6xvr8x4+n1sTPC
IronPort-HdrOrdr: A9a23:xt6wR65Lp1RTZgWuIgPXwA3XdLJyesId70hD6qm+c20yTiW9rb
 HToB17726ItN91YhsdcL+7Scy9qB/nhPpICMwqTMiftWrdyRGVxeNZnPPfKlTbckWUh4xgPO
 VbAtND4bXLfDtHZK3BkXCF+rgbsb662ZHtquHE0X93QA1mL41m5RxoExuWHyRNKDVuNN4WEN
 6z6KN8yQZIuk55Ui14PBQ4tiT4xuEjXaiHXSI7
X-Talos-CUID: =?us-ascii?q?9a23=3AXFNWKGiFYP3ufZDTemz76lqDrTJuSFfH0lLBD3S?=
 =?us-ascii?q?CFmNwUaCIZg6X+7Jnup87?=
X-Talos-MUID: 9a23:bxYXVwre1jN4LDmgxZYezw1mOu1QxqGzMQMMyKwmqpSHLH0pMDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="115011363"
X-MGA-submission: =?us-ascii?q?MDEgK9WCkbX14YVxwUPRtNkIOvLitr8x512YNr?=
 =?us-ascii?q?4ipb61lphTRY0skbOjXZddWthqbe69QU/IptY/44rg6FcftXSOhWJYgK?=
 =?us-ascii?q?HiEh3TBecih29qzj/sdUeknl1rtD4ENZJQna2f69XwInQLqfhKq1g40F?=
 =?us-ascii?q?ihV+oQEIOSSZeMaNA9k8MxFw=3D=3D?=
Received: from mail-pf1-f170.google.com ([209.85.210.170])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:27:11 +0200
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c277331eso1352525b3a.1;
        Wed, 23 Apr 2025 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745432829; x=1746037629; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g25cudfdER1fultAc6guoG7d90Bj2J+6OCH21hX/70=;
        b=mWOQ5mqz+wWoebMIkbdbMwv8InmdrgNiYmvjP6nArxsy3ag0Wk269yNuMxthtnDJIT
         e4jwQcyBJNxPLA6U5kP4S5+teBsk3HJ4L+K3L4e6+e4NMI1SX6VQRvQAwQC1v0aeKoHx
         kAq/RYG+e6NVagtYWBQACIoyINRp8Ut2iNfQy5Biz45vz4jQBTK7D5bV9sszC4R7no6o
         tWRfT/TaAQhdp6j0rpa5W3vnrYN4XpKawezLUSAd0f42uQDtbXdIz2ZpA9g0E/HH8qFM
         hM5qWTQmrPbV7AD798eV29sxnPv3MJPGm4Lxr7nsoq4Br0qa2wJUT9A9dDK9TQeqQEep
         /zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432829; x=1746037629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g25cudfdER1fultAc6guoG7d90Bj2J+6OCH21hX/70=;
        b=g6+9UTt8MQ1+YJOf8df2bWEnFWMbDa+XBrr6No5K7aMEG0HPC+4BoMPDthIswWVq0u
         lKGCvSIbAMyP/qyAXYSvDq4tqKOFTG+5mi+fwjczbbUffEOvzo+IlV56qa4EQAQMtu+J
         /Cdb/ono4o0g0FnPQm+Ep6ED7anA3PxNKbiGk6w6zjaJKRt2K5I69KKiUhJIyJP1WDBv
         JFk/hsu0mGbb7+bhCIX/raLcO9rdMk1uODkTf3iw6CZwKWTJi6VLvzpBJqX3vvg0V+uI
         TrAZCxlnu4R3aQvDNvQy5k8I2jV0qS6uqIVbTMAuatE62pmu3ICOXtKoYcnqeA9BoNZc
         E7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZco5PNtS1rgvhZFu64uOFMuyZgKy+LAj7Rrs4K48l4Qv+LkPsmlQN/jsrQ6hi4R7EWApedbE=@inria.fr, AJvYcCWsAqIe8SDqlR9Y+c4HT/JiV5y8x9RYzH5qi6T7HNf3Gmpa8jECiDy71RfJLtcv8CyKZbWc0xUJBX2vO1Y=@inria.fr
X-Gm-Message-State: AOJu0YyJ6rpaMrb3+Rp9d0zzSQcQwpLgIwY1b6PctxYO1Rlpjl1xlYNt
	aPeZvK5QdNNwqCPP/f+vMM6xl7PQOzPTqo+UwQeH+uZH593hxMMq
X-Gm-Gg: ASbGncuSZ13KzDx6Pn/E1zzlm16sSl5W54dF8lMn6dbDnR7tLT3J+RMKD1tu+2+Kcwh
	2ZfmL/xm4tvpxKQaOaejmkJ5x3dLnso7ae/p6mY1qJUtt0bjzEq8QHJZvPIsCeRgl15f2tjvh9n
	S4Pm7y82yP0i036m+ZAhtxBWm5m6SuhcniRXS3vefJI3Khu0i6wsIPYTWQQrvEdviAbgfYiQ73x
	9jmwNMum4ms16I/awWTPgXWsznXdLl1u2OAbeL6BsCD31iYN17QR59CEEmc8jjEM5NInLNlpgVT
	qSNo5HI7OFk1IKnf2giuhabaf42b08ox0fpI+KuQtlKBKect9NQ=
X-Google-Smtp-Source: AGHT+IGHyaRCja82Jp63ca6tDfY0vscU4gtWT0BCYYEH2SbVC6BGq3lUVFXS6KtlFAXf+XFDnn7bog==
X-Received: by 2002:a05:6a21:9105:b0:1f0:e2d0:fb65 with SMTP id adf61e73a8af0-20442d54a7fmr200581637.2.1745432828582;
        Wed, 23 Apr 2025 11:27:08 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa5d084sm11268524b3a.103.2025.04.23.11.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:27:07 -0700 (PDT)
Date: Wed, 23 Apr 2025 14:27:06 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <aAkw-tFctkk3xyS8@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
 <86r01rjald.wl-maz@kernel.org>
 <aAJsaNdznnz-1qap@yury>
 <aAkn8lvzoa1grdkt@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkn8lvzoa1grdkt@shell.armlinux.org.uk>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2716
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAkw-tFctkk3xyS8%40yury>

On Wed, Apr 23, 2025 at 06:48:34PM +0100, Russell King (Oracle) wrote:
> On Fri, Apr 18, 2025 at 11:14:48AM -0400, Yury Norov wrote:
> > On Thu, Apr 17, 2025 at 12:23:10PM +0100, Marc Zyngier wrote:
> > > On Thu, 17 Apr 2025 11:47:11 +0100,
> > > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > > 
> > > > Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> > > > - reg &= ~MASK;
> > > > - reg |= FIELD_PREP(MASK, val);
> > > > The semantic patch that makes this change is available
> > > > in scripts/coccinelle/misc/field_modify.cocci.
> > > > 
> > > > More information about semantic patching is available at
> > > > https://coccinelle.gitlabpages.inria.fr/website
> > > > 
> > > > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > > > ---
> > > >  arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > index 34233d586060..b2af748964d0 100644
> > > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > @@ -30,8 +30,7 @@ enum pkvm_page_state {
> > > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > > >  						 enum pkvm_page_state state)
> > > >  {
> > > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > > +	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
> > > >  	return prot;
> > > >  }
> > > 
> > > Following up on my suggestion to *not* add anything new, this patch
> > > could be written as:
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > index 34233d5860607..08cb6ba0e0716 100644
> > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > @@ -30,9 +30,8 @@ enum pkvm_page_state {
> > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > >  						 enum pkvm_page_state state)
> > >  {
> > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > -	return prot;
> > > +	u64 p = prot;
> > > +	return u64_replace_bits(p, state, PKVM_PAGE_STATE_PROT_MASK);
> > >  }
> > 
> > This is a great example where u64_replace_bit() should NOT be used. 
> 
> Why not? Explain it. Don't leave people in the dark, because right
> now it looks like it's purely a religous fanaticism about what
> should and should not be used. Where's the technical reasoning?

Because enum is an integer, i.e. 32-bit type. Now, the snippet above
typecasts it to 64-bit fixed size type, passes to 64-bit fixed-type
function, and the returned value is typecasted back to 32-bit int.

Doesn't sound the most efficient solution, right? On 32-bit arch it
may double the function size, I guess.

But the most important is that if we adopt this practice and spread it
around, it will be really easy to overflow the 32-bit storage. The
compiler will keep silence about that.

Fixed types are very useful in their specific areas - cross-ABI data
transfer, etc. But mixing them with native types like int may hurt
badly. 

Hope that helps.

Thanks,
Yury
