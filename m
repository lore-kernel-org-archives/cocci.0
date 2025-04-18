Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E34C369D8
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:message-id:from:to:cc:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nFgOrlNyb8Ejkb43D/yIyVFJ/IzoXYakXUeU5QoZiuU=;
  b=o89nKDpgLdL2kGujfDZW2ZNNt8p1GvS2duFyyXs55cBUmFKaXVq0LqzN
   3hn16qwkuJVryCEY9UGTNLuK1mjyMwlFOQuB0qnEwudQFUF0whtObIcqU
   HI0zSBPJZ2HwtNwMGAZnzKzqPE7B59Prc2MQwrXrqJ/C7v0zoLmtDoJYT
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
   d="scan'208";a="219056448"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E40C4E0DE9; Wed, 23 Apr 2025 10:51:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1CB1FE007A
	for <cocci@sympa.inria.fr>; Fri, 18 Apr 2025 17:35:34 +0200 (CEST)
IronPort-SDR: 68027138_bJQGY74ijG49ZmGDaqS+HwS3ibjORg7CbKgIpkTgCt6qDMK
 hmbXZOZTyLMh50NobTahtECodZ7ZUAMmyUGbRwg==
X-IPAS-Result: =?us-ascii?q?A0EmAADBcAJohVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDfVsyBAtIjVCGVYIkMIszEJIfgX4PAQMBDTkLBAEBAwSFAAKLK?=
 =?us-ascii?q?wIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQ?=
 =?us-ascii?q?EmFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECAToGAQE3AQQLCxIGG?=
 =?us-ascii?q?QITEBAoDgYTgwIBgjADDiMDBA2xNHiBNIEBggwBAQaCadg+DWyBZQMGgUkBi?=
 =?us-ascii?q?DEeAYVsg316JxuBSUSEPz6CH4MBA4VkgjGBAxSDLYQjhD+FM4JuhDqIflJ7H?=
 =?us-ascii?q?ANZLAFVExcLBwVhSEMDgQ8jTgUwHYF6g3KFNoIRgVwDAyIBgxV1HIRxhFQtT?=
 =?us-ascii?q?4MzggM7HUADC209NxQbBpkMhSUBK4JQljuaeZQicYQljBmPOIYSM5dGkxEum?=
 =?us-ascii?q?FCOBoQHkUkNhVKBbgQvgVwzGggoCIMiTwMZD4R3iSoZiHS+BEM0PAIHCwEBA?=
 =?us-ascii?q?wmPai0FgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z86eodV312r5w==
IronPort-HdrOrdr: A9a23:CKFBQq5u8oysvrwcqgPXwCrXdLJyesId70hD6qm+c203TiX4rb
 HWoB1/73LJYVkqN03I9ergBEDEewK4yXcX2/h2AV7BZmfbUQKTRekIh+ffKn/baknDH4VmpM
 VdmsZFaOEYQWIK6vrS0U2DO5IN0dmCtIqvguDTxWoobTgCUdAZ0y5JTjyyVmFmRA0DIZI4Ed
 6y/cxCzgDQA0g/X4CALj0oTujG4+bAjY+jXBhuPW9d1CC+yQmBrJLqExzd5B0XVDRCzN4ZgB
 X4rzA=
X-Talos-CUID: =?us-ascii?q?9a23=3AVDRTCGofLMjT11xgjV158sPmUcQVanPU9lnuH1K?=
 =?us-ascii?q?HDExCWqPPUBy98poxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AjIMEAwwHQjQBBjW41yvg673FVK2aqIOXNU4Ovok?=
 =?us-ascii?q?kgMzHBDwpZTWjiGrwWJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,222,1739833200"; 
   d="scan'208";a="218515099"
