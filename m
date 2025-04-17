Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EF8C369D8
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:message-id:from:to:cc:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/2maWr5nKaUYZks392Yr7+st8n64TBj8pRfEW3etv/U=;
  b=LLPZFKOHSxmSXxloBHPU9Ul5lYFc2NrrazU01c4IpJ9BQfrwJHN93cQj
   iJ5tHzFexK8Hq7ldu5E3vsji594vhrEKgly5BFhyPa0ke3MKGOFLOk8Rv
   tf2pnlTOkABtnvMerg/TDtn9dVlhvsHfymHa5bA/m/zSFsLS+eqdXjlJO
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
   d="scan'208";a="219056231"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF2E4E0DBE; Wed, 23 Apr 2025 10:51:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4A97AE007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 19:45:20 +0200 (CEST)
IronPort-SDR: 68013e31_8LHX8XuZGvCR/3phwsV4V+dd7hN52YlkAhad4Ld7G/NZay/
 3ToQTca9VvvCWds02YiNpxj15jKxYhWwtTY9nIQ==
X-IPAS-Result: =?us-ascii?q?A0EYAADwPAFohR/86qxaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgVgyBAtIjHFfhlWCJDCLQ5IfgX4PAQMBDUQEAQEDBIUAAosrAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBAzoGAQE3AQ8LEgYZAhMQOA4GE4MCg?=
 =?us-ascii?q?mUDBLEUgTSBAYIMAQEGgmnZN4FlCYFJAYhPAYVsG4NieicbgUlEhD8+hSADh?=
 =?us-ascii?q?WSCMUU+FIMvhCOEP4Uzgm6NJlJ7HANZLAFVExcLBwVhSEMDgQ8jTgUwHYF6g?=
 =?us-ascii?q?3SFNoIRgVwDAyIBgxV3HIRthFctT4MzgggdQAMLbT03FBsGmHeFJwGCe5Y6A?=
 =?us-ascii?q?bAMhCWhYzOXRpMRLphQo1YNhVKBZzqBXDMaCCgIgyJPAxkPhHeJKhmIdMBZQ?=
 =?us-ascii?q?zQ8AgcLAQEDCY9qLQWBSwEB?=
IronPort-PHdr: A9a23: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
 YqW/J8=
IronPort-Data: A9a23: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
 luvL1awD6uqNrD/dEfnVx/FQUO5NB5TIvWHEQ==
IronPort-HdrOrdr: A9a23:wSJ+7q/emZ3bATc2B1Fuk+D4I+orL9Y04lQ7vn2ZKCYlFPBw+P
 rOoB1273/JYXMqKRMdcLO7Sc69qBHnhP1ICOAqVN/INmaJhILrFvAG0WKI+UyFJ8SKzJ8m6U
 4WSdkENPTASXB/hdn7+k2dFdshz9mK/cmT6Ns2t00dNT2CPJsQljuR1Tz2LnFL
X-Talos-CUID: 9a23:UgppJmwBDf8bWcX5w6RuBgU7G+J/SnKExUzLAG65AlliGZ2Vdhy5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AEFv3fQ2cZIrFNY2s7sOfnHN8KzUjzoLpOV0ywZY?=
 =?us-ascii?q?/iciFES8uJGiljynqXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,219,1739833200"; 
   d="scan'208";a="218373820"
X-MGA-submission: =?us-ascii?q?MDELwfVCntzBDxPDm+HOPX1inbj1SZTFIp2Bh5?=
 =?us-ascii?q?cWWmBo4/Gy2ws/ccKT4lwtBnO15+jEoKc0McaNSGprxBmS7s1gEA9Jn/?=
 =?us-ascii?q?FnzA/+bxbr35SzSPg1QGbrTOGYs7JbkwefVQ7j5r5+c240w1oDhts3l6?=
 =?us-ascii?q?3WmjkrT4TtygblgoSfOioSPA=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 19:45:20 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 851D9450EC;
	Thu, 17 Apr 2025 17:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87272C4CEE4;
	Thu, 17 Apr 2025 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744911916;
	bh=6HqrhZNro99W4hlfSawIZ3bq362Egs1uCP6Vd2PPZEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rg9yC7QlGIMHPKQ7WEUGcSXGLVG9wxf2u/ZQSNnkgiCyTxtBSESRPGDe+sRSX9zqE
	 Yr6zKteWNfT21eUPrDzH3townbAbp+JNZoqjO8E9Btki0TkxaaNjeqnOFomOXxGsY9
	 npxcqlAvOCfIOhiGpE7+KHL4yZ17Ea7yhnR7iLd/LuMwKNgaMfatKUoXU++iSE+yc4
	 bCUeuLNT8zmRwNmWOd81ph5gMXXeKiDDW6+RZvyzte4ueYT3Dt2CGTpkNowMW9fKmZ
	 kSD+ATjwqop+j6mDFplMVngOWwDoWMPy9UNGDtf1OWVrt4ZVExz07i9a69OinfacJU
	 FCAJM3b+Ersgw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u5TIY-006VUB-5A;
	Thu, 17 Apr 2025 18:45:14 +0100
Date: Thu, 17 Apr 2025 18:45:12 +0100
Message-ID: <86mscek7h3.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Luo Jie <quic_luoj@quicinc.com>,
	Yury Norov <yury.norov@gmail.com>,
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
	quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com
In-Reply-To: <0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
	<86sem7jb5t.wl-maz@kernel.org>
	<0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: andrew@lunn.ch, quic_luoj@quicinc.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, Julia.Lawall@inria.fr, nicolas.palix@imag.fr, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, cocci@inria.fr, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Marc Zyngier <maz@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2699
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/86mscek7h3.wl-maz%40kernel.org>

On Thu, 17 Apr 2025 18:22:29 +0100,
Andrew Lunn <andrew@lunn.ch> wrote:
> 
> On Thu, Apr 17, 2025 at 12:10:54PM +0100, Marc Zyngier wrote:
> > On Thu, 17 Apr 2025 11:47:07 +0100,
> > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > 
> > > Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
> > > macros. It is functionally similar as xxx_replace_bits(), but adds
> > > the compile time checking to catch incorrect parameter type errors.
> > > 
> > > This series also converts the four instances of opencoded FIELD_MODIFY()
> > > that are found in the core kernel files, to instead use the new
> > > FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
> > > the script field_modify.cocci.
> > > 
> > > The changes are validated on IPQ9574 SoC which uses ARM64 architecture.
> > 
> > We already have the *_replace_bits() functions (see
> > include/linux/bitfield.h).
> > 
> > Why do we need extra helpers?
> 
> If you look at bitfield.h, the *_replace_bits() seem to be
> undocumented internal macro magic, not something you are expected to
> use. What you are expected to use in that file is however well
> documented. The macro magic also means that cross referencing tools
> don't find them.

$ git grep _replace_bits|  wc -l
1514

I think a bunch of people have found them, tooling notwithstanding.

As for the documentation, the commit message in 00b0c9b82663ac would
be advantageously promoted to full-fledged kernel-doc.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
