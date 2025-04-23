Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DDBC369DC
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=F4TIb8/cGcT5YOO6jpwMUaKc5ramXtbgTdB6E61EUK4=;
  b=XspKTluPoDUCJx6NWmv1R2Q8Tm0Xjevp0bvxqXJozVApHbMbVQZm/0ze
   jPYvkwFS2kVIoGMuosvEfEesptkmiZ0x7ayHHTICPH8JQq2O6z/uiYL60
   6BqjZdcWgVMeYUh84Gg939QHcP/G1wkTEtFkLKH6s9GlXcqFpAPp6Rt5o
   E=;
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
   d="scan'208";a="219234299"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA52AE007A; Thu, 24 Apr 2025 10:55:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A38ACE007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 21:40:51 +0200 (CEST)
IronPort-SDR: 68094242_k0c5KGrF+6NWfv8MUrQB0j0TX8vQaGWJ8eDvLpIazt0paKt
 +STIHLT1bUSSxC6eYrsmCdL5rBDt88MlVEzkT4w==
X-IPAS-Result: =?us-ascii?q?A0EbAADBQAlogbbWVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQn1aMwRTjHGHNIIhA4EThGeMUhyLK4FAPg8BAwELAQE5CQIEA?=
 =?us-ascii?q?QEDAwE4hEgCiy0CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEiGQcOO4V7DUkBEAGCBwGBJGECBQM7AQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECLD8BAR4BAQEDEigGARsdAQMMB?=
 =?us-ascii?q?gUYLhASEQEFARwGExsHgmGCLwEDMQMRpUiBBUKLPIEXBQIWgQGCDQbaXQoZK?=
 =?us-ascii?q?A1sA4FiAgEGCQEKgTUBhHUpTg6COB0BhWyDfXonD4FVRIEVgihKOD6ELYZaB?=
 =?us-ascii?q?INEgniHcYhdinkIBzEJCRMGCgJLCwoSAwQDBAQBAgsTCQMDAg4CCAMCCAYZA?=
 =?us-ascii?q?T8MBgQdGAwfCggIBBEKKCIEDisKA1s1CAYCAgQEAgQCCgIJAgIFBwIRAwQBA?=
 =?us-ascii?q?QgCAgMrBgMGGwkIAg0FDwgCAwMDAwwCAgMDAg4BAgIMCAMDCQIGCgkBAgoGA?=
 =?us-ascii?q?gkQAQICEAMCAgICBgcKAwITDAUGBgIKBw0LAhICAwkGAwUKAwcECg0CFQIVB?=
 =?us-ascii?q?R8BAggJDhECBRIDDgUDAgIRBAIDAwUDAQcBFQgIDAICAgIFAgUCGBENBAMDA?=
 =?us-ascii?q?wIIAQQVBgMJCCUbCgEDAQkDAgMECAMDAwIGDAsCAQcIAwMGCwgJBgMCBwgZA?=
 =?us-ascii?q?wUEAwcFCyECBgMCBAUEAQUCEw0CAxkCBgMGEQkNBggHCQMHAQEBAgICCAEGB?=
 =?us-ascii?q?RICAwQCBQQEAQEIAwMEBgIBAwICBAkBAQECCgIICgEJEwQDCAMDAwMDBQICC?=
 =?us-ascii?q?hEFBQIBBQoTDAoGAwYDBAICAgsHAgMDAwcBCxwCAQMCAgUCAgEFAwICBgQDA?=
 =?us-ascii?q?gEBCQIDAggBAgIBAgICBAEHAQQHBgEBAgQCAjICAQMIAgUBAQ4CAgQCAgECA?=
 =?us-ascii?q?gIEAgQBAgYLBAUNAQECAQICAQEBBAEIAwEBAgIDAwUDBQgPDQEBFwsdAwQFA?=
 =?us-ascii?q?gIBAQEBAhICAgEHAQIBAQMaAgEDAwQBCwIBAQQeBBYCAgICAgQDAgMCAgsTJ?=
 =?us-ascii?q?QECAwYTAgQCAQICBQUFAQMEERAJAwIFBAICBgIEBgoCBwQCGgQCAgIBAwQGA?=
 =?us-ascii?q?wECCAICBwQEBgMCAgECAgcZAhkBAwEBAgICBAICAgkKBAUEBAQDAgICAQwDA?=
 =?us-ascii?q?QIDAgICAgEDAgIBAQMBBQYNAhICAQMPCAQCAgcCAiEPCwECAQEGBgIDAwMKA?=
 =?us-ascii?q?wEKAQIBAQIGAgECEgUCAgECBAECAgMEJQECAQIBAQEFAgECAQIEAgcCAQICC?=
 =?us-ascii?q?wEFAgYBAgIJAQIBAgICAQIBAQIGAgEVAQICAgICAwEDBgICAgICAgkCAgICB?=
 =?us-ascii?q?QIFAwIDAQYCAgUCAwMCAgMEAwkDAwgDBgQCAwEBAQIBAgICAQIBAgUCAwkBA?=
 =?us-ascii?q?QMCAQICAgIDBgIFBQEDCwUEBwEBAgEDBQMDBAMGAQwEAwICBAICAgICAgQCA?=
 =?us-ascii?q?gEFAwMCAgUBBQMIAQIEAgEDAwMEBAMBAgIKBwUCBAEBAQECAQICCgMCBQEBA?=
 =?us-ascii?q?wMBEgMEAQYFBQYCBwkDAgIEAgMCBAMJBAIGAwMCAgIBAQsCAgECAgEBAwMHB?=
 =?us-ascii?q?hABAgICAgEPAgMDAwMDDwYDBQkBAwcBAQEBAQIUAwIBBAEECB0CCQMjDwMUC?=
 =?us-ascii?q?BM9DAcyBDYBFBQHBiWBAJVlgTmCLQYBgQ4IJCCBTJNzFIMYr1g0B4QegV4GD?=
 =?us-ascii?q?IoplhCXMwyTBZh+jgaVWgMBhSYCCgcHESMSgTI6gVwzGiODN08DGQ+OIYQAg?=
 =?us-ascii?q?T7BMic1AjoCBwsBAQMJhUMmE4QXhVYzgUsBAQ?=
