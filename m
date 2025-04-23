Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F18C369D8
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nNi428VMmxCpWKvb50p/bX9DgxfivgEs4/Ad9gqYDsM=;
  b=OyetreZAyMRzA/PC6qmyaFZouxqTwXzrUTj6rAYreTcwdK6jIjh9VOdP
   KR95rCdpvNGg4lhLQJr02oJm7puT2Djiu2I+/Ej9IyNiIE68vk4v0OQLl
   vY4Zn9hiT9epkDBdx/ZC9U+z236OpSEQNNAbeVT3GaiIGxr3AcIXsJ6UV
   s=;
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
   d="scan'208";a="219234108"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C69EE0D64; Thu, 24 Apr 2025 10:55:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C747DE007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 19:44:46 +0200 (CEST)
IronPort-SDR: 6809270e_+F3ljtcSAFFc2Ily7Yk56gnh/We4/TUre+kirL/FhQZQhI3
 y/TWuRllo1qUUoAyMyGCiuXJ2/OCX+zl2FPa5CA==
X-IPAS-Result: =?us-ascii?q?A0ERAAAhJgloctoeIE5aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFCAgEBAQELAYFxUn1ZNAQLSIgkjAFdBoEhIKAgAQMBDTkIA?=
 =?us-ascii?q?QIEAQEDAQOQLwIeBgYzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAGBDIV7DYJiATOCFiyBCwEFOgYBATcBDwEKGC4QRgaDFoJkBAMNsheBN?=
 =?us-ascii?q?IEBggwBAQaBCNx9AwaBSQGITwGFbIR3Jxt9gRCBFYMqPosHg0iVVlOIE1J7H?=
 =?us-ascii?q?ANZLAFVExcLBwWBJkMDgQ8jSwUwHYJXhSWCEYFcAwMjgxN0HIRohFItT4Mvg?=
 =?us-ascii?q?gNoCB1AAwttPTcUG5cOg2aBQZkLsAwKhBuhYzOEA40JmUsumFCpNYF9JIFcU?=
 =?us-ascii?q?TAEgyJPHA+OIYt5ujNFMjwCBwsBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 p7Ijq21NTQQq7rp
IronPort-Data: A9a23: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
 Z86eodV312r5w==
IronPort-HdrOrdr: A9a23:LUBOIqxpkvM85jOWhruNKrPwL71zdoMgy1knxilNoH1uA66lfq
 +V9sjzuSWYtN9VYh8dcLO7Scq9qBHnmqKdiLN5VdyftUvd2VdAR7sD0WKW+UyHJ8SIzJ876U
 4PScRD4aXLfDxHZJHBkWyFL+o=
X-Talos-CUID: 9a23:rAXxj2DrJRSjpsP6E2433XU5Jf5+S2Dy3WfRfWKiU3Z4GZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A/phIHwwuPmIkrqi8DyUa2ofYgsyaqJuqS20umJc?=
 =?us-ascii?q?Uh9GNCQ1iEAabnhr0ZpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219160353"
X-MGA-submission: =?us-ascii?q?MDF4THXkTCUtrmdVfon6H65F+w/AHu/Nl22Zod?=
 =?us-ascii?q?WgI4RpNmv+TK6BMbsteuVwGfNV77sBhGfDP4UlfjH2D1K/WgZAfqC0p+?=
 =?us-ascii?q?9A3dhfTGUjreUEuPbv6IkMdHWcF5bNZC3O5HjRxA6BYle5KnyN2Ceomz?=
 =?us-ascii?q?PVUdkPJsmTxDOzuMN0hll3qQ=3D=3D?=
Received: from pandora.armlinux.org.uk ([78.32.30.218])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 19:44:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nNi428VMmxCpWKvb50p/bX9DgxfivgEs4/Ad9gqYDsM=; b=sqBaQ1uxVV1Pn/zOz3VaBK6aKx
	/I4dFGbXcARGryXfnbvPWLGUtk1kZlUt0TMwuBBUgGzsc3TawnlO4KVddk2aiB7QCiDSrPFPX0UhH
	fAnQPyqWRWhA73bcXJ2cxstme/cqQdzOdeNSmykzWRsh7LguLYXdC5mKFviArEbe7kE7StwD/luU3
	KaDv+C24wS1f2nrM7EGI4Qu+rjOFF0owG01q4uyOVWtiu6Lq6cJ+r2oe6qSLvesrvkieXTZFlEpCY
	oJqVHW/y/NnxmVaJAjV/Hdz8qBaF/6CgmBwCcTXNn4Q2H5Uve2R+1UJLcaWz6BwQT9kp9UqPXceRD
	DY3fZ9pw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54318)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7e93-0006K9-0Z;
	Wed, 23 Apr 2025 18:44:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7e8t-0000Dc-15;
	Wed, 23 Apr 2025 18:44:15 +0100
Date: Wed, 23 Apr 2025 18:44:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yury Norov <yury.norov@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Luo Jie <quic_luoj@quicinc.com>,
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
	kvmarm@lists.linux.dev, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com
Message-ID: <aAkm79R8f5Vf6TLh@shell.armlinux.org.uk>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <86sem7jb5t.wl-maz@kernel.org>
 <0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
 <86mscek7h3.wl-maz@kernel.org>
 <aAJq9mGswYsnAOS8@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAJq9mGswYsnAOS8@yury>
Sender: cocci-request@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2714
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAkm79R8f5Vf6TLh%40shell.armlinux.org.uk>

On Fri, Apr 18, 2025 at 11:08:38AM -0400, Yury Norov wrote:
> The _replace_bits() functions return fixed-width values, and intended
> for: "manipulating bitfields both in host- and fixed-endian", as the
> very first line in the commit message says.
> 
> Those using _replace_bits() for something else abuse the API, and
> should switch to FIELD_MODIFY().

Sorry, but please explain this statement, because it means nothing to
me.

FIELD_MODIFY() replaces bits in host endian. _replace_bits() also
replaces bits, but has a wider range of which encompass FIELD_MODIFY().

I see nothing that precludes using using _replace_bits() with
bitfields.

I see nothing that would differentiate the behaviour, other than maybe
religous ideals about C functions vs macros or upper vs lower case.

Please explain why you think there's a difference between the two
because I really can't see any reason not to use one over the other
apart from asthetics.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
