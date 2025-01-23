Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581CC0218A
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=929SbkPZ1rHZGzLzkzfyL8bQgeP/Kh91Wpz1dFourKM=;
  b=pViYg55IZnadA8eliHSp/HwzKfHNoXCMOgfTErvIh/TC/uqWJJKed+qU
   t0BzbWUMje+uSRuZwLK+S7zPtPJNVGEEaEMxXk3/njOA7CrgnWnqhUwhZ
   uAlyVMkEUha/JF1LkViVXFOj0ceK+okZTSpPHpRnm1MrCjyPZdZ/zlbTa
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205238532"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 551F4E0D74; Mon, 27 Jan 2025 17:17:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D16E8E0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 22:30:55 +0100 (CET)
IronPort-SDR: 6792b50f_wCqQJopjz8ejIuiYPwe4oS/5lGtdmI8bwea8dzmsuxCMbxF
 ryzAotAEV4f/DLNuj+wdqxn93cWU90PPCB8MUOQ==
X-IPAS-Result: =?us-ascii?q?A0GeAADls5JnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQoFXMwQLSIRWiB1fhlKCJJ4YgX4PAQMBDUQEAQEDBIFQgzACi?=
 =?us-ascii?q?nQCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?UBJhXsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBAyMdAQE3AQ8LG?=
 =?us-ascii?q?AICBSECAg9HBgGDE4JlA7h1gTKBAYIMAQEG3gMJgRouAYhNAYVrhHcnG4INh?=
 =?us-ascii?q?D8+hEMVg0aCaYIzgXSDQKArSAp7HANZLAFVEw0KCwcFYUhIAysLDAsUHBUjg?=
 =?us-ascii?q?SYFNQo3OoINaUk3Ag0CNYIeJFiCK4IfgjuERYRThVuCFIFlAwMWEYI1cnsfg?=
 =?us-ascii?q?RYdQAMLGA1IESw3FBsGPQFuB5xanj0BsAAKhBuBYwKfZRYzl0STD5h8IqM9a?=
 =?us-ascii?q?IRmgWc6gVx9CIMiTwMZD44hGR+IVr1ZQTU8AgcLAQEDCYtthDiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VF3VxqBXIywLS03lHemd55DYdb4zR+YMi2TDj3oBLCC9Afbo8/
 xG/c5rrSMc5wxwZJhNo7290cq7MAjhHPxOkOos1N6ZNWGM0ldASrsSj7cKqAeOJ8SKzI9gPN
 BbHZSWZuedMbEwt7ec3ODxKadH/DCoytHQudvj
X-Talos-CUID: =?us-ascii?q?9a23=3A+smAGWptp4k8KqBUTEzPTRfmUc97cWzc60noGlK?=
 =?us-ascii?q?5NV1jcuy/FkXLyYoxxg=3D=3D?=
X-Talos-MUID: 9a23:zTRRGQjbXvMo/mfb8lLeS8MpFtx3xoKuNBs2rohbqpfHGAtiIweXtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,229,1732575600"; 
   d="scan'208";a="107214283"
X-MGA-submission: =?us-ascii?q?MDGtm5h321+K2vc5wJER4rr3+z//QKSqJag9xC?=
 =?us-ascii?q?8rdf79Sv9qije+w2bqXy2JnZg8+KJDCO86AWv5/h250RK7OwzRkDwbsB?=
 =?us-ascii?q?0V7wr6gZKzVTRWafRHurQridkpW9EbasDm6qc2P1NFxqadvgWFkFHD+X?=
 =?us-ascii?q?LB28MxnLmNmBELA6frGL4gbQ=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 22:30:49 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7BA33A4141E;
	Thu, 23 Jan 2025 21:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D00C4CED3;
	Thu, 23 Jan 2025 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737667846;
	bh=929SbkPZ1rHZGzLzkzfyL8bQgeP/Kh91Wpz1dFourKM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ma4Qyk7mEhcwihmS3b+DFhOCXJEno6SD0X4g8jNX14SQHHum/jftVXnUCHAxXyJtj
	 9SCAboLAP8ky3xalfX1MbyKuArL+iM3esKuGwRSrPAj1qCmgkCadWn5cTMndCiG/N1
	 RomQpgO5gpQOVLLUNtM5AIFSKhHWhrOUwVYrG4aVlhwu4lRAOVQDuNhTw84HqZTrQS
	 s68Ut3F0dPYC5upgmdHekKp+ta38/e+bzO7J+CV3WCyD1RlM1k21fS5czBOV6e3IEu
	 UdqLHrUXpiwCWTFe33OduOL4KpBZ9aBUrqPmvzthFGqUnxzooQoE8UIgTWiFdIHwf0
	 lRL//4PJcktsA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 23:30:40 +0200
Message-Id: <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
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
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vignesh Raman" <vignesh.raman@collabora.com>,
 <kernelci@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2235
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/D79RU9MHGKJ8.1HG89ZJS4Q5FC%40kernel.org>

On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> We are working towards creating a generic, upstream GitLab-CI pipeline
> (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipelin=
e
> is designed with a distributed infrastructure model, making it possible
> to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> integration.

Why can't you keep the next version of your great pipeline outside the
kernel tree?

If there is a legit motivation for doing that, why it needs to be bound
to Gitlab? Why can't you make script callable from any CI?

BR, Jarkko
