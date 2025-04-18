Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD96C369CB
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8tlr+U+ggvV9b6qUUYsEDpFnGs799KYouZS0u/xqDZw=;
  b=WjQ0AO1KN9TDLqaSADZlpokN3pXS6EwEGV0a+TqNU6H7EqfjLTcfSoAb
   AU8QsrdzLAW5FvYvdslfRwAge8pPpurQ725d60429bmH38zQOxGLIpubW
   +JXK+pxrDCmDkT59Ui80NaYp0gCUTv9UZcjJYwtyCrNN4jYY68n2MAIqg
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
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219056359"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53038E0D79; Wed, 23 Apr 2025 10:51:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B0FA7E007A
	for <cocci@sympa.inria.fr>; Fri, 18 Apr 2025 17:14:53 +0200 (CEST)
IronPort-SDR: 68026c6d_IKVnqlSO3u91ySc8nuWJGABoM4BRbG50gqWmoRHLWaCwx+S
 wHsYcM68Tdhn02vCyySJge/ddB1hA22zhCZL7Vw==
X-IPAS-Result: =?us-ascii?q?A0EDAADzagJofKrWVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGCQn1aMwRTjHGHNIIkhXqMUhyLKoFAPg8BA?=
 =?us-ascii?q?wELAQE5CQIEAQEDAwE4hEgCiysCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEiGQcOEimFew1JARABggcBgSRhAgUDOwEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAiw/AQEeAQEBA?=
 =?us-ascii?q?xIoBgEbHQEDDAYFDgouEBIRAQUBHAYTIoJhgi8BAzEDEaUugQVCizyBFwUCF?=
 =?us-ascii?q?oEBgg0G2l0KGSgNbAOBYgIBBgkBCoE1AYR1KU4OgjgdAYVsG4NieicPgVVEg?=
 =?us-ascii?q?RWDKj6LBwSCLUVShV2IB5QECAcxCQkTBgoCSwsKEgMEAwQEAQILEwkDAwIOA?=
 =?us-ascii?q?ggDAggGGQE/DAYEHRgMHwoICAQRCigDIgQOKwoDWzUIBgICBAQCBAIKAgkCA?=
 =?us-ascii?q?ggHAhEDBAEBCAICAysGAwYbCgIIAg0FEwoBBQQDBwUCGwMDAgIFCwIIBQIFB?=
 =?us-ascii?q?wMJDgECBQMEFQIQAgICCBUCAgIFHAMkAwMDAwsBAgIOCQYYDwQCAwMCDgECA?=
 =?us-ascii?q?gkBAgEDAwgDAwkIBwEKCQECCgYCCRABAgIQAwICAgIGBw4DAhMPBQYGAgoHD?=
 =?us-ascii?q?QsCEgIDCQYDBQoDBwQKDQIVAhUFHwECCAkOEQIFEgMOBQMCAhEEAgMDBQMBB?=
 =?us-ascii?q?wEVAwcIAgIMAgICAgUCBQIFFxENBAMDAwIIAQQVBgMJCCUbEAEBAwEJAwIDB?=
 =?us-ascii?q?AgDAwMCBgwLAgEHCAMDBgsICQYDAgcIGQMFBAMHBQshAgYDAgQFBAEFAhMNA?=
 =?us-ascii?q?gMZAgYDBhEJDQYIBwkDBwEBAQICAggBBgUSAgMEAgUEBAEBCAMDBAYCAQMCA?=
 =?us-ascii?q?gQJAQEBAgoCCAoBCRMEAwgDAwMDAwUCAggEEQUFAgEFChMMCgYDBgMEAgICC?=
 =?us-ascii?q?wcCAwMDBwELHAIBAwICBQICAQUDAgIGBAMCAQEJAgMCCAECAgECAgIEAQcBB?=
 =?us-ascii?q?AcGAQECBAICMgIBAwkCBQEBDgICBAICAQICAgQCBAECBgsEBQ0BAQIBAgIBA?=
 =?us-ascii?q?QEEAQgDAQECAgMDBQMFAwgPDQEBFwsdAwQFAgIBAQEBAhICAgEHAQIBAQMaA?=
 =?us-ascii?q?gEDAwQBCwIBAQQeBBYCAgICAgQDAgIDAgILEyUBAgMFAxMCAgQCAQICBQUFA?=
 =?us-ascii?q?QMEERAJAwIFBAICBgIEBgoCBwQCGgQCAgIBAwQGAwECCAICBwQEBgMCAgECA?=
 =?us-ascii?q?gcZAhkBAwEBAgICBAICAgkKBAUEBAQDAgICAQwDAQIDAgICAgEDAgIBAQMBB?=
 =?us-ascii?q?QYNAhICAQMPCAQCAgcCAiEPCwECAQECBgYCAwMDCgMBCgECAQECBgIBAhIFA?=
 =?us-ascii?q?gIBAgQBAgIDBCUBAgECAQEBBQIBAgECBAIHAgECAgsBBQIGAQICCQECAQICA?=
 =?us-ascii?q?gECAQECBgIBFQECAgICAgMBAwYCAgICAgIJAgICAgUCBQMCAwEGAgIFAgMDA?=
 =?us-ascii?q?gIDBAMJAwMIAwYEAgMBAQECAQICAgECAgECAgUCAwkBAQMCAQICAgIDBgIFB?=
 =?us-ascii?q?QEDCwUEBwEBAgEDBQMDBAMGAQwEAwICBAICAgICAgQCAgEFAwMCAgUBBQMIA?=
 =?us-ascii?q?QIEAgEDAwMEBAMBAgIKBwUCBAEBAQECAQICCgMCBQEBAwMBEgMEAQYFBQYCB?=
 =?us-ascii?q?wkDAgIEAgMCBAMJBAIGAwMCAgIBAQsCAgECAgEBAwMHBhABAgICAgEPAgMDA?=
 =?us-ascii?q?wMDDwYDBQ0dAgkDIw8DFAgTPQwHMgQ2ARQUBwYlgQCXZ4Fngi8BgQ4slXODG?=
 =?us-ascii?q?K9YNAeEHoFeBgyKKZYQlzMMkwWYfo4GmwQCCgcHESMSgTI6gVwzGiODN08DG?=
 =?us-ascii?q?Q+OIYN6gT7Bdyc1AjoCBwsBAQMJhUMmE4UkhHyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 gSRD7MC6Ihp5ayfNHB6CenExn6pbk8xMg==
