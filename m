Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46E9C0218C
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:to:cc:references:in-reply-to:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=U43wl3m4iytgZwURelg9Dd1JSuKG4wO5ZGgaRjHkiYQ=;
  b=pUd5BvEBhxlLfuTTJi6a5yZGWEN2ABnf5niFEBT1Zn8QHsPbJG+FOlj2
   2NPn7ThmSEexWVzYj3olhcwRqUS0fDYEi36STRqvGROZ6turuPlFGTZPJ
   ZUxZm9VCYorFicOQBQ1mOw18b89uQcLcHu3FajYMfuEPztlGeKv0g9ZR+
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
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205238550"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E1228E0D7F; Mon, 27 Jan 2025 17:17:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9AB0CE0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 22:32:05 +0100 (CET)
IronPort-SDR: 6792b555_te9AZtTdX8ubuahRgTBc7Y03kPFQBKPXHHujBFCT/Wtxpzn
 508oIkYokZvnXIbgjaHiboTIcZeALMiJqc4fjYw==
X-IPAS-Result: =?us-ascii?q?A0HWFQBqtJJnhdlUsotaHgEBCxIMQIFICwKCQoFXMwQLG?=
 =?us-ascii?q?i6EVoh8hlKCJJ4YgX4PAQMBDUQEAQEDBIFQgzACinQCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNSQEBBAsBggcBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDIx0BATcBDwsYAgIFIQICD0cGAYMTg?=
 =?us-ascii?q?mUDuHiBMoEBggwBAQaCaNsbCYEaLohOAYVrg316JxuCDYQ/PoRDFYNGgmmCM?=
 =?us-ascii?q?4F0g0CgK0gKexwDWSwBVRMNCgsHBWFIEDgDKwsMCxQcFSOBJgU1Cjc6gg1pS?=
 =?us-ascii?q?TcCDQI1gh4kWIIrgh+CO4RFhFOCQ4MYghR6awMDFhGCNXJ7H4EWHUADCxgNS?=
 =?us-ascii?q?BEsNwYOGwY9AW4HnFqePQGwAAqEG4FjAp9lFjOXRJMPmHwioz2FToFnOoFcf?=
 =?us-ascii?q?QiDIk8DGQ+OIRkfiFa9YEE1PAIHCwEBAwmHDIRhhDiBSwEB?=
IronPort-PHdr: A9a23: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
 hApzBB5fP4m+XHv7k0xK16MozE/whFZpA==
IronPort-Data: A9a23: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
 b0biodND62rNqQvhJYU
IronPort-HdrOrdr: A9a23:i219vaPkmVMy18BcTvCjsMiBIKoaSvp037By7TEVdfUnSL39qy
 nOpoVi6faaslYssR0b9OxoW5PwOk80l6QFgrX5VI3KNGKNhILPFvAB0WKI+VLd8ljFl9K1op
 0PT0ERMrHN5BNB/KHHCUGDYrAdKfe8gdmVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3AeB9samug5/MG6FD+/VV/fMVF6IsXeD7n3CuNeHS?=
 =?us-ascii?q?jAExZbZqvRX/M2qNrxp8=3D?=
X-Talos-MUID: 9a23:WhhZ4QSeHhWsBAStRXTovAhECsxHzJ+qBRk2v5EKvteLMCl/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,229,1732575600"; 
   d="scan'208";a="204742202"
X-MGA-submission: =?us-ascii?q?MDEjRPtQQ89da0E1kxA311zTQFCM70FRcqP1D7?=
 =?us-ascii?q?/g3x3IG5bmrJw4RqyqSR7ICtY3Bh06SMMuCLR1HmV4U5w0Pv8kKOAqfe?=
 =?us-ascii?q?22pQpFxNlSaVIIN0CK+fY6vOn8jZ6+aNzDJflChMyAIXG7CmTrByhNov?=
 =?us-ascii?q?tsEenblQI+FeXy1EijEvxBmw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 22:32:04 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E32085C5AC1;
	Thu, 23 Jan 2025 21:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1843DC4CED3;
	Thu, 23 Jan 2025 21:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737667921;
	bh=U43wl3m4iytgZwURelg9Dd1JSuKG4wO5ZGgaRjHkiYQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ljobwWhpPOWbHMWZfcZGBrqTEQWNSW4x8kKE8N10uOnz4Gmjy73R1KA/7PujDQrdG
	 nXfeKQ567VxWcLpobGbsYEY18BsNmEXo/G92okOwf8b+2HTay9aEuwVYZf0HxLZ12S
	 nst6+kC4CMjlsr+yndd9VMTIoofg7PQFUrS3nObaXgk3iZ6KBLCYZskndw5Vci2+HG
	 hfLSlR+3n8KScil9bF4K4fsXKHcy5KlX6OSypjgAEw3xxOA0IkRcbzesvn76J5PV4u
	 nfOFVoa2FcZoV/IBMsO6BAx80S8QMQmcpIDTHlWiqPw4xCNdLm02Se+Kh8AmBPzAQr
	 LYH2BzJvyZenw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 23:31:56 +0200
Message-Id: <D79RV8GG76R9.1WM0XRR47WA0W@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Vignesh Raman"
 <vignesh.raman@collabora.com>, <kernelci@lists.linux.dev>
Cc: <linuxtv-ci@linuxtv.org>, <dave.pigott@collabora.com>,
 <mripard@kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
 <gustavo.padovan@collabora.com>, <pawiecz@collabora.com>,
 <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>,
 <laurent.pinchart@ideasonboard.com>, <broonie@kernel.org>,
 <leobras.c@gmail.com>, <groeck@google.com>, <rdunlap@infradead.org>,
 <geert@linux-m68k.org>, <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
In-Reply-To: <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2236
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/D79RV8GG76R9.1WM0XRR47WA0W%40kernel.org>

On Thu Jan 23, 2025 at 11:30 PM EET, Jarkko Sakkinen wrote:
> On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> > We are working towards creating a generic, upstream GitLab-CI pipeline
> > (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipel=
ine
> > is designed with a distributed infrastructure model, making it possible
> > to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> > backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> > integration.
>
> Why can't you keep the next version of your great pipeline outside the
> kernel tree?
>
> If there is a legit motivation for doing that, why it needs to be bound
> to Gitlab? Why can't you make script callable from any CI?

To add, most of the distributions have their CI pipelines but they don't
proactively push them over here.

BR, Jarkko