IronPort-PHdr: A9a23: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
 CRZ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DlrCnq+mPVnyNuEM+A9uk+AdI+orL9Y04lQ7vn2ZhyYlFPBws/
 re4MjztCWE9Qr5PUtLpTnuAtjkfZqxz+8Q3WBVB8bcYOCEghrTEGgB1/qb/9SIIUSXnZ8+6U
 4jSdkENDSZNykYsS+Q2njALz9P+qjhzImYwcjZ1GlkVgxnZuVN6A1jGh+HHkAefmV7LKt8Op
 7ZyMQvnVSdkLcsAfhTxENpYwEOnbz2fVvdASI7Ow==
X-Talos-CUID: =?us-ascii?q?9a23=3A3srdHWp3WQsZ2t9iXEuDFHzmUfgGblPQ8lH2GEW?=
 =?us-ascii?q?fA01OWJ2lCkeI26wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ANVZpSg15rAGZaRUoQTUsaTkEhTUjvKakChwJgJM?=
 =?us-ascii?q?6q8SeE3NCFRCQqyiFTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="115013962"
X-MGA-submission: =?us-ascii?q?MDFYRFdaBQgyZypmGqyUgVHkwkY5Ijrc4KcI7S?=
 =?us-ascii?q?4yELicnQ1T5+caT3pDs3Iui4Ms7W/EEq71lb3Xy7yXI91F0L5jZmkAmc?=
 =?us-ascii?q?Drfbz0e/z/pn5xyO8YD7gtPNsC0P1hJsZ7UMwxXuWfWkeC+khZdQvOwD?=
 =?us-ascii?q?QFzaEhKOL3pxK8Nrgm/mM1tg=3D=3D?=