IronPort-HdrOrdr: A9a23:kfgk9q+/g9/zLlpAoN9uk+AdI+orL9Y04lQ7vn2ZhyYlFPBws/
 re4MjztCWE9Qr5PUtLpTnuAtjkfZqxz+8Q3WBVB8bcYOCEghrTEGgB1/qb/9SIIUSXnZ8+6U
 4jSdkENDSZNykYsS+Q2njALz9P+qjhzImYwcjZ1GlkVgxnZuVN6A1jGh+HHkAefmV7LKt8Op
 7ZyMQvnVSdkLcsAfhTxENpYwEOnbz2fVvdASI7Ow==
X-Talos-CUID: 9a23:rflNAG2Cv2/olNYOAFXMPLxfNd0UdVPz01HpcgySL2dRcoSoagWM0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3A7WVDXA9g8tD+X9KuPR7WvYGQf9Vs6qSsKhtWqrU?=
 =?us-ascii?q?foOOoCCAgFCyDiB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,222,1739833200"; 
   d="scan'208";a="218512130"
X-MGA-submission: =?us-ascii?q?MDEeeUpaQZ9mFWbxReAvxvLotUkeIUlfF5nJKc?=
 =?us-ascii?q?kiPL5Ki8bSsjryz+vZIRxUfhkMXcp34H+EMBgnPV+NaJSSeDdL4GIc8a?=
 =?us-ascii?q?cunkqkmnIpSHcPLuCru/kjK+3JK/jpvenlXS0BWdhDqmiT/UK2lies6Y?=
 =?us-ascii?q?k7GEaw7Husen4rD2hHlWaMRA=3D=3D?=
Received: from mail-pl1-f170.google.com ([209.85.214.170])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 17:14:52 +0200
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223f4c06e9fso19134855ad.1;
        Fri, 18 Apr 2025 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744989291; x=1745594091; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tlr+U+ggvV9b6qUUYsEDpFnGs799KYouZS0u/xqDZw=;
        b=i9aXHvXlAuma7aAWAdq19es8Cor3o15AQx5z5SeUn0gZy0rROVo4i6mFlTEI7hBP8h
         98gGdL4IZBVWOirQxD92Z6fEdwqocyxQoA3YWfwHQf6VwlhfQSUbQtfBDBw8DQLD47Rm
         jWhwYU59Dn5BAPr30YrJLTGm6ho3QSB33nKXgpFwgAANa/XNMt6CwnXkPQoFUGKHyP5O
         om/yTP0BCc/6AZBBn/BIb64CtqEMq/aBUTkryg6HfNdzL8JAZlO3BQHjkZgw/FFOmQgb
         K8HjgwG0Oer5z/Y5kXBPhTaqTpNV4OCxSbdq+Wbqpai1fmaWt9cZmkqWWVmYJhGM2Tcu
         EoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744989291; x=1745594091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tlr+U+ggvV9b6qUUYsEDpFnGs799KYouZS0u/xqDZw=;
        b=Tjew9uFfkj2OGYJQB7/XXHmqsjKYv76i750aph5D5VCVoatOALNp9kvhurBCsCkR/m
         MltVAG51Aj7G3Pu7rEFFBJ4QrBBuTreyXoz7t65sc1hQNDBoIjMDVjIOCJH/1PzGCZ7P
         GAq/iiffXusmQUl6IqLmeOyJ/y6rol/UCnzMbTBGvSXTkZtL+cMpVZxnBjbv0yAGmxxW
         KHvG/bHkl2zy17JgOTgr2f90xVFAo0r7fjOnbZfaiMrGb2Vy8AvzJRN3OS0KBLSVIqCU
         5dtvbpIIO2M4dcsHdtw2uR8tR0fY53STkTUV7E28syH1CVNCE634h6KMd4siDo6tC6Cv
         8/XA==
