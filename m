Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB41AC02197
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PWP/r/KJzrah8kJw56mkedA0AUVDRUPdI1WqzoyN34Q=;
  b=NJsyOoXioPKQ79gbhcMkplxpl4r4uNPNtmUIesVfHiM8fQlvH8bj8c10
   ydlKTvkkW4BD9FpFZVIQZZxo4ibHKvS8+7WyCFHvn7jy5fsH8POlwgZu8
   BYXPm2xVLaOEzBtxjm1c49ZKc+ZLewVz6JsustmhJiJdUtGzzArvv9zW/
   c=;
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
   d="scan'208";a="205324777"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0364E0D47; Tue, 28 Jan 2025 10:13:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3286BE007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 13:52:18 +0100 (CET)
IronPort-SDR: 67938d01_M1oJbrsJZBdL+y0N/Oj4R4/HJvPD5M5R6QGj7NOy1E9ZDxq
 iFiwzBUSz9VRnBVCa+8ExT+1DLObRVpuvoLSGzQ==
X-IPAS-Result: =?us-ascii?q?A0FPAgCgjJNnhVvBS5NaHgEBCxIMQIFIC4JEfVozBAtIB?=
 =?us-ascii?q?I1OhlKCIQOeGIF+DwEDAQ05CwQBAQMEggyCdAKKdQIeBwEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgEBAQIBOgYBATcBBAsLRlYGExSCbQGCQSMDEbkigTSBA?=
 =?us-ascii?q?YIMAQEG3B+BZAMGgUiITgGFaxuDYnongiiDPU8zPosHgjNLg12BDIsRgT2CP?=
 =?us-ascii?q?haBbYRngWOIYEgKexwDWSwBVRMNCgsHBWFISAM2DAswFSOBJgU1Cjc6gg1pS?=
 =?us-ascii?q?TcCDQI1gh58giuCH4I7hEWEU4VbghSBZQMDFhGCNXJ7H4EoHUADCxgNSBEsN?=
 =?us-ascii?q?xQbBj5uB5wjATyFHwgQcSCBJkCSQAiDR44TjF2VEYQljBiSJIMKTYQEjQaGO?=
 =?us-ascii?q?pMPmHyMC4F5mymBbQEzgVxNMIMqEzwDGQ+OIRkfiFbAUUI1AgE5AgcLAQEDC?=
 =?us-ascii?q?ZAjgUsBAQ?=
IronPort-PHdr: A9a23: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
 4+n6WlHxhhoYZg2KLbWKa4PyUJf1Prmgw==
IronPort-Data: A9a23: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
 J88e4dBD616FJDeVWvFdu/FWZNJNM8=
IronPort-HdrOrdr: A9a23:rHYl8a8eIeuCVH4ZkBRuk+DdI+orL9Y04lQ7vn2ZhyY1TiX+rb
 HWoB17726TtN91YhwdcL+7VJVoLUmyyXcx2/hyAV7AZniAhILLFvAA0WKK+VSJcEfDH6xmpM
 JdmsNFaOEYY2IVsS+D2njdL+od
X-Talos-CUID: 9a23:tFxT9G3Ic4j2+M7WGEMOwLxfHOsCQHf67CvpP0KbA1gyRKbScEGe5/Yx
X-Talos-MUID: 9a23:NkNUjwWBEjnBDFfq/CPQ1A5dBddG2Zu3Oh0fjZchsvKjLAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="107276905"
X-MGA-submission: =?us-ascii?q?MDEyHKd0vP1/R6nPeBUTynMgxY+qP2k0i3b2IM?=
 =?us-ascii?q?+jqtjKPwUvJSXyIUYwGj9zb1SIq8xLxb2vKIskgzffPpX3sxsyQKmGBp?=
 =?us-ascii?q?HQYAvGN09dZc+bfAyK68J5lbSa0tBz6BzpW/4NASJMkMnLM5mSKW//F1?=
 =?us-ascii?q?7QvnjhMDLUeiebbgsvCYMguQ=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:52:17 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4AD66A4171F;
	Fri, 24 Jan 2025 12:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07688C4CED2;
	Fri, 24 Jan 2025 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737723135;
	bh=CpbOkdw5ufLxu3POL0cSP+QQdt85eklh2emIk4kJQdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RryHRov2KoNJszYH1AdqbYFOqxFE00KYUb2qQdcn6XWytVkTx8AEyIRrA8EtuEe3m
	 x8vOQs1rPLvRD/zh1iMl58Md6wWIDJbhUApNpjadFhn1BxXv0G7GIqvg+ecspRbQs2
	 ZCpSlLnCbT5a575vFoYr3+QA00DD7DW4Ve3Zv5NQMMAaFsJKDK1xvx93vwx8Npif91
	 jJy+xIR3jmm3NpoWLMGKBF9sYPpgYeGOrVEHs3J8bQujOR6Gzn8ONECASE2bgS9HOq
	 hGV85cTPUIdxBpXvxG71Bum3JQdo6yF7NIxseaPBLQKBZg2MLk0avz41j2iPcqIMuq
	 kLeBOgTG4fqvg==
Date: Fri, 24 Jan 2025 13:52:03 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leonardo =?UTF-8?B?QnLDoXM=?= <leobras.c@gmail.com>, Vignesh Raman
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Message-ID: <20250124135203.040d0852@foz.lan>
In-Reply-To: <20250124081250.GA24731@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2246
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250124135203.040d0852%40foz.lan>

Em Fri, 24 Jan 2025 10:12:50 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> > It's been a few years since I first thought on finding a good way of helping
> > kernel developers testing their patches, while making use of the free runner
> > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > new to kernel development, or students trying to understand it better.
> > 
> > And this patchset allows that to happen :)
> > 
> > Actually, I spoke to Helen last year, and to enable it to run on the free
> > Gitlab-CI runners, there is a small extra patch which is needed:
> > 
> > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  

Sounds interesting!

> Gitlab as an open-source software project (the community edition) is one
> thing, but can we please avoid advertising specific proprietary services
> in the kernel documentation ?

Every time Gitlab is mentioned, the brand of the company that
developed it and has been providing proprietary services is also
advertised. If you're not happy with that, you should move to use
a git forge developed by some open source community.

The way I see, the best would be if the CI integration could work
with more than one type of forge and being able to use any
free Git??b-CI runners that would be available for developers to
use, as this would allow testing more subsystems with CI, thus
increasing code quality.

Thanks,
Mauro