X-MGA-submission: =?us-ascii?q?MDE6wR6i937T/Z3uqGmP2PTmzNiyPJ/PapOiIS?=
 =?us-ascii?q?Y9jiGYF7gbMAw9Nue4c3mYm0NPMr3vsNvT4ObN3Coh5kxp+mTJVayXvx?=
 =?us-ascii?q?Z732gO3hDFyKD93FeZyXoAxumBpHRgB/Uhofi9odGc2KOtRXd539BP/G?=
 =?us-ascii?q?h/Y2W+YqHj+JfU0CCAbBdKfQ=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 17:35:19 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3920EA4B520;
	Fri, 18 Apr 2025 15:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1863CC4CEEA;
	Fri, 18 Apr 2025 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990518;
	bh=7NHab62RZtPj0Np+h3D9F3dxP/sVC+/JnFk6D/PUpPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uqzjTsEnt9rDe+ksBBlT3BLXDvD6oHj/oGnFMl4wzPOE/y7OsfkdibxQnus0m3BAT
	 +Z2qaFSGhZq07whzJPZjt5WArxUXWXyOeLky4XMAa6ay+xm5WOX/17eKfxr4cxsuEX
	 JaJTxU+shymgO6NAmDcbCDNuZZparjTo6TcQRUt+Sb6pylRsSYd1lK97CI4B93LuVb
	 3wxLctZljW/x2jALr2c/dFwan9BRHFdFT+eNLM/5Uv+63xjEL/CVdzt4hRIOCvcGvi
	 7ZeABxWyYURO/vSJMWJE1tAx4ebji6fO4/FNg7uqS7KtaVU7TgmWnY3r2xP107RcjZ
	 kJ8+DBdQdreQA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u5nkJ-006krU-QT;
	Fri, 18 Apr 2025 16:35:15 +0100
Date: Fri, 18 Apr 2025 16:35:22 +0100
Message-ID: <87plh9xz2d.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Luo Jie <quic_luoj@quicinc.com>,
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
In-Reply-To: <aAJq9mGswYsnAOS8@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
	<86sem7jb5t.wl-maz@kernel.org>
	<0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
	<86mscek7h3.wl-maz@kernel.org>
	<aAJq9mGswYsnAOS8@yury>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: yury.norov@gmail.com, andrew@lunn.ch, quic_luoj@quicinc.com, linux@rasmusvillemoes.dk, Julia.Lawall@inria.fr, nicolas.palix@imag.fr, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, cocci@inria.fr, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Marc Zyngier <maz@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2704
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/87plh9xz2d.wl-maz%40kernel.org>

On Fri, 18 Apr 2025 16:08:38 +0100,
Yury Norov <yury.norov@gmail.com> wrote:
> 
> On Thu, Apr 17, 2025 at 06:45:12PM +0100, Marc Zyngier wrote:
> > On Thu, 17 Apr 2025 18:22:29 +0100,
> > Andrew Lunn <andrew@lunn.ch> wrote:
> > > 
> > > On Thu, Apr 17, 2025 at 12:10:54PM +0100, Marc Zyngier wrote:
> > > > On Thu, 17 Apr 2025 11:47:07 +0100,
> > > > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > > > 
> > > > > Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
> > > > > macros. It is functionally similar as xxx_replace_bits(), but adds
> > > > > the compile time checking to catch incorrect parameter type errors.
> > > > > 
> > > > > This series also converts the four instances of opencoded FIELD_MODIFY()
> > > > > that are found in the core kernel files, to instead use the new
> > > > > FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
> > > > > the script field_modify.cocci.
> > > > > 
> > > > > The changes are validated on IPQ9574 SoC which uses ARM64 architecture.
> > > > 
> > > > We already have the *_replace_bits() functions (see
> > > > include/linux/bitfield.h).
> > > > 
> > > > Why do we need extra helpers?
> > > 
> > > If you look at bitfield.h, the *_replace_bits() seem to be
> > > undocumented internal macro magic, not something you are expected to
> > > use. What you are expected to use in that file is however well
> > > documented. The macro magic also means that cross referencing tools
> > > don't find them.
> > 
> > $ git grep _replace_bits|  wc -l
> > 1514
> 
> FIELD_PREP() only is used 10 times more.

And? I'm sure that if you count "+", you'll find it to be yet a few
order of magnitudes more.

>  
> > I think a bunch of people have found them, tooling notwithstanding.
> > 
> > As for the documentation, the commit message in 00b0c9b82663ac would
> > be advantageously promoted to full-fledged kernel-doc.
> 
> The FIELD_MODIFY() and uxx_replace_bits() are simply different things.
> 
> FIELD_MODIFY() employs __BF_FIELD_CHECK(), which allows strict
> parameters checking at compile time. And people like it. See
> recent fixed-size GENMASK() series:
> 
> https://patchwork.kernel.org/comment/26283604/

I don't care much for what people like or not. I don't see this
FIELD_MODIFY() as a particular improvement on *_replace_bits().

> The _replace_bits() functions return fixed-width values, and intended
> for: "manipulating bitfields both in host- and fixed-endian", as the
> very first line in the commit message says.
> 
> Those using _replace_bits() for something else abuse the API, and
> should switch to FIELD_MODIFY().

Or not.

	M.

-- 
Jazz isn't dead. It just smells funny.