X-Forwarded-Encrypted: i=1; AJvYcCWSGVI4pw53jyxWepXpyW2uyfPvhKyzaSt3X8Fn/LWp2fHrz0ejF47c0b3KDQ9cnohpseDL/VsGN6cmaXU=@inria.fr, AJvYcCWwLBHr2Kci88if0DNqVadahVdQARWMAUZGTrWGB7EhGydGunyJlL8uS4ZkEOMF58B7Fyd57xw=@inria.fr
X-Gm-Message-State: AOJu0Yznh+V1aS2dc7RhxdTQnXyoc3K0XcA0Dav2H0sqw8GUpV5YN/kt
	5WZikdW6Mt6fw5jKdDanTsn1I9G3YkxjbkeRLl9Wo71AT389nHp/
X-Gm-Gg: ASbGnctaHfLmNpn+xNsofRDqo/HqOi6t8RgMO98VR6LhPWsbsAe305T4oGsu8IqSpOW
	/Ey0medtsUoFNZacwjR3BA1/d3B3zPknoCPIJtXPeHb46aO4dQ6e8sLIUfkQg9HqfdwpvMopOK0
	bJdQQS2SFXTGv/SiwpQqsUNQDmhg87KCT4FdmThDuz9gd9zdOo3/nVTsuv181hxgEYfEb9UUrP3
	NNsj1Pw/gM8gSe06pOnslAtg7V9MQ+hYwDxyEG1Sj+jAn1lQ+hlDKqn3Zw96+ER9iorbJVziGWb
	vP9D4xRk2ppfKsd0+8Bas98Gx27sd361OrIijY/0
X-Google-Smtp-Source: AGHT+IFgH6kH8q8Ukkj38k3Ycwx8mgsM0+PlhclwOyMownQr5Lp6Z8YsDqQFALXwipkdJoGcEZeG3A==
X-Received: by 2002:a17:902:fc4d:b0:225:abd2:5e5a with SMTP id d9443c01a7336-22c50bd610fmr55082235ad.4.1744989291024;
        Fri, 18 Apr 2025 08:14:51 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb64fbsm17891505ad.158.2025.04.18.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:14:50 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:14:48 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Luo Jie <quic_luoj@quicinc.com>,
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
Message-ID: <aAJsaNdznnz-1qap@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-4-6f7992aafcb7@quicinc.com>
 <86r01rjald.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r01rjald.wl-maz@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 4/6] arm64: nvhe: Convert the opencoded field
 modify
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2702
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAJsaNdznnz-1qap%40yury>

On Thu, Apr 17, 2025 at 12:23:10PM +0100, Marc Zyngier wrote:
> On Thu, 17 Apr 2025 11:47:11 +0100,
> Luo Jie <quic_luoj@quicinc.com> wrote:
> > 
> > Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> > - reg &= ~MASK;
> > - reg |= FIELD_PREP(MASK, val);
> > The semantic patch that makes this change is available
> > in scripts/coccinelle/misc/field_modify.cocci.
> > 
> > More information about semantic patching is available at
> > https://coccinelle.gitlabpages.inria.fr/website
> > 
> > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/memory.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > index 34233d586060..b2af748964d0 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > @@ -30,8 +30,7 @@ enum pkvm_page_state {
> >  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> >  						 enum pkvm_page_state state)
> >  {
> > -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> > -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> > +	FIELD_MODIFY(PKVM_PAGE_STATE_PROT_MASK, &prot, state);
> >  	return prot;
> >  }
> 
> Following up on my suggestion to *not* add anything new, this patch
> could be written as:
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> index 34233d5860607..08cb6ba0e0716 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> @@ -30,9 +30,8 @@ enum pkvm_page_state {
>  static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
>  						 enum pkvm_page_state state)
>  {
> -	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
> -	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
> -	return prot;
> +	u64 p = prot;
> +	return u64_replace_bits(p, state, PKVM_PAGE_STATE_PROT_MASK);
>  }

This is a great example where u64_replace_bit() should NOT be used. 

Thanks,
Yury