Received: from mail-pl1-f182.google.com ([209.85.214.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:40:49 +0200
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2255003f4c6so2733785ad.0;
        Wed, 23 Apr 2025 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437248; x=1746042048; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4TIb8/cGcT5YOO6jpwMUaKc5ramXtbgTdB6E61EUK4=;
        b=de24UJV4JmqAoGvU4sFaG39cAeOMpmrwdzh/qkx7hKiY/8KrMakjLRIwUYiunxCn/l
         rIbJKxom/dXiTPsZ66/qPitTNdA7xoeBxQrc+J33hPcj8vuXmwoSQOTEsMwRy0XBPJ9F
         pfeeCnJF0+AMqFk3vl/xBuVdjVrFHG+jHVT+xY+njnnUWT88hS3sSES46F5rTyKj+WF8
         FAvtto7z2zWH1CWpBM+UoOElwPzjWfLQTz8WrNviyAFBlo5cUFBRTk3uD3vt4+YRJ2/m
         ad2P2U4PeCsc7bLypBVHW/oq6/zsB2rtxwY91sUtXJX9ZCU+eEmT62gZJB9sHbNhjJDr
         sPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437248; x=1746042048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4TIb8/cGcT5YOO6jpwMUaKc5ramXtbgTdB6E61EUK4=;
        b=xOZxxwb1ApmXZEzOqlD4vxRFdhiO7kXzmk7h1nvMgmraVZX3RTntu64ugAUjCpeDUy
         ggEYPVo+vGmMGxYLUdOaqwiLFZADVXd7VkU0CuGbBUArf0hizR/xMUGnpJmkML7VR1N+
         fo/ZBIuWDsGzez/JRYv8+Og5cWaXkUjCHh3SggdKnA7FcDA5/GmWBmY3g2hm9hgP5VSO
         /C571QV9PNGGAJnYsPvKMgVxoz3/5KCYonyCpI08lEqiqiLzE85qqRVvd3tXtFFvu2Dv
         2CiKgkREXzbCmJGNHFmze1o9roUd9hqw+Ec7FAVIVNx/2T1wktDWBELOBl1u/sDTWTp2
         GTsw==
X-Forwarded-Encrypted: i=1; AJvYcCUn+My+PWmm7TH+j7dhtqLTKh52sAdq9jZcYMitw3zBsvtg9lufWSzZAolbztIN5VouKTWY6f8=@inria.fr, AJvYcCXa3TYvrXX0QgELMSnLEcq+DJNUVDFSAUHKMxgWdpnn094tRdfOEBI/DT5vFh1FQUmRbK9tgIRDRG3SYd4=@inria.fr
X-Gm-Message-State: AOJu0YxM11pxjwA8/E2qCU7xbf2IIcq8O/2x/pYAxmAT6DeL54HZGqnz
	vTI4uBm9GQzr9+JZEFy4mx8WtYGEiWilYE8euF+0GkBq5ZY2DR8c
X-Gm-Gg: ASbGncup/fcKO6jZyZrbhCpJwNk8ZJJ3ZF4bTGMTKVqcYV9JtIUdW1QCPo0aQ2Tfso7
	/olxwKbojR0iTO/oiFHr7vB5Pad78bKFOcfBeVDv2K++I7STwLWp8xOUcaSoEGYY04YYInVzwyj
	RsHJ11pWtxOgMKrdpn4RydmmhKurkHClL+WkyFClTOie7R60fxjoGvOjpL6dzrqPer+umicRHDR
	ajEwNhG3k7Io38pWsLP3kTLXG3B4s6NtVvraaP/fE9mY6+mkthlQiW2sNxrUlDVjjqx1+6pwA/1
	A/vGvjWJZc8Iqq27CsXTSLP4x9e8Bb7lbX6dR+we
X-Google-Smtp-Source: AGHT+IGJTj4t3YyBeTpu99dqNzdz4h1Gumsi9bbZoo/nwDcyxygthxC2epv2+Ql+pGJESwDyMuUhMw==
X-Received: by 2002:a17:902:d492:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22db1aa28a4mr9176975ad.22.1745437248148;
        Wed, 23 Apr 2025 12:40:48 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fe0976sm108905785ad.245.2025.04.23.12.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:40:47 -0700 (PDT)
Date: Wed, 23 Apr 2025 15:40:45 -0400
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
Message-ID: <aAlCPZQtFjr4F-re@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
 <86r01rjald.wl-maz@kernel.org>
 <aAJsaNdznnz-1qap@yury>
 <aAkn8lvzoa1grdkt@shell.armlinux.org.uk>
 <aAkw-tFctkk3xyS8@yury>
 <aAk7VqNOLujcyZS0@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAk7VqNOLujcyZS0@shell.armlinux.org.uk>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2719
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAlCPZQtFjr4F-re%40yury>

On Wed, Apr 23, 2025 at 08:11:18PM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 23, 2025 at 02:27:06PM -0400, Yury Norov wrote:
> > On Wed, Apr 23, 2025 at 06:48:34PM +0100, Russell King (Oracle) wrote:
> > > On Fri, Apr 18, 2025 at 11:14:48AM -0400, Yury Norov wrote:
> > > > On Thu, Apr 17, 2025 at 12:23:10PM +0100, Marc Zyngier wrote:
> > > > > On Thu, 17 Apr 2025 11:47:11 +0100,
> > > > > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > > > > 
> > > > > > Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> > > > > > - reg &= ~MASK;
> > > > > > - reg |= FIELD_PREP(MASK, val);
> > > > > > The semantic patch that makes this change is available
> > > > > > in scripts/coccinelle/misc/field_modify.cocci.
> > > > > > 
> > > > > > More information about semantic patching is available at
> > > > > > https://coccinelle.gitlabpages.inria.fr/website
> > > > > > 
> > > > > > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > > > > > ---
> > > > > >  arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > > index 34233d586060..b2af748964d0 100644
> > > > > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > > @@ -30,8 +30,7 @@ enum pkvm_page_state {
> > > > > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > > > > >  						 enum pkvm_page_state state)
> > > > > >  {
> > > > > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > > > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > > > > +	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
> > > > > >  	return prot;
> > > > > >  }
> > > > > 
> > > > > Following up on my suggestion to *not* add anything new, this patch
> > > > > could be written as:
> > > > > 
> > > > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > index 34233d5860607..08cb6ba0e0716 100644
> > > > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > > > @@ -30,9 +30,8 @@ enum pkvm_page_state {
> > > > >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> > > > >  						 enum pkvm_page_state state)
> > > > >  {
> > > > > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > > > > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > > > > -	return prot;
> > > > > +	u64 p = prot;
> > > > > +	return u64_replace_bits(p, state, PKVM_PAGE_STATE_PROT_MASK);
> > > > >  }
> > > > 
> > > > This is a great example where u64_replace_bit() should NOT be used. 
> > > 
> > > Why not? Explain it. Don't leave people in the dark, because right
> > > now it looks like it's purely a religous fanaticism about what
> > > should and should not be used. Where's the technical reasoning?
> > 
> > Because enum is an integer, i.e. 32-bit type.
> 
> This statement is false, in this case.
> 
> The kernel currently uses -std=gnu11, and GNU tends to be more relaxed
> about things, and while the C standard may say that enums are ints,
> that isn't the case - gcc appears to follow C++ and allow enums that
> are wider than ints.
> 
> $ aarch64-linux-gnu-gcc -S -o - -std=gnu99 -x c -
> enum foo {
> A = 1L << 0,
> B = 1L << 53,
> };
> int main()
> { return sizeof(enum foo); }
> 
> Gives the following code:
> 
> main:
> .LFB0:
>         .cfi_startproc
>         mov     w0, 8
>         ret
>         .cfi_endproc
> 
> meaning that sizeof(enum foo) is 8 or 64-bit.
> 
> If B were 1L << 31, then sizeof(enum foo) is 4.
> 
> > Now, the snippet above
> > typecasts it to 64-bit fixed size type, passes to 64-bit fixed-type
> > function, and the returned value is typecasted back to 32-bit int.
> 
> In this case, the enum is defined using:
> 
>         KVM_PGTABLE_PROT_X                      = BIT(0),
>         KVM_PGTABLE_PROT_W                      = BIT(1),
>         KVM_PGTABLE_PROT_R                      = BIT(2),
> 
>         KVM_PGTABLE_PROT_DEVICE                 = BIT(3),
>         KVM_PGTABLE_PROT_NORMAL_NC              = BIT(4),
> 
>         KVM_PGTABLE_PROT_SW0                    = BIT(55),
>         KVM_PGTABLE_PROT_SW1                    = BIT(56),
>         KVM_PGTABLE_PROT_SW2                    = BIT(57),
>         KVM_PGTABLE_PROT_SW3                    = BIT(58),
> 
> As it contains bits beyond bit 31, and we use -std=gnu11 when building
> the kernel, this enum is represented using a 64-bit integer type. So,
> the casting to a u64 is not increasing the size of the enum, and the
> return value is not getting truncated down to 32-bits.
> 
> > Doesn't sound the most efficient solution, right? On 32-bit arch it
> > may double the function size, I guess.
> 
> Given that there's no inefficiency here, and that this is arm64 code
> which is a 64-bit arch, both those points you mention seem to be
> incorrect or not relevant.
> 
> > But the most important is that if we adopt this practice and spread it
> > around, it will be really easy to overflow the 32-bit storage. The
> > compiler will keep silence about that.
> 
> Given that in Marc's suggestion, "prot" is a 64-bit value, it's being
> assigned to a u64, which is then being operated on by the u64 variant
> of _replace_bits(), which returns the u64 result, which then gets
> returned as a 64-bit enum, there is no issue here as far as I can see.

Ah, OK. You're right. On the other hand, enum is a bad specifier here,
because this thing is not an enumeration. It's clearly a bit structure
that reflects attributes in the page table record.

This enum confused me (and probably others), and could better be an
u64. And because this is really the 64-bit storage that tightly coupled
to MMU layout, it should be a fixed-type, and should be handled with
u64_xx_bits() functions.

If it was a true enumeration, something like dma_data_direction or
ucount_type, or if it was a true native type like long, using this
u64_xx_bits() is not optimal.
