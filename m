Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55F6C02193
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9/zDMqN6hhaBomecOPelO7rWtXLPgec1udymjzwGahE=;
  b=YnvWrfIr/UkW4Gy7o6PRcTRucBomsEB4s8pDARTgkYmUEpjC8/nmr7c4
   OiPjgJ5k68SsKZKs5uuDGgAqLI3fFP1yVBeSVcfCa/BEqoHtueJ+fE9y8
   ZgI8wRaZ5ixf9cjeLqUKM7C85hsTFH//pSpxKEJogOZqA9KoY6Cujt3bR
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
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324672"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 67365E0D21; Tue, 28 Jan 2025 10:13:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C230E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 13:16:59 +0100 (CET)
IronPort-SDR: 679384bb_SzJH982X3sfyI5X+zHCZ/sWm4bWU0X+pjx2uKAPIUdWywaB
 qAY/CqnQVIdDlUp8TIzGt67LeSlZ8RdCS/gW9Ug==
X-IPAS-Result: =?us-ascii?q?A0EUAAB9g5NnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHV+GUoIknhiBfg8BAwENRAQBAQMEggyCdAKKd?=
 =?us-ascii?q?QIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQ?=
 =?us-ascii?q?EmFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQMjHQEBNwEPCxgCAgUhA?=
 =?us-ascii?q?gIPRwYBJoJtgmUDuUWBMoEBggwBAQbeAwmBGi4BiE0BhWuEdycbgg2EPz6EW?=
 =?us-ascii?q?INGgmmCM4F0gjSBDIsRgT2EQYRnikNICnscA1ksAVUTDQoLBwVhSEgDKwsMC?=
 =?us-ascii?q?xQcFSOBJgU1Cjc6gg1pSTcCDQI1gh58giuCH4I7hEWEU4VbghSBZQMDFhGCN?=
 =?us-ascii?q?XJ7H4EoHUADCxgNSBEsNxQbBj0BbgecYIZIgQ4YkwCDTwGwAAqEG4FjAp9lF?=
 =?us-ascii?q?jODcRONBoY6kw+YfCKkJYRmgWc6gVx9CIMiTwMZD44hGR+IVsBTQTU8AgcLA?=
 =?us-ascii?q?QEDCZAjgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 k8bi4dAD656F5DTVWYUVwoVvJJJ
IronPort-HdrOrdr: A9a23:oUsi9KkjZwBnEpRuUgmUXdlUGXbpDfIp3DAbv31ZSRFFG/FwWf
 re/8jzsiWatN9xYh8dcLW7VZVoLkm8yXcY2/h1AV7mZniehILXFuFfBPrZrwEIcheWnoU26U
 4jSdkZNDSaNykZsS+V2njdLz9Z+qjhzJyV
X-Talos-CUID: 9a23:/t6XxGEbjCIPGxuAqmJGyFUOG9guKkba80n7CGylB1d5RaOKHAo=
X-Talos-MUID: 9a23:2yDd8gQcX34sv3f1RXTDvg1yKs5woJ6tL2s3s7E9vcWrdjJJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="204845483"
X-MGA-submission: =?us-ascii?q?MDEw1TL9zKPwBvLH0MfLdONC2jjscN3adH2Z04?=
 =?us-ascii?q?IKmCVQTQKQFojcKByF9uKOxMV7LZ2K0QCwY6zx3COzDwowJBN/qRxrD4?=
 =?us-ascii?q?lhaCeDK1kIZDhHkXKwDbLtYE4Wzxlb/IlPQm6b9aW9wbaBlDum6E4zJL?=
 =?us-ascii?q?7yfIvIKCaAovJFUj2xi5im/Q=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:16:59 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 05755A41670;
	Fri, 24 Jan 2025 12:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67084C4CED2;
	Fri, 24 Jan 2025 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737721017;
	bh=9/zDMqN6hhaBomecOPelO7rWtXLPgec1udymjzwGahE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eWQQv3Ugf4xoyIoBxAR8/sos283LO4tfdtueimw31HSVDOwgMGB2kNZZjf66Dh0hz
	 a6I1ULEjZyhOvrOUc6AeIeqjkUJNyN1XggtE5/hweH1G/K00T8rfWPCVrcG7yaIRPA
	 x6u3EX8rgtXrld9535e+lpZovv6mPWAHhz+p9KKX3xEGzGgW66k4DaL+AU/wyGeIBG
	 d8ukAc8lExSOcWXjbHtFdQ1e7We3n4HIl24sN4qcJNDa+BdbKRAIKXlK31y52ODIq9
	 IA5m48dT88TqN7E8sRAKrgIRUrPcpk7CXYyYrKvjz6WQYrhTeeORinbGugexmKmiGa
	 d0joC22bDyNIw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 14:16:52 +0200
Message-Id: <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
Cc: "Vignesh Raman" <vignesh.raman@collabora.com>,
 <kernelci@lists.linux.dev>, <linuxtv-ci@linuxtv.org>,
 <dave.pigott@collabora.com>, <mripard@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kselftest@vger.kernel.org>, <gustavo.padovan@collabora.com>,
 <pawiecz@collabora.com>, <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>, <broonie@kernel.org>,
 <groeck@google.com>, <rdunlap@infradead.org>, <geert@linux-m68k.org>,
 <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
 =?utf-8?q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
In-Reply-To: <20250124081250.GA24731@pendragon.ideasonboard.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2243
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/D7AAOSNDJV11.AXVF80Z934BK%40kernel.org>

On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
> Gitlab as an open-source software project (the community edition) is one
> thing, but can we please avoid advertising specific proprietary services
> in the kernel documentation ?

I don't think we should have any of this in the mainline kernel.

One angle is that "no regressions rule" applies also to the shenanigans.

Do we really spend energy on this proprietary crap to the eternity?

BR, Jarkko
